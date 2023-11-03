# 開発用

## イメージ作成

```
docker build -t dotfile -f dev/Dockerfile .
```

## コンテナ生成

```
docker run --rm -it \
    -v ${PWD}:/home/hoge/.local/share/chezmoi \
    -w /home/hoge/ \
    -u hoge \
    --name dotfile_dev \
    dotfile bash
```

install
```
~/.local/share/chezmoi/dev/install.sh
```
