#!/usr/bin/env bash
set -o errexit
set -o pipefail
set -o nounset
set -o allexport


GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'


source ./versions.sh

for version in "${meteor_versions[@]}"; do
	printf "${GREEN}Building Docker base image for Meteor ${version}...${NC}\n"
	if ! docker build --build-arg "METEOR_VERSION=${version}" --tag vilango/meteor-base:"${version}" ./src; then
		printf "${RED}Error building Docker base image for Meteor ${version}${NC}\n"
		exit 1
	fi
done
docker tag vilango/meteor-base:"${version}" vilango/meteor-base:latest
printf "${GREEN}Success building Docker base images for all supported Meteor versions\n"



# for version in "${meteor_versions[@]}"; do
# 	for cyversion in "${cypress_versions[@]}"; do
# 		printf "${GREEN}Building Docker base image for Meteor ${version}-${cyversion}...${NC}\n"
# 		if ! docker build --build-arg "METEOR_VERSION=${version}" --build-arg "CYPRESS_VERSION=${cyversion}" --tag vilango/meteor-base:"${version}-${cyversion}" ./src; then
# 			printf "${RED}Error building Docker base image for Meteor ${version}-${cyversion}${NC}\n"
# 			exit 1
# 		fi
# 	done
# done

# docker tag vilango/meteor-base:"${version}-${cyversion}" vilango/meteor-base:latest
# printf "${GREEN}Success building Docker base images for all supported Meteor versions\n"
