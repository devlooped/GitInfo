Vsix Info from MSBuild, C# and VB
--------------------------------
Exposes the following information for use directly from any MSBuild 
target that depends on the GitVsixInfo target:

  $(VsixID)
  $(VsixName)
  $(VsixDescription)
  $(VsixAuthor)
  $(VsixVersion)

From C# and VB, by default code is generated too so that the same 
information can be accessed from code:

[assembly: AssemblyTitle (ThisAssembly.Vsix.Name)]
[assembly: AssemblyDescription (ThisAssembly.Vsix.Description)]
[assembly: AssemblyCompany (ThisAssembly.Vsix.Author)]
	
** NOTE: you may need to close and reopen the solution in order 
         for Visual Studio to refresh intellisense and show the 
         ThisAssembly type right after package installation for 
         the first time.
	
All generated constants also have a Summary documentation tag 
that shows the current value in the intellisense tooltip, making 
it very easy to see what the different values contain.

The available constants from code are:

  ThisAssembly.Vsix.Identifier
  ThisAssembly.Vsix.Name
  ThisAssembly.Vsix.Description
  ThisAssembly.Vsix.Author
  ThisAssembly.Vsix.Version

Available MSBuild customizations:

	Target Name="GetVsixVersion": redefine this target to modify 
	the version number to use.	The target should set the $(VsixVersion)
	property. Default: $(GitSemVerMajor).$(GitSemVerMinor).$(GitSemVerPatch)
