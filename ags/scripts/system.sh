#!/bin/bash

get_cpu_usage() {
    top -bn1 | grep "Cpu(s)" | \
    awk '{printf "%.0f\n", $2 + $4 + $6}'
}

get_ram_usage() {
    free -m | awk 'NR==2{printf "%.0f\n", $3*100/$2 }'
}

get_swap_usage() {
    free -m | awk 'NR==3{printf "%.0f\n", $3*100/$2 }'
}

get_cpu_temp() {
    sensors | grep -i 'core ' | awk '{sum+=$3; count+=1} END {if (count > 0) print sum/count; else print "Undefined"}'
}

get_cpu_name() {
    lscpu | awk -F ': +' '/Model name/ {sub(" @ .*", "", $2); print $2}'
}

get_ram() {
    free -h | grep Mem | awk '{print $2}'
}

get_kernel() {
    uname -r
}

if [[ "$1" == "--cpu-usage" ]]; then
    get_cpu_usage
    elif [[ "$1" == "--ram-usage" ]]; then
    get_ram_usage
    elif [[ "$1" == "--swap-usage" ]]; then
    get_swap_usage
    elif [[ "$1" == "--cpu-temp" ]]; then
    get_cpu_temp
    elif [[ "$1" == "--cpu-name" ]]; then
    get_cpu_name
    elif [[ "$1" == "--cpu-cores" ]]; then
    nproc
    elif [[ "$1" == "--ram" ]]; then
    get_ram
    elif [[ "$1" == "--kernel" ]]; then
    get_kernel
fi