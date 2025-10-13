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

get_top5_cpu_processes(){
	ps -eo pid,user,pcpu,pmem,comm --sort=-pcpu | head -n 6 | awk '{print $3,$5}'		
}

get_top5_mem_processes(){
	ps -eo pid,user,pcpu,pmem,comm --sort=-pmem | head -n 6 | awk '{printf "%s\t%s\n", $4, $5}'
}

main(){
	cpu=$(get_cpu_usage)
	mem=$(get_memory_data)
	disk_usage=$(get_disk_usage)
	top5_cpu_processes=$(get_top5_cpu_processes)
	top5_mem_processes=$(get_top5_mem_processes)

	echo "Total CPU Usage: $cpu%"
	echo -e "\n"
	echo "Memory data:"
	echo "$mem"
	echo -e "\n"
	echo "Total disk usage: $disk_usage"
	echo -e "\n"
	echo -e "Top 5 CPU processes are: \n$top5_cpu_processes\n"
	echo -e "Top 5 MEM processes are: \n$top5_mem_processes\n"
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
	main "$@"
fi
