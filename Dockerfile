
FROM		alpine:3.17
RUN			apk add --no-cache git \
			&& rm -rf /var/cache/apk/*
ENTRYPOINT	[ "/usr/bin/git" ]
