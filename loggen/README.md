```
docker build -t narenp/loggen:v2 . 

docker pull narenp/loggen:v2

docker --rm -d --name=demo run narenp/loggen:v2

k run demo --image=narenp/loggen:v2
```
