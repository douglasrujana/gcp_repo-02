# tests/test_app.py
import pytest
from main import app # Importamos la instancia 'app' desde main.py

@pytest.fixture()
def client():
    """Crea un cliente de prueba para la app Flask."""
    app.config.update({
        "TESTING": True,
    })
    client = app.test_client()
    return client

def test_hello_world_route(client):
    """Prueba que la ruta principal '/' funciona y devuelve 'Hola Mundo'."""
    response = client.get('/')
    assert response.status_code == 200 # Verifica que la respuesta es OK
    assert response.data.decode('utf-8') == 'Hola Mundo' # Verifica el contenido
