# AWS Audit: Find out what's (still?) running

You ran `make destroy` but it exploded on you, complaining about some silly resource that should already be gone. Now you want to validate, *outside of the context that gave you problems just now*, what the __ACTUAL__ state of your AWS services are *right now*, not based on some crazy cached state that's probably gone stale before you finished reading this paragraph.

**Enter aws-audit.**

This tool uses Amazon's official [aws-sdk](https://github.com/aws/aws-sdk-ruby) for Ruby to query status when you run it via its CLI. You can get output back as a summary, a detailed list of as much info as Amazon will give us, and you can even get that data returned to `STDOUT` as `JSON`, so you can redirect to a file somewhere in your shell, thus enabling you to do some scripting against the returned data.

## Status: pre-alpha, active development

Until this project's status in the above line is updated to say something like "beta" or "release candidate", don't count on anything in this readme reflecting reality. Workflow, CLI commands/args, etc. may change at any time until an official release is pushed.

## Configuration

You *must* have a valid, working and correctly-filled-out [terraform/aws/terraform.tfvars](../../terraform/aws/terraform.tfvars.example). This tool will manually parse the keys/values in that plain-text file and use the region, token and secret mentioned therein automatically.

This tool will read the configuration you've already specified in . While the link in the previous sentence goes to the example file, it's expected that you have the actual file with values properly filled out on your local machine and you know that it works (e.g. perhaps after running `make all` or `make destroy` for example).

## User Stories / Features

+ Summary or detailed output;
+ Data output directly to `STDOUT` so you can use your shell to capture/stream it;
+ Information returned by `aws-audit` can be pretty formatted for your terminal;
+ Or it can be returned as one big `JSON` payload that you can redirect to a local file for scripting against it later;
+ Get a debug log written to disk if you want;
+ Control the verbosity of that log, too;

### TODO: Hash out and specify env-vars to set/tweak for various effects

+ `RUNTIME_ENV` (development, test); may load extra things, log development-only stuff if var exists and value is set to one of those. End user should never need this.
+ `AWS_AUDIT_LOG_FILE` can specify a location on the local system to append log data to. For example, `/home/me/.log/aws-audit.log`
+ `AWS_AUDIT_LOG_LEVEL` controls log verbosity. Planning only to implement two levels right now, "info" and "debug". Think of it as "regular" and "overkill" :smiley:
+ `AWS_REGION` to override/bypass `terraform.tfvars` settings;
+ `AWS_SECRET_KEY` and `AWS_SECRET_TOKEN` (or whatever AWS calls those now) - if present, ignores whatever's in `terraform.tfvars` and uses that.

----------

# Development Notes

Miscellaneous notes for the development team; should probably move this into a doc before release but this will do for now...

## Using bundler to package, redistribute app dependencies

First, unlock your Gemfile/Gemfile.lock so you can `bundle install` if you've made changes, want gems updated, etc.

```
bundle install --no-deployment
```

Now that `Gemfile.lock` is finally up to date (`git diff` it to be sure), *package your gems*:

```
bundle package --all --all-platforms --no-install
```

+ `--all` tells it to get gems specified by `:path` and/or `:git`
+ `--all-platforms` tells it to include gems for all available platforms the gem has a version for; otherwise it'll only retrieve the gem for the platform this command's being run on
+ `--no-install` don't bother to install these gems after packaging them, *just package them* and that's it

After this you should have `vendor/cache/*.gem` files, one for each of the gem/version/platform dependency resolution bundler worked out in `Gemfile.lock`. **YES, these need to be committed with this repository and project.** It dramatically eases user experience and improves security, longevity and reliability.

*Next*, install the gems into a location relative to this app instead of in the overall system.

```
bundle install --jobs 4 --deployment --standalone --clean --without development test
```

+ `--jobs 4` says to spin up 4 separate background processes to do things in parallel. Makes things much, much faster.
+ `--deployment` turns on a few options, actually. Isolate the installed gems under `$PWD/vendor/bundle`, **automatically use the packaged gems we just retrieved** instead of fetching from rubygems.org, and a few other things - see the section on `bundle install --deployment` at [bundler.io](http://bundler.io/v1.12/bundle_install.html).
+ `--standalone` is a **super important piece of this workflow** because it creates `vendor/bundle/bundler/setup.rb`, a script that modifies `$LOAD_PATH` to explicitly add the local filesystem location to it so that at runtime, when you `require 'aws-sdk'`, *it uses the DISTRIBUTED version shipped with this app, instead of whatever's in the system default load path location.* It's how we ensure that our users neither need bundler installed, nor do they wind up using the wrong gems installed throughout the whole system instead of what we explicitly want the app to use.
+ `--clean` just cleans up any unused gems in the bundler gem directory. Probably not needed but I prefer to keep things tidy as much as possible, so why not?
+ `--without test development` is *supposed* to skip installing gems specified in `Gemfile` as in the test or development groups, but unfortunately there appears to be a bug here where it basically says "lol no imma ignor u" and does it anyway. Instead of hack it, fight it or wait on an upstream fix, we're just biting the bullet here and letting it unpack dev/test gems too. Yep they'll ship with the app even though they shouldn't, and it's all thanks to this weird edge case.

**YES, you DO need to ship the entire contents of the `vendor` directory with this tool!** It's the only way we can ensure that users have all the needed dependencies in a format that can be used _at runtime_ **and** they have the original gem archives for each as well, thus allowing for maximum reliability as time goes on.

### Misc. Links / Docs / Notes

[Here's the public internet URLs for AWS API endpoints by region](http://docs.aws.amazon.com/general/latest/gr/rande.html)
