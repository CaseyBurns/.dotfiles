# .dotfiles

## install basic things to get started

Install Github Cli and Auth
```bash
# https://github.com/cli/cli/blob/trunk/docs/install_linux.md
(type -p wget >/dev/null || (sudo apt update && sudo apt-get install wget -y)) \
	&& sudo mkdir -p -m 755 /etc/apt/keyrings \
        && out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg \
        && cat $out | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
	&& sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
	&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
	&& sudo apt update \
	&& sudo apt install gh -y

gh auth login
gh repo list
```

Clone dotfiles repo
```bash
gh clone dotfiles
```

install packages and fonts
```bash
# ubuntu
.dotfiles/scripts/install-packages.sh
.dotfiles/scripts/install-fonts.sh
````

install starship
```bash
# https://starship.rs/guide/
curl -sS https://starship.rs/install.sh | sh
```
install taskfile
```
sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d -b /usr/local/bin
```

stow dot files
```bash
cd ~/.dotfiles
stow git
stow bash
```
