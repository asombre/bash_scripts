#!/bin/bash

network_ip="10.0.0"
first_host=100
last_host=150
good_list=()
bad_list=()

for i in {10..20}; do a=$(ping -c1 10.0.0.$i); if [[ \"$a\" == *ttl* ]]; then echo $i-ok; else $i-x; fi; done

for i in $(seq $first_host $last_host); do
    ping_results="$(ping -c1 $network_ip.$i)"
    if [[ \"$ping_results\" == *ttl* ]]; then
		echo -e "\033[32mok: $i\033[m"
        good_list+=("$i")
    else
    		echo -e "\033[31mloss: $i\033[m"
        bad_list+=("$i")
    fi
done
total_good=${#good_list[@]}
total_bad=${#bad_list[@]}
echo "good($total_good): ${good_list[@]}"
echo "bad($total_bad): ${bad_list[@]}"
echo "total: $(( $total_good + $total_bad ))"