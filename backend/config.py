import os

class Config:
    SQLALCHEMY_DATABASE_URI = os.getenv(
        'DATABASE_URL',
        'postgresql://swghazzawi:ar3CzTJDjWtTkDTn2f8g@virtualstagedb.cpy86iswc5f1.us-west-2.rds.amazonaws.com:5432/postgres'
    )
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    UPLOAD_FOLDER = os.path.join(os.getcwd(), 'uploads')
    os.makedirs(UPLOAD_FOLDER, exist_ok=True)
