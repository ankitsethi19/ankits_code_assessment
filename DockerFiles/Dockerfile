FROM python:3.8-slim-buster

RUN pip install --upgrade pip
RUN pip install --upgrade setuptools
RUN pip install flask

WORKDIR /app
COPY . /app

ENV FLASK_APP=hello

CMD ["python3", "setup.py", "install"]
CMD ["flask", "run", "-h", "0.0.0.0"]