***********************************************************
As we know we do not have direct delet option in ambari to delete ldap users. So This script will help you to delete users from ambari UI/DB.

***********************************************************
To run this script you need to follow the given steps. 

Prerequisites:
1. Keep handy your ambari server name
2. Keep handy your user'name which you want to delete
3. You shoud be ambari admin to delet any user.

Example: 
Before you try it first download it into your required folder then follow teh steps. 

[ambari@server script]$ ./delete_users.sh 
*******************************************
Welcome to Ambari User delete Script.
I am happy to help you!
*******************************************
Please enter Ambari server name: <ambari_server>          
Please enter user's window's id: sampleuser
So you want to delet sampleuser from ambari portal,
Are you sure? (y/n) y
Enter Admin login id: saurkuma
Enter Admin password: 
User sampleuser deleted. 

Notes: 
1. It will give you an error if your entered user does not exist. 
2. It will give you an error if you pass wrong admin username or password.
3. It will give you an error if you entered wrong ambari server name. 

Please feel free to give your feedback. 
