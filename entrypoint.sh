#!/bin/sh -l

sig=`cat ./github.sh`
challenge=`ssh-keyscan -t rsa github.com | ssh-keygen -lf -`

if [ "$challenge" = "$sig"]
    ssh-keyscan github.com >> ~/.ssh/known_hosts
    # Checkout the submodules!
    git submodule update --init --recursive
else
    echo "Signature validation failed!"
    exit(1)
fi;
