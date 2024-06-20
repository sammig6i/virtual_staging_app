from . import db

class Image(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    original_image = db.Column(db.String(128), nullable=False)
    staged_image = db.Column(db.String(128), nullable=True)
    image_hash = db.Column(db.CHAR(64), unique=True, nullable=False)
