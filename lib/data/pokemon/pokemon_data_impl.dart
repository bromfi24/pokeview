
import 'package:pokeview/data/pokemon/remote/pokemon_remote_impl.dart';
import 'package:pokeview/domain/pokemons_repository.dart';
import 'package:pokeview/model/pokemon.dart';

class PokemonDataImpl implements PokemonsRepository {

  final PokemonRemoteImpl _remoteImpl;
  PokemonDataImpl(this._remoteImpl);

  @override
  Future<List<Pokemon>> getPokemonsList(String url){
    return _remoteImpl.getPokemonsList(url);
  }

  @override
  Future<List<Pokemon>>getNextPokemonList(){
    return _remoteImpl.getNextPokemonList();
  }

  @override
  Future<List<Pokemon>> getPreviousPokemonList(){
    return _remoteImpl.getPreviousPokemonList();
  }

  @override
  Future<Pokemon> getPokemonMoves(Pokemon pokemon){
    return _remoteImpl.getPokemonMoves(pokemon);
  }
}