local alias = require('mappings/alias')

alias.normal_map(',<space>', '<cmd>nohlsearch<cr>')

-- working with tabs
alias.map('tc', '<cmd>tabnew<cr>')
alias.map('tn', '<cmd>tabNext<cr>')
alias.map('td', '<cmd>tabclose<cr>')

-- buffer
alias.map('bn', '<cmd>bnext<cr>')
alias.map('bd', '<cmd>bdelete<cr>')

-- WINDOW
local window = require('functions/window')
-- arrange
alias.map('<C-j>', function() window.move('j') end, { silent = true })
alias.map('<C-k>', function() window.move('k') end, { silent = true })
alias.map('<C-h>', function() window.move('h') end, { silent = true })
alias.map('<C-l>', function() window.move('l') end, { silent = true })
-- resize
alias.map('<A-Left>', '<C-w><<cr>', { silent = true })
alias.map('<A-Right>', '<C-w>><cr>', { silent = true })
alias.map('<A-Up>', '<C-w>+<cr>', { silent = true })
alias.map('<A-Down>', '<C-w>-<cr>', { silent = true })

require('mappings/files')

