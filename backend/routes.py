from flask import request, jsonify, current_app
from werkzeug.utils import secure_filename
from sqlalchemy import text
import os
from . import db
from .models import Image

@current_app.route('/')
def hello():
    try:
      result = db.session.execute(text("SELECT 1")).fetchall()
      print(result)
      return "Database connection succeeded.", 200
    except Exception as e:
        return f"Database connection failed: {str(e)}", 500

@current_app.route('/upload', methods=['POST'])
def upload_image():
    if 'file' not in request.files:
        return jsonify({"error": "No file part"}), 400
    file = request.files['file']
    if file.filename == '':
        return jsonify({"error": "No selected file"}), 400
    if file:
        filename = secure_filename(file.filename)
        file_path = os.path.join(current_app.config['UPLOAD_FOLDER'], filename)
        file.save(file_path)
        new_image = Image(original_image=file_path)
        db.session.add(new_image)
        db.session.commit()
        return jsonify({"message": "File uploaded successfully", "file_path": file_path}), 200
