import 'package:flutter/material.dart';

/// Widget de loading con animación pulsante para hacer más atractiva la espera
class PulsingLoadingWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const PulsingLoadingWidget({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 2000),
  });

  @override
  State<PulsingLoadingWidget> createState() => _PulsingLoadingWidgetState();
}

class _PulsingLoadingWidgetState extends State<PulsingLoadingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    
    _animation = Tween<double>(
      begin: 0.7,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    // Iniciar la animación en bucle
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.scale(
          scale: _animation.value,
          child: Opacity(
            opacity: _animation.value,
            child: widget.child,
          ),
        );
      },
    );
  }
}

/// Widget de loading con múltiples puntos animados
class DotsLoadingWidget extends StatefulWidget {
  final Color color;
  final double size;
  final Duration duration;

  const DotsLoadingWidget({
    super.key,
    this.color = Colors.blue,
    this.size = 8.0,
    this.duration = const Duration(milliseconds: 1200),
  });

  @override
  State<DotsLoadingWidget> createState() => _DotsLoadingWidgetState();
}

class _DotsLoadingWidgetState extends State<DotsLoadingWidget>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(3, (index) {
      return AnimationController(
        duration: widget.duration,
        vsync: this,
      );
    });

    _animations = _controllers.map((controller) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInOut),
      );
    }).toList();

    // Iniciar animaciones con delay escalonado
    for (int i = 0; i < _controllers.length; i++) {
      Future.delayed(Duration(milliseconds: i * 200), () {
        if (mounted) {
          _controllers[i].repeat(reverse: true);
        }
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) {
        return AnimatedBuilder(
          animation: _animations[index],
          builder: (context, child) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: widget.size * 0.2),
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                color: widget.color.withOpacity(0.3 + (_animations[index].value * 0.7)),
                shape: BoxShape.circle,
              ),
            );
          },
        );
      }),
    );
  }
}