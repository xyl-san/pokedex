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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final primaryType = pokemon.types.first;

    // Blend the type tint onto the theme's surface instead of a
    // transparent overlay. Works in both light and dark.
    final bgColor = Color.alphaBlend(
      primaryType.color.withValues(alpha: isDark ? 0.22 : 0.15),
      theme.colorScheme.surfaceContainerLow,
    );

    // Derived text colors that read on both surfaces.
    final mutedFg = theme.colorScheme.onSurface.withValues(alpha: 0.5);
    final faintFg = theme.colorScheme.onSurface.withValues(alpha: 0.15);

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
              // Top row: ID + Pokéball watermark
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    pokemon.formattedId,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: mutedFg,
                    ),
                  ),
                  Icon(
                    Icons.catching_pokemon,
                    size: 16,
                    color: faintFg,
                  ),
                ],
              ),

              // Image
              Expanded(
                child: Center(
                  child: Hero(
                    tag: 'pokemon-${pokemon.id}',
                    child: Image.network(
                      pokemon.imageUrl,
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) => Icon(
                        Icons.catching_pokemon,
                        size: 48,
                        color: faintFg,
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
              ),

              const SizedBox(height: 8),

              // Name
              Text(
                pokemon.displayName,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.onSurface,
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
