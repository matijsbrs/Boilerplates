# Blazor server demo

First steps in creating a Blazor demo with mysqldb support.

```bash
dotnet new sln --name "Blazor"  
dotnet new blazorserver --name "BlazorDemo"
dotnet sln .\Blazor.sln add .\BlazorDemo\BlazorDemo.csproj
dotnet add package MysqlConnector
```

