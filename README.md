# etcd
Just a simple etcd in a docker image as I did not happen to find a suiablke multi-platform one on docker hub.

I build it something like
```
docker buildx build --builder cluster --push --platform linux/amd64,linux/arm -f Dockerfile -t docker-registry.home:5000/etcd .

```
