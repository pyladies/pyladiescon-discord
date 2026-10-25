FROM python:3.14-slim

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1

WORKDIR /app

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY PyLadiesBot ./PyLadiesBot
COPY livestreams.toml ./

# Cabotage's release image layers its own entrypoint over this one and runs
# the Procfile command as `nobody`, with only /tmp writable; every runtime
# state path in config.toml therefore points at /tmp. USER and CMD here only
# matter for running the image locally, where they mirror that environment.
USER nobody
CMD ["python", "PyLadiesBot/bot.py"]
