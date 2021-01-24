"""Initial migration

Revision ID: 3e26347cb4e1
Revises:
Create Date: 2021-01-23 22:23:46.597838

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = "3e26347cb4e1"
down_revision = None
branch_labels = None
depends_on = None


def upgrade():
    op.create_table(
        "name",
        sa.Column("name", sa.String(length=50), nullable=False),
        sa.PrimaryKeyConstraint("name", name=op.f("pk_name")),
    )


def downgrade():
    op.drop_table("name")
