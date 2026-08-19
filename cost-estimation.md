# Cost Estimation

Region used: eu-north-1 (Stockholm)

These are approximate AWS On-Demand prices as of August 2026. Actual cost will depend on real usage. I checked current pricing on AWS's site and a few pricing comparison sites before writing these numbers down.

**EC2 (t3.micro)** – around $0.011 per hour, which works out to about $8/month if it runs the whole month.

**EBS storage (20GB)** – roughly $2/month.

**Elastic IP** – free as long as it's attached to a running instance.

**Data transfer out** – the first 1GB a month is free, after that it's about $0.09/GB. For a small SME blog with light traffic this is likely close to $0-5/month.

So the core setup (just EC2, no CloudFront) comes out to roughly **$10-15/month**.

**CloudFront (optional)** – if I turn this on later, it adds a small amount for requests (about $0.01 per 10,000 requests) plus data transfer, which for a low-traffic site would likely add another **$0-8/month**.

I picked t3.micro specifically because it's the smallest instance that can comfortably run Apache, PHP, MySQL, and WordPress together, and it keeps the whole project under $20/month, which matters for an SME that doesn't have a big budget for hosting. Running everything on one instance instead of splitting the database onto RDS also keeps costs down, since RDS alone would add another $13-15/month.

If the business grew and traffic increased, the next things to add would be RDS for the database and maybe a load balancer, but both of those would roughly double the monthly cost, so I left them out for now.
