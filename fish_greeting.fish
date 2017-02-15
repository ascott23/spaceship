# name: spaceship
# A fish theme with spaceships in mind

set -l black      (set_color black)
set -l red        (set_color red)
set -l green      (set_color green)
set -l yellow     (set_color yellow)
set -l blue       (set_color blue)
set -l magenta    (set_color magenta)
set -l cyan       (set_color cyan)
set -l white      (set_color white)
set -l bg_black   (set_color -b black)
set -l bg_red     (set_color -b red)
set -l bg_green   (set_color -b green)
set -l bg_yellow  (set_color -b yellow)
set -l bg_blue    (set_color -b blue)
set -l bg_magenta (set_color -b magenta)
set -l bg_cyan    (set_color -b cyan)
set -l bg_white   (set_color -b white)
set -l normal     (set_color normal)

function fish_greeting #-d "Greeting message on shell session start up"
   echo ""
   echo -en "        |         "(welcome_message) "\n"
   echo -en "       / \        \n"
   echo -en "      / _ \       "(show_date_info) "\n"
   echo -en "     |.o '.|      \n"
   echo -en "     |'._.'|      Your vessel:\n"
   echo -en "     |     |      " (show_os_info) "\n"
   echo -en "   ,'|  |  |`.    " (show_cpu_info) "\n"
   echo -en "  /  |  |  |  \   " (show_mem_info) "\n"
   echo -en "  |,-'--|--'-.|   " (show_net_info) "\n"
   echo ""
   set_color blue
   echo "Have a nice trip"
   set_color normal
end


function welcome_message -d "Say welcome to user"
   echo -en "Welcome aboard captain "
   set_color white
   echo -en (whoami)
   set_color normal
end


function show_date_info -d "Prints information about date"
   set --local up_time (uptime |sed 's/^ *//g' |cut -d " " -f4,5 |tr -d ",")

   echo -en "Today is "
   set_color cyan
   echo -en (date +%Y.%m.%d,)
   set_color normal
   echo -en " we've been up for "
   set_color cyan
   echo -en "$up_time"
   set_color normal
   echo -en "."
end


function show_os_info -d "Prints operating system info"
   set_color yellow
   echo -en "\tOS:     "
   set_color green
   echo -en (uname -sm)
   set_color normal
end


function show_cpu_info -d "Prints information about cpu"
   set --local os_type (uname -s)
   set --local cpu_info ""

   if [ "$os_type" = "Linux" ]
      set --local procs_n (grep -c "^processor" /proc/cpuinfo)
      set --local cores_n (grep "cpu cores" /proc/cpuinfo | head -1 | cut -d ":"  -f2 | tr -d " ")
      set --local cpu_type (grep "model name" /proc/cpuinfo | head -1 | cut -d ":" -f2)
      set cpu_info "$procs_n processors, $cores_n cores, $cpu_type"
   else if [ "$os_type" = "Darwin" ]
      set --local procs_n (system_profiler SPHardwareDataType | grep "Number of Processors" | cut -d ":" -f2 | tr -d " ")
      set --local cores_n (system_profiler SPHardwareDataType | grep "Cores" | cut -d ":" -f2 | tr -d " ")
      set --local cpu_type (system_profiler SPHardwareDataType | grep "Processor Name" | cut -d ":" -f2 | tr -d " ")
      set cpu_info "$procs_n processors, $cores_n cores, $cpu_type"
   end

   set_color yellow
   echo -en "\tCPU:    "
   set_color green
   echo -en $cpu_info
   set_color normal
end


function show_mem_info -d "Prints memory information"
   set --local os_type (uname -s)
   set --local total_memory ""

   if [ "$os_type" = "Linux" ]
      set total_memory (free -h | grep "Mem" | cut -d " " -f 12)

   else if [ "$os_type" = "Darwin" ]
      set total_memory (system_profiler SPHardwareDataType | grep "Memory:" | cut -d ":" -f 2 | tr -d " ")
   end

   set_color yellow
   echo -en "\tMemory: "
   set_color green
   echo -en $total_memory
   set_color normal
end


function show_net_info -d "Prints information about network"
   set --local os_type (uname -s)
   set --local ip ""
   set --local gw ""

   if [ "$os_type" = "Linux" ]
      set ip (ip addr show | grep -v "127.0.0.1" | grep "inet "| sed 's/^ *//g' | cut -d " " -f2)
      set gw (netstat -nr | grep UG | cut -d " " -f10)
   else if [ "$os_type" = "Darwin" ]
      set ip (ifconfig | grep -v "127.0.0.1" | grep "inet " | head -1 | cut -d " " -f2)
      set gw (netstat -nr | grep default | cut -d " " -f13)
   end

   set_color yellow
   echo -en "\tNet:    "
   set_color green
   echo -en "IP: $ip GW: $gw"
   set_color normal
end
