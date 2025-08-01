#!/bin/bash

curl  -H "User-Agent: useragent" -X 'GET' \
                                                                            'https://femi-aristodemos.onrender.com/api/v1/gateway/collections/bittensor_miners' \
                                                                            -H 'accept: application/json' \
                                                                            -H 'service-name: miner_service' \
                                                                            -H 'X-API-Key: Not give for secure' -H 'service-key: not give for secure'|jq . > bittensor_miners.json


