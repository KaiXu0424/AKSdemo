FROM mcr.microsoft.com/dotnet/core/aspnet:2.2 AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/core/sdk:2.2 AS build
WORKDIR /src
COPY ["AKSDemo.csproj", "."]
RUN dotnet restore "AKSDemo.csproj"
COPY . .
RUN dotnet build "AKSDemo.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "AKSDemo.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "AKSDemo.dll"]