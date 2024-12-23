#!/usr/bin/env bash

set -e

RELEASE_VERSION=${RELEASE_VERSION:-v0.0.1}
# Determines the operating system.
OS="${TARGET_OS:-$(uname)}"
if [ "${OS}" = "Darwin" ] ; then
  OSEXT="darwin"
elif [ "${OS}" = "Linux" ] ; then
  OSEXT="linux"
else
  echo "This system's OS, ${OS}, isn't supported"
  exit 1;
fi

LOCAL_ARCH=$(uname -m)
if [ "${TARGET_ARCH}" ]; then
    LOCAL_ARCH=${TARGET_ARCH}
fi

case "${LOCAL_ARCH}" in
  x86_64|amd64)
    TCA_ARCH=amd64
    ;;
  armv8*|aarch64*|arm64)
    TCA_ARCH=arm64
    ;;
  *)
    echo "This system's architecture, ${LOCAL_ARCH}, isn't supported"
    exit 1
    ;;
esac

if [ "${RELEASE_VERSION}" = "" ] ; then
  printf "Unable to get release version."
  exit 1;
fi

NAME="Release.txt"
URL="https://github.com/zirain/gh-action-demo/releases/download/${RELEASE_VERSION}/${NAME}"
echo "Downloading ${URL}"

curl -fsLO "${URL}"

echo "Downloading ${NAME} completed"
