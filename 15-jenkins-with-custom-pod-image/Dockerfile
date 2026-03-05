FROM jenkins/inbound-agent:3355.v388858a_47b_33-14

USER root

# Install build essentials and tools
RUN apt-get update && apt-get install -y build-essential cmake curl libjpeg-dev libpng-dev libtiff-dev libavcodec-dev libavformat-dev libgtk-3-dev python3-dev

# Download Bazel binary directly
RUN curl -LO https://github.com/bazelbuild/bazel/releases/download/6.0.0/bazel-6.0.0-linux-x86_64
RUN chmod +x bazel-6.0.0-linux-x86_64
RUN mv bazel-6.0.0-linux-x86_64 /usr/local/bin/bazel

USER jenkins