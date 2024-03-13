dir="$(dirname "$0")"
total_count=$1
is_scale=$2
let count=1

for ((i=1;i<=$total_count;i++))
do
	echo $3_mem_load_$count
    start_timestamp=$(date +%s) 
    start_timestamp=$((start_timestamp - 6 * 60))  
	kubectl apply -f $dir/mem_load.yaml -n chaos-mesh
	echo "$(date +"%Y-%m-%d %T") start create."
    sleep 60
    if [ $is_scale ]; then
        echo "$(date +"%Y-%m-%d %T") start scale up 1."
        kubectl scale deployment shippingservice --replicas=$(( $(kubectl get deployment shippingservice -n hipster -o=jsonpath='{.spec.replicas}') + 1)) -n hipster
    fi
	sleep 120
	echo "$(date +"%Y-%m-%d %T") start delete."
	kubectl delete -f $dir/mem_load.yaml -n chaos-mesh
	echo "$(date +"%Y-%m-%d %T") finish delete."
    sleep 60
    if [ $is_scale ]; then
        echo "$(date +"%Y-%m-%d %T") start scale down 1."
        before_timestamp=$(date +%s) 
        python $dir/../log-collect/Log.py $3_mem_load_$count before $start_timestamp $before_timestamp
        kubectl scale deployment shippingservice --replicas=$(( $(kubectl get deployment shippingservice -n hipster -o=jsonpath='{.spec.replicas}') - 1)) -n hipster
        after_timestamp=$(date +%s)
    fi
	echo -e "\n"
	sleep $((660 - $after_timestamp + $before_timestamp))
    if [ $is_scale ];then
        end_timestamp=$((before_timestamp + 5 * 60)) 
        python $dir/../log-collect/Log.py $3_mem_load_$count after $before_timestamp $end_timestamp &
    fi
    ((count++))
done