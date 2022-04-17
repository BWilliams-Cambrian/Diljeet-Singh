#!/bin/bash
users=0
groups=0
function username () {
    first=`echo $1`
    last=`echo $2`
    department=`echo $3`
    firstletter=`echo "${first:0:1}"`
    firstletter=`echo "${firstletter,,}"`
    lastchars=`echo "${last:0:7}"`
    lastchars=`echo "${lastchars,,}"`
    department=`echo "${department,,}"`
    department=`echo "${department//$'\r'/}"`
    username=`echo "$firstletter$lastchars"`
}
while IFS="," read -r first last department 
do 
    username $first $last $department
    user_output=`echo "$(awk -F: '{ print $1}' /etc/passwd | grep $username)"`
    if [ -z "$user_output" ];  then
        echo "username doesnt exist = $username"
        echo "creating user $username"
        sudo adduser $username --disabled-password --gecos ""
        ((users++))
    else 
        echo "This user $username already exist"
    fi
    echo "Creating group for department"
    group_output=`echo "$(sudo awk -F: '{ print $1}' /etc/group | grep ^$department)"`
    if [ -z "$group_output" ]; then
        echo "Group doesn't exist = $department"
        echo "creating group $department"
        sudo /usr/sbin/groupadd $department
        ((groups++))
    else
        echo "This group $department already exist"
    fi
    echo "Assigning Group $department to User $username"
    echo "$(sudo usermod -g $department $username)"
done < <(tail -n +2 EmployeeNames.csv)
echo "$users is number of users created"
echo "$groups is number of groups created"


