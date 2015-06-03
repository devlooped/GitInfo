#pragma warning disable CS0436

[assembly: System.Reflection.AssemblyMetadata("Git.Branch", RootNamespace.ThisAssembly.Git.Branch)]
[assembly: System.Reflection.AssemblyMetadata("Git.Commit", RootNamespace.ThisAssembly.Git.Commit)]
[assembly: System.Reflection.AssemblyMetadata("Git.BaseVersion", RootNamespace.ThisAssembly.Git.BaseVersion)]
[assembly: System.Reflection.AssemblyMetadata("Git.Commits", RootNamespace.ThisAssembly.Git.Commits)]
[assembly: System.Reflection.AssemblyMetadata("Git.Tag", RootNamespace.ThisAssembly.Git.Tag)]
[assembly: System.Reflection.AssemblyMetadata("Git.BaseTag", RootNamespace.ThisAssembly.Git.BaseTag)]
[assembly: System.Reflection.AssemblyMetadata("Git.Version.Major", RootNamespace.ThisAssembly.Git.SemVer.Major)]
[assembly: System.Reflection.AssemblyMetadata("Git.Version.Minor", RootNamespace.ThisAssembly.Git.SemVer.Minor)]
[assembly: System.Reflection.AssemblyMetadata("Git.Version.Patch", RootNamespace.ThisAssembly.Git.SemVer.Patch)]
[assembly: System.Reflection.AssemblyMetadata("Git.Version.Label", RootNamespace.ThisAssembly.Git.SemVer.Label)]
[assembly: System.Reflection.AssemblyMetadata("Git.Version.DashLabel", RootNamespace.ThisAssembly.Git.SemVer.DashLabel)]
[assembly: System.Reflection.AssemblyMetadata("Git.Version.Source", RootNamespace.ThisAssembly.Git.SemVer.Source)]

namespace RootNamespace
{
  /// &lt;summary&gt;Provides access to the current assembly information.&lt;/summary&gt;
  partial class ThisAssembly
  {
    /// &lt;summary&gt;Provides access to the git information for the current assembly.&lt;/summary&gt;
    public partial class Git
    {
      /// &lt;summary&gt;Branch: GitBranch&lt;/summary&gt;
      public const string Branch = "GitBranch";

      /// &lt;summary&gt;Commit: GitCommit&lt;/summary&gt;
      public const string Commit = "GitCommit";

      /// &lt;summary&gt;Base Version: GitBaseVersion&lt;/summary&gt;
      public const string BaseVersion = "GitBaseVersion";

      /// &lt;summary&gt;Commits on top of base version: GitCommits&lt;/summary&gt;
      public const string Commits = "GitCommits";

      /// &lt;summary&gt;Tag: GitTag&lt;/summary&gt;
      public const string Tag = "GitTag";

      /// &lt;summary&gt;Base tag: GitBaseTag&lt;/summary&gt;
      public const string BaseTag = "GitBaseTag";

      /// &lt;summary&gt;Provides access to SemVer information for the current assembly.&lt;/summary&gt;
      public partial class SemVer
      {
        /// &lt;summary&gt;Major: GitVersionMajor&lt;/summary&gt;
        public const string Major = "GitVersionMajor";

        /// &lt;summary&gt;Minor: GitVersionMinor&lt;/summary&gt;
        public const string Minor = "GitVersionMinor";

        /// &lt;summary&gt;Patch: GitVersionPatch&lt;/summary&gt;
        public const string Patch = "GitVersionPatch";

        /// &lt;summary&gt;Label: GitVersionLabel&lt;/summary&gt;
        public const string Label = "GitVersionLabel";

        /// &lt;summary&gt;Label with dash prefix: GitVersionDashLabel&lt;/summary&gt;
        public const string DashLabel = "GitVersionDashLabel";

        /// &lt;summary&gt;Source: GitVersionSource&lt;/summary&gt;
        public const string Source = "GitVersionSource";
      }
    }
  }
}

#pragma warning restore CS0436