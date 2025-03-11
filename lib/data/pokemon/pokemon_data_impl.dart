
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

  @override
  Future<void> savePokemon(Pokemon pokemon){
    return _remoteImpl.savePokemon(pokemon);
  }

  @override
  Future<void> deletePokemon(Pokemon pokemon){
    return _remoteImpl.deletePokemon(pokemon.id);
  }

  @override
  Future<List<Pokemon>> getSavedPokemons(){
    return _remoteImpl.getSavedPokemons();
  }

  @override
  Future<bool> isPokemonFavorite(int id){
    return _remoteImpl.isPokemonFavorite(id);
  }
}