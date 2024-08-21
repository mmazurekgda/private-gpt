### IMPORTANT, THIS IMAGE CAN ONLY BE RUN IN LINUX DOCKER
### You will run into a segfault in mac
FROM python:3.11.5-slim-bookworm as base

# Install poetry
RUN pip install --no-cache pipx && \
python3 -m pipx ensurepath && \
pipx install poetry==1.8.3
ENV PATH="/root/.local/bin:$PATH"
ENV PATH=".venv/bin/:$PATH"

# Dependencies to build llama-cpp
RUN apt update && apt install -y --no-install-recommends \
libopenblas-dev \
ninja-build \
build-essential \
pkg-config \
wget && apt clean -y && \
rm -rf /var/lib/apt/lists/*

ENV POETRY_VIRTUALENVS_IN_PROJECT=true

# FROM base as dependencies
WORKDIR /private_gpt
COPY pyproject.toml poetry.lock ./

ARG POETRY_EXTRAS="ui llms-ollama embeddings-ollama vector-stores-qdrant"
# embeddings-huggingface llms-llama-cpp vector-stores-qdrant"
RUN poetry install --no-root --no-cache --extras "${POETRY_EXTRAS}"
# IMPORTANT: RUN LATER the following dependency
# docker pip install --no-cache-dir llama-index-embeddings-huggingface==0.2.3

COPY private_gpt ./private_gpt/
RUN rm -rf /root/.cache
