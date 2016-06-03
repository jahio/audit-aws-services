# configuration for aws-audit

Since this tool is a piece of the [aws-nat-bastion-bosh-cf](https://github.com/cloudfoundry-community/aws-nat-bastion-bosh-cf) repository/project (note: as of this writing there's talk - _thankfully_ - of changing the name. I mean seriously, pronounce THAT three times fast!), **this tool expects a valid and known working file under `/path/to/this/repo/terraform/aws/terraform.tfvars`**. If that file doesn't exist, or doesn't contain necessary values, or if the tool can't parse the file's contents, **you need to make sure your file is formatted correctly and actually has the RIGHT values in there.**

TODO: More configuration info
