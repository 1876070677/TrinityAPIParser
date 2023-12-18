FROM python:3.8.6

WORKDIR /app/

COPY ./main.py /app/
COPY ./requirements.txt /app/

RUN pip install --upgrade pip
ENV PIP_ROOT_USER_ACTION=ignore
RUN pip install -r requirements.txt

CMD uvicorn --host=0.0.0.0 --port 5555 main:app