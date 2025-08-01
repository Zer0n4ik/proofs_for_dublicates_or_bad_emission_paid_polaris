#!/bin/bash

curl -H "User-Agent: useragent" -X 'GET' \
                                                                            'https://femi-aristodemos.onrender.com/api/v1/gateway/collections/compute_resources' \
                                                                            -H 'accept: application/json' \
                                                                            -H 'service-name: miner_service' \
                                                                            -H 'X-API-Key: NEED actual to ask developers polaris' -H 'service-key: NEED actual to ask developers polaris' |jq . > compute_resources.json



