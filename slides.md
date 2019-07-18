title: A short introduction to using Terraform with Ansible to provision Heroku apps
author:
  name: Henry
  url: https://github.com/simpleweb/be-tribe-terraform-heroku-presentation
output: slides.html
style: slides.css
theme: jdan/cleaver-retro
controls: true

--

# A short introduction to Terraform for Heroku with Ansible

* Why Terraform?
* Why Ansbile?

--

## A walk through Pitch Perfect

--

## A walk through Pitch Perfect
#### Entrypoint

* README.md
* script/provision

--

## A walk through Pitch Perfect
#### Ansible

* infrastructure.yml
* roles/app/main.yml
* vars.yml (production and shared)

--
## A walk through Pitch Perfect
#### Terraform

* roles/app/files/main.tf
* roles/app/templates/vars.tfvars.j2

--

# Workspaces

Split up configuration & re-use them

--

## Workspaces
# Naming Convention

${client}-${layer/service/team/role/purpose}-${environment}

e.g. simpleweb-app-staging

--

## Terraform Configuration Language
### State & Backend

* Local file
* "Remote" PostgreSQL DB
* Many more...

--

## Terraform Configuration Language
# (Input) Variables

--

## Terraform Configuration Language
# Locals

--
## Terraform Configuration Language
# Providers

--

## Terraform Configuration Language
# Resources

--

## Terraform Configuration Language
# Functions, expressions & logic

--

## Terraform Configuration Language
# Not covered

* Modules
* Outputs
* Importing existing resources
* Data sources
* Lots of funky logic you can (and can’t [easily]) do to make your templates powerful/illegible
* Plenty more

--

# Also not covered
* Actually deploying code

--

# Problems/Warnings

## Configuration drift

All in or else chaos - https://devcenter.heroku.com/articles/using-terraform-with-heroku#best-practices

--

# Problems/Warnings

## Collaboration

--

# Problems/Warnings

## Misc errors encountered

--

# Problems/Warnings

## Issues with Ansible & Terraform together

--

# Problems/Warnings

## Provider credentials

--

# Recommendations

* Try without Ansible first
* Maybe try with a local state file
* It's like AWS CloudFormation but...

--

# Documentation & Resources

## Motivation
* https://www.terraform.io/intro/index.html
* https://blog.heroku.com/six-strategies-deploy-to-heroku

--

# Documentation & Resources

## Best practices
* https://www.terraform.io/guides/core-workflow.html
* https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/best-practices.html

--

# Documentation & Resources

## Learning
* https://devcenter.heroku.com/articles/using-terraform-with-heroku
* https://www.terraform.io/docs/index.html
* https://learn.hashicorp.com/terraform/
* https://www.terraform.io/docs/configuration/index.html
* https://www.terraform.io/docs/providers/heroku/
