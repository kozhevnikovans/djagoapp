FROM python:3.10.4

ENV VIRTUAL_ENV=/opt/venv
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

COPY requirements.txt .
RUN pip install -r requirements.txt

ARG debug
ENV DEBUG ${debug:-TRUE}
ARG port
ENV PORT=${port:-8080}


ENV PYTHONUNBUFFERED 1
ENV DEBIAN_FRONTEND=noninteractive 

WORKDIR /app
COPY . .

EXPOSE 8080
CMD gunicorn hello_world.wsgi:application --bind 0.0.0.0:$PORT