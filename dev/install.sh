#!/bin/sh

cd ${HOME}

sh -c "$(curl -fsLS get.chezmoi.io)"
echo "PATH=\${HOME}/bin:\${PATH}"
