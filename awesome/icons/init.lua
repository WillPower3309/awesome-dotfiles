--      ██╗ ██████╗ ██████╗ ███╗   ██╗███████╗
--      ██║██╔════╝██╔═══██╗████╗  ██║██╔════╝
--      ██║██║     ██║   ██║██╔██╗ ██║███████╗
--      ██║██║     ██║   ██║██║╚██╗██║╚════██║
--      ██║╚██████╗╚██████╔╝██║ ╚████║███████║
--      ╚═╝ ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝


-- define icon folder directory
local dir = os.getenv('HOME') .. '/.config/awesome/icons'

-- return icons
return {
  logout = dir .. '/logout.svg',
  sleep = dir .. '/power-sleep.svg',
  power = dir .. '/power.svg',
  lock = dir .. '/lock.svg',
  brightness = dir .. '/brightness.svg',
  volume = dir .. '/volume.svg',
  chart = dir .. '/chart.svg',
  memory = dir .. '/memory.svg',
  harddisk = dir ..'/harddisk.svg',
  thermometer = dir .. '/thermometer.svg',
  menu = dir .. '/menu.svg',
  restart = dir .. '/restart.svg'
}
