#
# Load up application's gems upon which it relies
# We start here with loading rubygems just in case...
#

require 'rubygems'

#
# ...and then we check for whether or not the Bundler
# class is defined; if so, we treat it as a basic
# bundler invocation.
#
# But wait, Bundler is NOT defined? Okay, load up
# the bundler standalone setup script.
#

unless defined?(Bundler)
  require File.join(APP_ROOT, 'vendor', 'bundle', 'bundler', 'setup.rb')
end

#
# With that little edge case/chore done, now we can proceed
# as normal, loading our gems happily.
#

require 'thor'
require 'aws-sdk'

#
# Declare the class as a blank class to start; we'll
# shape it as we go.
#

class AwsAudit
end

#
# To facilitate easier/sane loading of this app's files under lib/,
# prepend APP_ROOT to the global $LOAD_PATH. That should ensure we
# can just `require 'aws-audit/version.rb'` (for example) instead
# of lots of crazy repetitive use of that APP_ROOT constant...
#

unless $LOAD_PATH.include?(File.join(APP_ROOT, 'lib'))
  $LOAD_PATH.unshift(File.join(APP_ROOT, 'lib'))
end

#
# Explicitly require all the things needed for this app.
# Why not just glob it or something? Because I want the developer
# (probably just me, honestly...) to be *forced* to be constantly
# aware of what they're loading at application instantiation, project
# structure, and to feel the pain if they (well, me...) do a bad job
# of organizing their stuff under `lib/aws-audit`, for example.
#

require 'aws-audit/version'
require 'aws-audit/errors'
require 'aws-audit/cli'
