FROM mcr.microsoft.com/dotnet/sdk:5.0
#AS build-env
WORKDIR /app

# copy csproj and restore as distinct layers
COPY *.csproj ./
RUN dotnet restore

# copy everything else and build
COPY . ./
RUN dotnet publish -c Release -o out

# install nodejs 
RUN sudo apt install nodejs

# build runtime image
#FROM microsoft/aspnetcore:2.0
WORKDIR /app
EXPOSE 80
ENTRYPOINT ["dotnet", "out/aspnetapp.dll"]
