
FROM		alpine:3.17
ARG			GIT_VERSION
RUN			apk add --no-cache git \
			&& rm -rf /var/cache/apk/*
ENTRYPOINT	[ "/usr/bin/git" ]
