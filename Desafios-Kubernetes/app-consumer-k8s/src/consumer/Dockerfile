FROM python:3.10.8-alpine
WORKDIR /app
RUN pip install requests
RUN export LOCAL=true
COPY ./ /app/
CMD ["python","consumer.py"]
