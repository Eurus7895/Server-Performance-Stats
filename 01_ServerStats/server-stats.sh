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
get_disk_usage(){
	total=0
	for size in $(df -B1 | awk '(NR>1 && $2 ~ /^[0-9]+$/) {print $2}'); do
		total=$((total +$size)); 
	done;
	numfmt --to=iec $total
}
main(){
	cpu=$(get_cpu_usage)
	mem=$(get_memory_data)
	disk_usage=$(get_disk_usage)
	echo "Total CPU Usage: $cpu%"
	echo "Memory data:"
	echo "$mem"
	echo "Total disk usage: $disk_usage"
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
	main "$@"
fi
