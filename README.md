# GitInfo
> A fresh and transparent approach to Git information retrieval from MSBuild and Code without 
> using any custom tasks or compiled code and tools, obscure settings, format strings, etc. 

[![Build status](https://ci.appveyor.com/api/projects/status/p9e5xdd86vnfe0q8?svg=true)](https://ci.appveyor.com/project/MobileEssentials/gitinfo) 
[![Latest version](https://img.shields.io/nuget/v/GitInfo.svg)](https://www.nuget.org/packages/GitInfo)
[![Downloads](https://img.shields.io/nuget/dt/GitInfo.svg)](https://www.nuget.org/packages/GitInfo)
[![License](http://img.shields.io/:license-MIT-blue.svg)](opensource.org/licenses/mit-license.php)

## Goals

- No compiled code or tools -> 100% transparency
- Trivially added/installed via [a NuGet package](https://www.nuget.org/packages/GitInfo)
- No format strings or settings to learn
- Single well-structured [.targets file](https://github.com/kzu/GitInfo/blob/master/src/GitInfo/build/GitInfo.targets) 
  with plain MSBuild and no custom tasks
- [Optional embedding](https://github.com/kzu/GitInfo/blob/master/src/GitInfo/build/GitInfo.targets#L51) 
  of Git info in assembly [as metadata](https://github.com/kzu/GitInfo/blob/master/src/GitInfo/build/GitInfo.cs.pp#L4)
- Optional use of Git info to build arbitrary assembly/file version information, both 
  [in C#](https://github.com/kzu/GitInfoDemo/blob/master/GitInfoDemo/Properties/AssemblyInfo.cs#L10) as well 
  [as VB](https://github.com/kzu/GitInfoDemo/blob/master/GitInfoDemoVB/My%20Project/AssemblyInfo.vb#L8).
- Trivially modified/improved generated code by just adjusting a 
  [C#](https://github.com/kzu/GitInfo/blob/master/src/GitInfo/build/GitInfo.cs.pp) or 
  [VB](https://github.com/kzu/GitInfo/blob/master/src/GitInfo/build/GitInfo.vb.pp) template 
  included in the [NuGet package](https://www.nuget.org/packages/GitInfo)
- Easily modified/improved by just adjusting a 
  [single .targets file](https://github.com/kzu/GitInfo/blob/master/src/GitInfo/build/GitInfo.targets) 
- 100% incremental build-friendly and high-performing (all proper Inputs/Outputs in place, smart caching of Git info, etc.)

## Overview

After installing via [NuGet](https://www.nuget.org/packages/GitInfo):

	PM> Install-Package GitInfo

By default, if the containing project is a C# or VB project, a compile-time generated source file will contain 
all the git information and can be accessed from anywhere within the assembly, as constants in a 
`ThisAssembly` (partial) class and its nested `Git` static class:

	Console.WriteLine(ThisAssembly.Git.Commit);

All generated constants also have a Summary documentation tag that shows the current 
value in the intellisense tooltip, making it easier to see what the different values contain:

![](https://raw.github.com/kzu/GitInfo/master/img/tooltip.png)

> NOTE: you may need to close and reopen the solution in order 
> for Visual Studio to refresh intellisense and show the 
> ThisAssembly type the first time after installing the package.

With this information at your fingertips, you can build any versioning attributes you want, 
with whatever information you want, without resorting to settings, format strings or anything, 
just plain code:

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

Because this information is readily available whenever you build the project, you 
never depend on CI build scripts that generate versions for you, and you can 
always compile locally exactly the same version of an assembly that was built by 
a CI server.

You can read more about this project at the 
[GitInfo announcement blog post](http://www.cazzulino.com/git-info-from-msbuild-and-code.html).
