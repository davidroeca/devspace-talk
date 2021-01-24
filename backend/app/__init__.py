import os
from flask import Flask, Blueprint, request, jsonify
from .extensions import db, migrate
from .models import Name

api = Blueprint("api", __name__)

DEFAULT_CONFIG = {
    "SQLALCHEMY_DATABASE_URI": os.environ["DATABASE_URL"],
    "SQLALCHEMY_TRACK_MODIFICATIONS": False,
}


@api.route("/name/<name>", methods=["POST"])
def create_name(name):
    try:
        record = Name(name=name)
        db.session.add(record)
        db.session.commit()
    except:
        db.session.rollback()
        raise
    return jsonify({"data": {"success": True}})


@api.route("/names")
def get_names():
    return jsonify(
        {
            "data": {
                "names": [
                    {
                        "name": record.name,
                        # "created": record.created,
                        # "updated": record.updated,
                    }
                    for record in db.session.query(Name)
                ]
            }
        }
    )


def create_app():
    app = Flask(__name__)
    app.config.update(DEFAULT_CONFIG)
    app.register_blueprint(api, url_prefix="/api")
    db.init_app(app)
    migrate.init_app(app, db)
    return app
