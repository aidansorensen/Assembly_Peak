require('assemblypeek.ui')

-- local function show_assembly()
--     vim.cmd("vsplit | terminal")
--     local command = ':call jobsend(b:terminal_job_id, "cargo asm --asm-style=intel fizzbuzz::fizz \\n")'
--     vim.cmd(command)
-- end

-- return {
--     show_assembly = show_assembly
-- }
--


local function show_assembly()
    vim.cmd("vsplit | terminal")
    local func_name = "fizzbuzz::fizz"
    local command = ':call jobsend(b:terminal_job_id, "cargo asm --asm-style=intel ' .. func_name ..' \\n")'
    vim.cmd(command)
end

return {
    show_assembly = show_assembly
}
