#!/usr/bin/env bash
# credit: https://github.com/chrisrun
set -ex

# Other versions (ref: https://github.com/litecoin-project/litecoin/releases)

VERSIONS=(
0.16.3
0.17.1
0.18.1
0.21.2
0.21.2.1
0.21.2.2
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

URL="https://github.com/litecoin-project/litecoin/releases/download/v${VERSION}/litecoin-${VERSION}-x86_64-linux-gnu.tar.gz"
CHECKSUM_URL="https://github.com/litecoin-project/litecoin/releases/download/v${VERSION}/SHA256SUMS.asc"

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
curl -Lo "litecoin.tar.gz" "${URL}"

tar -xzvf "litecoin.tar.gz"
DIR=$(find . -name 'litecoin-*' -type d | head -n 1)
rm -f "${DIR}"/bin/litecoin-qt
cp -r "${DIR}"/* "${INSTALL_PREFIX}"

echo
echo "Litecoin installed:"
echo
"${INSTALL_PREFIX}/bin/litecoind" --version || true