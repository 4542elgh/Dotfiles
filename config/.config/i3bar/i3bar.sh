#!/bin/sh

# i3 config in ~/.config/i3/config :
# bar {
#   status_command exec /home/you/.config/i3status/mybar.sh
# }

bg_bar_color="#000000"

# Print a left caret separator
# @params {string} $1 text color, ex: "#FF0000"
# @params {string} $2 background color, ex: "#FF0000"
separator() {
  echo -n "{"
  echo -n "\"full_text\":\"\"," # CTRL+Ue0b2
  echo -n "\"separator\":false,"
  echo -n "\"separator_block_width\":0,"
  echo -n "\"border\":\"$bg_bar_color\","
  echo -n "\"border_left\":0,"
  echo -n "\"border_right\":0,"
  echo -n "\"border_top\":2,"
  echo -n "\"border_bottom\":2,"
  echo -n "\"color\":\"$1\","
  echo -n "\"background\":\"$2\""
  echo -n "}"
}

common() {
  echo -n "\"border\": \"$bg_bar_color\","
  echo -n "\"separator\":false,"
  echo -n "\"separator_block_width\":0,"
  echo -n "\"border_top\":2,"
  echo -n "\"border_bottom\":2,"
  echo -n "\"border_left\":0,"
  echo -n "\"border_right\":0"
}

vpn(){
  local bg="#292b2e"
  separator $bg "#000000"
  vpn=$(ip route get 1 | sed -n 's/.*src \([0-9.]\+\).*/\1/p')
	if [ $vpn != "192.168.50.14" ]; then
		echo -n ",{"
		echo -n "\"color\":\"#4f97d7\","
		echo -n "\"name\":\"vpn\","
		echo -n "\"full_text\":\" VPN: ON\","
		echo -n "\"background\":\"$bg\","
		common
		echo -n "},"
	else 
		:
	fi
}

myip_local() {
  local bg="#444444"
  separator $bg "#292b2e"
  echo -n ",{"
  echo -n "\"color\":\"#d75f87\","
  echo -n "\"name\":\"ip_local\","
  echo -n "\"full_text\":\"  $(ip route get 1 | sed -n 's/.*src \([0-9.]\+\).*/\1/p') \","
  echo -n "\"background\":\"$bg\","
  common
  echo -n "},"
}

memory() {
  local bg="#292b2e"
  separator $bg "#444444"
  echo -n ",{"
  echo -n "\"color\":\"#875faf\","
  echo -n "\"name\":\"id_memory\","
  echo -n "\"full_text\":\" MEM: $(${XDG_CONFIG_HOME}/i3bar/memory_usage)\","
  echo -n "\"background\":\"$bg\","
  common
  echo -n "}"
}

cpu_usage() {
  local bg="#292b2e"
  echo -n ",{"
  echo -n "\"color\":\"#875faf\","
  echo -n "\"name\":\"id_cpu_usage\","
  echo -n "\"full_text\":\" CPU: $(${XDG_CONFIG_HOME}/i3bar/cpu_usage)\","
  echo -n "\"background\":\"$bg\","
  common
  echo -n "},"
}

openweather() {
  local bg="#444444"
  separator $bg "#292b2e"
  echo -n ",{"
  echo -n "\"color\":\"#20ad80\","
  echo -n "\"name\":\"id_openweather\","
  echo -n "\"full_text\":\" $(cat ${XDG_CONFIG_HOME}/i3bar/weather) \","
  echo -n "\"background\":\"$bg\","
  common
  echo -n "},"
}

mydate() {
  local bg="#292b2e"
  separator $bg "#444444"
  echo -n ",{"
  echo -n "\"name\":\"id_time\","
  echo -n "\"full_text\":\" $(date "+%a %m/%d/%Y %H:%M") \","
  echo -n "\"color\":\"#69a2d4\","
  echo -n "\"background\":\"$bg\","
  common
  echo -n "},"
}

volume() {
  local bg="#444444"
  separator $bg "#292b2e"
  vol=$(awk -F"[][]" '/Left:/ { print $2 }' <(amixer sget Master))
  echo -n ",{"
  echo -n "\"name\":\"id_volume\","
  if [ $vol -le 0 ]; then
    echo -n "\"full_text\":\"  ${vol} \","
  else
    echo -n "\"full_text\":\"  ${vol} \","
  fi
  echo -n "\"background\":\"$bg\","
  common
  echo -n "},"
  separator $bg_bar_color $bg
}

systemupdate() {
  local bg="#292b2e"
  # separator $bg "#444444"
  local nb=$(pacman -Qu | wc -l)
  if (( $nb > 0)); then
    echo -n ",{"
    echo -n "\"name\":\"id_systemupdate\","
    echo -n "\"full_text\":\"  ${nb} \""
		# common
    echo -n "}"
  fi
}

# https://github.com/i3/i3/blob/next/contrib/trivial-bar-script.sh
echo '{ "version": 1, "click_events":true }'     # Send the header so that i3bar knows we want to use JSON:
echo '['                    # Begin the endless array.
echo '[]'                   # We send an empty first array of blocks to make the loop simpler:

# Now send blocks with information forever:
(while :;
do
	echo -n ",["
	vpn
  # mycrypto
  # myip_public
  # myvpn_on
  myip_local
  # disk_usage
  memory
  cpu_usage
 	openweather 
  mydate
  # battery0
  volume
  systemupdate
  # logout
  echo "]"
	sleep 2
done) &

# click events
while read line;
do
  echo $line > /home/evanliu/tmp.txt
  # {"name":"id_vpn","button":1,"modifiers":["Mod2"],"x":2982,"y":9,"relative_x":67,"relative_y":9,"width":95,"height":22}

  # VPN click
  if [[ $line == *"name"*"id_vpn"* ]]; then
    # alacritty -e /home/you/.config/i3status/click_vpn.sh &
		:

  # CHECK UPDATES
  elif [[ $line == *"name"*"id_systemupdate"* ]]; then
		# termite -e ${XDG_CONFIG_HOME}/i3bar/update.sh &
		termite -e "sudo pacman -Syyu" &

  # CPU
  elif [[ $line == *"name"*"id_cpu_usage"* ]]; then
    termite -e gotop &

  # TIME
  elif [[ $line == *"name"*"id_time"* ]]; then
    termite -e calcurse &

  # OPENWEATHER 
  elif [[ $line == *"name"*"id_openweather"* ]]; then
    termite -e "xdg-open https://openweathermap.org/city/5368361" &

  # CRYPTO
  # elif [[ $line == *"name"*"id_crypto"* ]]; then
  #   xdg-open https://www.livecoinwatch.com/ > /dev/null &

  # VOLUME
  elif [[ $line == *"name"*"id_volume"* ]]; then
    termite -e alsamixer &

  # LOGOUT
  elif [[ $line == *"name"*"id_logout"* ]]; then
    i3-nagbar -t warning -m 'Log out ?' -b 'yes' 'i3-msg exit' > /dev/null &

  fi  
done
