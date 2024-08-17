FROM python:3.10

# ユーザーの作成
RUN useradd -ms /bin/bash user

# インストール
RUN usermod -aG sudo user && \
    apt update && \
    apt install -y sudo vim && \
    pip install --upgrade pip && \
    curl -sSL https://install.python-poetry.org | python -

# Poetryのパスの設定
ENV PATH /root/.local/bin:$PATH

# Poetryが仮想環境を生成しないようにする
RUN poetry config virtualenvs.create false

# JepxVisualization dirの作成
RUN mkdir /home/user/JepxVisualization
WORKDIR /home/user/JepxVisualization

# poetryのinstall
COPY poetry.lock ./poetry.lock
COPY pyproject.toml ./pyproject.toml
RUN poetry install
