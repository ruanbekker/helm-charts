#!/usr/bin/env bash
# credit: https://github.com/chrisrun
set -ex

# Other versions (ref: https://github.com/dogecoin-project/dogecoin/releases)

VERSIONS=(
1.14
1.14.2
1.14.3
1.14.4
1.14.5
1.14.6
1.14.7
1.14.8
)

err() {
  >&2 echo "$@"
}

if [ ! -f /etc/debian_version ] && [ ! -f /etc/lsb_release ]; then
  err "This script is intended for use on Debian-based systems."
  exit 1
fi

VERSION="$1"
INSTALL_PREFIX="${2:-/}"

URL="https://github.com/dogecoin/dogecoin/releases/download/v${VERSION}/dogecoin-${VERSION}-x86_64-linux-gnu.tar.gz"
CHECKSUM_URL="https://github.com/dogecoin/dogecoin/releases/download/v${VERSION}/SHA256SUMS.asc"

if [ -z "${VERSION}" ]; then
  err "Usage: get_software.sh <version> [<install-prefix>]"
  err
  err "Available versions are:"

  for v in "${VERSIONS[@]}"; do
    err "  ${v}"
  done

  err
  exit 1
fi

set -x

TMPDIR=$(mktemp -d)
cd "$TMPDIR"

curl -O "${CHECKSUM_URL}"
curl -Lo "dogecoin.tar.gz" "${URL}"

tar -xzvf "dogecoin.tar.gz"
DIR=$(find . -name 'dogecoin-*' -type d | head -n 1)
rm -f "${DIR}"/bin/dogecoin-qt
cp -r "${DIR}"/* "${INSTALL_PREFIX}"

echo
echo "dogecoin installed:"
echo
"${INSTALL_PREFIX}/bin/dogecoind" --version || true
