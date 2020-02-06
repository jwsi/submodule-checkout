#!/bin/sh -l

sig=`cat /github.sig`
challenge=`ssh-keyscan -t rsa github.com 2>/dev/null | ssh-keygen -lf -`

if [ "$challenge" = "$sig" ]; then
    mkdir /root/.ssh/
    chmod 700 /root/.ssh/
    echo $1 > /root/.ssh/deploy.key
    chmod 600 /root/.ssh/deploy.key
    export GIT_SSH_COMMAND="ssh -i /root/.ssh/deploy.key"
    ssh-keyscan github.com 2>/dev/null >> /root/.ssh/known_hosts
    # Checkout the submodules!
    git submodule update --init --recursive
else
    echo "Signature validation failed!"
    exit 1
fi;
