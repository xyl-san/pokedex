import 'package:flutter/material.dart';
import 'package:pokedex/features/pokemon/domain/pokemon_type.dart';

class TypeBadge extends StatelessWidget {
  final PokemonType type;
  final bool large;
  const TypeBadge({super.key, required this.type, this.large = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: large ? 14 : 8,
        vertical: large ? 5 : 2,
      ),
      decoration: BoxDecoration(
        color: type.color,
        borderRadius: BorderRadius.circular(large ? 14 : 10),
      ),
      child: Text(
        type.displayName,
        style: TextStyle(
          color: Colors.white,
          fontSize: large ? 13 : 10,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
