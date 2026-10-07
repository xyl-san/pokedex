import 'package:pokedex/features/pokemon/domain/pokemon_type.dart';

class Pokemon {
  final int id;
  final String name;
  final List<PokemonType> types;
  final int height; // decimeters
  final int weight; // hectograms
  final String imageUrl;
  final String description;

  const Pokemon({
    required this.id,
    required this.name,
    required this.types,
    required this.height,
    required this.weight,
    required this.imageUrl,
    required this.description,
  });

  String get formattedId => '#${id.toString().padLeft(3, '0')}';
  String get displayName => name[0].toUpperCase() + name.substring(1);
}
