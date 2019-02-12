FROM python:3.7-alpine

WORKDIR /app

ADD . /app

RUN pip install --upgrade pip && \
    pip install -r requirements.txt

EXPOSE 5000

CMD ["python", "main.py"]