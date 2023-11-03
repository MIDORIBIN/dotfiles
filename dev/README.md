# 開発用

## イメージ作成

```
docker build -t dotfile -f dev/Dockerfile .
```

## コンテナ生成

```
docker run --rm -it \
    -v ${PWD}:/root/.local/share/chezmoi \
    --name dotfile_dev \
    dotfile
```

## フォント

https://github.com/yuru7/HackGen
