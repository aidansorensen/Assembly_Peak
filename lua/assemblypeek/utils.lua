


local function show_assembly(func_name)
    vim.cmd("vsplit | terminal")
    --local func_name = "fizzbuzz::fizz"
    local command = ':call jobsend(b:terminal_job_id, "cargo asm --asm-style=intel ' .. func_name ..' \\n")'
    vim.cmd(command)
end

return {
    show_assembly = show_assembly
}
