
exec >> details-v1-edge-558f5757fc-2gc72-label.txt

file_path='/home/cron/jupiter-hybrid/bookinfo/details-edge/pod_cpu_load.yaml'

echo ${file_path}

let count=1

for ((i=1;i<=4;i++))
do
	echo cpu_load_$count
	kubectl apply -f ${file_path} -n chaos-mesh
	echo "$(date +"%Y-%m-%d %T") start create."
	sleep 180
	echo "$(date +"%Y-%m-%d %T") start delete."
	kubectl delete -f ${file_path} -n chaos-mesh
	echo "$(date +"%Y-%m-%d %T") finish delete."
	echo -e "\n"
	sleep 720
	((count++))
done