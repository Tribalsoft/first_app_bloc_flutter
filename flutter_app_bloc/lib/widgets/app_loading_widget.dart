import 'package:flutter/material.dart';

/// Widget de carga para mostrar durante la inicialización de la aplicación
/// o cuando se está verificando el estado de autenticación.
class AppLoadingWidget extends StatelessWidget {
  final String? message;
  final bool showLogo;

  const AppLoadingWidget({
    super.key,
    this.message,
    this.showLogo = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (showLogo) ...[
              // Logo o icono de la aplicación
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.flutter_dash,
                  size: 80,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 40),
              // Nombre de la aplicación
              Text(
                'Demo Flutter BLoC',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 60),
            ],
            
            // Indicador de progreso
            const SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Mensaje descriptivo
            Text(
              message ?? 'Inicializando aplicación...',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.white.withOpacity(0.9),
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            
            // Mensaje secundario
            const SizedBox(height: 8),
            Text(
              'Por favor espera un momento',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white.withOpacity(0.7),
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

/// Widget de carga más simple para usar dentro de otras pantallas
class SimpleLoadingWidget extends StatelessWidget {
  final String message;
  final Color? color;
  final double? size;

  const SimpleLoadingWidget({
    super.key,
    required this.message,
    this.color,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: size ?? 32,
          height: size ?? 32,
          child: CircularProgressIndicator(
            strokeWidth: 3,
            valueColor: AlwaysStoppedAnimation<Color>(
              color ?? Theme.of(context).primaryColor,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          message,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: color ?? Theme.of(context).textTheme.bodyLarge?.color,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}