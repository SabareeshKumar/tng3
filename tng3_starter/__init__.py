from pyramid.config import Configurator


def main(global_config, **settings):
    """ This function returns a Pyramid WSGI application.
    """
    config = Configurator(settings=settings)
    config.include('cornice')
    config.include('pyramid_jinja2')
    config.add_jinja2_renderer('.html')
    config.include('.models')
    config.include('.routes')
    config.scan()
    config.add_static_view(name='/', path=settings['client_package'])
    return config.make_wsgi_app()
