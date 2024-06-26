dir="$(dirname "$0")"
total_count=$1
is_scale=$2
let count=1

for ((i=1;i<=$total_count;i++))
do
	echo $3_net_jitter_$count
	start_timestamp=$(date +%s) 
    start_timestamp=$((start_timestamp - 6 * 60))
    end_timestamp=$((start_timestamp + 12 * 60))

	tc qdisc replace dev raven0 root netem delay 500ms 1000ms
	echo "$(date +"%Y-%m-%d %T") start create."
    sleep 180
	echo "$(date +"%Y-%m-%d %T") start delete."
	tc qdisc del dev raven0 root netem delay 500ms 1000ms
	echo "$(date +"%Y-%m-%d %T") finish delete."
    echo -e "\n"
    sleep 720

	python $dir/log-collect/Log.py $3_net_jitter_$count full $start_timestamp $end_timestamp &
	((count++))
done