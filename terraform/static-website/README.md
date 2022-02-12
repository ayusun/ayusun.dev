# Static Website terraform
This terraform contains all the things necessary to host the static Website. The Folder provides 3 things
* Infrastructure for Contact form
* Hosted Zones
* The Website hosting


# Contact Form
The Static page has a contact form which can be used to contact me. It's basically an AWS API Gateway with processing in AWS Lambda

# Hosted Zone
This Hosted Zone is created using Route53

# Website Hosting
The Website hosting is using S3 + Cloudfront. It also comes with a url rewriter Lambda to add index.html infront of url path