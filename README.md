# Ticket API 

This is a FastAPI, ticket CRUD, in-memory db, with tests, and a Docker image.

## Run with Docker

```bash
docker build -t ticket-api:0.1.0 .
docker run --rm --name ticket-api -p 8000:8000 ticket-api:0.1.0
```

Open `http://localhost:8000/docs` for the interactive API documentation.

## Run without Docker

```bash
python -m venv devops_venv
source devops_venv/Scripts/activate or  source devops_venv/bin/activate
pip install -r requirements-dev.txt
uvicorn app.main:app --reload
```

Run tests:

```bash
pytest
```

## Example request

```bash
curl -X POST http://localhost:8000/api/v1/tickets \
  -H 'content-type: application/json' \
  -d '{
    "customer_id": "customer-123",
    "subject": "Payment failed",
    "description": "Card was rejected",
    "priority": "high"
  }'
```

Endpoints:

- `POST /api/v1/tickets`
- `GET /api/v1/tickets`
- `GET /api/v1/tickets/{ticket_id}`
- `PATCH /api/v1/tickets/{ticket_id}`
- `DELETE /api/v1/tickets/{ticket_id}`
- `GET /health/live`
