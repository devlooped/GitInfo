![Icon](https://raw.githubusercontent.com/devlooped/GitInfo/main/assets/images/git.png) GitInfo
============

Git Info from MSBuild, C# and VB

> [!NOTE]
> A fresh and transparent approach to Git information retrieval from MSBuild and Code without
> using any custom tasks or compiled code and tools, obscure settings, format strings, etc.

[![Latest version](https://img.shields.io/nuget/v/GitInfo.svg)](https://www.nuget.org/packages/GitInfo)
[![Downloads](https://img.shields.io/nuget/dt/GitInfo.svg)](https://www.nuget.org/packages/GitInfo)
[![EULA](https://img.shields.io/badge/EULA-OSMF-blue?labelColor=black&color=C9FF30)](osmfeula.txt)
[![OSS](https://img.shields.io/github/license/devlooped/oss.svg?color=blue)](license.txt) 

Install via [NuGet](https://www.nuget.org/packages/GitInfo):

```pwsh
PM> Install-Package GitInfo
```

<!-- include https://github.com/devlooped/.github/raw/main/osmf.md -->
## Open Source Maintenance Fee

To ensure the long-term sustainability of this project, users of this package who generate 
revenue must pay an [Open Source Maintenance Fee](https://opensourcemaintenancefee.org). 
While the source code is freely available under the terms of the [License](license.txt), 
this package and other aspects of the project require [adherence to the Maintenance Fee](osmfeula.txt).

To pay the Maintenance Fee, [become a Sponsor](https://github.com/sponsors/devlooped) at the proper 
OSMF tier. A single fee covers all of [Devlooped packages](https://www.nuget.org/profiles/Devlooped).

<!-- https://github.com/devlooped/.github/raw/main/osmf.md -->

<!-- #content -->
## Usage
By default, if the containing project is a C#, F# or VB project, a compile-time generated
source file will contain all the git information and can be accessed from anywhere within
the assembly, as constants in a `ThisAssembly` (partial) class and its nested `Git` static class:

```csharp
Console.WriteLine(ThisAssembly.Git.Commit);
```

> NOTE: you may need to close and reopen the solution in order
> for Visual Studio to refresh intellisense and show the
> ThisAssembly type the first time after installing the package.

By default, GitInfo will also set `$(Version)` and `$(PackageVersion)` which the .NET
SDK uses for deriving the AssemblyInfo, FileVersion and InformationalVersion values,
as well as for packing. This default version is formatted from the following populated
MSBuild properties: `$(GitSemVerMajor).$(GitSemVerMinor).$(GitSemVerPatch)$(GitSemVerDashLabel)+$(GitBranch).$(GitCommit)`.

So, straight after install and build/pack, you will get some versioning in place :).

Alternatively, you can opt-out of this default versioning by setting `GitVersion=false`
in your project file, if you want to just leverage the Git information and/or version
properties/constants yourself:

```xml
<PropertyGroup>
  <GitVersion>false</GitVersion>
</PropertyGroup>
```

This allows you to use the provided constants to build any versioning attributes you want,
with whatever information you want, without resorting to settings, format strings or anything,
just plain code:

C#:
```csharp
[assembly: AssemblyVersion(ThisAssembly.Git.BaseVersion.Major + "." + ThisAssembly.Git.BaseVersion.Minor + "." + ThisAssembly.Git.BaseVersion.Patch)]

[assembly: AssemblyFileVersion(ThisAssembly.Git.SemVer.Major + "." + ThisAssembly.Git.SemVer.Minor + "." + ThisAssembly.Git.SemVer.Patch)]

[assembly: AssemblyInformationalVersion(
    ThisAssembly.Git.SemVer.Major + "." +
    ThisAssembly.Git.SemVer.Minor + "." +
    ThisAssembly.Git.Commits + "-" +
    ThisAssembly.Git.Branch + "+" +
    ThisAssembly.Git.Commit)]
```

F#:
```fsharp
module AssemblyInfo

open System.Reflection

[<assembly: AssemblyVersion(ThisAssembly.Git.BaseVersion.Major + "." + ThisAssembly.Git.BaseVersion.Minor + "." + ThisAssembly.Git.BaseVersion.Patch)>]

[<assembly: AssemblyFileVersion(ThisAssembly.Git.SemVer.Major + "." + ThisAssembly.Git.SemVer.Minor + "." + ThisAssembly.Git.SemVer.Patch)>]

[<assembly: AssemblyInformationalVersion(
    ThisAssembly.Git.SemVer.Major + "." +
    ThisAssembly.Git.SemVer.Minor + "." +
    ThisAssembly.Git.Commits + "-" +
    ThisAssembly.Git.Branch + "+" +
    ThisAssembly.Git.Commit)>]

do ()
```

VB:
```vbnet
<Assembly: AssemblyVersion(ThisAssembly.Git.BaseVersion.Major + "." + ThisAssembly.Git.BaseVersion.Minor + "." + ThisAssembly.Git.BaseVersion.Patch)>

<Assembly: AssemblyFileVersion(ThisAssembly.Git.SemVer.Major + "." + ThisAssembly.Git.SemVer.Minor + "." + ThisAssembly.Git.SemVer.Patch)>

<Assembly: AssemblyInformationalVersion(
    ThisAssembly.Git.SemVer.Major + "." +
    ThisAssembly.Git.SemVer.Minor + "." +
    ThisAssembly.Git.Commits + "-" +
    ThisAssembly.Git.Branch + "+" +
    ThisAssembly.Git.Commit)>
```

> NOTE: when generating your own assembly version attributes, you will need to turn off
> the corresponding assembly version attribute generation from the .NET SDK, by setting
> the relevant properties to false: `GenerateAssemblyVersionAttribute`,
> `GenerateAssemblyFileVersionAttribute` and `GenerateAssemblyInformationalVersionAttribute`.

You can also just build your own versioning logic in a target that depends on GitInfo using plain MSBuild:

```xml
<PropertyGroup>
  <GitVersion>false</GitVersion> <!-- we'll do our own versioning -->
</PropertyGroup>

<ItemGroup>
  <PackageReference Include="GitInfo" PrivateAssets="all" />
</ItemGroup>

<Target Name="PopulateInfo" DependsOnTargets="GitVersion" BeforeTargets="GetAssemblyVersion;GenerateNuspec;GetPackageContents">
  <PropertyGroup>
    <Version>$(GitSemVerMajor).$(GitSemVerMinor).$(GitSemVerPatch)$(GitSemVerDashLabel)+$(GitBranch).$(GitCommit)</Version>
    <PackageVersion>$(Version)</PackageVersion>
    <RepositoryBranch>$(GitBranch)</RepositoryBranch>
    <RepositoryCommit>$(GitCommit)</RepositoryCommit>
    <SourceRevisionId>$(GitBranch) $(GitCommit)</SourceRevisionId>
  </PropertyGroup>
</Target>
```

> NOTE: because the provided properties are populated via targets that need to run
> before they are available, you cannot use the GitInfo-provided properties in a
> PropertyGroup at the project level. You can only use them from within a target that
> in turn depends on the relevant target from GitInfo (typically, `GitVersion` as
> shown above, if you consume the SemVer properties).

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

For C#, F# and VB, constants are generated too so that the same information can be
accessed from code:

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

## Goals

- No compiled code or tools -> 100% transparency
- Trivially added/installed via [a NuGet package](https://www.nuget.org/packages/GitInfo)
- No format strings or settings to learn
- Simple well-structured [.targets file](https://github.com/kzu/GitInfo/blob/main/src/GitInfo/build/GitInfo.targets)
  with plain MSBuild and no custom tasks
- [Optional embedding](https://github.com/kzu/GitInfo/blob/main/src/GitInfo/build/GitInfo.AssemblyMetadata.targets)
  of Git info in assembly metadata
- Optional use of Git info to build arbitrary assembly/file version information, both
  [in C#](https://github.com/kzu/GitInfoDemo/blob/main/GitInfoDemo/Properties/AssemblyInfo.cs#L10) as well
  [as VB](https://github.com/kzu/GitInfoDemo/blob/main/GitInfoDemoVB/My%20Project/AssemblyInfo.vb#L8).
- Trivially modified/improved generated code by just adjusting a
  [C#](https://github.com/kzu/GitInfo/blob/main/src/GitInfo/build/GitInfo.cs.pp) or
  [F#](https://github.com/kzu/GitInfo/blob/main/src/GitInfo/build/GitInfo.fs.pp) or
  [VB](https://github.com/kzu/GitInfo/blob/main/src/GitInfo/build/GitInfo.vb.pp) template
  included in the [NuGet package](https://www.nuget.org/packages/GitInfo)
- 100% incremental build-friendly and high-performing (all proper Inputs/Outputs in place, smart caching of Git info, etc.)

<!-- #content -->

## Customization

Available [MSBuild properties](https://learn.microsoft.com/en-us/visualstudio/msbuild/msbuild-properties)
to customize the behavior:

```
$(GitVersion): set to 'false' to avoid setting Version and PackageVersion to a default version with format:
               $(GitSemVerMajor).$(GitSemVerMinor).$(GitSemVerPatch)$(GitSemVerDashLabel)+$(GitBranch).$(GitCommit)

$(GitThisAssembly): set to 'false' to prevent assembly metadata and constants generation.

$(GitThisAssemblyMetadata): set to 'false' to prevent assembly metadata generation only. Defaults to 'false'.
                            If 'true', it will also provide assembly metadata attributes for each of the populated values.

$(ThisAssemblyNamespace): allows overriding the namespace for the ThisAssembly class. Defaults to the global namespace.

$(GitRemote): name of remote to get repository url for. Defaults to 'origin'.

$(GitBranchCI): determines whether the branch name should be populated from default environment variables used by the CI system. Default to 'true'.

$(GitDefaultBranch): determines the base branch used to calculate commits on top of current branch. Defaults to 'main'.

$(GitVersionFile): determines the name of a file in the Git repository root used to provide the base version info. Defaults to 'GitInfo.txt'.

$(GitCommitsRelativeTo): optionally specifies an alternative directory for counting commits on top of the base version. Defaults to the $(GitVersionFile) directory.

$(GitCommitsIgnoreMerges): set to 'true' to ignore merge commits when calculating the number of commits. Defaults to 'false'.

$(GitInfoReportImportance): allows rendering all the retrieved git information with the specified message importance ('high', 'normal' or 'low'). Defaults to 'low'.

$(GitIgnoreBranchVersion) and $(GitIgnoreTagVersion): determines whether the branch and tags (if any) will be used to find a base version. Defaults to empty value (no ignoring).

$(GitNameRevOptions): options passed to git name-rev when finding a branch name for a commit (Detached head). The default is '--refs=refs/heads/* --no-undefined --always'
                      meaning branch names only, falling back to commit hash. For the legacy behavior where $(GitBranch) for detached head can also be a tag name, use '--refs=refs/*'.
                      Refs can be included and excluded, see git name-rev docs.

$(GitSkipCache): whether to cache the Git information determined in a previous build in a GitInfo.cache for performance reasons. Defaults to empty value (no ignoring).

$(GitCachePath): where to cache the determined Git information. Gives the chance to use a shared location for different projects. This can improve the overall build time.
                 Has to end with a path seperator Defaults to empty value ('$(IntermediateOutputPath)').

$(GitTagRegex): regular expression used with git describe to filter the tags to consider for base version lookup. Defaults to * (all).

$(GitBaseVersionRegex): regular expression used to match and validate valid base versions in branch, tag or file sources. By default, matches any string that *ends* in a valid SemVer2 string.
                        Defaults to 'v?(?<MAJOR>\d+)\.(?<MINOR>\d+)\.(?<PATCH>\d+)(?:\-(?<LABEL>[\dA-Za-z\-\.]+))?$|^(?<LABEL>[\dA-Za-z\-\.]+)\-v?(?<MAJOR>\d+)\.(?<MINOR>\d+)\.(?<PATCH>\d+)$'

$(GitCommitDateFormat): value passed as the format option when trying to retrieve the git commit date. Defaults to %%cI (windows) or %cI (non windows).
```

<!-- include https://github.com/devlooped/sponsors/raw/main/footer.md -->
# Sponsors 

<!-- sponsors.md -->
[![Clarius Org](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/clarius.png "Clarius Org")](https://github.com/clarius)
[![MFB Technologies, Inc.](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/MFB-Technologies-Inc.png "MFB Technologies, Inc.")](https://github.com/MFB-Technologies-Inc)
[![DRIVE.NET, Inc.](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/drivenet.png "DRIVE.NET, Inc.")](https://github.com/drivenet)
[![Keith Pickford](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/Keflon.png "Keith Pickford")](https://github.com/Keflon)
[![Thomas Bolon](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/tbolon.png "Thomas Bolon")](https://github.com/tbolon)
[![Kori Francis](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/kfrancis.png "Kori Francis")](https://github.com/kfrancis)
[![Uno Platform](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/unoplatform.png "Uno Platform")](https://github.com/unoplatform)
[![Reuben Swartz](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/rbnswartz.png "Reuben Swartz")](https://github.com/rbnswartz)
[![Jacob Foshee](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/jfoshee.png "Jacob Foshee")](https://github.com/jfoshee)
[![](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/Mrxx99.png "")](https://github.com/Mrxx99)
[![Eric Johnson](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/eajhnsn1.png "Eric Johnson")](https://github.com/eajhnsn1)
[![David JENNI](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/davidjenni.png "David JENNI")](https://github.com/davidjenni)
[![Jonathan ](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/Jonathan-Hickey.png "Jonathan ")](https://github.com/Jonathan-Hickey)
[![Charley Wu](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/akunzai.png "Charley Wu")](https://github.com/akunzai)
[![Ken Bonny](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/KenBonny.png "Ken Bonny")](https://github.com/KenBonny)
[![Simon Cropp](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/SimonCropp.png "Simon Cropp")](https://github.com/SimonCropp)
[![agileworks-eu](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/agileworks-eu.png "agileworks-eu")](https://github.com/agileworks-eu)
[![Zheyu Shen](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/arsdragonfly.png "Zheyu Shen")](https://github.com/arsdragonfly)
[![Vezel](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/vezel-dev.png "Vezel")](https://github.com/vezel-dev)
[![ChilliCream](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/ChilliCream.png "ChilliCream")](https://github.com/ChilliCream)
[![4OTC](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/4OTC.png "4OTC")](https://github.com/4OTC)
[![Vincent Limo](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/v-limo.png "Vincent Limo")](https://github.com/v-limo)
[![Jordan S. Jones](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/jordansjones.png "Jordan S. Jones")](https://github.com/jordansjones)
[![domischell](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/DominicSchell.png "domischell")](https://github.com/DominicSchell)
[![Justin Wendlandt](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/jwendl.png "Justin Wendlandt")](https://github.com/jwendl)
[![Adrian Alonso](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/adalon.png "Adrian Alonso")](https://github.com/adalon)
[![Michael Hagedorn](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/Eule02.png "Michael Hagedorn")](https://github.com/Eule02)
[![](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/henkmartijn.png "")](https://github.com/henkmartijn)
[![torutek](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/torutek.png "torutek")](https://github.com/torutek)
[![mccaffers](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/mccaffers.png "mccaffers")](https://github.com/mccaffers)


<!-- sponsors.md -->

[![Sponsor this project](https://raw.githubusercontent.com/devlooped/sponsors/main/sponsor.png "Sponsor this project")](https://github.com/sponsors/devlooped)
&nbsp;

[Learn more about GitHub Sponsors](https://github.com/sponsors)

<!-- https://github.com/devlooped/sponsors/raw/main/footer.md -->
