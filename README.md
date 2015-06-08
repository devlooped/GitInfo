# GitInfo
> A fresh and transparent approach to Git information retrieval from MSBuild without using any custom tasks or compiled code and tools, obscure settings, format strings, etc. 

## Goals

- No compiled code or tools -> 100% transparency
- Trivially added/installed via [a NuGet package](https://www.nuget.org/packages/GitInfo)
- No format strings or settings to learn
- Single well-structured [.targets file](https://github.com/kzu/GitInfo/blob/master/src/build/GitInfo.targets) with plain MSBuild
- [Optional embedding](https://github.com/kzu/GitInfo/blob/master/src/build/GitInfo.targets#L53) of Git info in assembly [as metadata](https://github.com/kzu/GitInfo/blob/master/src/build/GitInfo.cs#L3)
- Optional use of Git info to build arbitrary assembly/file version information, both [in C#](https://github.com/kzu/GitInfoDemo/blob/master/GitInfoDemo/Properties/AssemblyInfo.cs#L10) as well [as VB](https://github.com/kzu/GitInfoDemo/blob/master/GitInfoDemoVB/My%20Project/AssemblyInfo.vb#L8).
- Trivially modified/improved generated code by just adjusting a [C#/VB template file](https://github.com/kzu/GitInfo/blob/master/src/build/GitInfo.cs) included in the [NuGet package](https://www.nuget.org/packages/GitInfo)
- Easily modified/improved by just adjusting a [single .targets file](https://github.com/kzu/GitInfo/blob/master/src/build/GitInfo.targets) 
- 100% incremental build-friendly and high-performing (all proper Inputs/Outputs in place, smart caching of Git info, etc.)

## Overview

After installing via [NuGet](https://www.nuget.org/packages/GitInfo):

	PM> Install-Package GitInfo

By default, if the containing project is a C# or VB project, a compile-time generated source file will contain all the git information as metadata that can be accessed from anywhere within the assembly, as constants in a `ThisAssembly` (partial) class and its nested `Git` static class:

	Console.WriteLine(ThisAssembly.Git.Commit);

All generated constants also have a Summary documentation tag that shows the current value in the intellisense tooltip, making it easier to see what the different values contain:

![](https://raw.github.com/kzu/GitInfo/master/img/tooltip.png)

> NOTE: you may need to close and reopen the solution in order 
> for Visual Studio to refresh intellisense and show the 
> ThisAssembly type.

With this information at your fingertips, you can build any versioning attributes you want, with whatever information you want, without resorting to settings, format strings or anything, just plain code:

C#:
```
[assembly: AssemblyVersion (ThisAssembly.Git.BaseVersion.Major + "." + ThisAssembly.Git.BaseVersion.Minor + "." + ThisAssembly.Git.BaseVersion.Patch)]

[assembly: AssemblyFileVersion (ThisAssembly.Git.SemVer.Major + "." + ThisAssembly.Git.SemVer.Minor + "." + ThisAssembly.Git.SemVer.Patch)]

[assembly: AssemblyInformationalVersion (
	ThisAssembly.Git.SemVer.Major + "." + 
	ThisAssembly.Git.SemVer.Minor + "." + 
	ThisAssembly.Git.Commits + "-" + 
	ThisAssembly.Git.Branch + "+" + 
	ThisAssembly.Git.Commit)]
```

VB:
```
<Assembly: AssemblyVersion(ThisAssembly.Git.BaseVersion.Major + "." + ThisAssembly.Git.BaseVersion.Minor + "." + ThisAssembly.Git.BaseVersion.Patch)>
<Assembly: AssemblyFileVersion(ThisAssembly.Git.SemVer.Major + "." + ThisAssembly.Git.SemVer.Minor + "." + ThisAssembly.Git.SemVer.Patch)>
<Assembly: AssemblyInformationalVersion(
    ThisAssembly.Git.SemVer.Major + "." +
    ThisAssembly.Git.SemVer.Minor + "." +
    ThisAssembly.Git.Commits + "-" +
    ThisAssembly.Git.Branch + "+" +
    ThisAssembly.Git.Commit)>
```