# GitInfo
> A fresh and transparent approach to Git information retrieval from MSBuild without using any custom tasks or compiled code and tools, obscure settings, format strings, etc. 

## Goals

- No compiled code or tools -> 100% transparency
- Trivially added/installed via *NuGet*
- No format strings or settings to learn
- Single well-structured `.targets` file with plain MSBuild
- Optional embedding of Git info in assembly as metadata
- Optional use of Git info to build arbitrary assembly/file version information
- Trivially modified/improved by just adjusting a single `.targets` file 

## Overview

After installing via *NuGet*:

	PM> Install-Package GitInfo

By default, if the containing project is a C# or VB project, a compile-time generated source file will contain all the git information as metadata that can be accessed from anywhere within the assembly, as constants in a `ThisAssembly` (partial) class and its nested `Git` static class:

	Console.WriteLine(
