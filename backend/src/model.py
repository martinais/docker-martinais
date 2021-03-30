from peewee import *

db = PostgresqlDatabase(
    'gallery', user='postgres', password='postgres', host='database'
)


class User(Model):
    name = CharField(unique=True)

    class Meta:
        database = db


def migrate_database():
    db.create_tables([User])


def connect():
    if not db.connect():
        exit("ERROR: unable to connect to database")


def disconnect():
    db.close()
