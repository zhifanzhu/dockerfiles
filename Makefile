github_base="https://github.com"
# github_base="https://github.com.cnpmjs.org"

vim:
	test -d temp/$@ || git clone --depth 1 --branch v8.2.3455 ${github_base}/vim/vim.git temp/$@
vim-plug:
	test -f temp/plug.vim || wget https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim -O temp/plug.vim
vim_runtime:
	test -d temp/$@ || git clone --depth 1 ${github_base}//ktw361/vim_runtime.git temp/$@

dotfiles:
	test -d temp/$@ || git clone ${github_base}/ktw361/dotfiles.git temp/$@

oh-my-zsh:
	test -d temp/ohmyzsh-master || unzip tar/ohmyzsh-master.zip -d temp/  # ohmyzsh-master

zsh-z:
	test -d temp/$@ || git clone ${github_base}/agkozak/zsh-z temp/$@
zsh-autosuggestions:
	test -d temp/$@ || git clone ${github_base}/zsh-users/zsh-autosuggestions temp/$@
zsh-syntax-highlighting:
	test -d temp/$@ || git clone ${github_base}/zsh-users/zsh-syntax-highlighting.git temp/$@

prerequisites=\
	vim\
	vim-plug\
	vim_runtime\
	dotfiles\
	oh-my-zsh\
	zsh-z\
	zsh-autosuggestions\
	zsh-syntax-highlighting\

prepare: $(prerequisites)
	@echo "Preparation complete"

ubuntu16: prepare
	docker build -f ubuntu16-Dockerfile -t ktw361/ubuntu16 .

ubuntu20: prepare
	docker build -f ubuntu20-Dockerfile -t ktw361/ubuntu20 .
ubuntu20-cu11: prepare
	docker build -f ubuntu20-cu11-Dockerfile -t ktw361/ubuntu20-cu11 .

ubuntu22-cu115: prepare
	docker build -f ubuntu22-cu115-Dockerfile -t ktw361/ubuntu22-cu115 .

torch17: prepare
	docker build -f torch17-Dockerfile -t ktw361/torch17 .

# Miscellaneous
colmap-ubuntu20: prepare
	docker build -f misc/colmap-ubuntu20-Dockerfile -t ktw361/colmap-ubuntu20 .
vins-mono: prepare
	docker build -f misc/VINS-Mono-Dockerfile -t ktw361/vins-mono .


.PHONY: clean
clean:
	rm -rf temp/
