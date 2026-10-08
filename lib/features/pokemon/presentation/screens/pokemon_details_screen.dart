import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/features/pokemon/data/pokemon_repository.dart';
import 'package:pokedex/features/pokemon/domain/pokemon.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/pokemon_type_badge.dart';

class PokemonDetailsScreen extends ConsumerWidget {
  final int id;

  const PokemonDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemonAsync = ref.watch(pokemonByIdProvider(id));

    return pokemonAsync.when(
      loading: () => const _LoadingScaffold(),
      error: (err, _) => _ErrorScaffold(error: err, id: id),
      data: (pokemon) => _DetailScaffold(pokemon: pokemon),
    );
  }
}

// =============================================================================
// MAIN CONTENT
// =============================================================================

class _DetailScaffold extends StatelessWidget {
  final Pokemon pokemon;
  const _DetailScaffold({required this.pokemon});

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
              background: _HeaderBackground(pokemon: pokemon),
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
                        child: _StatCard(
                          icon: Icons.straighten,
                          label: 'Height',
                          value:
                              '${pokemon.heightInMeters.toStringAsFixed(1)} m',
                          color: typeColor,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _StatCard(
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
                  _StatBar(label: 'HP', value: 45, color: typeColor),
                  _StatBar(label: 'ATK', value: 49, color: typeColor),
                  _StatBar(label: 'DEF', value: 49, color: typeColor),
                  _StatBar(label: 'SPA', value: 65, color: typeColor),
                  _StatBar(label: 'SPD', value: 65, color: typeColor),
                  _StatBar(label: 'SPE', value: 45, color: typeColor),

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
// =============================================================================
// HEADER BACKGROUND (gradient + big image + ID)
// =============================================================================

class _HeaderBackground extends StatelessWidget {
  final Pokemon pokemon;
  const _HeaderBackground({required this.pokemon});

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

// =============================================================================
// STAT CARD (height / weight)
// =============================================================================

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        // Light: white card. Dark: elevated surface.
        color: isDark ? theme.colorScheme.surfaceContainerHigh : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
// =============================================================================
// STAT BAR (animated)
// =============================================================================

class _StatBar extends StatelessWidget {
  final String label;
  final int value;
  final Color color;

  const _StatBar({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fraction = (value / 150).clamp(0.0, 1.0);

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          SizedBox(
            width: 40,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: fraction),
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOutCubic,
                builder: (context, value, _) {
                  return LinearProgressIndicator(
                    value: value,
                    minHeight: 8,
                    backgroundColor: theme.colorScheme.onSurface.withValues(
                      alpha: 0.08,
                    ),
                    valueColor: AlwaysStoppedAnimation(color),
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 32,
            child: Text(
              '$value',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
// =============================================================================
// SECTION TITLE
// =============================================================================

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }
}

// =============================================================================
// LOADING + ERROR STATES
// =============================================================================

class _LoadingScaffold extends StatelessWidget {
  const _LoadingScaffold();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(child: CircularProgressIndicator()),
    );
  }
}

class _ErrorScaffold extends StatelessWidget {
  final Object error;
  final int id;

  const _ErrorScaffold({required this.error, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.redAccent.withValues(alpha: 0.7),
              ),
              const SizedBox(height: 16),
              const Text(
                'Something went wrong',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '$error',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
