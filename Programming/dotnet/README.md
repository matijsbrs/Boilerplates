# Visual Studio Code dotnet development tutorial

## Summary

Create a C# project and program with Visual Studio Code.
The project is based on .NET 7.0 version, but the .NET 6.0 will also work

## Essentials

* [https://code.visualstudio.com/](Visual Studio Code)
* [https://marketplace.visualstudio.com/items?itemName=ms-dotnettools.csharp](C# Extention)
* [https://dotnet.microsoft.com/download/dotnet/6.0](.NET 6.0)
* [https://dotnet.microsoft.com/download/dotnet/7.0](.NET 7.0)

## Intro

We'll start with checking the versions:

```bash
$ dotnet --info 
.NET SDK:
 Version:   7.0.102
 Commit:    4bbdd14480

Runtime Environment:
 OS Name:     ubuntu
 OS Version:  22.04
 OS Platform: Linux
 RID:         ubuntu.22.04-x64
 Base Path:   /usr/share/dotnet/sdk/7.0.102/

Host:
  Version:      7.0.2
  Architecture: x64
  Commit:       d037e070eb

.NET SDKs installed:
  6.0.404 [/usr/share/dotnet/sdk]
  7.0.102 [/usr/share/dotnet/sdk]

.NET runtimes installed:
  Microsoft.AspNetCore.App 7.0.2 [/usr/share/dotnet/shared/Microsoft.AspNetCore.App]
  Microsoft.NETCore.App 7.0.2 [/usr/share/dotnet/shared/Microsoft.NETCore.App]

Other architectures found:
  None

Environment variables:
  DOTNET_ROOT       [/usr/lib/dotnet/dotnet6-6.0.110]

global.json file:
  Not found

Learn more:
  https://aka.ms/dotnet/info

Download .NET:
  https://aka.ms/dotnet/download
```

We can see that both SDK's are installed '6.0.404' and '7.0.102'.

The tutorial is tested with VSCode '1.74.3'

## Create a new Solution

The first thing we need to do is create a new Solution. We will do this using the following command:

```bash
$ dotnet new solution --name Learn_dotnet
The template "Solution File" was created successfully.

```

Now we have the Learn_dotnet.sln file created.
Most of the projects I do are in a git repos. But a dotnet project contains allot of files after you've compiled, and you don't want that. There is a neat trick you can use:

```bash
$ dotnet new gitignore
The template "dotnet gitignore file" was created successfully.

```

Now a '.gitignore' file is created. From this point on, the project should be nice and clean in you git repos.

## Create a new project

To be able to program we need a project. In this case it will be a simple Hello, World Console app.

The used framework is manually set to .net 7.0 but you can change this, or even don't use the -f option and use the latest version on you machine. To name the project we'll add '--name "CLI"' to the dotnet command. This will create a project named CLI setup to use the <nobr>.NET 7.0 framework</nobr>.

```bash
dotnet new console -f net7.0 --name "CLI"
The template "Console App" was created successfully.

Processing post-creation actions...
Restoring /home/admin/tmp/CLI/CLI.csproj:
  Determining projects to restore...
  Restored /home/admin/tmp/CLI/CLI.csproj (in 125 ms).
Restore succeeded.

```

## Create a new Class library

For completenes this tutorial also contains a class library.

To create the new class library we'll use the following command:

```bash
dotnet new classlib -f net7.0 --name "SupportLib"
The template "Class Library" was created successfully.

Processing post-creation actions...
Restoring /home/admin/tmp/SupportLib/SupportLib.csproj:
  Determining projects to restore...
  Restored /home/admin/tmp/SupportLib/SupportLib.csproj (in 112 ms).
Restore succeeded.

```

The '-f net7.0' option again set the framework to <nobr>.NET 7.0 framework</nobr>. The name is set using the '--name' option. In this case the project is named 'SupportLib'.

## Associate the two projects to the solution

Associating projects with a solution is simple with the dotnet command. Use the following steps:

```bash
$ dotnet sln Learn_dotnet.sln add CLI/CLI.csproj
Project `CLI/CLI.csproj` added to the solution.

$ dotnet sln Learn_dotnet.sln add SupportLib/SupportLib.csprj
Project `SupportLib/SupportLib.csproj` added to the solution.

```

The 'sln' option stands for solution and takes the newly created 'Learn_dotnet.sln' as an argument. Followed by the 'add' command which in turn is followed by a path to the project file which need to be associated in the solution.

## Adding a reference to a project

In the project we have created two projects, a Console app and a Class library. To be able to use the Class library in the Console app we need to add a reference to the project.
This is done again using the dotnet command. 

```bash
$ dotnet add CLI/CLI.csproj reference SupportLib/SupportLib.csproj
Reference `..\SupportLib\SupportLib.csproj` added to the project.

```

Now there is a reference added to the CLI.csproj file.

If you have the need to add a reference to a nuget packet enter the project directory and  use the following command:

```bash
$ dotnet add package newtonsoft.json
  Determining projects to restore...
  Writing /tmp/tmpaeKmE2.tmp
info : X.509 certificate chain validation will use the fallback certificate bundle at '/usr/share/dotnet/sdk/7.0.102/trustedroots/codesignctl.pem'.
info : X.509 certificate chain validation will use the fallback certificate bundle at '/usr/share/dotnet/sdk/7.0.102/trustedroots/timestampctl.pem'.
info : Adding PackageReference for package 'newtonsoft.json' into project '/home/admin/tmp/CLI/CLI.csproj'.
info :   GET https://api.nuget.org/v3/registration5-gz-semver2/newtonsoft.json/index.json
info :   OK https://api.nuget.org/v3/registration5-gz-semver2/newtonsoft.json/index.json 120ms
info : Restoring packages for /home/admin/tmp/CLI/CLI.csproj...
info :   GET https://api.nuget.org/v3-flatcontainer/newtonsoft.json/index.json
info :   OK https://api.nuget.org/v3-flatcontainer/newtonsoft.json/index.json 118ms
info :   GET https://api.nuget.org/v3-flatcontainer/newtonsoft.json/13.0.2/newtonsoft.json.13.0.2.nupkg
info :   OK https://api.nuget.org/v3-flatcontainer/newtonsoft.json/13.0.2/newtonsoft.json.13.0.2.nupkg 25ms
info : Installed Newtonsoft.Json 13.0.2 from https://api.nuget.org/v3/index.json with content hash R2pZ3B0UjeyHShm9vG+Tu0EBb2lC8b0dFzV9gVn50ofHXh9Smjk6kTn7A/FdAsC8B5cKib1OnGYOXxRBz5XQDg==.
info : Package 'newtonsoft.json' is compatible with all the specified frameworks in project '/home/admin/tmp/CLI/CLI.csproj'.
info : PackageReference for package 'newtonsoft.json' version '13.0.2' added to file '/home/admin/tmp/CLI/CLI.csproj'.
info : Writing assets file to disk. Path: /home/admin/tmp/CLI/obj/project.assets.json
log  : Restored /home/admin/tmp/CLI/CLI.csproj (in 968 ms).

```

We've now added 'Newtonsoft.json' to the project.

## Edit the Program.cs

Dotnet allows for unstructed files. But in this tutorial I'd like to use a 'regular' C# file.

Replace the contents of 'Program.cs' with:

```c#
using System;

namespace CLI
{
    internal class Program
    {
        static void Main(string[] args)
        {
                Console.WriteLine("Hello, World!");
        }
   }
}
```

## Building the project

You can build the project manually using the terminal using a dotnet command:
Enter the directory where the project root is.

```bash
$ dotnet build
MSBuild version 17.4.1+9a89d02ff for .NET
  Determining projects to restore...
  All projects are up-to-date for restore.
  SupportLib -> /home/admin/tmp/SupportLib/bin/Debug/net7.0/SupportLib.dll
  CLI -> /home/admin/tmp/CLI/bin/Debug/net7.0/CLI.dll

Build succeeded.
    0 Warning(s)
    0 Error(s)

Time Elapsed 00:00:03.47

```

If no errors are found the code is now succesfully build. Execute the code using:

```bash
$ dotnet run
Hello, World!
```

## Building and running in Visual Studio Code

It is much more comfinient to use vscode to run and help with debugging. A couple of simple steps are needed.

1. Press CTRL + SHIFT + P
2. Type: '.NET: Generate Assets for Build and Debug'

This creates a directory named: '.vscode' in this directory two files are created:

1. launch.json
2. tasks.json

I recommend changing the launch.json slightly. By default the console used is just for output. But it is nice to have input. Open the file and look for the line containing: 

```json
"console": "internalConsole",
```

Change this to:

```json
"console": "integratedTerminal",
```

This way the integrated terminal of VScode is used.

Now press 'F5' and your program should now run.
