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

**NOTE: use PIPX to install global python tools**

NOT SURE ABOUT THIS...

py cli tools can be installed via apt or pipx...

```
sudo apt install python3-pytest
# or
pipx install poetry
```
or 

install taskfile
- *this can be doe with pipx*

```
sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d -b /usr/local/bin
```
install helm
```bash
curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
sudo apt-get install apt-transport-https --yes
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt-get update
sudo apt-get install helm
```

stow dot files
```bash
cd ~/.dotfiles
stow git
stow bash
```
