import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  try {
    print('🚀 Iniciando prueba de API...');
    
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/users'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    
    print('📡 Código de respuesta: ${response.statusCode}');
    
    if (response.statusCode == 200) {
      final List<dynamic> usersData = json.decode(response.body);
      print('👥 Total de usuarios: ${usersData.length}');
      
      for (int i = 0; i < usersData.length; i++) {
        final user = usersData[i];
        print('$i. ${user['name']} - ${user['email']}');
      }
      
      // Prueba de búsqueda específica
      print('\n🔍 Probando búsqueda de email...');
      final testEmail = 'Sincere@april.biz'; // Email corregido
      final foundUser = usersData.firstWhere(
        (user) => user['email'].toString().toLowerCase() == testEmail.toLowerCase(),
        orElse: () => null,
      );
      
      if (foundUser != null) {
        print('✅ Usuario encontrado: ${foundUser['name']} (${foundUser['email']})');
      } else {
        print('❌ Usuario NO encontrado para: $testEmail');
      }
    } else {
      print('❌ Error en la respuesta: ${response.statusCode}');
    }
  } catch (e) {
    print('💥 Error: $e');
  }
}