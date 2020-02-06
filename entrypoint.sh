#!/bin/sh -l

sig=`cat /github.sig`
challenge=`ssh-keyscan -t rsa github.com | ssh-keygen -lf -`

if [ "$challenge" = "$sig" ]; then
    mkdir /root/.ssh/
    chmod 0700 /root/.ssh/
    ssh-keyscan github.com >> /root/.ssh/known_hosts
    # Checkout the submodules!
    git submodule update --init --recursive
else
    echo "Signature validation failed!"
    exit 1
fi;
