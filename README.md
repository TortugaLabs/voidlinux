# voidlinux-container

My own voidlinux container images


Build:

```bash
libc=musl
image=voidlinux-$libc:latest
docker buildx build -t $image --build-arg LIBC=$libc
```

Run:

```bash
libc=musl
image=voidlinux-$libc:latest
docker run --rm -it "$image" "$@"
```
