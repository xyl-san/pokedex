import 'package:flutter/material.dart';
import 'package:pokedex/features/pokemon/domain/pokemon_type.dart';

class TypeBadge extends StatelessWidget {
  final PokemonType type;
  const TypeBadge({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: type.color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        type.displayName,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
