import 'package:flutter/material.dart';
import 'package:netflixclone/src/core/app_colors.dart';

class CardPerfilWidget extends StatefulWidget {
  final Map<String, dynamic> perfil;
  final bool estaEditando;
  final VoidCallback onTap;

  const CardPerfilWidget({super.key, required this.perfil, required this.estaEditando, required this.onTap});

  @override
  State<CardPerfilWidget> createState() => _CardPerfilWidgetState();
}

class _CardPerfilWidgetState extends State<CardPerfilWidget> {
  bool _estaComFoco = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _estaComFoco = true),
      onExit: (_) => setState(() => _estaComFoco = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Column(
          children: [
            AnimatedScale(
              scale: _estaComFoco ? 1.1 : 1.0,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOutCubic,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Color(int.parse(widget.perfil['colorValue'])),
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: _estaComFoco
                          ? [
                              BoxShadow(
                                color: Colors.white.withAlpha(50),
                                blurRadius: 10,
                                spreadRadius: 2,
                                offset: const Offset(0, 4),
                              )
                            ]
                          : null,
                      border: _estaComFoco
                          ? Border.all(color: Colors.white, width: 3)
                          : null,
                    ),
                    child: const Icon(Icons.person, size: 60, color: Colors.white70),
                  ),
                  if (widget.estaEditando)
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(150),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Icon(Icons.edit, size: 40, color: Colors.white),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: TextStyle(
                color: _estaComFoco ? Colors.white : AppColors.textGray,
                fontSize: 16,
                fontWeight: _estaComFoco ? FontWeight.bold : FontWeight.normal,
              ),
              child: Text(widget.perfil['name'] as String),
            ),
          ],
        ),
      ),
    );
  }
}