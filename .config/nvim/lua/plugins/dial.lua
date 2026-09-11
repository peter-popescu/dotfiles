return {
  "monaqa/dial.nvim",
  keys = {
    -- Normal mode increment/decrement
    { "<C-a>", function() return require("dial.map").inc_normal() end, expr = true, desc = "Increment" },
    { "<C-x>", function() return require("dial.map").dec_normal() end, expr = true, desc = "Decrement" },
    -- Visual mode increment/decrement
    { "<C-a>", function() return require("dial.map").inc_visual() end, expr = true, mode = "v", desc = "Increment" },
    { "<C-x>", function() return require("dial.map").dec_visual() end, expr = true, mode = "v", desc = "Decrement" },
  },
  config = function()
    local augend = require("dial.augend")
    require("dial.config").augends:register_group({
      default = {
        augend.integer.alias.decimal,  -- 1, 2, 3...
        augend.integer.alias.hex,      -- 0x1a, 0x0f...
        augend.date.alias["%Y/%m/%d"], -- 2026/09/11
        augend.date.alias["%Y-%m-%d"], -- 2026-09-11
        augend.date.alias["%m/%d"],    -- 09/11
        augend.date.alias["%H:%M"],    -- 14:30
        augend.constant.alias.bool,    -- true/false, True/False
        augend.constant.new{
          elements = {"and", "or"},
          word = true,
          cyclic = true, -- "or" is incremented into "and".
        },
        augend.constant.new{
          elements = {"&&", "||"},
          word = false,
          cyclic = true,
        },
      },
    })
  end,
}
