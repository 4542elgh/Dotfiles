#!/bin/sh


# https://github.com/i3/i3/blob/next/contrib/trivial-bar-script.sh
echo '{ "version": 1, "click_events":true }'     # Send the header so that i3bar knows we want to use JSON:
# echo '['                    # Begin the endless array.
# echo '[]'                   # We send an empty first array of blocks to make the loop simpler:

# Now send blocks with information forever:
	echo -n "["
	# vpn
  # mycrypto
  # myip_public
  # myvpn_on

  # myip_local

  # disk_usage

  echo -n "{"
	echo -n "\"full_text\":\" MEM: $(${XDG_CONFIG_HOME}/i3bar/memory_usage)\","
  echo -n "}"

  # memory
  # cpu_usage
 	# openweather 
  #mydate

  # battery0
  # volume
  # systemupdate
  # logout
  echo "]"

# # click events
while read line;
do
#   echo $line > /home/evanliu/tmp.txt
#   # {"name":"id_vpn","button":1,"modifiers":["Mod2"],"x":2982,"y":9,"relative_x":67,"relative_y":9,"width":95,"height":22}

#   # VPN click
  if [[ $line == *"name"*"id_vpn"* ]]; then
    alacritty -e /home/you/.config/i3status/click_vpn.sh &
		# :

#   # CHECK UPDATES
#   elif [[ $line == *"name"*"id_systemupdate"* ]]; then
# 		# termite -e ${XDG_CONFIG_HOME}/i3bar/update.sh &
# 		termite -e "sudo pacman -Syyu" &

#   # CPU
#   elif [[ $line == *"name"*"id_cpu_usage"* ]]; then
#     termite -e gotop &

#   # TIME
#   elif [[ $line == *"name"*"id_time"* ]]; then
#     termite -e calcurse &

#   # OPENWEATHER 
#   elif [[ $line == *"name"*"id_openweather"* ]]; then
#     termite -e "xdg-open https://openweathermap.org/city/5368361" &

#   # CRYPTO
#   # elif [[ $line == *"name"*"id_crypto"* ]]; then
#   #   xdg-open https://www.livecoinwatch.com/ > /dev/null &

#   # VOLUME
#   elif [[ $line == *"name"*"id_volume"* ]]; then
#     termite -e alsamixer &

#   # LOGOUT
#   elif [[ $line == *"name"*"id_logout"* ]]; then
#     i3-nagbar -t warning -m 'Log out ?' -b 'yes' 'i3-msg exit' > /dev/null &

  fi
done
