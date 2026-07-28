return {
  "vscode-neovim/vscode-neovim",

  config = function()
    local vscode = require("vscode-neovim")
    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    -- window settings
    keymap.set({ "n", "v" }, "<leader>sv", function() vscode.action("workbench.action.splitEditorRight") end)
    keymap.set({ "n", "v" }, "<leader>sh", function() vscode.action("workbench.action.splitEditorDown") end)
    keymap.set({ "n", "v" }, "<leader>se", function() vscode.action("workbench.action.evenEditorWidths") end)
    keymap.set({ "n", "v" }, "<leader>sx", function() vscode.action("workbench.action.closeEditorsAndGroup") end)
    keymap.set({ "n", "v" }, "<leader>sm", function() vscode.action("workbench.action.toggleMaximizeEditorGroup") end)

    -- "pane" navigation 
    -- keymap.set({ "n", "v" }, "C-k", function() vscode.action("workbench.action.focusAboveGroupWithoutWrap") end)
    -- keymap.set({ "n", "v" }, "C-j", function() vscode.action("workbench.action.focusBelowGroupWithoutWrap") end)
    -- keymap.set({ "n", "v" }, "C-h", function() vscode.action("workbench.action.focusLeftGroupWithoutWrap") end)
    -- keymap.set({ "n", "v" }, "C-l", function() vscode.action("workbench.action.focusRightGroupWithoutWrap") end)

    -- call vscode commands from neovim
    keymap.set({ "n", "v" }, "<leader>d", function() vscode.action("editor.action.showHover") end)
    keymap.set({ "n", "v" }, "<leader>D", function() vscode.action("workbench.actions.view.problems") end)
    keymap.set({ "n", "v" }, "<leader>a", function() vscode.action("editor.action.quickFix") end)
    keymap.set({ "n", "v" }, "<leader>cn", function() vscode.action("notifications.clearAll") end)
    keymap.set({ "n", "v" }, "<leader>ff", function() vscode.action("workbench.action.quickOpen") end)
    keymap.set({ "n", "v" }, "<leader>cp", function() vscode.action("workbench.action.showCommands") end)
    keymap.set({ "n", "v" }, "<leader>pr", function() vscode.action("code-runner.run") end)
    keymap.set({ "n", "v" }, "<leader>mp", function() vscode.action("editor.action.formatDocument") end)
    keymap.set({ "n", "v" }, "<leader>kx", function() vscode.action("editor.action.trimTrailingWhitespace") end)

    -- refactoring
    vim.keymap.set({ "n", "x" }, "<leader>r", function()
      vscode.with_insert(function()
        vscode.action("editor.action.refactor")
      end)
    end)
    vim.keymap.set({ "n", "x" }, "<leader>rn", function()
      vscode.with_insert(function()
        vscode.action("editor.action.rename")
      end)
    end)

    -- select next occurrences (multi-cursor)
    -- vim.keymap.set({ "n", "x", "i" }, "<C-m>", function()
    -- vscode.with_insert(function()
    --   vscode.action("editor.action.addSelectionToNextFindMatch")
    --   end)
    -- end)
    vim.keymap.set('n', '<C-m>', 'mciw*<Cmd>nohl<CR>', { remap = true })
    -- vim.keymap.set({ "n", "x", "i" }, "<C-S-l>", function()
    -- vscode.with_insert(function()
    --   vscode.action("editor.action.selectHighlights")
    --   end)
    -- end)

  end,
  
}
