--      ██╗ ██████╗ ██████╗ ███╗   ██╗███████╗
--      ██║██╔════╝██╔═══██╗████╗  ██║██╔════╝
--      ██║██║     ██║   ██║██╔██╗ ██║███████╗
--      ██║██║     ██║   ██║██║╚██╗██║╚════██║
--      ██║╚██████╗╚██████╔╝██║ ╚████║███████║
--      ╚═╝ ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝


-- define icon folder directory
local dir = os.getenv('HOME') .. '/.config/awesome/icons/'

-- return icons
return {
  menu = dir .. 'menu.svg',
  logout = dir .. 'logout.svg',
  sleep = dir .. 'power-sleep.svg',
  power = dir .. 'power.svg',
  lock = dir .. 'lock.svg',
  brightness = dir .. 'brightness.svg',
  volume = dir .. 'volume.svg',
  close = dir .. 'close.svg',
  open = dir .. 'open.svg',
  restart = dir .. 'restart.svg',
  arch = dir .. 'arch.svg'
}
