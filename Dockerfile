FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive \
    LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    ANDROID_HOME=/opt/android-sdk \
    ANDROID_SDK_ROOT=/opt/android-sdk \
    ANDROID_NDK_HOME=/opt/android-sdk/ndk/25.2.9519653 \
    ANDROID_NDK_ROOT=/opt/android-sdk/ndk/25.2.9519653 \
    JAVA_HOME=/usr/lib/jvm/temurin-17-jdk-amd64 \
    PATH=/opt/android-sdk/cmdline-tools/latest/bin:/opt/android-sdk/platform-tools:/opt/android-sdk/build-tools/34.0.0:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

WORKDIR /workspace

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential git python3 python3-pip python3-dev python3-venv \
    autoconf automake libtool pkg-config wget unzip curl ca-certificates \
    openjdk-17-jdk ffmpeg libsdl2-dev libsdl2-image-dev libsdl2-mixer-dev \
    libsdl2-ttf-dev libportmidi-dev libswscale-dev libavformat-dev libavcodec-dev \
    zlib1g-dev libffi-dev libssl-dev && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /opt/android-sdk/cmdline-tools && \
    cd /tmp && \
    wget -q https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip -O cmdline-tools.zip && \
    unzip -q cmdline-tools.zip && \
    mv /tmp/cmdline-tools /opt/android-sdk/cmdline-tools/latest && \
    yes | /opt/android-sdk/cmdline-tools/latest/bin/sdkmanager --sdk_root=/opt/android-sdk --licenses && \
    /opt/android-sdk/cmdline-tools/latest/bin/sdkmanager --sdk_root=/opt/android-sdk \
      "platform-tools" \
      "platforms;android-31" \
      "build-tools;34.0.0" \
      "ndk;25.2.9519653" && \
    python3 -m pip install --upgrade pip setuptools wheel && \
    python3 -m pip install "cython==0.29.33" "buildozer==1.5.0"

CMD ["/bin/bash"]
