# Changelog

## [v2.2.1](https://github.com/devlooped/GitInfo/tree/v2.2.1) (2022-11-16)

[Full Changelog](https://github.com/devlooped/GitInfo/compare/v2.2.0...v2.2.1)

:sparkles: Implemented enhancements:

- maybe: show better error msg if windows visual studio git outputs linux paths [\#131](https://github.com/devlooped/GitInfo/issues/131)
- Add release notes [\#89](https://github.com/devlooped/GitInfo/issues/89)
- Can the same be used for managed C++? If not create it? [\#67](https://github.com/devlooped/GitInfo/issues/67)
- Cake: Use within Cake [\#48](https://github.com/devlooped/GitInfo/issues/48)
- Doesn't work with projects on SMB shares [\#8](https://github.com/devlooped/GitInfo/issues/8)
- Add section on how to set versions from MSBuild [\#211](https://github.com/devlooped/GitInfo/pull/211) (@kzu)
- Fix "MSBuild customizations" misnomer & add link to documentation [\#206](https://github.com/devlooped/GitInfo/pull/206) (@JimmyCushnie)
- fix bug Branch name is wrong when compiling from a git worktree [\#197](https://github.com/devlooped/GitInfo/pull/197) (@li-zhixin)
- Properly escape GitExe and CygPathExe for WSL [\#195](https://github.com/devlooped/GitInfo/pull/195) (@socram8888)
- Update "dirty" file only when `GitIsDirty` changes [\#184](https://github.com/devlooped/GitInfo/pull/184) (@AmoreCadenza)
- Fix of buildTransitive feature of package [\#182](https://github.com/devlooped/GitInfo/pull/182) (@PadreSVK)

:bug: Fixed bugs:

- MSBuild variables don't work for MAUI projects [\#203](https://github.com/devlooped/GitInfo/issues/203)
- Execution fails if using WSL and username contains spaces [\#194](https://github.com/devlooped/GitInfo/issues/194)
- delete [\#193](https://github.com/devlooped/GitInfo/issues/193)
- \[Question\] Commit Message [\#185](https://github.com/devlooped/GitInfo/issues/185)
- Build fails if `git config log.showSignature true` [\#180](https://github.com/devlooped/GitInfo/issues/180)
- Disable signatures when obtaining commit date - fixes \#180 [\#213](https://github.com/devlooped/GitInfo/pull/213) (@socram8888)

:hammer: Other:

- Deleted [\#181](https://github.com/devlooped/GitInfo/issues/181)
- Publish new version to nuget.org [\#159](https://github.com/devlooped/GitInfo/issues/159)

:twisted_rightwards_arrows: Merged:

- +M▼ includes [\#200](https://github.com/devlooped/GitInfo/pull/200) (@github-actions[bot])

## [v2.2.0](https://github.com/devlooped/GitInfo/tree/v2.2.0) (2021-08-25)

[Full Changelog](https://github.com/devlooped/GitInfo/compare/v2.1.2...v2.2.0)

:sparkles: Implemented enhancements:

- Add source repository information to package [\#169](https://github.com/devlooped/GitInfo/issues/169)
- Add support for nuget transitive dependencies \(via PackageReference\) [\#154](https://github.com/devlooped/GitInfo/issues/154)
- GitThisAssemblyMetadata documentation is confusing [\#152](https://github.com/devlooped/GitInfo/issues/152)
- Feature request: let \_CommitDateFormat be configurable [\#144](https://github.com/devlooped/GitInfo/issues/144)
- Build error when the first commit on a new branch is a cherry pick [\#133](https://github.com/devlooped/GitInfo/issues/133)
- support for git worktree [\#88](https://github.com/devlooped/GitInfo/issues/88)
- Issue with GitIsDirty and GitCache [\#60](https://github.com/devlooped/GitInfo/issues/60)

:bug: Fixed bugs:

- Handle add non-zero exit codes from Git [\#147](https://github.com/devlooped/GitInfo/pull/147) (@Therzok)

:hammer: Other:

- Project URL should be devlooped.github.io/GitInfo [\#149](https://github.com/devlooped/GitInfo/issues/149)

:twisted_rightwards_arrows: Merged:

- 🖆 Apply devlooped/oss template, nugetize and modernize [\#168](https://github.com/devlooped/GitInfo/pull/168) (@kzu)
- Is dirty always check [\#165](https://github.com/devlooped/GitInfo/pull/165) (@freza-tm)
- Add support for nuget transitive dependecy for .targets [\#155](https://github.com/devlooped/GitInfo/pull/155) (@PadreSVK)
- Updating content readme.txt for issue \#152 [\#153](https://github.com/devlooped/GitInfo/pull/153) (@daiplusplus)
- Allowed git commit date format to be configured through GitCommitDateFormat property [\#145](https://github.com/devlooped/GitInfo/pull/145) (@tomcurran)
- Add --always to default name-rev args, so a commit hash is used instead of 'undefined' [\#132](https://github.com/devlooped/GitInfo/pull/132) (@andersforsgren)

## [v2.1.2](https://github.com/devlooped/GitInfo/tree/v2.1.2) (2020-09-24)

[Full Changelog](https://github.com/devlooped/GitInfo/compare/89d9e9d5e61e983f507cd1fd2133ee23dd3b6af2...v2.1.2)

:sparkles: Implemented enhancements:

- Option to exclude merges when calculating SemVerPatch [\#124](https://github.com/devlooped/GitInfo/issues/124)
- RepositoryUrl may contain username and password [\#122](https://github.com/devlooped/GitInfo/issues/122)
- Folder Syntax are not supported [\#101](https://github.com/devlooped/GitInfo/issues/101)
- Only consider version tags [\#100](https://github.com/devlooped/GitInfo/issues/100)
- Add "CheckinDate" to the ThisAssembly to be used in AssemblyInfo [\#65](https://github.com/devlooped/GitInfo/issues/65)
- Error when the path to file GitInfo.txt contains spaces [\#13](https://github.com/devlooped/GitInfo/issues/13)
- Include boolean indicating whether working tree is dirty [\#10](https://github.com/devlooped/GitInfo/issues/10)
- GitExe in the PATH should be first [\#6](https://github.com/devlooped/GitInfo/issues/6)
- Thoughts on including date information [\#2](https://github.com/devlooped/GitInfo/issues/2)

:hammer: Other:

- Possibility to exclude tag refs from $\(GitBranch\) [\#126](https://github.com/devlooped/GitInfo/issues/126)
- "Unrecognized escape sequence" when remote url is a Windows path [\#119](https://github.com/devlooped/GitInfo/issues/119)
- GitSemVerPatch always 0 after update from 2.0.26 to 2.0.29 [\#116](https://github.com/devlooped/GitInfo/issues/116)
- Add GitSha override when building [\#114](https://github.com/devlooped/GitInfo/issues/114)
- Use MSBuild property to determine base version instead of external file [\#113](https://github.com/devlooped/GitInfo/issues/113)
- \[Feature\] Retrieve repository url [\#109](https://github.com/devlooped/GitInfo/issues/109)
- ASP.NET Core 3.1 GitThisAssemblyMetadata setting? [\#108](https://github.com/devlooped/GitInfo/issues/108)
- Change ThisAssembly access to Public [\#107](https://github.com/devlooped/GitInfo/issues/107)
- Include origin in git info [\#103](https://github.com/devlooped/GitInfo/issues/103)
- Can't Get BaseVersion.Patch+1 [\#99](https://github.com/devlooped/GitInfo/issues/99)
- Build fails if `git config log.showSignature true` [\#86](https://github.com/devlooped/GitInfo/issues/86)
- Emit assembly attributes [\#85](https://github.com/devlooped/GitInfo/issues/85)
- Conflicts when using InternalsVisibleTo [\#84](https://github.com/devlooped/GitInfo/issues/84)
- Broken link [\#83](https://github.com/devlooped/GitInfo/issues/83)
- Incremental build is broken [\#81](https://github.com/devlooped/GitInfo/issues/81)
- dotnet tool [\#79](https://github.com/devlooped/GitInfo/issues/79)
- Question regarding ThisAssembly.Git.Tag - separate commit using a plus? [\#78](https://github.com/devlooped/GitInfo/issues/78)
- Is there a way to make GitInfo work with Xamarin Live Player [\#77](https://github.com/devlooped/GitInfo/issues/77)
- GitInfo.txt per project leaves GitSemVerPatch at zero [\#76](https://github.com/devlooped/GitInfo/issues/76)
- How to add pre-release information only if building from dev branches or on dev box [\#70](https://github.com/devlooped/GitInfo/issues/70)
- Default protection level of ThisAssembly [\#69](https://github.com/devlooped/GitInfo/issues/69)
- Info on target \(release/debug/...\)? [\#68](https://github.com/devlooped/GitInfo/issues/68)
- csproj example [\#62](https://github.com/devlooped/GitInfo/issues/62)
- Cannot use on OSX [\#61](https://github.com/devlooped/GitInfo/issues/61)
- Preffered Version Scheme [\#59](https://github.com/devlooped/GitInfo/issues/59)
- naming clash? "ThisAssembly" exists in Microsoft.Build.Utilities.v4.0 [\#56](https://github.com/devlooped/GitInfo/issues/56)
- Cannot access internal class "ThisAssembly" here [\#55](https://github.com/devlooped/GitInfo/issues/55)
- Commits not counting correctly when base branch is already ahead [\#54](https://github.com/devlooped/GitInfo/issues/54)
- Examples to increase the counters. [\#49](https://github.com/devlooped/GitInfo/issues/49)
- Clean up the output by using EchoOff for Exec [\#47](https://github.com/devlooped/GitInfo/issues/47)
- If no Git found, build should fail [\#46](https://github.com/devlooped/GitInfo/issues/46)
- HOWTO dotnet core nuget versioning [\#45](https://github.com/devlooped/GitInfo/issues/45)
- Using GitInfo in a WPF app causes build failure [\#44](https://github.com/devlooped/GitInfo/issues/44)
- Assembly Metadata IsDirty must be a string [\#43](https://github.com/devlooped/GitInfo/issues/43)
- Build fails from dotnet publish [\#41](https://github.com/devlooped/GitInfo/issues/41)
- Templates should have the \<auto-generated /\> tag as first line [\#39](https://github.com/devlooped/GitInfo/issues/39)
- packed-refs need be tracked. [\#37](https://github.com/devlooped/GitInfo/issues/37)
- ThisAssembly.Git.Commit: Information Mis-match [\#33](https://github.com/devlooped/GitInfo/issues/33)
- VB.Net: Strict Mode [\#32](https://github.com/devlooped/GitInfo/issues/32)
- Using GitSemVer in TFS builds/releases. [\#29](https://github.com/devlooped/GitInfo/issues/29)
- Branch names with slashes are chopped [\#27](https://github.com/devlooped/GitInfo/issues/27)
- Set default value for GitIsDirty [\#23](https://github.com/devlooped/GitInfo/issues/23)
- Confused about where values come from [\#21](https://github.com/devlooped/GitInfo/issues/21)
- override ThisAssemblyNamespace [\#20](https://github.com/devlooped/GitInfo/issues/20)
- Build error with 1.1.32 [\#17](https://github.com/devlooped/GitInfo/issues/17)
- Usefulness of Git.SemVer.Patch compared to Git.Commits? [\#9](https://github.com/devlooped/GitInfo/issues/9)
- Cant get it to work on Universal Windows Platform [\#7](https://github.com/devlooped/GitInfo/issues/7)
- Tag prefix per project possible ? [\#5](https://github.com/devlooped/GitInfo/issues/5)
- Still -Pre release on nuget? [\#1](https://github.com/devlooped/GitInfo/issues/1)

:twisted_rightwards_arrows: Merged:

- Allow tag and base version customization, flex matching [\#129](https://github.com/devlooped/GitInfo/pull/129) (@kzu)
- Prevent tag refs in $\(GitBranch\) for detached heads. [\#127](https://github.com/devlooped/GitInfo/pull/127) (@andersforsgren)
- Add GitCommitsIgnoreMerges option [\#125](https://github.com/devlooped/GitInfo/pull/125) (@christianerbsmehl)
- Remove username and password from repository URL [\#123](https://github.com/devlooped/GitInfo/pull/123) (@sbj42)
- Add GitCommitDate \(\#65\) [\#121](https://github.com/devlooped/GitInfo/pull/121) (@nikolamilekic)
- Use verbatim string literals in C\# and F\# templates [\#120](https://github.com/devlooped/GitInfo/pull/120) (@sbj42)
- Fix GitSemVerPatch always 0 [\#117](https://github.com/devlooped/GitInfo/pull/117) (@ysc3839)
- Make the PATCH / GitBaseVersionPatch optional [\#115](https://github.com/devlooped/GitInfo/pull/115) (@BoBiene)
- Fix GitThisAssemblyMetadata [\#112](https://github.com/devlooped/GitInfo/pull/112) (@joacar)
- Add repository url [\#111](https://github.com/devlooped/GitInfo/pull/111) (@joacar)
- fixed \#98 [\#110](https://github.com/devlooped/GitInfo/pull/110) (@pedoc)
- Turn off signature display when running log [\#102](https://github.com/devlooped/GitInfo/pull/102) (@kzu)
- Fix SemVer.Source not working in Visual Basic [\#97](https://github.com/devlooped/GitInfo/pull/97) (@MobileManiC)
- F\# support [\#93](https://github.com/devlooped/GitInfo/pull/93) (@ndani14)
- Don't cause MSBuild warnings 'expected' failures [\#90](https://github.com/devlooped/GitInfo/pull/90) (@alanmcgovern)
- Fix incremental build [\#82](https://github.com/devlooped/GitInfo/pull/82) (@shadow-cs)
- Reintroduce NormalizeDirectory usage, fix actual error [\#75](https://github.com/devlooped/GitInfo/pull/75) (@kzu)
- Ensure we normalize to the correct path separator [\#73](https://github.com/devlooped/GitInfo/pull/73) (@alanmcgovern)
- Allow counting all commits in the repository [\#66](https://github.com/devlooped/GitInfo/pull/66) (@alanmcgovern)
- Ensuring the GitExe is set when the initial target is not evaluated [\#58](https://github.com/devlooped/GitInfo/pull/58) (@adalon)
- Fix for cygwin/WSL and add support for Windows Store WSL distros [\#57](https://github.com/devlooped/GitInfo/pull/57) (@chkn)
- Add support for multi-targeting builds to retrieve Git information [\#53](https://github.com/devlooped/GitInfo/pull/53) (@kzu)
- v2 [\#52](https://github.com/devlooped/GitInfo/pull/52) (@kzu)
- Switch to 2017 image [\#51](https://github.com/devlooped/GitInfo/pull/51) (@kzu)
- Use MSBuildRuntimeTime to discern xbuild [\#50](https://github.com/devlooped/GitInfo/pull/50) (@abock)
- Don't do xbuild things on Windows [\#42](https://github.com/devlooped/GitInfo/pull/42) (@bojanrajkovic)
- Add \<auto-generated /\> comments to templates [\#40](https://github.com/devlooped/GitInfo/pull/40) (@bvli)
- track packed-refs as refs/heads may be empty when "packed-refs -all" have been used [\#38](https://github.com/devlooped/GitInfo/pull/38) (@bigbearzhu)
- VB.Net: Strict Mode, fixes \#32 [\#36](https://github.com/devlooped/GitInfo/pull/36) (@wahmedswl)
- fixes \#32 [\#35](https://github.com/devlooped/GitInfo/pull/35) (@wahmedswl)
- Add support for git in WSL [\#31](https://github.com/devlooped/GitInfo/pull/31) (@chkn)
- Update documentation \(and whitespace\) [\#26](https://github.com/devlooped/GitInfo/pull/26) (@dueringa)
- Set default value for GitIsDirty in non-repos [\#25](https://github.com/devlooped/GitInfo/pull/25) (@dueringa)
- Set default value for GitIsDirty in non-repos [\#24](https://github.com/devlooped/GitInfo/pull/24) (@dueringa)
- Added support for worktrees [\#22](https://github.com/devlooped/GitInfo/pull/22) (@taylorjonl)
- Update GitInputs list to include branch heads recursively [\#19](https://github.com/devlooped/GitInfo/pull/19) (@bigbearzhu)
- add missing close paren breaking markdown link [\#11](https://github.com/devlooped/GitInfo/pull/11) (@jamesmanning)
- Fix cygwin support [\#4](https://github.com/devlooped/GitInfo/pull/4) (@chkn)
- Untabification of readme.txt [\#3](https://github.com/devlooped/GitInfo/pull/3) (@atifaziz)



\* *This Changelog was automatically generated by [github_changelog_generator](https://github.com/github-changelog-generator/github-changelog-generator)*
