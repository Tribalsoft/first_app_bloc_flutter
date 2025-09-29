class ApiConfig {
  static const String baseUrl =
      'https://api.ejemplo.com'; // Cambia esto por tu URL real
  static const String carsEndpoint = '/cars';

  // Headers comunes para las peticiones
  static const Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
}
