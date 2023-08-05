#!/bin/bash
cat ~/.config/homepage/data.yaml | yq -j | base64 -w0
