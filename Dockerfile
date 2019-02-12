FROM python:3.7-alpine

WORKDIR /app

ADD . /app

RUN sudo apt update && \
    sudo apt install git -qq -y && \
    pip install --upgrade pip && \
    pip install -r requirements.txt

EXPOSE 5000

CMD ["python", "main.py"]