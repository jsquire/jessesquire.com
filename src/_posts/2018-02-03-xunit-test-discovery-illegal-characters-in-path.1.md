---
layout: post
title:  "Visual Studio Fails to Discover Tests Due to Illegal Characters in the Path"
date:   2017-02-03 12:28:12 -0500
category: articles
tags: 
  - xunit 
  - visual-studio
  - development
---
I recently ran into an issue when working on a .NET Core application in which the Visual Studio failed to discover tests with an error about illegal characters in the path, despite the build being successful.  I spent a good amount of time looking over every path that was related to the solution - the project paths, build output paths, NuGet package paths, and any paths in the project configuration.  All to no avail.  

After doing a bunch of searches, and trying a variety of things that didn't work, turns out that the root cause had nothing to do with the solution or its projects.  Rather, it was related to my PATH environment variables.  In my case, the system PATH contained a path segment that was wrapped in double quotes and wasn't playing nice.  Removing the quotes fixed things up and hasn't seemed to have a negative impact in other areas that the PATH is used - at least, not that I've noticed so far.   

I'm not sure if the underlying incompatibility was related to Visual Studio or the xUnit test runner, but thanks to this [xUnit issue](https://github.com/xunit/xunit/issues/1413) for shedding light on the problem.