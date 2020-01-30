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
  logout = dir .. 'logout.png',
  sleep = dir .. 'sleep.png',
  power = dir .. 'power.png',
  lock = dir .. 'lock.png',
  brightness = dir .. 'brightness.png',
  volume = dir .. 'volume.png',
  close = dir .. 'close.svg',
  open = dir .. 'open.svg',
  restart = dir .. 'restart.png'
}
