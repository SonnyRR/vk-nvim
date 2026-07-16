local check_version = function()
  local verstr = tostring(vim.version())
  if not vim.version.ge then
    vim.health.error(string.format("Neovim out of date: '%s'. Upgrade to 0.10+", verstr))
    return
  end

  if vim.version.ge(vim.version(), '0.10-dev') then
    vim.health.ok(string.format('Neovim %s', verstr))
  else
    vim.health.error(string.format("Neovim out of date: '%s'. Upgrade to 0.10+", verstr))
  end
end

local check_system = function()
  local uv = vim.uv or vim.loop
  local uname = uv.os_uname()
  vim.health.info(('OS: %s %s'):format(uname.sysname, uname.release))
  vim.health.info(('Arch: %s'):format(uname.machine))

  if uv.total_memory then
    local total_mem = uv.total_memory()
    if total_mem and total_mem > 0 then
      vim.health.info(('Memory: %.1f GB total'):format(total_mem / 1073741824))
    end
  end

  if uv.available_memory then
    local avail_mem = uv.available_memory()
    if avail_mem and avail_mem >= 0 then
      vim.health.info(('Memory: %.1f GB available'):format(avail_mem / 1073741824))
    end
  end

  local cpus = uv.available_parallelism and uv.available_parallelism() or uv.hardware_concurrency and uv.hardware_concurrency() or nil
  if cpus and cpus > 0 then
    vim.health.info(('CPUs: %d'):format(cpus))
  end
end

local check_readme_tools = function()
  for _, exe in ipairs { 'fzf', 'rg', 'fd' } do
    if vim.fn.executable(exe) == 1 then
      local ver = vim.fn.system({ exe, '--version' }):match '%d[%d%.]+'
      vim.health.ok(string.format('%s: %s', exe, ver or 'found'))
    else
      vim.health.warn(string.format('%s: not found', exe))
    end
  end
end

local check_language_runtimes = function()
  if vim.fn.executable 'node' == 1 then
    local ver = vim.fn.system({ 'node', '--version' }):match '%d[%d%.]+'
    vim.health.ok(string.format('Node.js: %s', ver or 'found'))
  else
    vim.health.warn 'Node.js: not found'
  end

  if vim.fn.executable 'elixir' == 1 then
    local ver = vim.fn.system({ 'elixir', '--version' }):match 'Elixir (%d+%.%d+%.?%d*)'
    vim.health.ok(string.format('Elixir: %s', ver or 'found'))
  else
    vim.health.warn 'Elixir: not found'
  end

  if vim.fn.executable 'erl' == 1 then
    local otp = vim.trim(vim.fn.system { 'erl', '-noshell', '-eval', 'io:format("OTP ~s", [erlang:system_info(otp_release)]), halt().' })
    local erts = vim.fn.system({ 'erl', '-version' }):match '%d+%.%d+%.?%d*'
    vim.health.ok(string.format('Erlang: %s, ERTS %s', otp, erts or '?'))
  else
    vim.health.warn 'Erlang/OTP: not found'
  end

  if vim.fn.executable 'dotnet' == 1 then
    local sdks = vim.fn.systemlist { 'dotnet', '--list-sdks' }
    if #sdks > 0 then
      for _, sdk in ipairs(sdks) do
        vim.health.ok(string.format('.NET SDK: %s', sdk))
      end
    else
      vim.health.warn '.NET: no SDKs found'
    end
  else
    vim.health.warn '.NET: not found'
  end
end

local check_dotnet_tools = function()
  if vim.fn.executable 'dotnet' == 0 then
    return
  end

  local tools = { 'easydotnet', 'dotnet-outdated-tool', 'dotnet-ef' }
  local ok, result = pcall(vim.fn.systemlist, { 'dotnet', 'tool', 'list', '-g' })
  if not ok then
    return
  end

  local installed = {}
  for _, line in ipairs(result) do
    local parts = vim.split(vim.trim(line), '%s+')
    local name = parts[1]
    local ver = parts[2]
    if name then
      installed[name] = ver
    end
  end

  for _, tool in ipairs(tools) do
    local ver = installed[tool]
    if ver then
      vim.health.ok(string.format('dotnet tool %s: %s', tool, ver))
    else
      vim.health.warn(string.format('dotnet tool %s: not installed', tool))
    end
  end
end

local check_nerd_font = function()
  if vim.g.have_nerd_font then
    vim.health.ok 'Nerd Font detected'
  else
    vim.health.warn 'Nerd Font not detected — some UI icons may not render'
  end
end

return {
  check = function()
    vim.health.start 'vk-nvim'

    vim.health.info 'Config-level health overview. Run :checkhealth <plugin> for plugin-specific diagnostics.'

    vim.health.start 'System'
    check_system()
    check_version()
    vim.health.start 'CLI Tools'
    check_readme_tools()
    vim.health.start 'Language Runtimes'
    check_language_runtimes()
    vim.health.start '.NET Tools'
    check_dotnet_tools()
    vim.health.start 'UI'
    check_nerd_font()
  end,
}
