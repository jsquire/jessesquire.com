---
layout: post
title:  "Miner is Not Available for My Private Ethereum Network"
date:   2018-04-19 04:35:23 -0500
category: articles
tags: 
  - blockchain 
  - ethereum
  - development
---
I've been working to build some knowledge and skills around Blockchain technologies lately and was trying to use `geth` as both the server and a miner node for a private network.  I created the network using `geth --datadir=./chaindata/ init ./genesis.json`. After launching the console in another window using `geth attach`, each time that I tried to invoke `miner.start()`, I was met with an error because `miner` was unknown.  Unfortunately, I didn't find much help in searching the web - there seemed to be few, if any, mentions of it.

It turns out that the default set of APIs that `geth` published did not include `miner`, nor did it include `admin` which is often referenced by tutiorials for managing the network.  The good news is that these are easily configured using the `--rpcapi` parameter; launching the network using `geth --datadir=./chaindata/ --rpc --rpcapi "eth,net,web3,admin,personal,miner"` fixed my issue.  
