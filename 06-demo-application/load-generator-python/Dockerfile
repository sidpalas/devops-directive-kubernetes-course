# FROM python:3.12-slim AS generate-requirements
# RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*
# RUN curl -sSL https://install.python-poetry.org | python3 -
# COPY pyproject.toml poetry.lock ./
# RUN /root/.local/bin/poetry export --output requirements.txt

###

FROM python:3.12-slim
COPY . .
RUN pip install --no-cache-dir .
CMD ["python", "-m", "load_generator_python.main"]