![Icon](https://raw.githubusercontent.com/devlooped/GitInfo/main/assets/images/git.png) GitInfo
============

Git Info from MSBuild, C# and VB

> A fresh and transparent approach to Git information retrieval from MSBuild and Code without 
> using any custom tasks or compiled code and tools, obscure settings, format strings, etc. 

[![Latest version](https://img.shields.io/nuget/v/GitInfo.svg)](https://www.nuget.org/packages/GitInfo)
[![Downloads](https://img.shields.io/nuget/dt/GitInfo.svg)](https://www.nuget.org/packages/GitInfo)
[![License](https://img.shields.io/:license-MIT-blue.svg)](https://opensource.org/licenses/mit-license.php)
[![Build status](https://ci.appveyor.com/api/projects/status/p9e5xdd86vnfe0q8?svg=true)](https://ci.appveyor.com/project/MobileEssentials/gitinfo) 

## Usage

After installing via [NuGet](https://www.nuget.org/packages/GitInfo):

	PM> Install-Package GitInfo

By default, if the containing project is a C#, F# or VB project, a compile-time generated 
source file will contain all the git information and can be accessed from anywhere within 
the assembly, as constants in a `ThisAssembly` (partial) class and its nested `Git` static class:

	Console.WriteLine(ThisAssembly.Git.Commit);

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

> NOTE: when generating your own assembly version attributes, you will need to turn off
> the corresponding assembly version attribute generation from the .NET SDK, by setting 
> the relevant properties to false: `GenerateAssemblyVersionAttribute`, 
> `GenerateAssemblyFileVersionAttribute` and `GenerateAssemblyInformationalVersionAttribute`.


MSBuild:

```
<!-- Just edit .csproj file -->  
<PropertyGroup>
    <!-- We'll do our own versioning -->
    <GitVersion>false</GitVersion>
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

Available [MSBuild properties](https://learn.microsoft.com/en-us/visualstudio/msbuild/msbuild-properties) 
to customize the behavior:

```
  $(GitVersion): set to 'false' to prevent setting Version 
                 and PackageVersion.

  $(GitThisAssembly): set to 'false' to prevent assembly 
                      metadata and constants generation.

  $(GitThisAssemblyMetadata): set to 'false' to prevent assembly 
                              metadata generation only. Defaults 
                              to 'false'. If 'true', it will also 
                              provide assembly metadata attributes 
                              for each of the populated values.

  $(ThisAssemblyNamespace): allows overriding the namespace
                            for the ThisAssembly class.
                            Defaults to the global namespace.

  $(GitRemote): name of remote to get repository url for.
                Defaults to 'origin'.

  $(GitDefaultBranch): determines the base branch used to 
                       calculate commits on top of current branch.
                       Defaults to 'main'.

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

  $(GitCachePath): where to cache the determined Git information
				   gives the chance to use a shared location
				   for different projects. this can improve
				   the overall build time.
				   has to end with a path seperator
				   Defaults to empty value ('$(IntermediateOutputPath)').

  $(GitNameRevOptions): Options passed to git name-rev when finding
              a branch name for the current commit (Detached head). The default is
              '--refs=refs/heads/* --no-undefined --always'
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


<!-- include https://github.com/devlooped/sponsors/raw/main/footer.md -->
# Sponsors 

<!-- sponsors.md -->
[![Clarius Org](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/clarius.png "Clarius Org")](https://github.com/clarius)
[![Kirill Osenkov](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/KirillOsenkov.png "Kirill Osenkov")](https://github.com/KirillOsenkov)
[![MFB Technologies, Inc.](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/MFB-Technologies-Inc.png "MFB Technologies, Inc.")](https://github.com/MFB-Technologies-Inc)
[![Stephen Shaw](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/decriptor.png "Stephen Shaw")](https://github.com/decriptor)
[![Torutek](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/torutek-gh.png "Torutek")](https://github.com/torutek-gh)
[![DRIVE.NET, Inc.](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/drivenet.png "DRIVE.NET, Inc.")](https://github.com/drivenet)
[![David Kean](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/davkean.png "David Kean")](https://github.com/davkean)
[![](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/chiluap.png "")](https://github.com/chiluap)
[![Daniel Gnägi](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/dgnaegi.png "Daniel Gnägi")](https://github.com/dgnaegi)
[![Ashley Medway](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/AshleyMedway.png "Ashley Medway")](https://github.com/AshleyMedway)
[![Keith Pickford](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/Keflon.png "Keith Pickford")](https://github.com/Keflon)
[![bitbonk](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/bitbonk.png "bitbonk")](https://github.com/bitbonk)
[![Thomas Bolon](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/tbolon.png "Thomas Bolon")](https://github.com/tbolon)
[![Yurii Rashkovskii](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/yrashk.png "Yurii Rashkovskii")](https://github.com/yrashk)
[![Kori Francis](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/kfrancis.png "Kori Francis")](https://github.com/kfrancis)
[![Zdenek Havlin](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/wdolek.png "Zdenek Havlin")](https://github.com/wdolek)
[![Sean Killeen](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/SeanKilleen.png "Sean Killeen")](https://github.com/SeanKilleen)
[![Toni Wenzel](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/twenzel.png "Toni Wenzel")](https://github.com/twenzel)
[![Giorgi Dalakishvili](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/Giorgi.png "Giorgi Dalakishvili")](https://github.com/Giorgi)
[![Kelly White](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/mckhendry.png "Kelly White")](https://github.com/mckhendry)
[![Allan Ritchie](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/aritchie.png "Allan Ritchie")](https://github.com/aritchie)
[![Mike James](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/MikeCodesDotNET.png "Mike James")](https://github.com/MikeCodesDotNET)
[![Uno Platform](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/unoplatform.png "Uno Platform")](https://github.com/unoplatform)
[![Dan Siegel](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/dansiegel.png "Dan Siegel")](https://github.com/dansiegel)
[![Reuben Swartz](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/rbnswartz.png "Reuben Swartz")](https://github.com/rbnswartz)
[![Jeremy Simmons](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/jeremysimmons.png "Jeremy Simmons")](https://github.com/jeremysimmons)
[![Jacob Foshee](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/jfoshee.png "Jacob Foshee")](https://github.com/jfoshee)
[![](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/Mrxx99.png "")](https://github.com/Mrxx99)
[![Eric Johnson](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/eajhnsn1.png "Eric Johnson")](https://github.com/eajhnsn1)
[![Norman Mackay](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/mackayn.png "Norman Mackay")](https://github.com/mackayn)
[![Certify The Web](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/certifytheweb.png "Certify The Web")](https://github.com/certifytheweb)
[![Taylor Mansfield](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/lavahot.png "Taylor Mansfield")](https://github.com/lavahot)
[![Mårten Rånge](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/mrange.png "Mårten Rånge")](https://github.com/mrange)
[![David Petric](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/davidpetric.png "David Petric")](https://github.com/davidpetric)
[![Rich Lee](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/richlee.png "Rich Lee")](https://github.com/richlee)
[![Danilo Dantas](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/dannevesdantas.png "Danilo Dantas")](https://github.com/dannevesdantas)
[![](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/nietras.png "")](https://github.com/nietras)
[![Gary Woodfine](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/garywoodfine.png "Gary Woodfine")](https://github.com/garywoodfine)
[![](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/kristinnstefansson.png "")](https://github.com/kristinnstefansson)
[![](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/DarrenAtConexus.png "")](https://github.com/DarrenAtConexus)
[![Steve Bilogan](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/kazo0.png "Steve Bilogan")](https://github.com/kazo0)
[![Ix Technologies B.V.](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/IxTechnologies.png "Ix Technologies B.V.")](https://github.com/IxTechnologies)
[![New Relic](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/newrelic.png "New Relic")](https://github.com/newrelic)
[![Chris Johnston‮](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/Chris-Johnston.png "Chris Johnston‮")](https://github.com/Chris-Johnston)
[![David JENNI](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/davidjenni.png "David JENNI")](https://github.com/davidjenni)
[![](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/ehonda.png "")](https://github.com/ehonda)
[![Jonathan ](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/Jonathan-Hickey.png "Jonathan ")](https://github.com/Jonathan-Hickey)
[![Oleg Kyrylchuk](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/okyrylchuk.png "Oleg Kyrylchuk")](https://github.com/okyrylchuk)
[![Juan Blanco](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/juanfranblanco.png "Juan Blanco")](https://github.com/juanfranblanco)
[![LosManos](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/LosManos.png "LosManos")](https://github.com/LosManos)
[![Mariusz Kogut](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/MariuszKogut.png "Mariusz Kogut")](https://github.com/MariuszKogut)
[![Charley Wu](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/akunzai.png "Charley Wu")](https://github.com/akunzai)
[![](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/meisenring.png "")](https://github.com/meisenring)
[![Thomas Due](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/Tdue21.png "Thomas Due")](https://github.com/Tdue21)
[![Jakob Tikjøb Andersen](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/jakobt.png "Jakob Tikjøb Andersen")](https://github.com/jakobt)
[![Seann Alexander](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/seanalexander.png "Seann Alexander")](https://github.com/seanalexander)
[![Tino Hager](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/tinohager.png "Tino Hager")](https://github.com/tinohager)
[![Badre BSAILA](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/pedrobsaila.png "Badre BSAILA")](https://github.com/pedrobsaila)
[![Mark Seemann](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/ploeh.png "Mark Seemann")](https://github.com/ploeh)
[![Angelo Belchior](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/angelobelchior.png "Angelo Belchior")](https://github.com/angelobelchior)
[![Tony Qu](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/tonyqus.png "Tony Qu")](https://github.com/tonyqus)
[![Daniel May](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/danielrmay.png "Daniel May")](https://github.com/danielrmay)
[![Blauhaus Technology (Pty) Ltd](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/BlauhausTechnology.png "Blauhaus Technology (Pty) Ltd")](https://github.com/BlauhausTechnology)
[![Richard Collette](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/rcollette.png "Richard Collette")](https://github.com/rcollette)
[![Nick Vaughan](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/bngv.png "Nick Vaughan")](https://github.com/bngv)
[![Ken Bonny](https://raw.githubusercontent.com/devlooped/sponsors/main/.github/avatars/KenBonny.png "Ken Bonny")](https://github.com/KenBonny)


<!-- sponsors.md -->

[![Sponsor this project](https://raw.githubusercontent.com/devlooped/sponsors/main/sponsor.png "Sponsor this project")](https://github.com/sponsors/devlooped)
&nbsp;

[Learn more about GitHub Sponsors](https://github.com/sponsors)

<!-- https://github.com/devlooped/sponsors/raw/main/footer.md -->
