FROM python:2.7-alpine

WORKDIR /app

ADD . /app

RUN apk add --no-cache curl && \
    pip install --upgrade pip && \
    pip install -r requirements.txt && \
    # Due to a bug in Werkzeug==0.15.2 -> Downgrade to Werkzeug==0.14.1
    pip uninstall Werkzeug -y && \
    pip install Werkzeug==0.14.1

EXPOSE 5000

CMD ["python", "main.py"]
