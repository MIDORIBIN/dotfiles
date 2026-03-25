
# Install

```
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b ${HOME}/.local/bin init MIDORIBIN
```

# Install Font (For Ubuntu)

```
curl -L https://github.com/yuru7/HackGen/releases/download/v2.9.0/HackGen_NF_v2.9.0.zip -o /tmp/HackGen_NF_v2.9.0.zip
unzip /tmp/HackGen_NF_v2.9.0.zip -d /tmp
rm /tmp/HackGen_NF_v2.9.0.zip

mkdir -p ${HOME}/.local/share/fonts
mv /tmp/HackGen_NF_v2.9.0 ${HOME}/.local/share/fonts/HackGenNF
```

## Python uv

https://docs.astral.sh/uv/

```sh
curl -LsSf https://astral.sh/uv/install.sh | sh
```

```sh
uv python install --preview-features python-install-default --default 3.14.3
```

## Node nvm

https://github.com/nvm-sh/nvm

```sh
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | bash
```

```sh
nvm install --lts 
```

## Opencode

https://opencode.ai/ja

```
curl -fsSL https://opencode.ai/install | bash
```

## oh-my-openagent

https://github.com/code-yeongyu/oh-my-openagent

```
npx oh-my-opencode install --no-tui --claude=no --gemini=no --copilot=no --openai=no --opencode-go=no --opencode-zen=no --zai-coding-plan=no
```
