require('options')        
require('keymaps')


------------ set up essential nvim plugins through plugin manager - lazy.nvim -------------------------

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)



require("lazy").setup({
  {
    "Tsuzat/NeoSolarized.nvim",
    priority = 10000, 
    lazy = false,
    config = function()
      vim.cmd [[ colorscheme NeoSolarized ]]
    end
  },
  -- its recommended to load legendary.nvim before other plugins
  {
    'mrjones2014/legendary.nvim',
    priority = 10000,
    lazy = false,
    -- sqlite is only needed if you want to use frecency sorting
    -- dependencies = { 'kkharji/sqlite.lua' }
  },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.4',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  {'ggandor/leap.nvim'},
  {'ojroques/nvim-osc52'}
})

require('leap').add_default_mappings()




local function notify(cmd)
    return string.format("<cmd>call VSCodeNotify('%s')<CR>", cmd)
end

local function v_notify(cmd)
    return string.format("<cmd>call VSCodeNotifyVisual('%s', 1)<CR>", cmd)
end



vim.g.mapleader = ‘,’


if vim.g.vscode then
    -- Bind shortcut to VSCode line/block comment action
    vim.api.nvim_set_keymap('v', 'C', v_notify 'editor.action.blockComment', { silent = false })

    -- Bind copy Y to VSCode copy action
    vim.api.nvim_set_keymap('v', 'Y', v_notify 'editor.action.clipboardCopyAction', { silent = false })

    vim.api.nvim_set_keymap('n', 'gr', notify 'editor.action.goToReferences', { silent = true })
    vim.api.nvim_set_keymap('n', 'gb', notify 'workbench.action.navigateBack', { silent = true })


else
    -- ordinary Neovim
end
