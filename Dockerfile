FROM python:3.7-alpine

WORKDIR /app

ADD . /app

RUN apk add --no-cache git && \
    pip install --upgrade pip && \
    pip install -r requirements.txt

EXPOSE 5000

CMD ["python", "main.py"]