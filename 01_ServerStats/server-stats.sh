#!/bin/bash

# Total CPU usage 
get_cpu_usage(){
    	top -bn1 | awk '/Cpu/' | awk '{print 100 - $8"%"}'
}

get_memory_data(){
	top -bn1 | awk '/MiB Mem/{
	print "Free: " ($6/$4)*100"%"
	print "Used: " ($8/$4)*100"%"}'
}
cpu=$(get_cpu_usage)
mem=$(get_memory_data)
echo "Total CPU Usage: $cpu%"
echo "Memory data:"
echo "$mem"

