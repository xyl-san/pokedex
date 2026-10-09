import 'package:flutter/material.dart';
import 'package:pokedex/features/pokemon/domain/pokemon.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/pokemon_detail/header.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/pokemon_detail/stat_bar.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/pokemon_detail/stat_card.dart';

class DetailScaffold extends StatelessWidget {
  final Pokemon pokemon;
  const DetailScaffold({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final typeColor = pokemon.types.first.color;

    final bgColor = Color.alphaBlend(
      typeColor.withValues(alpha: isDark ? 0.12 : 0.08),
      theme.colorScheme.surface,
    );

    return Scaffold(
      backgroundColor: bgColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 300,
            backgroundColor: typeColor,
            foregroundColor:
                Colors.white, // white on saturated type color is fine
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                pokemon.displayName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              titlePadding: const EdgeInsets.only(left: 56, bottom: 16),
              background: HeaderBackground(pokemon: pokemon),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ... type badges ...

                  const SizedBox(height: 20),

                  Text(
                    pokemon.description,
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.6,
                      // was: Colors.black87
                      color: theme.colorScheme.onSurface.withValues(
                        alpha: 0.85,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  Row(
                    children: [
                      Expanded(
                        child: StatCard(
                          icon: Icons.straighten,
                          label: 'Height',
                          value:
                              '${pokemon.heightInMeters.toStringAsFixed(1)} m',
                          color: typeColor,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: StatCard(
                          icon: Icons.monitor_weight_outlined,
                          label: 'Weight',
                          value: '${pokemon.weightInKg.toStringAsFixed(1)} kg',
                          color: typeColor,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 28),

                  Text(
                    'Base Stats',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      // was: Colors.black87
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 12),
                  StatBar(label: 'HP', value: 45, color: typeColor),
                  StatBar(label: 'ATK', value: 49, color: typeColor),
                  StatBar(label: 'DEF', value: 49, color: typeColor),
                  StatBar(label: 'SPA', value: 65, color: typeColor),
                  StatBar(label: 'SPD', value: 65, color: typeColor),
                  StatBar(label: 'SPE', value: 45, color: typeColor),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
