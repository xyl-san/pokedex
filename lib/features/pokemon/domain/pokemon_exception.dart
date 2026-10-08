sealed class PokemonException implements Exception {
  final String message;
  const PokemonException(this.message);

  @override
  String toString() => message;
}

class PokemonNotFoundException extends PokemonException {
  const PokemonNotFoundException(int id) : super('Pokemon #$id not found.');
}

class PokemonNetworkException extends PokemonException {
  const PokemonNetworkException()
    : super('Please check your internet connection and try again.');
}

class PokemonUnknownException extends PokemonException {
  const PokemonUnknownException() : super('An unknown error occurred.');
}
