import 'package:flutter/material.dart';
import 'package:pokedex/features/pokemon/domain/pokemon.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/pokemon_type_badge.dart';

class PokemonGridTile extends StatelessWidget {
  final Pokemon pokemon;
  final VoidCallback? onTap;

  const PokemonGridTile({
    super.key,
    required this.pokemon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Primary type color tints the card background
    final primaryType = pokemon.types.first;
    final bgColor = primaryType.color.withValues(alpha: 0.15);

    return Material(
      color: bgColor,
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top row: ID + Pokéball icon
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    pokemon.formattedId,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.black.withValues(alpha: 0.4),
                    ),
                  ),
                  Icon(
                    Icons.catching_pokemon,
                    size: 16,
                    color: Colors.black.withValues(alpha: 0.15),
                  ),
                ],
              ),

              // Image (fills remaining space, centers itself)
              Expanded(
                child: Center(
                  child: Image.network(
                    pokemon.imageUrl,
                    fit: BoxFit.contain,
                    errorBuilder: (_, _, _) => const Icon(
                      Icons.catching_pokemon,
                      size: 48,
                      color: Colors.black26,
                    ),
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;
                      return const SizedBox(
                        width: 32,
                        height: 32,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // Name
              Text(
                pokemon.displayName,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 6),

              // Type badges
              Row(
                children: [
                  for (final type in pokemon.types) ...[
                    TypeBadge(type: type),
                    if (type != pokemon.types.last) const SizedBox(width: 4),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
