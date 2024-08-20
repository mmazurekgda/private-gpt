### IMPORTANT, THIS IMAGE CAN ONLY BE RUN IN LINUX DOCKER
### You will run into a segfault in mac
FROM python:3.11.5-slim-bookworm as base

# Install poetry
RUN pip install pipx
RUN python3 -m pipx ensurepath
RUN pipx install poetry==1.8.3
ENV PATH="/root/.local/bin:$PATH"
ENV PATH=".venv/bin/:$PATH"

# Dependencies to build llama-cpp
RUN apt update && apt clean -y
RUN apt install -y \
    libopenblas-dev\
    ninja-build\
    build-essential\
    pkg-config\
    wget

ENV POETRY_VIRTUALENVS_IN_PROJECT=true

# FROM base as dependencies
WORKDIR /private_gpt
COPY pyproject.toml poetry.lock ./

ARG POETRY_EXTRAS="ui embeddings-huggingface llms-llama-cpp vector-stores-qdrant"
RUN poetry install --extras "${POETRY_EXTRAS}"

COPY private_gpt ./

