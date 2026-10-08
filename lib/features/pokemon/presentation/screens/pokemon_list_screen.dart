import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/features/pokemon/data/pokemon_repository.dart';
import 'package:pokedex/features/pokemon/domain/pokemon_exception.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/pokemon_grid_view.dart';

class PokemonListScreen extends ConsumerWidget {
  const PokemonListScreen({super.key}); // fixed the constructor name

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemonListAsyncValue = ref.watch(pokemonListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokédex'),
        // No backgroundColor — let Material 3 pick it from the scheme.
      ),
      body: pokemonListAsyncValue.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => _ErrorView(
          error: error,
          onRetry: () => ref.invalidate(pokemonListProvider),
        ),
        data: (pokemonList) => RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(pokemonListProvider);
            await ref.read(pokemonListProvider.future);
          },
          child: PokemonGridView(pokemonList: pokemonList),
        ),
      ),
    );
  }
}

class _ErrorView extends ConsumerWidget {
  final Object error;
  final VoidCallback onRetry;

  const _ErrorView({required this.error, required this.onRetry});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    // Show a friendly message based on our sealed exception hierarchy.
    final (icon, title, message) = switch (error) {
      PokemonNetworkException(:final message) => (
        Icons.wifi_off_rounded,
        'No connection',
        message,
      ),
      PokemonNotFoundException(:final message) => (
        Icons.search_off_rounded,
        'Not found',
        message,
      ),
      PokemonUnknownException() => (
        Icons.error_outline_rounded,
        'Something went wrong',
        'Please try again in a moment.',
      ),
      _ => (
        Icons.error_outline_rounded,
        'Something went wrong',
        error.toString(),
      ),
    };

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 64, color: theme.colorScheme.error),
            const SizedBox(height: 16),
            Text(
              title,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
