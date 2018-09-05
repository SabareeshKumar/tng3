from cornice import Service

_USERS = {}

users = Service(name='users', pyramid_route='home', description="User registration")

@users.get()
def get_users(request):
    """Returns a list of all users."""
    return {'users': list(_USERS)}

@users.post()
def create_user(request):
    """Adds a new user."""
    user = {}
    user['name'] = request.text

    _USERS[user['name']] = user['name']
    return {'users': list(_USERS)}