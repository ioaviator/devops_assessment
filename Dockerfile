FROM python:3.12-slim-trixie AS builder

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /build

RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt


# multi-stage build
FROM python:3.12-slim-trixie AS runner

WORKDIR /app

RUN addgroup --system --gid 10001 devops && \
  adduser --system --uid 10001 --ingroup devops devops

COPY --from=builder --chown=devops:devops /opt/venv /opt/venv
COPY --chown=devops:devops ./app ./app

ENV PATH="/opt/venv/bin:$PATH"

USER devops

EXPOSE 8000

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:8000/health/live')"

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
