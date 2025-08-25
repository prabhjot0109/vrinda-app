# APi for interfacing with the mobile app
import requests
import os
from urllib.parse import urlparse
from werkzeug.utils import secure_filename

from ultralytics import YOLO
import cv2
from supabase import create_client, Client
from supabase.client import ClientOptions

from glob import glob
from flask import Flask, request, jsonify

app = Flask(__name__)

# Load the YOLO model
def process_img(img_path):
    model = YOLO('Model\\YOLO_V5.pt')
    result = model.predict(img_path,
                 conf=0.3,
                 save=True,
                 show=False,
                 show_conf=False,
                 project='Vrinda_API')
    
    
    # Plotting the results to i/p img
    res = result[0]
    class_ids = res.boxes.cls.tolist()
    class_names = [model.names[int(cid)] for cid in class_ids]
        
    annotated = res.plot()

    cv2.imwrite("result.jpg", annotated)
    
    return class_names

@app.route('/')
def home():
    return '<h1>Vrinda Image API</h1>'

# Downloads the image from the link and saves it locally
# and then processes the image using the YOLO model
# Then uploads the result to supabase and returns the link to the result image
# and the prediction result
@app.route('/predictImg', methods=['GET','POST'])
def predict_img():
    '''Downloads the image from the link and saves it locally 
        and then processes the image using the YOLO model
        Then uploads the result to supabase and 
        returns the link to the result image and 
        the prediction result'''
        
    data = request.get_json()
    
    
    if not data or 'link' not in data:
        return jsonify({'error': 'No link provided'}), 400
    
    link = data['link']
    print(link)
    
    try:
        # Get the img content
        response = requests.get(link, stream=True)
        response.raise_for_status()
        
        os.makedirs('downloads', exist_ok=True)
        
        # Extract the img filename from the link
        parsed_url = urlparse(link)
        filename = os.path.basename(parsed_url.path)
        filename = f"downloads\{secure_filename(filename)}"
        
        if filename not in glob('downloads\*'):           
            # Save the img locally
            with open(filename, 'wb') as f:
                for chunk in response.iter_content(chunk_size=8192):
                    f.write(chunk)
            
            print(f"{filename} saved")
        
        else:
            print(f"{filename} already exists")
        
        # Process the img
        prediction = process_img(filename)  
        
        
        try:        
            url: str = "https://jkkoibvrkmvyibvqrixl.supabase.co"

            key: str = " "
            supabase: Client = create_client(
                url, 
                key,
                options=ClientOptions(
                    postgrest_client_timeout=10,
                    storage_client_timeout=10,
                    schema="public",
                )
            )

            print("Connected to supabase")
        except Exception as e:
            return jsonify({'error': 'Error connecting to supabase'}), 500
        
        #Upload File
        try:
            filename = filename.split("\\")[-1]
            print(f"result\\{filename}")
            with open("result.jpg", "rb") as f:
                        response = (
                            supabase.storage\
                            .from_("images")\
                            .upload(
                                file=f,
                                path=f"result/{filename}"
                            )
                        )
            print("File uploaded successfully")
        
        except Exception as e:
            return jsonify({'error': 'Error uploading file'}), 500
        
        os.remove("result.jpg")
        
        # genrates public url for the uploaded file
        public_url = (
        supabase.storage
            .from_("images")
            .get_public_url(f"result/{filename}")
        )

        print(f"Prediction: {prediction}")
        print(f"Public URL: {public_url}")
        
        return jsonify({'prediction':prediction,'img_link':public_url}), 200
    
    except Exception as e:
        return jsonify({'error': str(e)}), 500
    


if __name__ == '__main__':    
    app.run(host='127.0.0.1', port=5000)
    