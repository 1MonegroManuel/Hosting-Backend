# Etapa 1: build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copia csproj y restaura dependencias
COPY *.csproj ./
RUN dotnet restore

# Copia todo y publica en modo Release
COPY . ./
RUN dotnet publish -c Release -o out

# Etapa 2: runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/out ./

# Expone puerto 80 (Render usa este puerto)
EXPOSE 80

# Forzar a escuchar en puerto 80
ENV ASPNETCORE_URLS=http://+:80

# Ejecuta la app
ENTRYPOINT ["dotnet", "HostingServiceBackend.dll"]
