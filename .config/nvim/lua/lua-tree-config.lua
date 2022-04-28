local luv = vim.loop
local reloaders = require'nvim-tree.actions.reloaders'

local function template_fn(command)
  return function(node)
    local process = {
      cmd = command,
      args = {},
      errors = '\n',
      stderr = luv.new_pipe(false)
    }

    local s = vim.fn.input("New "..command..": ", "")
    local path = vim.fn.fnamemodify(node.absolute_path, ':p:h')
    process.handle, process.pid = luv.spawn(process.cmd,
      { args = { s },
        stdio = { nil, nil, process.stderr },
        detached = true,
        cwd = path
      },
      function(code)
        process.stderr:read_stop()
        process.stderr:close()
        process.handle:close()
        if code ~= 0 then
          process.errors = process.errors .. string.format('NvimTree system_open: return code %d.', code)
          error(process.errors)
        else
          vim.schedule_wrap(reloaders.reload_explorer)()
        end
      end
    )
    table.remove(process.args)
    if not process.handle then
      error("\n" .. process.pid .. "\nNvimTree system_open: failed to spawn process using '" .. process.cmd .. "'.")
      return
    end
    luv.read_start(process.stderr,
      function(err, data)
        if err then return end
        if data then process.errors = process.errors .. data end
      end
    )
    luv.unref(process.handle)
  end
end


require'nvim-tree'.setup {
  git = {
    enable = false,
    ignore = false
  },
  actions = {
    open_file = {
      quit_on_open = true
    },
  },
  log = {
    enable = true,
    truncate = true,
    types = {
      git = true,
      profile = true,
    },
  },
  view = {
    width = 60,
    mappings = {
      list = {
        { key = "s", action = "vsplit" },
        { key = "t", action = "tabnew" },
        { key = "U", action = "dir_up" },
        { key = "y", action = "copy" },
        { key = "c", action = "component", action_cb = template_fn("component") },
        { key = "h", action = "hook", action_cb = template_fn("hook") }
      }
    }
  }
}

