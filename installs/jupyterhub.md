# JupyterHub installation and configuration

- Target sofwater: [JupyterHub](https://jupyterhub.readthedocs.io/)
- Tested: 2019-09-13
- Working on:
    - Debian 8

## Description

Here are collected some notes for running a JupyterHub server in order to share some notebooks and perform quick data analysis with colleagues.

## Installation & running

- Starting from the Conda environment [sloth-lab](https://github.com/maurov/xraysloth/blob/master/environment-lab.yml) created in `~/local/conda`.
- Install `jupyterhub`

    ```bash
    pip install jupyterhub
    ```
- Create a dedicated running directory and start jupyterhub via `tmux`:

    ```bash
    cd
    mkdir .jupyterhub
    cd .jupyterhub
    tmux
    source ~/local/
    jupyterhub
    ```
- *Note*: to attach to a running session, `tmux attach`

## Configuration

- Create initial default configuration `jupyterhub_config.py`

    ```bash
    (sloth-lab)> jupyterhub --generate-config
    ```

- Use JupyterLab interface by default

    ```python
    c.Spawner.default_url = '/lab'
    ```
