from pyramid.view import view_config

@view_config(route_name='home', renderer='../../client/output/web/index.html')
def home(request):
    return {}
