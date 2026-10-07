import 'package:pokedex/features/pokemon/data/sample_pokemon.dart';
import 'package:pokedex/features/pokemon/domain/pokemon.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pokemon_repository.g.dart';

class PokemonRepository {
  Future<List<Pokemon>> getAll() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return samplePokemon;
  }

  Future<Pokemon> getById(int id) async {
    await Future.delayed(const Duration(milliseconds: 600));
    return samplePokemon.firstWhere((pokemon) => pokemon.id == id);
  }
}

@riverpod
PokemonRepository pokemonRepository(Ref ref) {
  return PokemonRepository();
}

@riverpod
FutureOr<List<Pokemon>> pokemonList(Ref ref) async {
  final repo = ref.watch(pokemonRepositoryProvider);
  return repo.getAll();
}

@riverpod
FutureOr<Pokemon> pokemonById(Ref ref, int id) async {
  final repo = ref.watch(pokemonRepositoryProvider);
  return repo.getById(id);
}
