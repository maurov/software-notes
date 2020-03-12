# JupyterHub installation and configuration

- Target sofwater: [JupyterHub](https://jupyterhub.readthedocs.io/)
- Last tested: 2020-03-12
- Working on:
  - Debian 8

## Description

Here are collected some notes for running a JupyterHub server in order to share some notebooks and perform quick data analysis with colleagues.

## Installation

- Use the Conda environment [sloth](https://github.com/maurov/xraysloth/blob/master/environment.yml) created in `~/local/conda`.
- Add alias (usually in `~/.bash_aliases`) for activating the environment:

    ```bash
    alias sloth='unset PYTHONPATH; source /users/opd16/local/conda/bin/activate sloth'
    ```

## Configuration

- If not using HTTPS, one needs to install the HTTP proxy

    ```bash
    (sloth)> npm install -g configurable-http-proxy

- Create initial default configuration `jupyterhub_config.py`

    ```bash
    (sloth)> jupyterhub --generate-config
    ```

- Use JupyterLab interface by default

    ```python
    c.Spawner.default_url = '/lab'
    ```

- No user has admin rights

    ```python
    c.Authenticator.admin_users = set()
    ```

## Running

- Create a dedicated running directory and start jupyterhub via `tmux`:

    ```bash
    cd
    mkdir .jupyterhub
    cd .jupyterhub
    tmux
    sloth
    jupyterhub
    ```

- *Note*: to attach to a running session, `tmux attach`
