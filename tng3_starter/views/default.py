from pyramid.view import view_config

from cornice import Service

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
    _USERS[user_data['name']] = [user_data['name'], user_data['age'], user_data['mail_id']]
    return {}

@view_config(route_name='home', renderer='../templates/homepage.jinja2')
def home(request):
    return {}