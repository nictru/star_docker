#!/bin/bash
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

cd "$parent_path"
docker build -t star_$(whoami) --build-arg USER_ID=$(id -u) --build-arg GROUP_ID=$(id -g) .
