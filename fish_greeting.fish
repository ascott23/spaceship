# # name: spaceship
# # A fish theme with spaceships in mind


# ## Set this options in your config.fish (if you want to)
# # set -g theme_display_user yes
# # set -g default_user default_username

# set -l black      (set_color black)
# set -l red        (set_color red)
# set -l green      (set_color green)
# set -l yellow     (set_color yellow)
# set -l blue       (set_color blue)
# set -l magenta    (set_color magenta)
# set -l cyan       (set_color cyan)
# set -l white      (set_color white)
# set -l bg_black   (set_color -b black)
# set -l bg_red     (set_color -b red)
# set -l bg_green   (set_color -b green)
# set -l bg_yellow  (set_color -b yellow)
# set -l bg_blue    (set_color -b blue)
# set -l bg_magenta (set_color -b magenta)
# set -l bg_cyan    (set_color -b cyan)
# set -l bg_white   (set_color -b white)
# set -l normal     (set_color normal)

# function fish_greeting #-d "Greeting message on shell session start up"
#     echo ""
#     echo -en "        |         " (welcome_message) "\n"
#     echo -en "       / \        \n"
#     echo -en "      / _ \       " (show_date_info) "\n"
#     echo -en "     |.o '.|      \n"
#     echo -en "     |'._.'|      Space vessel computer:\n"
#     echo -en "     |     |      " (show_os_info) "\n"
#     echo -en "   ,'|  |  |`.    " (show_cpu_info) "\n"
#     echo -en "  /  |  |  |  \   " (show_mem_info) "\n"
#     echo -en "  |,-'--|--'-.|   " (show_net_info) "\n"
#     echo ""
#     $blue
#     echo "Have a nice trip"
#     $normal
# end


# function welcome_message -d "Say welcome to user"

#     echo -en "Welcome aboard captain "
#     $white
#     echo -en (whoami) "!"
#     $normal
# end


# function show_date_info -d "Prints information about date"
#     set --local up_time (uptime |sed 's/^ *//g' |cut -d " " -f4,5 |tr -d ",")

#     echo -en "Today is "
#     $cyan
#     echo -en (date +%Y.%m.%d,)
#     $normal
#     echo -en " we are up and running for "
#     $cyan
#     echo -en "$up_time"
#     $normal
#     echo -en "."
# end


# function show_os_info -d "Prints operating system info"
#     $yellow
#     echo -en "\tOS: "
#     $green
#     echo -en (uname -sm)
#     $normal
# end


# function show_cpu_info -d "Prints iformation about cpu"
#     set --local os_type (uname -s)
#     set --local cpu_info ""

#     if [ "$os_type" = "Linux" ]
#         set --local procs_n (grep -c "^processor" /proc/cpuinfo)
#         set --local cores_n (grep "cpu cores" /proc/cpuinfo | head -1 | cut -d ":"  -f2 | tr -d " ")
#         set --local cpu_type (grep "model name" /proc/cpuinfo | head -1 | cut -d ":" -f2)
#         set cpu_info "$procs_n processors, $cores_n cores, $cpu_type"

#     else if [ "$os_type" = "Darwin" ]
#         set --local procs_n (system_profiler SPHardwareDataType | grep "Number of Processors" | cut -d ":" -f2 | tr -d " ")
#         set --local cores_n (system_profiler SPHardwareDataType | grep "Cores" | cut -d ":" -f2 | tr -d " ")
#         set --local cpu_type (system_profiler SPHardwareDataType | grep "Processor Name" | cut -d ":" -f2 | tr -d " ")
#         set cpu_info "$procs_n processors, $cores_n cores, $cpu_type"
#     end

#     $yellow
#     echo -en "\tCPU: "
#     $green
#     echo -en $cpu_info
#     $normal
# end


# function show_mem_info -d "Prints memory information"
#     set --local os_type (uname -s)
#     set --local total_memory ""

#     if [ "$os_type" = "Linux" ]
#         set total_memory (free -h | grep "Mem" | cut -d " " -f 12)

#     else if [ "$os_type" = "Darwin" ]
#         set total_memory (system_profiler SPHardwareDataType | grep "Memory:" | cut -d ":" -f 2 | tr -d " ")
#     end

#     $yellow
#     echo -en "\tMemory: "
#     $green
#     echo -en $total_memory
#     $normal
# end


# function show_net_info -d "Prints information about network"

#     set --local os_type (uname -s)
#     set --local ip ""
#     set --local gw ""

#     if [ "$os_type" = "Linux" ]
#         set ip (ip addr show | grep -v "127.0.0.1" | grep "inet "| sed 's/^ *//g' | cut -d " " -f2)
#         set gw (netstat -nr | grep UG | cut -d " " -f10)
#     else if [ "$os_type" = "Darwin" ]
#         set ip (ifconfig | grep -v "127.0.0.1" | grep "inet " | head -1 | cut -d " " -f2)
#         set gw (netstat -nr | grep default | cut -d " " -f13)
#     end

#     $yellow
#     echo -en "\tNet: "
#     $green
#     echo -en "Ip address $ip, default gateway $gw"
#     $normal
# end
