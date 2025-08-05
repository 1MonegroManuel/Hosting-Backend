# Etapa 1: build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copia el archivo .csproj específico y restaura dependencias
COPY HostingServiceBackend.csproj ./
RUN dotnet restore HostingServiceBackend.csproj

# Copia todo el código y publica en modo Release
COPY . ./
RUN dotnet publish HostingServiceBackend.csproj -c Release -o out

# Etapa 2: runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/out ./

# Expone puerto 80 (Render usa este puerto)
EXPOSE 80

# Forzar a escuchar en puerto 80 en todas las interfaces
ENV ASPNETCORE_URLS=http://+:80

# Ejecuta la aplicación
ENTRYPOINT ["dotnet", "HostingServiceBackend.dll"]
