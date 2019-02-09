from flask import Flask
import os

def check_ping(token):
    if token == "Cyberark1":
        hostname = os.uname()[1]
        response = os.system("ping -c 1 " + hostname)
        # and then check the response...
        if response == 0:
            pingstatus = "Network Active"
        else:
            pingstatus = "Network Error"
    else:
        pingstatus = "Unauthorized Request"
    return pingstatus


app = Flask(__name__)

@app.route('/')
def home():
    pingstatus = check_ping(os.getenv('PING_TOKEN'))
    return pingstatus


if __name__ == "__main__":
    app.run()