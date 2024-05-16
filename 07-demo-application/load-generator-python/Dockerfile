FROM python:3.12-slim AS generate-requirements
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*
RUN curl -sSL https://install.python-poetry.org | python3 -
COPY pyproject.toml poetry.lock ./
RUN /root/.local/bin/poetry export --output requirements.txt

###

FROM python:3.12-slim AS production
COPY --from=generate-requirements /requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . . 
CMD ["python", "main.py"]