#!/bin/bash

function build::docs() {
    local docs_dir="docs"
    local build_dir="build/docs"
    concat::md > "${build_dir}/README.md"
}

function load::config() {
    local config_file="${1:-./README.toml}"
    local config=$(toml decode -f "$config_file")
    local files=($(echo "${config}" | jq -r '.files[]'))
    echo "${files[@]}"
}

function concat::md() {
    local files=($(load::config))
    local content=""
    for file in "${files[@]}"; do
        content+=$(cat "$file")
    done
    echo "$content"
}

function main() {
    build::docs
}

main