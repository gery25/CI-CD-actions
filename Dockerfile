FROM python:3.11-slim

WORKDIR /web_django

COPY ./requirements.txt /web_django/

RUN pip install -r requirements.txt

COPY . .

EXPOSE 8000


CMD ["python", "web_django/manage.py", "runserver", "0.0.0.0:8000"]