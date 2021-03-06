FROM jetbrains/teamcity-minimal-agent:latest

# Set to 1 to configure this image as Teamcity build agent
# Default value is 0 (manual build)
ENV AS_BUILDAGENT 0

# Set default target platform to 64-bits
ENV BUILD_BITS 64

# Install dependencies to install the latest gcc
RUN apt-get update && \
    apt-get install -y software-properties-common wget && \
    add-apt-repository ppa:ubuntu-toolchain-r/test

# Install latest gcc and libs
RUN dpkg --add-architecture i386 && apt-get update && \
    apt-get install -y ca-certificates git build-essential gcc-multilib g++-multilib gcc-8-multilib g++-8-multilib curl subversion ncftp \
        libncursesw5-dev libmysqlclient-dev \
        lib32ncursesw5-dev libncursesw5-dev:i386

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    apt-get install -y nodejs

# Set build directory
VOLUME /build
WORKDIR /build
