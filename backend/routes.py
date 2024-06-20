import json
from flask import request, jsonify, current_app
from werkzeug.utils import secure_filename
import os
from . import db
from .models import Image
from.utils import generate_image_hash


@current_app.route('/upload', methods=['POST'])
def upload_image():
    if 'file' not in request.files:
        return jsonify({"error": "No file part"}), 400
    file = request.files['file']
    if file.filename == '':
        return jsonify({"error": "No selected file"}), 400
    if file:
        filename = secure_filename(file.filename)
        temp_path = os.path.join(current_app.config['UPLOAD_FOLDER'], 'temp',filename)
        file.save(temp_path)
        # Generate hash for image and pull duplicate image if available
        image_hash = generate_image_hash(temp_path)
        existing_image = Image.query.filter_by(image_hash=image_hash).first()
        if existing_image:
            os.remove(temp_path)
            return jsonify({"message": "Duplicate image", "file_path": existing_image.original_image}), 200
        else:
          final_path = os.path.join(current_app.config['UPLOAD_FOLDER'], filename)
          os.rename(temp_path, final_path)
          new_image = Image(original_image=final_path, image_hash=image_hash)
          db.session.add(new_image)
          db.session.commit()
          return jsonify({"message": "File uploaded successfully", "file_path": final_path}), 200


