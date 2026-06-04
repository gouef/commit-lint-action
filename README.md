<img align=right width="168" src="docs/gouef_logo.png">

# Commit lint action
Github commit lint action

[![GitHub stars](https://img.shields.io/github/stars/gouef/commit-lint-action?style=social)](https://github.com/gouef/commit-lint-action/stargazers)
![Usages](https://img.shields.io/endpoint?url=https://github-repo-usages.vercel.app/api/getAction.go?repository=gouef/commit-lint-action)

## Versions
![Stable Version](https://img.shields.io/github/v/release/gouef/commit-lint-action?label=Stable&labelColor=green)
![GitHub Release](https://img.shields.io/github/v/release/gouef/commit-lint-action?label=RC&include_prereleases&filter=*rc*&logoSize=diago)
![GitHub Release](https://img.shields.io/github/v/release/gouef/commit-lint-action?label=Beta&include_prereleases&filter=*beta*&logoSize=diago)

## Introduction

This is template repository for new libraries

## Example

```yaml
name: Commit Lint

on:
  workflow_call:
    inputs:
      branch:
        required: false
        type: string
        default: "main"
      prefixes:
        required: true
        default: "Add|Fix|Update|Remove|Refactor|Docs|Test|Improve|Merge|Bump"
        description: "List of all allowed prefix [TYPE] where type can be Add, Fix, use Add|Fix|Update ..."
      minLengthText:
        required: true
        default: 8
        description: "Minimal length after [TYPE] for commit message"
  pull_request:
    types: [opened, synchronize, edited]
  push:
    branches:
      - master
      - main
      - develop
      - feature/**
      - release/**
      - test/**
      - bugfix/**

jobs:
  lint-commits:
    runs-on: ubuntu-latest
    steps:
      - name: Commit lint
        uses: gouef/commit-lint-action@main
```


## Commit rules
Commit message should looks like
```
[TYPE] some message
```


## Pre-commit

### Requirements:
- pre-commit

```sh
  pre-commit install --hook-type commit-msg
```

`.pre-commit-config`
```yaml
repos:
  - repo: https://github.com/gouef/commit-lint-action
    rev: v1.1.1
    hooks:
      - id: check-commit-msg
        args: [
          "-p", "Add|Fix|Update|Remove|Refactor|Docs|Test|Improve|Merge|Bump", # List of all allowed prefix [TYPE] where type can be Add, Fix, use Add|Fix|Update ...
          "-l", "6" # Minimal length after [TYPE] for commit message
        ]
```

## Contributors

<div>
<span>
  <a href="https://github.com/JanGalek"><img src="https://raw.githubusercontent.com/gouef/commit-lint-action/refs/heads/contributors-svg/.github/contributors/JanGalek.svg" alt="JanGalek" /></a>
</span>
<span>
  <a href="https://github.com/actions-user"><img src="https://raw.githubusercontent.com/gouef/commit-lint-action/refs/heads/contributors-svg/.github/contributors/actions-user.svg" alt="actions-user" /></a>
</span>
</div>

