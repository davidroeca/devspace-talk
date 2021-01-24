from sqlalchemy.sql import func
from .extensions import db


class Name(db.Model):
    """Basic name table"""

    __tablename__ = "name"
    name = db.Column(db.String(50), nullable=False, primary_key=True)
    # created = db.Column(db.DateTime(), nullable=True, server_default=func.now())
    # updated = db.Column(
        # db.DateTime(), nullable=True, server_default=func.now(), onupdate=func.now()
    # )
