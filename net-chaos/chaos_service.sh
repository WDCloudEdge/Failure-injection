total_count=$1
dir="$(dirname "$0")"
sh $dir/net_loss.sh $total_count >> $dir/net_loss_label.txt
sh $dir/net_delay.sh $total_count >> $dir/net_delay_label.txt
sh $dir/net_latency.sh $total_count >> $dir/net_latency_label.txt
sh $dir/net_duplicate.sh $total_count >> $dir/net_duplicate_label.txt
sh $dir/net_corrupt.sh $total_count >> $dir/net_corrupt_label.txt
sh $dir/net_reorder.sh $total_count >> $dir/net_reorder_label.txt