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

Route 53 Hosted Zones for all domains I have currently own. The actual DNS records for these zones will lagely live within their respective application repositories.

### TLS Certificates

TLS certificates for all domains I currently own.

### Domain Redirects

I own the `timovink.*` domain for a few different TLDs. For now I'd like to use `timovink.dev` as the main one, and sinmply redirect all others to it.
