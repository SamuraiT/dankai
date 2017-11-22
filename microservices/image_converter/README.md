# image_converter

## Usage

`/convert` endpoint receive PNG formatted by RFC 2397 and it will returns converted PNG formatted by RFC 2397

```
LISTEN_ADDR=":8080" ./image_converter
```

## Example

```
curl -XPOST localhost:8080/convert -d "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAAAAAA6fptVAAAACklEQVQIHWP4DwABAQEANl9ngAAAAABJRU5ErkJggg=="
data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAIAAACQd1PeAAAAEElEQVR4nGL6//8/IAAA//8GBgMAt2YRIQAAAABJRU5ErkJggg==
```
