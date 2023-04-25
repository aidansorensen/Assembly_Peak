
local function show_assembly()
    local file = vim.fn.expand("%:p")
    print("my file is" .. file)
    vim.cmd("vsplit | terminal")
    local command = ':call jobsend(b:terminal_job_id, "cargo asm --asm-style=intel fizzbuzz::main \\n")'
    vim.cmd(command)
end

return {
    show_assembly = show_assembly
}
