let's say it's a bit late, but the polaris proofs. It describes the methods of how I got information from the database and describe how mining generally happens and so on. All for the review of the bittensor guide.

The data may not be completely relevant at the time of reading, please refer to the polaris manual for updates. And check the integrity of the subnet, please.

The fact that you use phantom mining or fake servers (I don't know what else to call it) Fake servers are created directly into the database and they bypass the monitoring system, for which these fake servers receive rewards! and there are 1000+ such servers. And your concept won't be able to rent them out to others. And ordinary miners get many times less, that's what I wanted to show you, because the developers still can't understand it!!! total alpha emissions per day 2960 so these fake servers get about 2500 alpha every day!!! And for at least 4 weeks now And when your condition improves and you raise the price, he will sell his coins and the price will fall again and the subnet will not be able to grow. (if not developers fake servers and hidden mining) You have 3 database tables, (Firestone database)

- 1 compute_resource (example curl request in take_compute_resources.sh saved on compute_resources.json)
- 2 miners (example curl request in take_miners.sh saved on miners.json)
- 3 bittensor_miners (example curl request in take_bittensor_miners.sh saved on bittensor_miners.json)

And they are connected to each other and when monitoring checks compute_resource They end up in the next business database , where there are links to all these tables.

And at the same time, the miners are credited from this common database.

The hacker added fake servers to this shared database alone! and they receive awards directly, although they are not recorded in compute_resources,miners,bittensor_miners and cannot be interviewed by monitoring.

I'll turn to how I received the data when the developers were working transparently and did not enter a whitelist of ip addresses for validators.

these are simple post, get, put, and other api requests. So I didn't do anything special. Although the developers themselves offered to cooperate, which I agreed to, and then they simply did not respond for several days.

I'll turn to how I received the data when the developers were working transparently and did not enter a whitelist of ip addresses for validators.

these are simple post, get, put, and other api requests. So I didn't do anything special. Although the developers themselves offered to cooperate, which I agreed to, and then they simply did not respond for several days.

I'll turn to how I received the data when the developers were working transparently and did not enter a whitelist of ip addresses for validators.

these are simple post, get, put, and other api requests. So I didn't do anything special. Although the developers themselves offered to cooperate, which I agreed to, and then they simply did not respond for several days. There are 3 tables, and in normal operation they are all combined into one reward table. which is taken by the following query. I'll call it a business table or a business database.

  **take buissnes database (example take_database.sh saved on data.json) or command**
```    
curl -H "User-Agent: useragent"  -X 'GET' 'https://femi-aristodemos.onrender.com/api/v1/services/miner/miners' \
  -H 'accept: application/json' -H 'x-api-key: ask dev actual' -H 'service-key: ask dev actual' -H 'service-name: miner_service'| jq . >data.json
```

**Right now, these scripts will only work if you ask the developers for all the api data. Because they have blocked API access to other ip addresses(just access ip addresses devs, and any new validators can't run validator).**

The FOR_GITHUB directory contains the latest data I downloaded and you can see for yourself at the time of download on about July 19th. Only bittensor_miners.I downloaded the json earlier... there's only 1 main script that just filters the data.json script filter_script.sh . It will simply display how many duplicates there are (output at the end of the script), when the last version monitoring date was, and their correlation with other tables that I mentioned earlier.

 bash filter_script.sh > filtered_data.txt So that's the real catch, and the developers either pretend they don't understand it, or they're just mining it themselves.

There are some servers that were last monitored on July 7-8.9. And they are available only in data.json, although if you actually add servers via the app, they start to be monitored immediately and every N minutes. So the data is for July 19, 2025, and it turns out that the servers have been inactive for 10 days and receive a reward. And I am more than sure that there is the same data on fake servers now.

**There are no fake servers in the 3 tables that I indicated earlier, which means they were added in some other way or by the developers themselves directly to the buisness database. miner_id and id not valid with tables**

how to easily verify the integrity of the server. For anyone who understands how ssh works in a primitive. Then the ssh server should respond at least something when accessing it.

- 1 connection refused
- 2 permission denied
- 3 ask password

I have indicated the basic ssh server responses above. But there is no response in the fake servers and fake data, which may mean that there is no ssh server on the port or no service at all. And the statuses are verified and they receive rewards. CHECK this UIDS coldkeys for exmaple in real actual table

- UIDS: 66,206,117,197,118 - 5CzJrbx4bkZxjXkNutQzfSPgywihiMJaQdHhgUorv9nykfjd
- UIDS: 76,37,162,172 - 5EhH4mbpLu8kbb4ydn3Ph3uQLVGdttMhHAZWemZXFG4Wkm2m
- UIDS: 228, 84,171,51,135 - 5GbKvpicATM6dwzyaTnogHz6pekDq28tFi9nge3PFqoC7FPk
- UIDS: 227,16,226,230,56 - 5FUAjtooFvmHrw27ocRYemjAYweuw7y3gXibm3bYxTnpjGG3

**You can ask the developers for up-to-date buisness database data. save to data.json put it near filter_script.sh and run the script filter_script.sh . To check that I'm not lying to you.**

EXMAPLE FOR 135 any 1 fake server SEE MONITORING_LAST_MONITORED 2025-07-08 and verified him servers

================ Miner 113 ================
Name: avenger
UID: 135
MINER_ID: NyV527B8zXubQHF0ZurQ
BIT ID: 1Mc7svhKJJxGfjjJrxDg
Global miner id: NyV527B8zXubQHF0ZurQ
Coldkey: 5GbKvpicATM6dwzyaTnogHz6pekDq28tFi9nge3PFqoC7FPk
Hotkey: 5GbNgUaD9tY7Yb8rkLRz3UPKHxZcN9GUjwHdwMGGLM66sv6E

ssh://root@78.46.84.169:8080             -> a2429411-7761-4f2e-9506-c58323bf9f90 | MINER_ID: NyV527B8zXubQHF0ZurQ | Validation: verified
    [auth: ok] [conn: ok] [pow: ok] [docker: ok - docker_ver: Docker version 25.0.3, build afdd53b]
    [MONITORING LAST_MONITORED: 2025-07-08T14:27:41.420 ]
    [NEXT: 2025-07-08T17:35:41.420  ]
    [LAST: 2025-07-08T14:28:41.420  ]

ssh://root@186.179.169.22:3128           -> b8ce11d4-d081-43af-ae54-a3569b788a63 | MINER_ID: NyV527B8zXubQHF0ZurQ | Validation: verified
    [auth: ok] [conn: ok] [pow: ok] [docker: ok - docker_ver: Docker version 25.0.3, build afdd53b]
    [MONITORING LAST_MONITORED: 2025-07-08T14:15:41.420 ]
    [NEXT: 2025-07-08T15:35:41.420  ]
    [LAST: 2025-07-08T14:34:41.420  ]


**Due to the fact that I just wanted to prove my innocence and the dishonesty of the subnet, I was banned from bittensor, please review the data that I provided. I was just telling the truth.**
