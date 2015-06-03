<Assembly: System.Reflection.AssemblyMetadata("Git.Branch", RootNamespace.ThisAssembly.Git.Branch)>
<Assembly: System.Reflection.AssemblyMetadata("Git.Commit", RootNamespace.ThisAssembly.Git.Commit)>
<Assembly: System.Reflection.AssemblyMetadata("Git.BaseVersion", RootNamespace.ThisAssembly.Git.BaseVersion)>
<Assembly: System.Reflection.AssemblyMetadata("Git.Commits", RootNamespace.ThisAssembly.Git.Commits)>
<Assembly: System.Reflection.AssemblyMetadata("Git.Tag", RootNamespace.ThisAssembly.Git.Tag)>
<Assembly: System.Reflection.AssemblyMetadata("Git.BaseTag", RootNamespace.ThisAssembly.Git.BaseTag)>
<Assembly: System.Reflection.AssemblyMetadata("Git.Version.Major", RootNamespace.ThisAssembly.Git.Version.Major)>
<Assembly: System.Reflection.AssemblyMetadata("Git.Version.Minor", RootNamespace.ThisAssembly.Git.Version.Minor)>
<Assembly: System.Reflection.AssemblyMetadata("Git.Version.Patch", RootNamespace.ThisAssembly.Git.Version.Patch)>
<Assembly: System.Reflection.AssemblyMetadata("Git.Version.Label", RootNamespace.ThisAssembly.Git.Version.Label)>
<Assembly: System.Reflection.AssemblyMetadata("Git.Version.DashLabel", RootNamespace.ThisAssembly.Git.Version.DashLabel)>
<Assembly: System.Reflection.AssemblyMetadata("Git.Version.Source", RootNamespace.ThisAssembly.Git.Version.Source)>

Namespace Global.RootNamespace
    ''' <summary>Provides access to the git information for the current assembly.</summary>
    Partial Class ThisAssembly
        ''' <summary>Provides access to the git information for the current assembly.</summary>
        Partial Public Class Git
            ''' <summary>Branch: GitBranch</summary>
            Public Const Branch = "GitBranch"

            ''' <summary>Commit: GitCommit</summary>
            Public Const Commit = "GitCommit"

            ''' <summary>Base Version: GitBaseVersion</summary>
            Public Const BaseVersion = "GitBaseVersion"

            ''' <summary>Commits on top of base version: GitCommits</summary>
            Public Const Commits = "GitCommits"

            ''' <summary>Tag: GitTag</summary>
            Public Const Tag = "GitTag"

            ''' <summary>Base tag: GitBaseTag</summary>
            Public Const BaseTag = "GitBaseTag"

            ''' <summary>Provides access to SemVer information for the current assembly.</summary>
            Partial Public Class SemVer
                ''' <summary>Major: GitVersionMajor</summary>
                Public Const Major = "GitVersionMajor"

                ''' <summary>Minor: GitVersionMinor</summary>
                Public Const Minor = "GitVersionMinor"

                ''' <summary>Patch: GitVersionPatch</summary>
                Public Const Patch = "GitVersionPatch"

                ''' <summary>Label: GitVersionLabel</summary>
                Public Const Label = "GitVersionLabel"

                ''' <summary>Label with dash prefix: GitVersionDashLabel</summary>
                Public Const DashLabel = "GitVersionDashLabel"

                ''' <summary>Label with dash prefix: GitVersionSource</summary>
                Public Const Source = "GitVersionSource"
            End Class
        End Class
    End Class
End Namespace