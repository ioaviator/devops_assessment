from datetime import datetime, timezone
from pydantic import BaseModel


class TicketCreate(BaseModel):

    customer_id: str

    subject: str

    description: str

    priority: str = "medium"



class TicketUpdate(BaseModel):

    subject: str | None = None

    description: str | None = None

    priority: str | None = None

    status: str | None = None



class Ticket(BaseModel):

    id: str

    customer_id: str

    subject: str

    description: str

    priority: str = "medium"

    status: str = "open"

    created_at: datetime = datetime.now(
        timezone.utc
    )

    updated_at: datetime = datetime.now(
        timezone.utc
    )