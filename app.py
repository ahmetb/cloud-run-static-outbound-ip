import requests
import sys
from flask import Flask

app = Flask(__name__)

@app.route("/")
def hello():
    r = requests.get('https://ifconfig.me/ip')
    return 'You connected from IP address: ' + r.text

@app.route("/exit")
def exit():
    """You can use this to trigger IP change on Cloud Run."""
    sys.exit(1)

