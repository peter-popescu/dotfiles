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
local notified_roots = {}

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

local function default_pixi_environment(root)
  return environment_python(vim.fs.joinpath(root, ".pixi", "envs", "default"))
end

local function pixi_shell_environment(root)
  if vim.env.PIXI_IN_SHELL ~= "1" or canonical(vim.env.PIXI_PROJECT_ROOT) ~= root then
    return nil
  end

  return environment_python(
    vim.fs.joinpath(root, ".pixi", "envs", vim.env.PIXI_ENVIRONMENT_NAME or "default")
  )
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

  local virtualenv_python = environment_python(vim.env.VIRTUAL_ENV)
  if virtualenv_python then
    return virtualenv_python
  end

  local saved = load_selections()[root]
  if executable(saved) then
    return canonical(saved)
  end

  local in_matching_pixi_shell =
    vim.env.PIXI_IN_SHELL == "1" and canonical(vim.env.PIXI_PROJECT_ROOT) == root
  local pixi_python = pixi_shell_environment(root)
  if pixi_python then
    return pixi_python
  end

  -- Pixi exposes its active prefix through CONDA_PREFIX. Do not use that
  -- value again here: pixi_shell_environment() handled the matching project,
  -- and a saved picker choice should win over Pixi's default environment.
  if not in_matching_pixi_shell then
    local conda_python = environment_python(vim.env.CONDA_PREFIX)
    if conda_python then
      return conda_python
    end
  end

  local environments = pixi_environments(root)
  if #environments == 1 then
    return environments[1]
  end

  -- Pixi uses the `default` environment when no `-e/--environment` is
  -- specified. Prefer it when a project has multiple environments so a
  -- pyproject.toml workspace still gets an interpreter automatically.
  return default_pixi_environment(root)
end

local function notify_environment(root, python)
  if notified_roots[root] then
    return
  end

  notified_roots[root] = true
  vim.schedule(function()
    if python then
      vim.notify("Pyright environment: " .. (vim.fs.relpath(root, python) or python))
    else
      vim.notify(
        "Pyright could not find a Python environment for "
          .. root
          .. "\nUse <leader>pe or :PyrightPickEnv to choose one.",
        vim.log.levels.WARN
      )
    end
  end)
end

local function set_client_python(client, python)
  client.settings = vim.tbl_deep_extend("force", client.settings or {}, {
    python = { pythonPath = python },
  })
  client.config.settings = vim.tbl_deep_extend("force", client.config.settings or {}, {
    python = { pythonPath = python },
  })
  client:notify("workspace/didChangeConfiguration", { settings = nil })
end

function M.apply_to_pyright_client(client)
  local root = canonical(client.config.root_dir)
  local python = M.resolve(root)
  if not python then
    if root then
      notify_environment(root)
    end
    return
  end

  notify_environment(root, python)
  set_client_python(client, python)
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
    notified_roots[root] = true
    vim.notify("Pyright environment: " .. (vim.fs.relpath(root, python) or python))

    for _, client in ipairs(vim.lsp.get_clients({ name = "pyright", bufnr = bufnr })) do
      if canonical(client.config.root_dir) == root then
        set_client_python(client, python)
      end
    end
  end)
end

function M.clear(bufnr)
  local root = canonical(M.root_for_buffer(bufnr))
  load_selections()[root] = nil
  save_selections()
  notified_roots[root] = nil

  for _, client in ipairs(vim.lsp.get_clients({ name = "pyright", bufnr = bufnr })) do
    if canonical(client.config.root_dir) == root then
      M.apply_to_pyright_client(client)
    end
  end
end

return M
