import requests
import os

response = requests.get("https://api.github.com/repos/ONLYOFFICE/DocumentServer/releases/latest")

print('docker buildx build --push --platform linux/arm64,linux/amd64 --tag jiriks74/onlyoffice-documentserver:latest .')
os.system(f'docker buildx build --push --platform linux/arm64,linux/amd64 --tag jiriks74/onlyoffice-documentserver:latest .')
print("///////////////////////////////////////////////////////////////////////////")
print('Build and push ":latest" .........................................finished')
print("///////////////////////////////////////////////////////////////////////////")
print()

print(f'docker buildx build --push --platform linux/arm64,linux/amd64 --tag jiriks74/onlyoffice-documentserver:{response.json()["name"].replace("ONLYOFFICE-DocumentServer-", "")} .')
os.system(f'docker buildx build --push --platform linux/arm64,linux/amd64 --tag jiriks74/onlyoffice-documentserver:{response.json()["name"].replace("ONLYOFFICE-DocumentServer-", "")} .')
print("///////////////////////////////////////////////////////////////////////////")
print(f'Build and push ":{response.json()["name"].replace("ONLYOFFICE-DocumentServer-", "")}".........................................finished')
print("///////////////////////////////////////////////////////////////////////////")

