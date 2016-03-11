#define $NamespaceDefine$
#define $MetadataDefine$
#pragma warning disable 0436

#if ADDMETADATA
[assembly: System.Reflection.AssemblyMetadata("Vsix.Identifier", RootNamespace.ThisAssembly.Vsix.Identifier)]
[assembly: System.Reflection.AssemblyMetadata("Vsix.Name", RootNamespace.ThisAssembly.Vsix.Name)]
[assembly: System.Reflection.AssemblyMetadata("Vsix.Description", RootNamespace.ThisAssembly.Vsix.Description)]
[assembly: System.Reflection.AssemblyMetadata("Vsix.Author", RootNamespace.ThisAssembly.Vsix.Author)]
[assembly: System.Reflection.AssemblyMetadata("Vsix.Version", RootNamespace.ThisAssembly.Vsix.Version)]
#endif

#if LOCALNAMESPACE
namespace _RootNamespace_
{
#endif
  partial class ThisAssembly
  {
  /// <summary>Provides access to the current VSIX extension information.</summary>
    public static partial class Vsix
    {
      /// <summary>Identifier: $VsixID$</summary>
      public const string Identifier = "$VsixID$";
          
      /// <summary>Name: $VsixName$</summary>
      public const string Name = "$VsixName$";

      /// <summary>Description: $VsixDescription$</summary>
      public const string Description = "$VsixDescription$";

      /// <summary>Author: $VsixAuthor$</summary>
      public const string Author = "$VsixAuthor$";
              
      /// <summary>Version: $VsixVersion$</summary>
      public const string Version = "$VsixVersion$";	
    }
  }
#if LOCALNAMESPACE
}
#endif
#pragma warning restore 0436
