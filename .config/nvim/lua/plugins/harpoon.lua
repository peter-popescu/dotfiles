return {
  "theprimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup()

    vim.api.nvim_create_autocmd("DirChanged", {
      group = vim.api.nvim_create_augroup("HarpoonReloadOnDirectoryChange", { clear = true }),
      callback = function()
        -- Harpoon selects its list by cwd, but loads the matching data file in setup.
        harpoon:setup()
      end,
    })
  end,
  keys = {
    { "<leader>h", function() require("harpoon"):list():add() end, desc = "Harpoon file", },
    { "<leader>H", function() local harpoon = require("harpoon") harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "Harpoon quick menu", },
    { "<leader>1", function() require("harpoon"):list():select(1) end, desc = "Harpoon to 1"},
    { "<leader>2", function() require("harpoon"):list():select(2) end, desc = "Harpoon to 2"},
    { "<leader>3", function() require("harpoon"):list():select(3) end, desc = "Harpoon to 3"},
    { "<leader>4", function() require("harpoon"):list():select(4) end, desc = "Harpoon to 4"},
    { "<leader>5", function() require("harpoon"):list():select(5) end, desc = "Harpoon to 5"},
    { "<C-S-P>", function() require("harpoon"):list():prev() end},
    { "<C-S-N>", function() require("harpoon"):list():next() end},
  },
}
