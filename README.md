##### Rotate PDF files

The files in this folder will be processed:

```shell
export PDF_PATH=/mnt/data/pdf
```

```shell
docker build . -t rotate-pdf \
  --build-arg pdf_path=$PDF_PATH \
  -f .docker/Dockerfile
```

```shell
docker run --rm -it -v /data:/mnt/data rotate-pdf
```

