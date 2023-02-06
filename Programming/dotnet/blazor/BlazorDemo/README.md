# Blazor server demo

First steps in creating a Blazor demo with mysqldb support.

```bash
dotnet new sln --name "Blazor"  
dotnet new blazorserver --name "BlazorDemo"
dotnet sln .\Blazor.sln add .\BlazorDemo\BlazorDemo.csproj
dotnet add package MysqlConnector
```

## Stop tracking changes of hthe appsettings.json file
```bash
git update-index --assume-unchanged Programming/dotnet/blazor/BlazorDemo/appsettings.json
```

## Start tracking changes again
```bash
git update-index --no-assume-unchanged [<file> ...]
```