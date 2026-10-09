import 'package:pokedex/features/pokemon/data/sample_pokemon.dart';
import 'package:pokedex/features/pokemon/domain/pokemon.dart';
import 'package:pokedex/features/pokemon/domain/pokemon_exception.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pokemon_repository.g.dart';

class PokemonRepository {
  Future<List<Pokemon>> getAll() async {
    await Future.delayed(const Duration(seconds: 3));
    return samplePokemon;
  }

  Future<Pokemon> getById(int id) async {
    await Future.delayed(const Duration(seconds: 3));
    for (final p in samplePokemon) {
      if (p.id == id) return p;
    }
    throw PokemonNotFoundException(id);
  }
}

@riverpod
PokemonRepository pokemonRepository(Ref ref) {
  return PokemonRepository();
}

@riverpod
Future<List<Pokemon>> pokemonList(Ref ref) {
  final repo = ref.read(pokemonRepositoryProvider);
  return repo.getAll();
}

@riverpod
Future<Pokemon> pokemonById(Ref ref, int id) {
  final repo = ref.read(pokemonRepositoryProvider);
  return repo.getById(id);
}
