local M = {}

local state_file = vim.fs.joinpath(vim.fn.stdpath("state"), "pyright-envs.json")
local root_markers = {
  "pyrightconfig.json",
  "pyproject.toml",
  "pixi.toml",
  "setup.py",
  "setup.cfg",
  "requirements.txt",
  "Pipfile",
  ".git",
}

local selections

local function canonical(path)
  if not path or path == "" then
    return nil
  end
  return vim.uv.fs_realpath(path) or vim.fs.normalize(path)
end

local function executable(path)
  return path and vim.fn.executable(path) == 1
end

local function load_selections()
  if selections then
    return selections
  end

  selections = {}
  if not vim.uv.fs_stat(state_file) then
    return selections
  end

  local ok, lines = pcall(vim.fn.readfile, state_file)
  if not ok or #lines == 0 then
    return selections
  end

  local decoded_ok, decoded = pcall(vim.json.decode, table.concat(lines, "\n"))
  if decoded_ok and type(decoded) == "table" then
    selections = decoded
  end
  return selections
end

local function save_selections()
  vim.fn.mkdir(vim.fs.dirname(state_file), "p")
  vim.fn.writefile({ vim.json.encode(load_selections()) }, state_file)
end

local function environment_python(prefix)
  if not prefix or prefix == "" then
    return nil
  end

  local python = vim.fs.joinpath(prefix, "bin", "python")
  return executable(python) and canonical(python) or nil
end

local function pixi_environments(root)
  local python_paths = vim.fn.globpath(vim.fs.joinpath(root, ".pixi", "envs"), "*/bin/python", false, true)
  local environments = {}

  for _, python in ipairs(python_paths) do
    if executable(python) then
      table.insert(environments, canonical(python))
    end
  end

  table.sort(environments)
  return environments
end

function M.root_for_buffer(bufnr)
  local name = vim.api.nvim_buf_get_name(bufnr)
  local start = name ~= "" and name or vim.uv.cwd()
  return vim.fs.root(start, root_markers) or vim.fs.dirname(start) or vim.uv.cwd()
end

function M.resolve(root)
  root = canonical(root)
  if not root then
    return nil
  end

  for _, prefix in ipairs({ vim.env.VIRTUAL_ENV, vim.env.CONDA_PREFIX }) do
    local python = environment_python(prefix)
    if python then
      return python
    end
  end

  local saved = load_selections()[root]
  if executable(saved) then
    return canonical(saved)
  end

  local environments = pixi_environments(root)
  if #environments == 1 then
    return environments[1]
  end
end

function M.apply_to_pyright_config(config)
  local python = M.resolve(config.root_dir)
  if not python then
    return
  end

  config.settings = vim.tbl_deep_extend("force", config.settings or {}, {
    python = { pythonPath = python },
  })
end

local function update_clients(root, python)
  root = canonical(root)
  for _, client in ipairs(vim.lsp.get_clients({ name = "pyright" })) do
    if canonical(client.config.root_dir) == root then
      client.settings = vim.tbl_deep_extend("force", client.settings or {}, {
        python = { pythonPath = python },
      })
      client.config.settings = vim.tbl_deep_extend("force", client.config.settings or {}, {
        python = { pythonPath = python },
      })
      client:notify("workspace/didChangeConfiguration", { settings = nil })
    end
  end
end

function M.pick(bufnr)
  local root = canonical(M.root_for_buffer(bufnr))
  local environments = pixi_environments(root)
  if #environments == 0 then
    vim.notify("No Pixi Python environments found for " .. root, vim.log.levels.WARN)
    return
  end

  vim.ui.select(environments, {
    prompt = "Pyright environment",
    format_item = function(path)
      return vim.fs.relpath(root, path) or path
    end,
  }, function(python)
    if not python then
      return
    end

    load_selections()[root] = python
    save_selections()
    update_clients(root, python)
  end)
end

function M.clear(bufnr)
  local root = canonical(M.root_for_buffer(bufnr))
  load_selections()[root] = nil
  save_selections()
  vim.cmd("LspRestart pyright")
end

return M
