local map = vim.keymap.set

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
map("n", "<ESC>", "<cmd> noh <CR>", { desc = "Clear highlights" })

-- Remap for dealing with word wrap
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Center view after moving up/down half a page
map("n", "<C-d>", "<C-d>zz", { silent = true })
map("n", "<C-u>", "<C-u>zz", { silent = true })

-- Diagnostic keymaps
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- Comment toggle
map("n", "<leader>/", function() require("Comment.api").toggle.linewise.current() end, { desc = "Toggle comment" })
map("v", "<leader>/", "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", { desc = "Toggle comment" })

-- Execute code in vsplit
map("n", "<leader>fw", "@g", { silent = true })

-- Competitive programming
map("n", "<leader>fo", "<cmd> CphReceive <CR>", { silent = true, desc = "recieve testcases" })
map("n", "<leader>fj", "<cmd> CphTest <CR>", { silent = true, desc = "run on testcases" })

-- Go to next/prev buffer
map("n", "J", "<cmd> bnext <CR>", { silent = true, noremap = true })
map("n", "K", "<cmd> bprev <CR>", { silent = true, noremap = true })

-- Move lines up/down
map("v", "J", ":m '>+1<CR>gv=gv", { silent = true, noremap = true })
map("v", "K", ":m '<-2<CR>gv=gv", { silent = true, noremap = true })

-- Delete current buffer
map("n", "<leader>d", "<cmd> bd <CR>", { silent = true, noremap = true })

-- Copy everything in buffer
map("n", "YY", "<cmd> %y+ <CR>", { silent = true, noremap = true })

-- Trouble
map("n", "<leader>v", "<cmd> Trouble diagnostics toggle <CR>", { silent = true })

-- Escape terminal mode
map("t", "<C-x>", vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true), { silent = true, noremap = true, desc = "Escape terminal mode"})

-- Telescope
map("n", "<leader>rf", "<cmd> Telescope oldfiles <CR>", { desc = "Find recently opened files" })
map("n", "<leader><space>", "<cmd> Telescope buffers <CR>", { desc = "Find existing buffers" })
map("n", "<leader>gf", "<cmd> Telescope git_files <CR>", { desc = "Search Git Files" })
map("n", "<leader>ff", "<cmd> Telescope find_files <CR>", { desc = "Search Files" })
map("n", "<leader>sh", "<cmd> Telescope help_tags <CR>", { desc = "Search Help" })
map("n", "<leader>sw", "<cmd> Telescope grep_string <CR>", { desc = "Search current Word" })
map("n", "<leader>sg", "<cmd> Telescope live_grep <CR>", { desc = "Search by Grep" })
map("n", "<leader>sd", "<cmd> Telescope diagnostics <CR>", { desc = "Search Diagnostics" })
map("n", "<leader>u", "<cmd> Telescope undo <CR>", { desc = "Search Undo History" })

map("n", "<leader>fs", "<cmd> SessionManager load_session<CR>", { desc = "Load session" })
map("n", "<leader>ls", "<cmd> SessionManager load_last_session<CR>", { desc = "Load last session" })
map("n", "<leader>ss", "<cmd> SessionManager save_current_session<CR>", { desc = "Save session" })

local function toggle_neovide_fullscreen()
  local curr_value = vim.g.neovide_fullscreen
  if curr_value == nil or curr_value == false then
    vim.g.neovide_fullscreen = true
  else
    vim.g.neovide_fullscreen = false
  end
end

map("n", "<D-f>", toggle_neovide_fullscreen, { desc = "Toggle fullscreen in neovide" })

vim.api.nvim_create_augroup("execute_code", {
  clear = true,
})

local function execute_code(extension, command)
  vim.api.nvim_create_autocmd("BufEnter", {
    group = "execute_code",
    pattern = "*." .. extension,
    command = "let @g=':40vsp | term " .. command .. "\ni'",
  })
end

execute_code("c", "gcc \"%\" && ./a.out")
execute_code("cpp", "g++ -DCUSTOM_DEBUG -std=c++23 -O2 \"%\" && ./a.out")
execute_code("java", "java \"%\"")
execute_code("py", "python3 \"%\"")
execute_code("go", "go run \"%\"")
execute_code("sml", "sml <\"%\"")
execute_code("html", "npx parcel \"%\" --port 3000")
execute_code("pl", "swipl -q -l \"%\"")
vim.api.nvim_create_autocmd("BufEnter", {
  group = "execute_code",
  pattern = "*.tex",
  command = "let @g=':TexlabBuild\n'",
})
