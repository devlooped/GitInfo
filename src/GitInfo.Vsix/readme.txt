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

  ThisAssembly.Vsix.
  ThisAssembly.Vsix.
  ThisAssembly.Vsix.
  ThisAssembly.Vsix.
  ThisAssembly.Vsix.
  ThisAssembly.Vsix.
  ThisAssembly.Vsix.
  ThisAssembly.Vsix.
  ThisAssembly.Vsix.
  ThisAssembly.Vsix.
  ThisAssembly.Vsix.
  ThisAssembly.Vsix.
  ThisAssembly.Vsix.
  ThisAssembly.Vsix.

Available MSBuild customizations:

	$(GitThisAssembly): set to 'false' to prevent assembly 
						metadata and constants generation.

	$(GitThisAssemblyMetadata): set to 'false' to prevent assembly 
  							    metadata generation only. Defaults 
                                to 'false'.
	
	$(ThisAssemblyNamespace): allows overriding the namespace
							  for the ThisAssembly class.
							  Defaults to the global namespace.
											
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


