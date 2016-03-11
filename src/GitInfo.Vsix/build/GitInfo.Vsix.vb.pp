#Const $NamespaceDefine$ = 1
#Const $MetadataDefine$ = 1

#If ADDMETADATA
<Assembly: System.Reflection.AssemblyMetadata("Vsix.Identifier", Global.RootNamespace.ThisAssembly.Vsix.Identifier)>
<Assembly: System.Reflection.AssemblyMetadata("Vsix.Name", Global.RootNamespace.ThisAssembly.Vsix.Name)>
<Assembly: System.Reflection.AssemblyMetadata("Vsix.Description", Global.RootNamespace.ThisAssembly.Vsix.DEscription)>
<Assembly: System.Reflection.AssemblyMetadata("Vsix.Author", Global.RootNamespace.ThisAssembly.Vsix.Author)>
<Assembly: System.Reflection.AssemblyMetadata("Vsix.Version", Global.RootNamespace.ThisAssembly.Vsix.Version)>
#End If

#If LOCALNAMESPACE
Namespace Global._RootNamespace_
#Else
Namespace Global
#End If
    Partial Class ThisAssembly
        ''' <summary>Provides access to the current VSIX extension information.</summary>
        Partial Public Class Vsix
            ''' <summary>Identifier: $VsixID$</summary>
            Public Const Identifier = "$VsixID$"

            ''' <summary>Name: $VsixName$</summary>
            Public Const Name = "$VsixName$"

            ''' <summary>Description: $VsixDescription$</summary>
            Public Const Description = "$VsixDescription$"

            ''' <summary>Author: $VsixAuthor$</summary>
            Public Const Author = "$VsixAuthor$"

            ''' <summary>Version: $VsixVersion$</summary>
            Public Const Version = "$VsixVersion$"
        End Class
    End Class
End Namespace