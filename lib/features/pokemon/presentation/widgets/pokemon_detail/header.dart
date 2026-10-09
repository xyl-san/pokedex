import 'package:flutter/material.dart';
import 'package:pokedex/features/pokemon/domain/pokemon.dart';

class HeaderBackground extends StatelessWidget {
  final Pokemon pokemon;
  const HeaderBackground({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    final typeColor = pokemon.types.first.color;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            typeColor,
            typeColor.withValues(alpha: 0.7),
            typeColor.withValues(alpha: 0.3),
          ],
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Watermark: giant Pokéball icon
          Positioned(
            top: 60,
            right: -20,
            child: Icon(
              Icons.catching_pokemon,
              size: 200,
              color: Colors.white.withValues(alpha: 0.08),
            ),
          ),

          // Pokémon image
          Padding(
            padding: const EdgeInsets.only(top: 60, bottom: 40),
            child: Hero(
              tag: 'pokemon-${pokemon.id}',
              child: Image.network(
                pokemon.imageUrl,
                height: 180,
                fit: BoxFit.contain,
                errorBuilder: (_, _, _) => const Icon(
                  Icons.catching_pokemon,
                  size: 120,
                  color: Colors.white24,
                ),
              ),
            ),
          ),

          // ID badge (top-left of the header)
          Positioned(
            top: 100,
            left: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                pokemon.formattedId,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
