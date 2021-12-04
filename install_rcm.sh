#/bin/bash
set -euox pipefail
cd "$(dirname "$0")"

VERSION=1.3.4

curl https://thoughtbot.github.io/rcm/dist/rcm-${VERSION}.tar.gz | tar zx -C .
cd rcm-${VERSION}
./configure --prefix=${HOME}/local
make
make install
cd ../
rm -rf rcm-${VERSION}
