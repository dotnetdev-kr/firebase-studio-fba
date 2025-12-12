#!/usr/bin/env dotnet
#:sdk Microsoft.NET.Sdk.Web
#:property PublishAot=false

var builder = WebApplication.CreateBuilder(args);

var port = Environment.GetEnvironmentVariable("PORT") ?? "3000";
var url = $"http://0.0.0.0:{port}";
var target = Environment.GetEnvironmentVariable("TARGET") ?? "World";

using var app = builder.Build();
app.MapGet("/", () => $"Hello {target}!");
app.Run(url);
