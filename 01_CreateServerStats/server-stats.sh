#!/bin/bash

# Total CPU usage 
get_cpu_usage(){
    cpu_1=($(grep '^cpu ' /proc/stat))
    idle_1=${cpu_1[4]}
    total_1=0
    for val in "${cpu_1[@]:1}"; do
	total_1=$((total_1 + val))
    done
    
    sleep 1    

    cpu_2=($(grep '^cpu ' /proc/stat))
    idle_2=${cpu_2[4]}
    total_2=0
    for val in "${cpu_2[@]:1}"; do
        total_2=$((total_2 + val))
    done
    
    idle=$((idle_2 - idle_1))
    total=$((total_2 - total_1))
    cpu_usage=$(echo "scale=2; (100*($total-$idle)/$total)" | bc) 

    echo "$cpu_usage"
}

cpu=$(get_cpu_usage)
echo "Total CPU Usage: $cpu%"


