#!/bin/bash

arch=$(uname -m)
kern=$(uname -r)
ppro=$(cat /proc/cpuinfo | grep processor | wc -l)
vpro=$(cat /proc/cpuinfo | grep processor | wc -l)
aram=$(free -h | grep Mem | awk {'print $2'})
uram=$(free -m | grep Mem | awk {'print $3/$2 * 100'})
amem=$(df -h / | grep / | awk {'print $4'})
umem=$(df -h / | grep / | awk {'print $5'})
upro=$(grep 'cpu ' /proc/stat | awk {'{usage=($2+$4)*100/($2+$4+$5)} {print usage "%"}'})
reeb=$(who -b | awk {'print $3" "$4'})
 lvm=$(lsblk | grep lvm | awk {'if ($1) {print"yes";exit;} else {print"no"}'})
ccon=$(netstat -an | grep ESTABLISHED | wc -l)
user=$(who | wc -l)
ipv4=$(/sbin/ifconfig | grep "inet " | awk 'FNR == 2{print $2}')
 mac=$(ip link | grep ether | awk {'print $2'})
nsud=$(cat /var/log/sudo/sudo.log | wc -l)

wall $" Architecture = $arch, Kernel version = $kern
        Number of Pcpu = $ppro, Vcpu = $vpro
        Available ram = $aram (used:$uram%)
        Available memory = $amem (used:$umem)
        Processor usage = $upro
        Date and time of the last reboot = $reeb
        Is Logical Volume Manager on ? $lvm
        Number of active connection = $ccon
        Number of user(s) = $user
        Ipv4 address = $ipv4, mac adress = $mac
        Number of command with sudo = $nsud
"
