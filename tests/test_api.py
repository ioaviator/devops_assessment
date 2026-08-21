from fastapi.testclient import TestClient

from app.main import app, tickets


client = TestClient(app)


def setup_function():
    tickets.clear()


def test_ticket_crud():

    # CREATE
    created = client.post(
        "/api/v1/tickets",
        json={
            "customer_id": "customer-123",
            "subject": "Payment failed",
            "description": "Card was rejected",
            "priority": "high",
        },
    )

    assert created.status_code == 200

    ticket_id = created.json()["ticket_id"]


    # READ
    response = client.get(
        f"/api/v1/tickets/{ticket_id}"
    )

    assert response.status_code == 200


    # UPDATE
    updated = client.patch(
        f"/api/v1/tickets/{ticket_id}",
        json={
            "status": "resolved"
        },
    )

    assert updated.status_code == 200
    assert updated.json()["status"] == "resolved"


    # DELETE
    deleted = client.delete(
        f"/api/v1/tickets/{ticket_id}"
    )

    assert deleted.status_code == 200


    # Confirm deleted
    missing = client.get(
        f"/api/v1/tickets/{ticket_id}"
    )

    assert missing.status_code == 404



def test_liveness():

    response = client.get("/health/live")

    assert response.json() == {
        "status": "ok"
    }