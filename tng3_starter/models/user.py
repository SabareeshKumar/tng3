from sqlalchemy import (
    Column,
    Integer,
    Text,
)
from .meta import Base


class User(Base):
    __tablename__ = 'user'

    id = Column(Integer, primary_key=True)
    name = Column(Text)
    age = Column(Integer)
    email_id = Column(Text)

    def __init__(self, data):
        self.name = data['name']
        self.age = data['age']
        self.email_id = data['email_id']

    def __json__(self, request):
        json_exclude = getattr(self, '__json_exclude__', set())
        return {key: value for key, value in self.__dict__.items()
                if not key.startswith('_')
                and key not in json_exclude}
