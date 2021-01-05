ARG METEOR_VERSION
ARG CYPRESS_VERSION

FROM vilango/meteor-base:$METEOR_VERSION


ENV SCRIPTS_FOLDER /docker
ENV APP_SOURCE_FOLDER /opt/src
ENV APP_BUNDLE_FOLDER /opt/bundle

# Install Cypress

RUN apt-get update && \
#	apt-get install --no-install-recommends --assume-yes libgtk2.0-0 libgtk-3-0 libnotify-dev libgconf-2-4 libnss3 libxss1 libasound2 libxtst6 xauth xvfb && \ 
    apt-get install --no-install-recommends --assume-yes libgtk2.0-0 libgtk-3-0 libnotify-dev && \
	apt-get install --no-install-recommends --assume-yes libgconf-2-4 libnss3 libxss1 && \
    apt-get install --no-install-recommends --assume-yes libxtst6 xauth && \
	apt-get install --no-install-recommends --assume-yes libasound2 xvfb


RUN cd $SCRIPTS_FOLDER && \
	meteor yarn global add cypress@$CYPRESS_VERSION
#	meteor yarn global add cypress

# No ONBUILD lines, because this is intended to be used by your app’s multistage Dockerfile and you might need control of the sequence of steps using files from this image
