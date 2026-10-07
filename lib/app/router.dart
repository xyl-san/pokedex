import 'package:go_router/go_router.dart';
import 'package:pokedex/features/pokemon/presentation/screens/pokemon_details_screen.dart';
import 'package:pokedex/features/pokemon/presentation/screens/pokemon_list_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/pokemon',
  routes: [
    GoRoute(
      path: '/pokemon',
      builder: (context, state) => const PokemonListScreen(),
      // routes: <RouteBase>[
      //   GoRoute(
      //     path: ':id',
      //     builder: (context, state) {
      //       final id = int.tryParse(state.pathParameters['id'] ?? '');
      //       if (id == null) return const PokemonListScreen();
      //       return PokemonDetailsScreen(pokemonId: id);
      //     },
      //   ),
      // ],
    ),
  ],
);
