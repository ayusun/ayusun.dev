# ayusun.dev
Public Portfolio Website of Ayush

# How to run it locally
```
hugo server -D
```

# How to deploy
```
rm -rf public/
hugo
aws s3 sync public/ s3://ayusun.dev
```