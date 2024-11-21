FROM python:3.12-slim
COPY . .
RUN pip install --no-cache-dir .
CMD ["python", "-m", "load_generator_python.main"]