dir="$(dirname "$0")"
total_count=$1
is_scale=$2
let count=1

for ((i=1;i<=$total_count;i++))
do
	echo $3_cpu_load_$count
    start_timestamp=$(date +%s) 
    start_timestamp=$((start_timestamp - 6 * 60))  
	kubectl apply -f $dir/cpu_load.yaml -n chaos-mesh
	echo "$(date +"%Y-%m-%d %T") start create."
    sleep 60
    if [ $is_scale ]; then
        echo "$(date +"%Y-%m-%d %T") start scale up 1."
        kubectl scale deployment catalogue-edge --replicas=$(( $(kubectl get deployment catalogue-edge -n cloud-sock-shop -o=jsonpath='{.spec.replicas}') + 1)) -n cloud-sock-shop
    fi
	sleep 120
	echo "$(date +"%Y-%m-%d %T") start delete."
	kubectl delete -f $dir/cpu_load.yaml -n chaos-mesh
	echo "$(date +"%Y-%m-%d %T") finish delete."
    sleep 60
    before_timestamp=$(date +%s) 
    if [ $is_scale ]; then
        echo "$(date +"%Y-%m-%d %T") start scale down 1."
        python $dir/../log-collect/Log.py $3_cpu_load_$count before $start_timestamp $before_timestamp
        kubectl scale deployment catalogue-edge --replicas=$(( $(kubectl get deployment catalogue-edge -n cloud-sock-shop -o=jsonpath='{.spec.replicas}') - 1)) -n cloud-sock-shop
    fi
    after_timestamp=$(date +%s)
	echo -e "\n"
	sleep $((660 - $after_timestamp + $before_timestamp))
    if [ $is_scale ];then
        end_timestamp=$((before_timestamp + 5 * 60)) 
        python $dir/../log-collect/Log.py $3_cpu_load_$count after $before_timestamp $end_timestamp &
    fi
    ((count++))
done