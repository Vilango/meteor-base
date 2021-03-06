# Based on:
# - https://github.com/jshimko/meteor-launchpad/blob/master/Dockerfile
# - https://github.com/meteor/galaxy-images/blob/master/ubuntu/Dockerfile
FROM node:12-slim
# FROM ubuntu  # does not have node pre-installed

# Meteor version to build for; see ../build.sh
ARG METEOR_VERSION
# ARG CYPRESS_VERSION

ENV SCRIPTS_FOLDER /docker
ENV APP_SOURCE_FOLDER /opt/src
ENV APP_BUNDLE_FOLDER /opt/bundle

## Prevent prompt for tzdata region
ENV TZ=Europe/Vienna 
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies, based on https://github.com/jshimko/meteor-launchpad/blob/master/scripts/install-deps.sh (only the parts we plan to use)
RUN apt-get update && \
	apt-get install --assume-yes apt-transport-https ca-certificates && \
	apt-get install --assume-yes --no-install-recommends build-essential libarchive-tools bzip2 curl git python
	# for older ubuntu build
	# apt-get install --assume-yes --no-install-recommends build-essential bsdtar bzip2 curl git python
	

# Install Meteor
RUN curl https://install.meteor.com/?release=$METEOR_VERSION --output /tmp/install-meteor.sh && \
	# Replace tar with bsdtar in the install script; https://github.com/jshimko/meteor-launchpad/issues/39
	sed --in-place "s/tar -xzf.*/bsdtar -xf \"\$TARBALL_FILE\" -C \"\$INSTALL_TMPDIR\"/g" /tmp/install-meteor.sh && \
	# Install Meteor
	printf "\n[-] Installing Meteor $METEOR_VERSION...\n\n" && \
	sh /tmp/install-meteor.sh

# Fix permissions warning; https://github.com/meteor/meteor/issues/7959
ENV METEOR_ALLOW_SUPERUSER true


# Copy entrypoint and dependencies
COPY ./docker $SCRIPTS_FOLDER/

# Install entrypoint dependencies
RUN cd $SCRIPTS_FOLDER && \
	meteor npm install && \
	meteor npm install yarn -g

# --- newly added
# Install ps commands - since the slim root images does not have it installed by default
RUN apt-get update && \
	apt-get install --assume-yes procps

# No ONBUILD lines, because this is intended to be used by your app’s multistage Dockerfile and you might need control of the sequence of steps using files from this image
