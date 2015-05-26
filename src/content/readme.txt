Git Info from MSBuild, C# and VB
--------------------------------
Exposes the following information for use directly from any MSBuild 
target that depends on the GitInfo target:

  $(GitBranch)
  $(GitCommit)
  $(GitBaseVersion)
  $(GitCommits)
  $(GitTag)
  $(GitBaseTag)
  $(GitVersionMajor)
  $(GitVersionMinor)
  $(GitVersionPatch)
  $(GitVersionLabel)
  $(GitVersionDashLabel)

From C# and VB, by default code is generated too so that the same 
information can be accessed from code, to construct your own 
assembly/file version attributes with whatever format you want:

[assembly: AssemblyVersion(ThisAssembly.Git.Version.Major, ThisAssembly.Git.Version.Minor, 0)] 
[assembly: AssemblyInformationalVersion(
	ThisAssembly.Git.Version.Major + "." + 
	ThisAssembly.Git.Version.Minor + "." + 
	ThisAssembly.Git.Version.Patch + "-" + 
	ThisAssembly.Git.Branch + "+" + 
	ThisAssembly.Git.Commit)]
	
All generated constants also have a Summary documentation tag 
that shows the current value in the intellisense tooltip, making 
it easier to see what the different values contain.

The available constants from code are:

  ThisAssembly.Git.Branch
  ThisAssembly.Git.Commit
  ThisAssembly.Git.BaseVersion
  ThisAssembly.Git.Commits
  ThisAssembly.Git.Tag
  ThisAssembly.Git.BaseTag
  ThisAssembly.Git.Version.Major
  ThisAssembly.Git.Version.Minor
  ThisAssembly.Git.Version.Patch
  ThisAssembly.Git.Version.Label
  ThisAssembly.Git.Version.DashLabel


