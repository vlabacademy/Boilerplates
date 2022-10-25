# Prerequisites:
# - Replace 'projectname' with the name the project

# Build Stage
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /source
COPY . .
RUN dotnet restore ./projectname/projectname.csproj
RUN dotnet publish ./projectname/projectname.csproj -c release -o /publish

# Publish Stage
FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS publish
WORKDIR /app
COPY --from=build /publish ./

# Serve Stage
EXPOSE 80
ENTRYPOINT ["dotnet","projectname.dll"]