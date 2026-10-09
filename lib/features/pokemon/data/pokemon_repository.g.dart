// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(pokemonRepository)
final pokemonRepositoryProvider = PokemonRepositoryProvider._();

final class PokemonRepositoryProvider
    extends
        $FunctionalProvider<
          PokemonRepository,
          PokemonRepository,
          PokemonRepository
        >
    with $Provider<PokemonRepository> {
  PokemonRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pokemonRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pokemonRepositoryHash();

  @$internal
  @override
  $ProviderElement<PokemonRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PokemonRepository create(Ref ref) {
    return pokemonRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PokemonRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PokemonRepository>(value),
    );
  }
}

String _$pokemonRepositoryHash() => r'6bda524134fb341354f3c8a33428343e6f951e50';

@ProviderFor(pokemonList)
final pokemonListProvider = PokemonListProvider._();

final class PokemonListProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Pokemon>>,
          List<Pokemon>,
          FutureOr<List<Pokemon>>
        >
    with $FutureModifier<List<Pokemon>>, $FutureProvider<List<Pokemon>> {
  PokemonListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pokemonListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pokemonListHash();

  @$internal
  @override
  $FutureProviderElement<List<Pokemon>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Pokemon>> create(Ref ref) {
    return pokemonList(ref);
  }
}

String _$pokemonListHash() => r'e969068e1b340ad27ebbdc50dafeae48e637def3';

@ProviderFor(pokemonById)
final pokemonByIdProvider = PokemonByIdFamily._();

final class PokemonByIdProvider
    extends $FunctionalProvider<AsyncValue<Pokemon>, Pokemon, FutureOr<Pokemon>>
    with $FutureModifier<Pokemon>, $FutureProvider<Pokemon> {
  PokemonByIdProvider._({
    required PokemonByIdFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'pokemonByIdProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$pokemonByIdHash();

  @override
  String toString() {
    return r'pokemonByIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Pokemon> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Pokemon> create(Ref ref) {
    final argument = this.argument as int;
    return pokemonById(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PokemonByIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$pokemonByIdHash() => r'1a7b54e7cc45d60506c04cb4b06ac7bc55bd629c';

final class PokemonByIdFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Pokemon>, int> {
  PokemonByIdFamily._()
    : super(
        retry: null,
        name: r'pokemonByIdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  PokemonByIdProvider call(int id) =>
      PokemonByIdProvider._(argument: id, from: this);

  @override
  String toString() => r'pokemonByIdProvider';
}
