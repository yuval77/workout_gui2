# Imports
import json
import werkzeug
from flask import Flask, request, jsonify

app = Flask(__name__)
@app.route("/upload", methods=["POST"])

def index():
    imagefile = request.files["image"]
    filename = werkzeug.utils.secure_filename(imagefile.filename)
    print("\nReceived image File name : " + imagefile.filename)
    imagefile.save("uploadimages/" + filename)


    

    if (len(filename) > 5): faces = "big"
    else: faces = "small"




    return json.dumps({"faces": faces})

if __name__ =="__main__":
    app.run(debug = True, port= 4000)
