#!/bin/bash
#**************************************************************
### This script will help you to list out top 15 hdfs dir which are consuming more space. 
#***************************************************************
echo "***********************************************************************************************************"
echo -e "\nYou can do your other work or play some nice game while we calculating size."
echo -e "\n******************************************************************************************************"
for dir in `hadoop fs -ls /|awk '{print $8}'`;do hadoop fs -du $dir/* 2>/dev/null;done|sort -k1,1nr|head -15 > /tmp/size.txt
echo "|  ---------------------------          |  -----------        |  ------------  |  ----------     ------  |" > /tmp/tmp
echo "| Dir_on_HDFS | Size_in_GB | User | Last_modified Time |" >> /tmp/tmp
echo "|  ---------------------------          |  -----------        |  ------------  |  ----------     ------  |" >> /tmp/tmp
while read line;
do
        size=`echo $line|cut -d' ' -f1`
        size_gb=`echo "scale=2; $size/1073741824" | bc`        
	path=`echo $line|cut -d' ' -f2`
        dirname=`echo $path|rev|cut -d'/' -f1|rev`
        parent_dir=`echo $path|rev|cut -d'/' -f2-|rev`
        fs_out=`hadoop fs -ls $parent_dir|grep -w $dirname`
        user=`echo $fs_out|grep $dirname|awk '{print $3}'`
        ##group=`echo $fs_out|grep $dirname|awk '{print $4}'`
        last_mod=`echo $fs_out|grep $dirname|awk '{print $6,$7}'`
        echo "| $path | $size_gb | $user | $last_mod |" >> /tmp/tmp
done < /tmp/size.txt

cat /tmp/tmp | column -t
echo -e "\n******************************************************************************************************"
