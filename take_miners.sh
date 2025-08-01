#!/bin/bash
curl -H "User-Agent: useragent"  -X 'GET' \
                                                                            'https://femi-aristodemos.onrender.com/api/v1/gateway/collections/miners' \
                                                                            -H 'accept: application/json' \
                                                                            -H 'service-name: miner_service' \
                                                                            -H 'X-API-Key: ' -H 'service-key: '|jq . > miners.json
