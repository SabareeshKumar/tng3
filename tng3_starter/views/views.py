import colander

from pyramid.view import view_config
from pyramid.response import Response
from cornice import Service
from cornice.validators import colander_body_validator
from pyramid.renderers import render_to_response
from ..models import User

import json

class UserSchema(colander.MappingSchema):
    name = colander.SchemaNode(colander.String())
    age = colander.SchemaNode(colander.Int(),
                              validator=colander.Range(0, 200))
    email_id = colander.SchemaNode(colander.String(), validator=colander.Email())

user_collection = Service(name='user_collection', path='/users', description="User registration")
user = Service(name='user', path='/users/{id}', description="User registration")

@user_collection.get()
def get_users(request):
    """Returns a list of all users."""
    user_list = request.dbsession.query(User).filter().all()
    return {'data': user_list}

@user_collection.post()
def create_user(request):
    """Adds a new user."""
    user_data = request.json_body
    schema = UserSchema()
    try:
        schema.deserialize(user_data)
        user = User(user_data)
        request.dbsession.add(user)
    except colander.Invalid as e:
        return {'message': e.asdict()}

@user.delete()
def delete_user(request):
    id = request.matchdict['id'] 
    query = request.dbsession.query(User)
    query.filter(User.id == id).delete()
    user_list = query.filter().all()
    return {'data': user_list}

@user.get()
def get_user(request):
    id = request.matchdict['id']
    query = request.dbsession.query(User)
    user = query.filter(User.id == id).first()
    return {'data': user}

@user.put()
def update_user(request):
    user_data = request.json_body
    schema = UserSchema()
    try:
        schema.deserialize(user_data)
        id = request.matchdict['id'] 
        query = request.dbsession.query(User)
        user = query.filter(User.id == id).first()
        user.name = user_data['name']
        user.age = user_data['age']
        user.email_id = user_data['email_id']
    except colander.Invalid as e:
        return {'message': e.asdict()}

@view_config(route_name='home', renderer='../../client/output/web/index.html')
def home(request):
    return {}
