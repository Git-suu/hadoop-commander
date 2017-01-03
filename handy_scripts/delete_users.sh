#!/usr/bin/env bash

echo "*******************************************"
echo "Welcome to Ambari User delete Script."
echo "I am happy to help you!"
echo "*******************************************"
##echo "Please enter user's window's id:"
read -p "Please enter Ambari server name: " ambariserver
read -p "Please enter user's window's id: " name
echo "So you want to delet $name from ambari portal,"
read -p "Are you sure? (y/n) " RESP
if [ "$RESP" = "y" ]; then
	 read -p "Enter Admin login id: " username
	 read -s -p "Enter Admin password: " password
	response=`curl --insecure --fail -u $username:$password -H 'X-Requested-By: ambari' -X GET http://$ambariserver:8080/api/v1/users/$name 2>&1`
	if [[ "$response" == *"403"* ]]
	 then
		echo -e "\033[1;31m \nInvalid username or password combination\e[m";
	elif [[ "$response" == *"404"* ]]
	 then 
		echo -e "\033[1;31m \n$name does not exist.\e[m";
	else
		curl --insecure -u $username:$password -H 'X-Requested-By: ambari' -X DELETE http://$ambariserver:8080/api/v1/users/$name
		echo -e "\nUser \033[4;34m$name\e[m deleted.";
	fi
else
  echo "Thank God! You saved me, I was about to delete user $name by mistake."
fi
