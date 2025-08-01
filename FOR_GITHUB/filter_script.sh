#!/bin/bash

json_file="data.json"

jq -r '
.data.miners | to_entries[] as $entry |
  $entry.value.id as $globalid |
  $entry.value.name as $name |
  $entry.value.bittensor_registration.miner_uid as $uid |
  $entry.value.bittensor_registration.miner_id as $mid |
  $entry.value.bittensor_registration.id as $bitid |
  $entry.value.bittensor_registration.coldkey as $coldkey |
  $entry.value.bittensor_registration.hotkey as $hotkey |
  $entry.key as $index |
  ($entry.value.compute_resources_details[]? |
    select(.network.ssh? != null) |
    [
      $index,
      $uid,
      $mid,
      $bitid,
      $globalid,
      $name,
      $coldkey,
      $hotkey,
      .network.ssh,
      .id,
      .miner_id,
      .validation_status,
      .monitoring_status.last_monitored,
      .monitoring_status.next_check,
      .monitoring_status.last_check,
      .monitoring_status.auth.status,
      .monitoring_status.conn.status,
      .monitoring_status.pow.status,
      .monitoring_status.docker.status,
      .monitoring_status.docker.version
    ] | @tsv)
' "$json_file" > tmp_data.txt

declare -A resource_count
declare -A ssh_count

current_miner=-1

while IFS=$'\t' read -r index uid mid bitid globalid name coldkey hotkey ssh resource_id resource_miner_id validation_status \
    last_monitored next_check last_check auth_status conn_status pow_status docker_status docker_version; do

    if [[ "$index" != "$current_miner" ]]; then
        if [[ "$current_miner" != -1 ]]; then
            echo
        fi
        current_miner=$index
        echo "================ Miner $current_miner ================"
        echo "Name: $name"
        echo "UID: $uid"
        echo "MINER_ID: $mid"
        echo "BIT ID: $bitid"
        echo "Global miner id: $globalid"
        echo "Coldkey: $coldkey"
        echo "Hotkey: $hotkey"
        echo
    fi

    if [[ "$ssh" == "NO_SSH" ]]; then
        echo "No resources with SSH found for MINER_ID: $mid"
    else
        printf "%-40s -> %s | MINER_ID: %s | Validation: %s\n" "$ssh" "$resource_id" "$resource_miner_id" "$validation_status"
        echo "    [auth: $auth_status] [conn: $conn_status] [pow: $pow_status] [docker: $docker_status - docker_ver: $docker_version]"
	echo "    [MONITORING LAST_MONITORED: $last_monitored ] "
	echo "    [NEXT: $next_check  ]"
	echo "    [LAST: $last_check  ]"
	echo ""
        ((resource_count["$resource_id"]++))
        ((ssh_count["$ssh"]++))
    fi

done < tmp_data.txt

echo
echo "========= Resource ID Occurrences ========="
for id in "${!resource_count[@]}"; do
    echo "${resource_count[$id]} $id"
done | sort -nr

echo
echo "========= SSH Address Occurrences ========="
for s in "${!ssh_count[@]}"; do
    echo "${ssh_count[$s]} $s"
done | sort -nr

rm tmp_data.txt

