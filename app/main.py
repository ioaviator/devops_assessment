from datetime import datetime, timezone
from uuid import uuid4

from fastapi import FastAPI, HTTPException, Query

from app.models import Ticket, TicketCreate, TicketUpdate


app = FastAPI(
    title="Ticket API",
    description="Simple Ticket API",
    version="1.0"
)


# dummy in-memory database
tickets = {}


@app.get("/")
def home():
    return {
        "service": "ticket-api",
        "docs": "/docs"
    }


# create ticket
@app.post("/api/v1/tickets")
def create_ticket(ticket: TicketCreate):

    new_ticket = Ticket(
        ticket_id=str(uuid4()),
        **ticket.model_dump()
    )

    tickets[new_ticket.ticket_id] = new_ticket

    return new_ticket


# read all tickets
@app.get("/api/v1/tickets")
def get_tickets(
    offset:int=0,
    limit:int=20
):

    all_tickets = list(tickets.values())

    return all_tickets[offset:offset + limit]


# read one ticket
@app.get("/api/v1/tickets/{ticket_id}")
def get_ticket(ticket_id):

    ticket = tickets.get(ticket_id)

    if not ticket:
        raise HTTPException(
            status_code=404,
            detail="Ticket not found"
        )

    return ticket


# update a ticket
@app.patch("/api/v1/tickets/{ticket_id}")
def update_ticket(
    ticket_id,
    update: TicketUpdate
):

    ticket = tickets.get(ticket_id)

    if not ticket:
        raise HTTPException(
            status_code=404,
            detail="Ticket not found"
        )


    changes = update.model_dump(
        exclude_none=True
    )


    for key, value in changes.items():
        setattr(ticket, key, value)


    ticket.updated_at = datetime.now(
        timezone.utc
    )

    return ticket



# delete a ticket
@app.delete("/api/v1/tickets/{ticket_id}")
def delete_ticket(ticket_id):

    if ticket_id not in tickets:
        raise HTTPException(
            status_code=404,
            detail="Ticket not found"
        )


    del tickets[ticket_id]

    return {
        "message": "Ticket deleted"
    }



@app.get("/health/live")
def health():

    return {
        "status": "ok"
    }