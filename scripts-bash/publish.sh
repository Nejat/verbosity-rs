#!/bin/bash

IFS='/' read -ra script_parts <<< "$0"

NC='\033[0m'
RED='\033[0;31m'
YELLOW='\033[1;33m'

if [[ "$0" == "./${script_parts[-1]}" ]]
then
  echo -e "\n${YELLOW}Scripts need to be run from the project root${NC}, i.e. ./scripts-ps/${script_parts[-1]}\n"
  exit 1
fi

function confirm-success() {
    exit_code=$?
    if [ $exit_code -ne 0 ]
    then
        echo -e "\n$1 ${RED}failed${NC} with exitcode ${exit_code}\n"
        exit $exit_code
    fi
}

clear

for_reals="false"
skip_clean="false"

while test $# -gt 0; do
  case "$1" in
    --for_reals) for_reals="true" && shift ;;
    --skip_clean) skip_clean="true" && shift ;;
    *) shift ;;
  esac
done

if [[ "${for_reals}" == "true" ]] && [[ "${skip_clean}" == "true" ]]
then
    echo -e "${YELLOW}Can not skip clean step when actually publishing${NC}\n"

    skip_clean="false"
fi

if [[ "${skip_clean}" == "true" ]]
then
    cargo clean
    confirm-success "clean"
fi

cargo clippy --all-features
confirm-success "clippy"

cargo clippy --release --all-features
confirm-success "clippy release"

cargo test --all-features -- --nocapture --test-threads=1
confirm-success "test"

cargo test --all-features --release -- --nocapture --test-threads=1
confirm-success "test release"

cargo publish --locked --all-features --dry-run
confirm-success "publish dry run"

if [[ "${for_reals}" == "true" ]]
then
  cargo publish --locked --all-features
  confirm-success "publish"
fi