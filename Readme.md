# Debug dev container

This is a uber development container suitable for debugging or quickly getting up and running for development purposes.

The container itself is a little bit on the fat side, since it contains all sorts of unnecessary things. One can use this as a starting point and trim it down to a more custom tailored image.

Contains the following tools:

* gcc / g++
* python
* make
* curl
* git
* nodejs
* perforce command line client

This is in about 270MB (an equivalent ubuntu image is around 600MB).

## Usage 

This will execute the default makefile target in the current directory:

```
docker run --rm -v .:/home/jenkins jtilander/dev-debug
```

## Volumes

You can mount any directory with a makefile into /home/jenkins and the default entrypoint and command will execute make. This gives you the ability to simply run make commands inside the container easily, but with data that you mounted externally.

