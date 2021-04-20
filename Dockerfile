##########################
# Build the release image.
FROM ghcr.io/linuxserver/baseimage-alpine:3.13

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="bachmma1 version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="bachmma1"

# environment settings
ENV S6_BEHAVIOUR_IF_STAGE2_FAILS=2
ENV FFMPEG_COMMAND=-h

# install packages
RUN \
echo "**** install packages ****" && \
apk add --no-cache --upgrade \
	ffmpeg \
	fdk-aac-dev \
	nginx \
	nginx-mod-rtmp \
	ca-certificates \
	gettext \
	openssl \
	pcre \
	lame \
	libogg \
	curl \
	libass \
	libvpx \
	libvorbis \
	libwebp \
	libtheora \
	opus \
	rtmpdump \
	x264-dev \
	x265-dev && \
echo "**** configure nginx ****" && \
rm -f /etc/nginx/conf.d/default.conf

COPY root/ /

EXPOSE 80
EXPOSE 1935

VOLUME /config /opt/data