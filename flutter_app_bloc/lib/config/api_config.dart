class ApiConfig {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';
  static const String users = '/users';

  static const Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
}
