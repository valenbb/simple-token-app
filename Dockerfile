FROM python:3.7-alpine

RUN mkdir -p /src
WORKDIR /src

COPY main.py /src
COPY requirements.txt /src

RUN pip install -r requirements.txt

ENTRYPOINT [ "python" ]

CMD [ "main.py" ]