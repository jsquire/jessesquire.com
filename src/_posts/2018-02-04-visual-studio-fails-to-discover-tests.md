---
layout: post
title:  "Visual Studio Fails to Discover Tests"
date:   2018-02-04 02:40:10 -0500
category: articles
tags: 
  - xunit 
  - visual-studio
  - development
---
Every once in a while, Visual Studio fails to discover my tests at all.  There's no build error, nor other indication in the output window or IDE... just zero tests discovered.  This seemed to happen often when I was working with Service Fabric and the SDK/tools were updated.   That may, or may not, be coincidence but, anecdotally, I haven't seemed to encounter it outside of that context.

To fix discovery, here's the steps that have helped get me working again:

  - Shut down all instances of Visual Studio
  - Remove the `CompnentModelCache` directory from the application data for the current version of Visual Studio.  For example, for Visual Studio 2017 v15.5.6, I need to delete: `%LocalAppData%\Microsoft\VisualStudio\15.0_7464e363\CompnentModelCache`  
  - Clear out the any unit test runners from the Visual Studio Test Explorer extensions.  To do so, delete `%temp%\VisualStudioTestExplorerExtensions`  
  - Restart Visual Studio.

Though it was written in reference to Visual Studio 2013, this [StackOverflow Thread](https://stackoverflow.com/questions/25304425/visual-studio-2013-doesnt-discover-unit-tests) was incredibly helpful and still relevant to Visual Studio 2017.  It's where I found the right combination to fix my issue after some trial-and-error.  If the above isn't working for you, there's some other advice in the thread that may.