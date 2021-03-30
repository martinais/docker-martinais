FROM python:3 AS base

WORKDIR /usr/src/app
COPY requirements.txt ./
RUN pip install -r requirements.txt
COPY ./src .

FROM base AS dev

ENV FLASK_ENV development
ENV FLASK_APP martinade
CMD [ "flask", "run", "--host=0.0.0.0" ]

FROM base AS prod

RUN pip install gunicorn
CMD [ "gunicorn", "--bind", "0.0.0.0:80", "martinade:app" ]
