FROM python:3.7-alpine

COPY main.py /src
COPY requirements.txt /src

WORKDIR /src

RUN pip install -r requirements.txt

ENTRYPOINT [ "python" ]

CMD [ "main.py" ]