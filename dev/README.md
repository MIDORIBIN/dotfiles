# 開発用

## イメージ作成

```
docker build -t dotfile -f dev/Dockerfile .
```

## コンテナ生成

```
docker run --rm -it \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v ${PWD}:/home/hoge/.dotfiles \
    -w /home/hoge/.dotfiles \
    --name dotfile_dev \
    dotfile bash
```

```
docker create -it \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v ${PWD}:/home/hoge/.dotfiles \
    -w /home/hoge/.dotfiles \
    --name dotfile_dev \
    dotfile
docker start dotfile_dev
docker exec dotfile_dev bash -c "mv ~/.bashrc ~/.bashrc_original"
docker exec dotfile_dev bash -c "RCRC=./rcrc PATH=\${HOME}/local/bin/:\${PATH} rcup"
```

## アタッチ

```
docker exec -it dotfile_dev bash
```

## 削除

```
docker stop dotfile_dev && \
docker rm dotfile_dev
```
