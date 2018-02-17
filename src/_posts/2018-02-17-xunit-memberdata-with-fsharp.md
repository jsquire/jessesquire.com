---
layout: post
title:  "Using xUnit Theory Member Data with F#"
date:   2018-02-17 01:03:16 -0500
category: articles
tags: 
  - xunit 
  - f#
  - development
---
I've been using an introductory book on machine learning as an excuse to start cuddling up to F# again, after letting my skills deteriorate.  I'm adding unit tests into the mix with the book materials, using FsUnit with xUnit.  In doing so, I struggled a bit to get a `Theory` based on member data working correctly.  

I wasn't able to turn much up in a few searches, so I wanted to capture it here, lest I forget again in the future.   The basic structure that worked for me was:

```fsharp
namespace MachineLearningBook.SpamDetector.UnitTests
    module DocumentTests =

        open FSharp.Reflection
        open MachineLearningBook.SpamDetector
        open Xunit
        open FsUnit.Xunit

        type ``Parsing a DocType should produce the expected results`` () =
            
            static member DocTypeNameData 
                with get() = 
                    FSharpType.GetUnionCases typeof<Document.DocType> 
                    |> Seq.map (fun case -> [| case.Name |])

            
            [<Theory>]
            [<MemberData("DocTypeNameData")>]            
            member verify.``Exact DocTypes can be parsed`` (docTypeName:string) =
                let result = Document.DocType.parse docTypeName
                
                result.IsSome |> should be True
                result.Value.ToString() |> should equal docTypeName
``` 

Hopefully, that helps someone (or future me) to avoid some pain.
