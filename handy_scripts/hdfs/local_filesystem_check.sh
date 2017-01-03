#!/bin/bash
EXCLUDE_LIST="rootfs"
ALERT_WARN=50
ALERT_CRIT=70
HOST=$HOSTNAME
body="Hi All,

Please be informed that dir is going to be out of space so can you please clean your dir space asap to avoid any further issues.

Regards
Hadoop Admin
"
from="hadoopAdmin@server.com"
ADMIN="saurabh.k4@server.com"
function format_sendmail(){   
   i=0
   df -P > /hdptmp/df
   while read output; do
         if [[ $i -ne 0 ]]; then
            usep=$(echo $output | awk '{ print $5}' | sed 's/.$//')
            part=$(echo $output | awk '{ print $6}' )
            if (( $(echo $usep | awk '{ print ($1 > '$ALERT_CRIT')}') )); then
            	mailx -s "Disk Space Alert: CRITICAL: $HOST Almost out of disk space $usep% on $part" -r "$from" $ADMIN <<< "$body"
	    elif (( $(echo $usep | awk '{ print ($1 > '$ALERT_WARN')}') )); then
            	mailx -s "Disk Space Alert: WARNING:$HOST Almost out of disk space $usep% on $part" -r "$from" $ADMIN <<< "$body"
	    fi
         fi
         i=$(($i + 1)) 
      done   
}
if [ "$EXCLUDE_LIST" != "" ] ; then
   df -P | grep -v "^tmpfs|${EXCLUDE_LIST}" | format_sendmail
else
   df -P | grep -v "^tmpfs" | format_sendmail
fi
