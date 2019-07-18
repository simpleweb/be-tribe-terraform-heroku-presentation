# A short introduction to Terraform for Heroku with Ansible

## Why Terraform

I'm not going to go too deep into why terraform on it's own (I prefer AWS CloudFormation but it's also an unfair fight - only one provider).

With Heroku, however, for me, Terraform is the only one that makes it simple to recreate environments (maybe review apps do too)
and share config. See Motivation resources for wanting to use Terraform.

Plus can extend from a Heroku app to manage the extras too (AWS S3 buckets, AWS CloudFront CDNs, EasyDNS records, etc...)

## Why Ansible

We know it - it's great at what it does well but it's for server configuration NOT infrastructure provisioning.
So it's good for configuring a terraform environment (which in turn does) and handling secrets in a way that's easy to handover (a file rather than a whole database system like Vault - this is not a dig at Vault but trouble is you then have to manage it and expect next maintainers to manage it, with an encrypted file it's just a file and a password, these are commonly understood).
It may be the new Terraform Online/Cloud/Enterprise makes some of this logic redundent (online services & APIs are also commonly understood).


# A walk through Pitch Perfect

Warning - there is plenty of room for improvement.

See Learning & Best Practices resources for your gateway to knowing more.

## Entrypoint

README.md
script/provision

## Ansible
infrastructure.yml
roles/app/main.yml
vars.yml (production and shared)

## Terraform
roles/app/files/main.tf
roles/app/templates/vars.tfvars.j2


## Workspace
Split up configurations, grouping together things that change together - allow for re-use (e.g. between environments) and split up an environment by lifecycle [& ownership]  (e.g. layers: network > database > app servers OR services-oriented)
naming convention: ${client}-${layer/service/team/role/purpose}-${environment} - ideally there’s a separate “backend” for each client but just in case. The other two then keep things separate by environment and

## Terraform & backend (State)
(and why it’s better than Ansible but watch out for Configuration Drift)
**Warning**:Do not check in - state files (they have secrets in them)

## (Input) Variables

make configs reusable by parameterising them and allow passing in of secret values rather than storing them directly in the config file.

## Locals

reduce duplicate logic

## Provider

thing that actual provides resources (e.g. AWS, Heroku, easyDNS, ...). Will require some configuration to connect (e.g. AWS access keys, Heroku API key)

## Resource
a declarative way of describing the actual infrastructure you want

also related:
* depends_on - make explicit the occassional hidden dependency
* lifecycle - can tweak a bit how and if resources are created & destroyed

## Functions, expressions & logic

e.g. computing the domain of the app in this case

## Not covered
* Modules (but these are highly recommended by the docs)
* Outputs - very useful when have multiple workspaces per environment so can get at useful information (eg database hostname, network subnet ids)
* Importing existing resources (so putting existing infrastructure under terraform control)
* Data sources - I think these allow you to get information about resources (perhaps you want to find out the private IP address of an EC2 instances that's already been provisioned by someone else)
* Lots of funky logic you can (and can’t [easily]) do to make your templates powerful/illegible
* Plenty more - there’s a bucket load of functionality in Terraform (e.g. running local or remote scripts)
* Actually deploying code - this just creates a Heroku app but there is no "slug" yet so there's nothing running. In theory you can use terraform with this but there is a warning about the different between infrastructure resources (like apps and add ones) and operational resources (like slugs & dyno scaling) - https://devcenter.heroku.com/articles/using-terraform-with-heroku#configuring-infrastructure-and-operational-resources

# Problems run into or warnings:

## Configuration drift

**Warning** You have to go all in or else chaos - https://devcenter.heroku.com/articles/using-terraform-with-heroku#best-practices

OK, so you can have some stuff at the edges - perhaps a domain already bought or a database-backup task tacked on at the side - but once you start fiddling with the Terraform resources "by hand" (CLI, API, web console, anything not Terraform) then you can really get in a muddle because Terraform uses it's state to expect one thing so then all bets are off if it's not in that state.

## Collaboration

It's definitely possible and what terraform is built for
but not sure if & how this setup will work in collaboration with others (will it init for them?) because I haven't tried.

## Difficulties tearing down environments & working with workspaces

* Difficulties tearing down environments (Heroku specifically perhaps - it deletes config vars and db at same time which causes an error because app will release on config var change but now db is gone
release fails which puts the heroku API calls in a twist later)
* Workspace-based errors: this might be due to A) tearing stuff down inexpertly and/or B) possibly not safe to run concurrently since workspace switching appears to be file based

NB some of these may just be down to me doing weird stuff whilst developing the config

## Ansible & Terraform

* Ansible & Terraform: Tough to debug by hand (due to templated vars file, and init in an odd place and workspace management)
* Ansible & Terraform: Similarly, bit tough to see plans - even nicer if some CI tool could produce these and display them in PRs
* Ansible & Terraform: hard to read errors

## Provider credentials

* Missing a nice way for devs to pass in the provider credentials they need (solution might be docs, improved CLI tool or some sort of CI tool to do it for us)

# Recommendations

* Learn terraform first without the Ansible part or hiding secrets (just don’t necessarily push those variable files with secrets in to GitHub) - it’s a different way of thinking about infrastructure (in some ways less flexible but very powerful and concise)
* Maybe try it out using a local file for state to start with so you it’s easier to see what’s going on with state
* If you’re done any AWS CloudFormation you’ll have a good head start but Terraform offers more in some ways (though you’ll miss the auto-rollback on failure and the built-in UI and managed state storage and the extras are at the expense of more bugs and giving you extra rope to hang yourself)

# Documentation & Resources

## Motivation
* https://www.terraform.io/intro/index.html
* https://blog.heroku.com/six-strategies-deploy-to-heroku

## Best practices
* https://www.terraform.io/guides/core-workflow.html
* https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/best-practices.html
* https://devcenter.heroku.com/articles/using-terraform-with-heroku#best-practices

## Learning
* https://devcenter.heroku.com/articles/using-terraform-with-heroku
* https://www.terraform.io/docs/index.html
* https://learn.hashicorp.com/terraform/
* https://www.terraform.io/docs/configuration/index.html
* https://www.terraform.io/docs/providers/heroku/
