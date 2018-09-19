from cornice import Service
from pyramid.renderers import render_to_response
from pyramid.response import Response
from cornice.validators import colander_body_validator, colander_path_validator
from pyramid.view import view_config

from ..models import User

import colander
import json
import logging

class UserSchema(colander.MappingSchema):
    name = colander.SchemaNode(colander.String())
    age = colander.SchemaNode(colander.Int(),
                              validator=colander.Range(0, 200))
    email_id = colander.SchemaNode(colander.String(),
                                   validator=colander.Email())

user_collection = Service(
    name='user_collection',
    path='/api/users',
    description="User registration"
)
user = Service(
    name='user',
    path='/api/users/{id}',
    description="User registration"
)

class IdSchema(colander.MappingSchema):
    id = colander.SchemaNode(colander.Int())

@user_collection.get()
def get_users(request):
    """Returns a list of all users."""
    user_list = request.dbsession.query(User).filter().all()
    return {'data': user_list}

@user_collection.post(schema=UserSchema(), validators=(colander_body_validator,))
def create_user(request):
    """Adds a new user."""
    user = User(request.validated)
    request.dbsession.add(user)
    return {'data': user}

@user.delete()
def delete_user(request):
    id = request.matchdict['id']
    query = request.dbsession.query(User)
    user = query.filter(User.id == id)
    if user is None:
        request.errors.add("header", "id", "User does not exist!")
    else:
        user.delete()
    return None

@user.get(schema = IdSchema(), validators=(colander_path_validator,))
def get_user(request):
    id = request.validated['id']
    query = request.dbsession.query(User)
    user = query.filter(User.id == id).first()
    if user is None:
        request.errors.add("header", "id", "User does not exist!")
        return None
    return {'data': user}

@user.put(schema=UserSchema(), validators=(colander_body_validator,))
def update_user(request):
    id = request.matchdict['id']
    query = request.dbsession.query(User)
    user = query.filter(User.id == id).first()
    if user is None:
        request.errors.add("header", "id", "User does not exist!")
        return None
    user_data = request.validated
    user.name = user_data['name']
    user.age = user_data['age']
    user.email_id = user_data['email_id']
    return {'data': user}
