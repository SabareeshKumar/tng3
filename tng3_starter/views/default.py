import colander

from pyramid.view import view_config
from pyramid.response import Response
from cornice import Service
from cornice.validators import colander_body_validator

class UserSchema(colander.MappingSchema):
    name = colander.SchemaNode(colander.String())
    age = colander.SchemaNode(colander.Int(),
                              validator=colander.Range(0, 200))
    mail_id = colander.SchemaNode(colander.String(), validator=colander.Email())

_USERS = {}

users = Service(name='users', path='/users', description="User registration")

@users.get()
def get_users(request):
    """Returns a list of all users."""
    users = []
    for name in _USERS:
        users.append(_USERS[name])
    return {'users': users}

@users.post()
def create_user(request):
    """Adds a new user."""
    user_data = request.POST
    schema = UserSchema()
    try:
        schema.deserialize(user_data)
        _USERS[user_data['name']] = [user_data['name'], user_data['age'], user_data['mail_id']]
        return {'message':'User added'}
    except colander.Invalid as e:
        return {'message': str(e)}

@view_config(route_name='home', renderer='../templates/homepage.jinja2')
def home(request):
    return {}
