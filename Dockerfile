# NuGet restore
FROM mcr.microsoft.com/dotnet/core/sdk:3.0 AS build
WORKDIR /src
COPY *.sln .
COPY UnitTestProject/*.csproj UnitTestProject/
COPY TodoApi/*.csproj TodoApi/
RUN dotnet restore
COPY . .

# testing
FROM build AS testing
WORKDIR /src/TodoApi
RUN dotnet build
WORKDIR /src/UnitTestProject
RUN dotnet test

# publish
FROM build AS publish
WORKDIR /src/TodoApi
RUN dotnet publish -c Release -o /src/publish

FROM mcr.microsoft.com/dotnet/core/aspnet:3.0 AS runtime
WORKDIR /app
COPY --from=publish /src/publish .
# ENTRYPOINT ["dotnet", "TodoApi.dll"]
# heroku uses the following
CMD ASPNETCORE_URLS=http://*:$PORT dotnet TodoApi.dll