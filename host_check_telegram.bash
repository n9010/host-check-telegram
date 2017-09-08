#/bin/bash


#######################
#TELEGRAM ALERT SCRIPT#
#######################
#Telegram chat id
USERID="<put_id_here>"

#Telegram bot api key
KEY="<put_api_key_here>"

#ping timeout
TIMEOUT="2"

#Number of pings
COUNT=5

URL="https://api.telegram.org/bot$KEY/sendMessage"

#Host list, leave a blank space between them
HOSTS="www.example.xx 192.168.42.42 test.com"

#For each host, do 5 pings, if 3 fails than send a message trough telegram
for myHost in $HOSTS
do
  count=$(ping -c $COUNT $myHost | grep 'received' | awk -F',' '{ print $2 }' | awk '{ print $1 }')
 if [ $count -ge 3 ]; then
        echo
       else
        TEXT="Host $myHost  down! (ping failed) at $(date)"
        curl -s --max-time $TIMEOUT -d "chat_id=$USERID&disable_web_page_preview=1&text=$TEXT" $URL > /dev/null

  fi
done


