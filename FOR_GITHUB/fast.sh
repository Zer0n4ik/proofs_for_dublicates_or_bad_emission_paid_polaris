#!/bin/bash

json_file="data.json"

# One jq call: get index, UID, MINER_ID, GLOBAL_ID, BITID, SSH, resource_id, miner_id per resource
jq -r '
.data.miners | to_entries[] as $entry |
  $entry.value.id as $globalid |
  $entry.value.name as $name |
  $entry.value.original_name as $original_name |
  $entry.value.bittensor_registration.miner_uid as $uid |
  $entry.value.bittensor_registration.miner_id as $mid |
  $entry.value.bittensor_registration.id as $bitid |
  $entry.value.bittensor_registration.coldkey as $coldkey |
  $entry.value.bittensor_registration.hotkey as $hotkey |
  $entry.key as $index |
  ($entry.value.compute_resources_details[]? |
    select(.network.ssh? != null) |
	    "\($index) \($uid) \($mid) \($globalid) \($bitid) \($name) \($original_name) \($coldkey) \($hotkey) \(.network.ssh) \(.id) \(.miner_id)")
	    // "\($index) \($uid) \($mid) \($globalid) \($bitid) \($name) \($original_name) \($coldkey) \($hotkey) NO_SSH - -"
' "$json_file" > tmp_data.txt

declare -A resource_count
declare -A ssh_count

current_miner=-1

while read -r index uid mid globalid bitid original_name name coldkey hotkey ssh resource_id resource_miner_id; do
    if [[ "$index" != "$current_miner" ]]; then
        if [[ "$current_miner" != -1 ]]; then
            echo
        fi
        current_miner=$index
        echo "================ Miner $current_miner ================"
        echo "Name: $name"
        echo "Original_name: $original_name"
        echo "UID: $uid"
        echo "MINER_ID: $mid"
        echo "Global miner id: $globalid"
        echo "BitID: $bitid"
        echo "Coldkey: $coldkey"
        echo "Hotkey: $hotkey"
        echo
    fi

    if [[ "$ssh" == "NO_SSH" ]]; then
        echo "No resources with SSH found for MINER_ID: $mid"
    else
        printf "%-40s -> %s | MINER_ID: %s\n" "$ssh" "$resource_id" "$resource_miner_id"
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

