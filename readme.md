![Icon](https://raw.githubusercontent.com/devlooped/GitInfo/main/assets/images/git.png) GitInfo
============

Git Info from MSBuild, C# and VB

> A fresh and transparent approach to Git information retrieval from MSBuild and Code without 
> using any custom tasks or compiled code and tools, obscure settings, format strings, etc. 

[![Build status](https://ci.appveyor.com/api/projects/status/p9e5xdd86vnfe0q8?svg=true)](https://ci.appveyor.com/project/MobileEssentials/gitinfo) 
[![Latest version](https://img.shields.io/nuget/v/GitInfo.svg)](https://www.nuget.org/packages/GitInfo)
[![Downloads](https://img.shields.io/nuget/dt/GitInfo.svg)](https://www.nuget.org/packages/GitInfo)
[![License](http://img.shields.io/:license-MIT-blue.svg)](opensource.org/licenses/mit-license.php)

## Usage

After installing via [NuGet](https://www.nuget.org/packages/GitInfo):

	PM> Install-Package GitInfo

By default, if the containing project is a C#, F# or VB project, a compile-time generated source file will contain 
all the git information and can be accessed from anywhere within the assembly, as constants in a 
`ThisAssembly` (partial) class and its nested `Git` static class:

	Console.WriteLine(ThisAssembly.Git.Commit);

All generated constants also have a Summary documentation tag that shows the current 
value in the intellisense tooltip, making it easier to see what the different values contain:

![](https://raw.githubusercontent.com/devlooped/GitInfo/main/assets/images/tooltip.png)

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

F#:
```
module AssemblyInfo

open System.Reflection

[<assembly: AssemblyVersion (ThisAssembly.Git.BaseVersion.Major + "." + ThisAssembly.Git.BaseVersion.Minor + "." + ThisAssembly.Git.BaseVersion.Patch)>]

[<assembly: AssemblyFileVersion (ThisAssembly.Git.SemVer.Major + "." + ThisAssembly.Git.SemVer.Minor + "." + ThisAssembly.Git.SemVer.Patch)>]

[<assembly: AssemblyInformationalVersion (
    ThisAssembly.Git.SemVer.Major + "." + 
    ThisAssembly.Git.SemVer.Minor + "." + 
    ThisAssembly.Git.Commits + "-" + 
    ThisAssembly.Git.Branch + "+" + 
    ThisAssembly.Git.Commit)>]

do ()
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

## Details

Exposes the following information for use directly from any MSBuild 
target that depends on the GitInfo target:

```
  $(GitRepositoryUrl)
  $(GitBranch)
  $(GitCommit)
  $(GitCommitDate)
  $(GitCommits)
  $(GitTag)
  $(GitBaseTag)
  $(GitBaseVersionMajor)
  $(GitBaseVersionMinor)
  $(GitBaseVersionPatch)
  $(GitSemVerMajor)
  $(GitSemVerMinor)
  $(GitSemVerPatch)
  $(GitSemVerLabel)
  $(GitSemVerDashLabel)
  $(GitSemVerSource)
  $(GitIsDirty)
```

From C#, F# and VB, by default code is generated too so that the same 
information can be accessed from code, to construct your own 
assembly/file version attributes with whatever format you want:

```csharp
[assembly: AssemblyVersion (ThisAssembly.Git.SemVer.Major + "." + ThisAssembly.Git.SemVer.Minor + "." + ThisAssembly.Git.SemVer.Patch)]
[assembly: AssemblyInformationalVersion (
  ThisAssembly.Git.SemVer.Major + "." +
  ThisAssembly.Git.SemVer.Minor + "." +
  ThisAssembly.Git.SemVer.Patch + "-" +
  ThisAssembly.Git.Branch + "+" +
  ThisAssembly.Git.Commit)]
// i..e ^: 1.0.2-main+c218617
```

> NOTE: you may need to close and reopen the solution in order 
> for Visual Studio to refresh intellisense and show the 
> ThisAssembly type right after package installation for 
> the first time.

All generated constants also have a Summary documentation tag 
that shows the current value in the intellisense tooltip, making 
it very easy to see what the different values contain.

The available constants from code are:

```
  ThisAssembly.Git.RepositoryUrl
  ThisAssembly.Git.Branch
  ThisAssembly.Git.Commit
  ThisAssembly.Git.Commits
  ThisAssembly.Git.Tag
  ThisAssembly.Git.BaseTag
  ThisAssembly.Git.BaseVersion.Major
  ThisAssembly.Git.BaseVersion.Minor
  ThisAssembly.Git.BaseVersion.Patch
  ThisAssembly.Git.SemVer.Major
  ThisAssembly.Git.SemVer.Minor
  ThisAssembly.Git.SemVer.Patch
  ThisAssembly.Git.SemVer.Label
  ThisAssembly.Git.SemVer.DashLabel
  ThisAssembly.Git.SemVer.Source
  ThisAssembly.Git.IsDirty
```

Available MSBuild customizations:

```
  $(GitThisAssembly): set to 'false' to prevent assembly 
                      metadata and constants generation.

  $(GitThisAssemblyMetadata): set to 'false' to prevent assembly 
                              metadata generation only. Defaults 
                              to 'false'.

  $(ThisAssemblyNamespace): allows overriding the namespace
                            for the ThisAssembly class.
                            Defaults to the global namespace.

  $(GitRemote): name of remote to get repository url for.
                Defaults to 'origin'.

  $(GitDefaultBranch): determines the base branch used to 
                       calculate commits on top of current branch.
                       Defaults to 'master'.

  $(GitVersionFile): determines the name of a file in the Git 
                     repository root used to provide the base 
                     version info.
                     Defaults to 'GitInfo.txt'.

  $(GitInfoReportImportance): allows rendering all the retrieved
                              git information with the specified
                              message importance ('high', 
                              'normal' or 'low').
                              Defaults to 'low'.

  $(GitIgnoreBranchVersion) and $(GitIgnoreTagVersion): determines 
                            whether the branch and tags (if any) 
                            will be used to find a base version.
                            Defaults to empty value (no ignoring).

  $(GitSkipCache): whether to cache the Git information determined
           in a previous build in a GitInfo.cache for
           performance reasons.
           Defaults to empty value (no ignoring).

  $(GitNameRevOptions): Options passed to git name-rev when finding
              a branch name for the current commit (Detached head). The default is
              '--refs=refs/heads/* --no-undefined --alwas'
              meaning branch names only, falling back to commit hash.
              For legacy behavior where $(GitBranch) for detached head
              can also be a tag name, use '--refs=refs/*'.
              Refs can be included and excluded, see git name-rev docs.

  $(GitTagRegex): Regular expression used with git describe to filter the tags 
                  to consider for base version lookup.
                  Defaults to * (all)
           
  $(GitBaseVersionRegex): Regular expression used to match and validate valid base versions
                          in branch, tag or file sources. By default, matches any string that 
                          *ends* in a valid SemVer2 string.
                          Defaults to 'v?(?<MAJOR>\d+)\.(?<MINOR>\d+)\.(?<PATCH>\d+)(?:\-(?<LABEL>[\dA-Za-z\-\.]+))?$|^(?<LABEL>[\dA-Za-z\-\.]+)\-v?(?<MAJOR>\d+)\.(?<MINOR>\d+)\.(?<PATCH>\d+)$'
```

## Goals

- No compiled code or tools -> 100% transparency
- Trivially added/installed via [a NuGet package](https://www.nuget.org/packages/GitInfo)
- No format strings or settings to learn
- Single well-structured [.targets file](https://github.com/kzu/GitInfo/blob/main/src/GitInfo/build/GitInfo.targets) 
  with plain MSBuild and no custom tasks
- [Optional embedding](https://github.com/kzu/GitInfo/blob/main/src/GitInfo/build/GitInfo.targets#L51) 
  of Git info in assembly [as metadata](https://github.com/kzu/GitInfo/blob/main/src/GitInfo/build/GitInfo.cs.pp#L4)
- Optional use of Git info to build arbitrary assembly/file version information, both 
  [in C#](https://github.com/kzu/GitInfoDemo/blob/main/GitInfoDemo/Properties/AssemblyInfo.cs#L10) as well 
  [as VB](https://github.com/kzu/GitInfoDemo/blob/main/GitInfoDemoVB/My%20Project/AssemblyInfo.vb#L8).
- Trivially modified/improved generated code by just adjusting a 
  [C#](https://github.com/kzu/GitInfo/blob/main/src/GitInfo/build/GitInfo.cs.pp) or 
  [F#](https://github.com/kzu/GitInfo/blob/main/src/GitInfo/build/GitInfo.fs.pp) or 
  [VB](https://github.com/kzu/GitInfo/blob/main/src/GitInfo/build/GitInfo.vb.pp) template 
  included in the [NuGet package](https://www.nuget.org/packages/GitInfo)
- Easily modified/improved by just adjusting a 
  [single .targets file](https://github.com/kzu/GitInfo/blob/main/src/GitInfo/build/GitInfo.targets) 
- 100% incremental build-friendly and high-performing (all proper Inputs/Outputs in place, smart caching of Git info, etc.)




## Sponsors

[![sponsored](https://raw.githubusercontent.com/devlooped/oss/main/assets/images/sponsors.svg)](https://github.com/sponsors/devlooped) [![clarius](https://raw.githubusercontent.com/clarius/branding/main/logo/byclarius.svg)](https://github.com/clarius)[![clarius](https://raw.githubusercontent.com/clarius/branding/main/logo/logo.svg)](https://github.com/clarius)

*[get mentioned here too](https://github.com/sponsors/devlooped)!*
