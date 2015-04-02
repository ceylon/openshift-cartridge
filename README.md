#OpenShift Ceylon cartridge

Login to [OpenShift](https://openshift.redhat.com/app/console/application_types) and find "Code Anything" at the bottom of "Create Application" tab.

Provide url to cartridge definition and continue with your application deployment.

Cartridge definition url: https://raw.github.com/ceylon/openshift-cartridge/master/metadata/manifest.yml

# Testing the cartridge

Create a test folder:

    $ mkdir test

Copy your cartridge to it:

    $ cp -r .../openshift-cartridge/* test/

Set up your environment:

    $ cd test
    $ export OPENSHIFT_CEYLON_DIR=`pwd`/ # last slash is important
    $ export OPENSHIFT_CEYLON_IP=127.0.0.1
    $ export OPENSHIFT_CEYLON_VERSION=1.1.0
    $ export OPENSHIFT_REPO_DIR=template/ # last slash is important
    $ bin/setup

Build and run:

    $ bin/control build
    $ bin/control run

Check that you got something at http://localhost:8080

Stop it:

    $ bin/control stop 
