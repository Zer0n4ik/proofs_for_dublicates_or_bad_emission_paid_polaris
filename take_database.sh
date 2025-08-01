curl -H "User-Agent: useragent"  -X 'GET' 'https://femi-aristodemos.onrender.com/api/v1/services/miner/miners' \
  -H 'accept: application/json' -H 'x-api-key: ask dev actual' -H 'service-key: ask dev actual' -H 'service-name: miner_service'| jq . >data.json
