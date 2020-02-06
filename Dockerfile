FROM alpine/git
COPY github.sig /github.sig
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
