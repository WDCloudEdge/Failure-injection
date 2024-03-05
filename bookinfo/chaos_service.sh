service=$1
total_count=$2
is_scale=$3
dir="$(dirname "$0")"
sh $dir/$service/cpu_load.sh $total_count $is_scale $service >> $dir/label.txt
sh $dir/$service/mem_load.sh $total_count $is_scale $service >> $dir/label.txt
sh $dir/$service/net_latency.sh $total_count $is_scale $service >> $dir/label.txt