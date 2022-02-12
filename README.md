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

# Terraform Config
Terraform config for the static website is located under terraform/static-website.


# Things to do
* Forward the contact form to email of my choice
* Add CI/CD to portfolio website
* URL Rewriter caching
