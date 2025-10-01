import 'package:flutter/material.dart';
import '../services/auth_api_service.dart';

class AvailableEmailsWidget extends StatefulWidget {
  const AvailableEmailsWidget({super.key});

  @override
  State<AvailableEmailsWidget> createState() => _AvailableEmailsWidgetState();
}

class _AvailableEmailsWidgetState extends State<AvailableEmailsWidget> {
  List<String> _emails = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadEmails();
  }

  Future<void> _loadEmails() async {
    try {
      final authService = AuthApiService();
      
      // Agregar delay para mostrar el loading más tiempo
      await Future.delayed(const Duration(seconds: 3));
      
      final emails = await authService.getAvailableEmails();
      if (mounted) {
        setState(() {
          _emails = emails;
          _loading = false;
        });
      }
      authService.dispose();
    } catch (e) {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.green.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.info_outline, color: Colors.green, size: 20),
              SizedBox(width: 8),
              Text(
                'Credenciales de prueba:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (_loading)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: const Row(
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Cargando emails disponibles...',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.green,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Consultando API de usuarios',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          else if (_emails.isEmpty)
            const Text(
              'No se pudieron cargar los emails. Verifica tu conexión.',
              style: TextStyle(color: Colors.orange),
            )
          else ...[
            const Text(
              '📧 Emails válidos:',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            ..._emails.take(3).map((email) => Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 4),
              child: Text(
                '• $email',
                style: const TextStyle(
                  fontSize: 12,
                  fontFamily: 'monospace',
                  color: Colors.green,
                ),
              ),
            )),
            if (_emails.length > 3)
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  '... y ${_emails.length - 3} más',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
          ],
          const SizedBox(height: 12),
          const Text(
            '🔑 Contraseña: wil1122',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}