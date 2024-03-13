total_count=$1
dir="$(dirname "$0")"
is_scale=$2
sh $dir/chaos_service.sh "adservice" $total_count $is_scale


