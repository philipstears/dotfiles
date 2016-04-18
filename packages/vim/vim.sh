#!/usr/bin/env bash

declare -ra plugins=(
  "https://github.com/rking/ag.vim"
  "https://github.com/kien/ctrlp.vim"
  "https://github.com/editorconfig/editorconfig-vim"
  "https://github.com/othree/html5.vim"
  "https://github.com/goatslacker/mango.vim"
  "https://github.com/scrooloose/nerdtree"
  "https://github.com/scrooloose/syntastic"
  "https://github.com/clausreinke/typescript-tools"
  "https://github.com/leafgarland/typescript-vim"
  "https://github.com/bling/vim-airline"
  "https://github.com/elixir-lang/vim-elixir"
  "https://github.com/vim-erlang/vim-erlang-tags"
  "https://github.com/jimenezrick/vimerl"
  "https://github.com/fsharp/vim-fsharp"
  "https://github.com/tpope/vim-fugitive"
  "https://github.com/digitaltoad/vim-jade"
  "https://github.com/pangloss/vim-javascript"
  "https://github.com/mxw/vim-jsx.git"
  "https://github.com/groenewege/vim-less"
  "https://github.com/ahayman/vim-nodejs-complete"
  "https://github.com/jgdavey/vim-railscasts"
  "https://github.com/wavded/vim-stylus"
  "https://github.com/tpope/vim-surround"
  "https://github.com/cespare/vim-toml"
)

main() {
  install_plugins
}

install_plugins() {
  local -r vim_dir="$HOME/.vim"
  local -r bundle_dir="$vim_dir/bundle"

  mkdir -p "$bundle_dir"

  install_pathogen "$vim_dir"

  # TODO: Detect neovim? or just put both files in?
  install_vimrc "$HOME/.vimrc"

  for plugin in "${plugins[@]}"; do
    install_plugin "$bundle_dir" "$plugin"
  done
}

install_pathogen() {
  local -r vim_dir="$1"
  local -r pathogen_dir="$vim_dir/autoload"
  local -r pathogen_path="$pathogen_dir/pathogen.vim"

  if [[ ! -f $pathogen_path ]]; then
    echo "Installing pathogen"
    mkdir -p "$pathogen_dir"
    curl -LSso "$pathogen_path" https://tpo.pe/pathogen.vim
  else
    echo "Pathogen already exists, skipping installation"
  fi
}

install_vimrc() {
  local -r vimrc_path="$1"

  if [[ ! -f $vimrc_path ]]; then
    echo "Installing vimrc"
    curl -LSso "$vimrc_path" https://raw.githubusercontent.com/philipstears/dotfiles/master/.vimrc
  else
    echo "vimrc already exists, skipping installation"
  fi
}

install_plugin() {
  local -r bundle_dir="$1"
  local -r plugin_repo="$2"
  local -r directory_name="$(basename --suffix=".git" "$plugin_repo")"
  local -r plugin_path="$bundle_dir/$directory_name"

  echo "Installing $plugin_repo to $plugin_path"

  if [[ -d "$plugin_path" ]]; then
    update_plugin "$plugin_repo" "$plugin_path"
  else
    clone_plugin "$plugin_repo" "$plugin_path"
  fi
}

update_plugin() {
  local -r plugin_repo="$1"
  local -r plugin_path="$2"

  pushd "$plugin_path"
  # TODO: rev_parse or something to check if we're detached?
  git pull
  popd
}

clone_plugin() {
  local -r plugin_repo="$1"
  local -r plugin_path="$2"

  git clone "$plugin_repo" "$plugin_path"
}

main
