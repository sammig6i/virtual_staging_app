import hashlib
from PIL import Image
import numpy as np

def generate_image_hash(image_path):
    image = Image.open(image_path)
    image = image.resize((8, 8), Image.LANCZOS).convert('L')
    pixel_data = np.array(image.getdata())
    avg_pixel = pixel_data.mean()
    hash_str = ''.join('1' if pixel > avg_pixel else '0' for pixel in pixel_data)
    return hashlib.sha256(hash_str.encode()).hexdigest()
