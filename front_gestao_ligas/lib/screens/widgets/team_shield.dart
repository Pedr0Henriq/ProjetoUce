import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

/// Widget de escudo do time com fallback
class TeamShield extends StatelessWidget {
  final String? escudoUrl;
  final String nome;
  final double size;

  const TeamShield({
    super.key,
    this.escudoUrl,
    required this.nome,
    this.size = 40,
  });

  @override
  Widget build(BuildContext context) {
    if (escudoUrl != null && escudoUrl!.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(size / 4),
        child: CachedNetworkImage(
          imageUrl: escudoUrl!,
          width: size,
          height: size,
          fit: BoxFit.cover,
          placeholder: (_, _) => _placeholder(context),
          errorWidget: (_, _, _) => _placeholder(context),
        ),
      );
    }
    return _placeholder(context);
  }

  Widget _placeholder(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(size / 4),
      ),
      child: Center(
        child: Text(
          nome.isNotEmpty ? nome[0].toUpperCase() : '?',
          style: TextStyle(
            fontSize: size * 0.45,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
      ),
    );
  }
}
