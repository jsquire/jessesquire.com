---
layout: post
title:  "Truffle Tests Fail to Compile with Solidity 0.4.21"
date:   2018-04-19 05:19:34 -0500
category: articles
tags: 
  - blockchain 
  - ethereum
  - solidity
  - development
---
I was exploring the [Truffle Framework](http://truffleframework.com) for developing against Ethereum and working my way through its [Pet Shop Tutorial](http://truffleframework.com/tutorials/pet-shop) with things going well until I hit the first section on testing.  When I attempted to run the tests that it had me write, I ran into compiler errors against the Truffle assertion library.  It seems that the package was written against v0.4.17 of the Solidity compiler while I'm using the current release, v0.4.21, and there have been breaking changes.   

The fix appears to have already made in the `next` branch in the Truffle repository, but I was able to hack my way around them for the time being.  If you're running into the same issue, you may be able to work around it until the next Truffle package release by replacing `$NPM_ROOT/node_modules/truffle/build/Assert.sol` with the version in this [Gist](https://gist.github.com/jsquire/6f2649f6f50133fc8d7a7f8cb66f7b69).