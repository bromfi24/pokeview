import 'dart:async';

import 'package:pokeview/domain/pokemons_repository.dart';
import 'package:pokeview/model/pokemon.dart';
import 'package:pokeview/presentation/common/base/base_view_model.dart';
import 'package:pokeview/presentation/common/base/resource_state.dart';
import 'package:pokeview/presentation/common/errorhandling/app_action.dart';
import 'package:pokeview/presentation/view/pokemon/viewmodel/pokemon_error_builder.dart';

class PokemonViewModel extends BaseViewModel {
  final PokemonsRepository _pokemonsRepository;

  PokemonViewModel(this._pokemonsRepository);

  StreamController<ResourceState> pokemonListState =
      StreamController<ResourceState>();

  Future<void> getPokemonsList(String url) async {
    pokemonListState.add(ResourceState.loading());
    _pokemonsRepository.getPokemonsList(url).then((pokemons) {
      pokemonListState.add(ResourceState.success(pokemons));
    }).catchError((e) {
      pokemonListState.add(ResourceState.error(
          PokemonErrorBuilder.create(e, AppAction.GET_ARTISTS).build()));
    });
  }

  Future<void> getNextPokemonList() async {
    pokemonListState.add(ResourceState.loading());
    _pokemonsRepository.getNextPokemonList().then((pokemons) {
      pokemonListState.add(ResourceState.success(pokemons));
    }).catchError((e) {
      pokemonListState.add(ResourceState.error(
          PokemonErrorBuilder.create(e, AppAction.GET_ARTISTS).build()));
    });
  }

  Future<void> getPreviousPokemonList() async {
    pokemonListState.add(ResourceState.loading());
    _pokemonsRepository.getPreviousPokemonList().then((pokemons) {
      pokemonListState.add(ResourceState.success(pokemons));
    }).catchError((e) {
      pokemonListState.add(ResourceState.error(
          PokemonErrorBuilder.create(e, AppAction.GET_ARTISTS).build()));
    });
  }

  Future<void> getPokemonMoves(Pokemon pokemon) async {
    pokemonListState.add(ResourceState.loading());
    _pokemonsRepository.getPokemonMoves(pokemon).then((pokemon) {
      pokemonListState.add(ResourceState.success(pokemon));
    }).catchError((e) {
      pokemonListState.add(ResourceState.error(
          PokemonErrorBuilder.create(e, AppAction.GET_ARTISTS).build()));
    });
  }


  @override
  void dispose() {
    pokemonListState.close();
  }
}
