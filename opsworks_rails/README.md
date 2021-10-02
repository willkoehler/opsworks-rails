# Package and Publish

NOTE Use Berkshelf 7.1 until https://github.com/berkshelf/berkshelf/issues/1857 is fixed

    gem install berkshelf -v7.1

Package and publish to a cookbook branch that can be used on OpsWorks. This also
updates dependencies (i.e. opsworks_ruby) to the latest versions.

    ./publish
    
    7.1.0

# Rails App Cookbook for OpsWorks Stacks

For deploying a Rails app on OpsWorks Stacks / Chef 12

Generated with

    chef generate cookbook .

Edited `Berksfile` to add dependencies and installed dependencies with

    berks install

# OpsWorks Ruby

Documentation: <https://opsworks-ruby.readthedocs.io/en/latest/index.html>

Configuration tool: <https://opsworks-ruby.rzegocki.pl/configuration-builder>
