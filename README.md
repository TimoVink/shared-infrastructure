![GitHub](https://img.shields.io/github/license/TimoVink/infra-shared)


# Shared Infrastructure

This repository contains Terraform cloud infrastructure declarations for any infrastructure that doesn't belong to an individual application.

Our primary cloud provider is `AWS`, and our primary region is `us-west-2` (Oregon).


## Components

### IAM

Users and roles to provide basic access to the AWS account.

### Budget

AWS budgets for both forecasted and actual costs to prevent any surprises.

### DNS

Route 53 Hosted Zones for all domains I manage. The actual DNS records for these zones will lagely live within their respective application repositories.

### TLS Certificates

TLS certificates for all domains I manage.

### Domain Redirects

For some of the domain names I manage, I own several TLDs. In this case I'd like to redirect all "secondary" TLDs to the primary TLD.
