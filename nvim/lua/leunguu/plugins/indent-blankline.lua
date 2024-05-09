return {
  "lukas-reineke/indent-blankline.nvim",
  event = { "BufReadPre", "BufNewFile" },
  main = "ibl",
  opts = {
    indent = { char = '│', tab_char = '│'}, -- ▏│
    exclude = {
      filetypes = {
        'alpha',
        'checkhealth',
        'dashboard',
        'git',
        'gitcommit',
        'help',
        'lazy',
        'lazyterm',
        'lspinfo',
        'man',
        'mason',
        'neo-tree',
        'notify',
        'Outline',
        'TelescopePrompt',
        'TelescopeResults',
        'terminal',
        'toggleterm',
        'Trouble',
      },
    },
  },
}
