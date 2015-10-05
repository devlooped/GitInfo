Git Info from MSBuild, C# and VB
--------------------------------
Exposes the following information for use directly from any MSBuild 
target that depends on the GitInfo target:

  $(GitBranch)
  $(GitCommit)
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

From C# and VB, by default code is generated too so that the same 
information can be accessed from code, to construct your own 
assembly/file version attributes with whatever format you want:

[assembly: AssemblyVersion (ThisAssembly.Git.SemVer.Major + "." + ThisAssembly.Git.SemVer.Minor + "." + ThisAssembly.Git.SemVer.Patch)]
[assembly: AssemblyInformationalVersion (
	ThisAssembly.Git.SemVer.Major + "." +
	ThisAssembly.Git.SemVer.Minor + "." +
	ThisAssembly.Git.SemVer.Patch + "-" +
	ThisAssembly.Git.Branch + "+" +
	ThisAssembly.Git.Commit)]
// i..e ^: 1.0.2-master+c218617
	
** NOTE: you may need to close and reopen the solution in order 
         for Visual Studio to refresh intellisense and show the 
         ThisAssembly type right after package installation for 
         the first time.
	
All generated constants also have a Summary documentation tag 
that shows the current value in the intellisense tooltip, making 
it very easy to see what the different values contain.

The available constants from code are:

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


