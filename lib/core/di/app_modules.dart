import 'package:pokeview/data/pokemon/pokemon_data_impl.dart';
import 'package:pokeview/data/pokemon/remote/pokemon_remote_impl.dart';
import 'package:pokeview/data/auth/auth_data_impl.dart';
import 'package:pokeview/data/auth/remote/auth_remote_impl.dart';
import 'package:pokeview/data/remote/http_client.dart';
import 'package:pokeview/domain/pokemons_repository.dart';
import 'package:pokeview/domain/auth_repository.dart';
import 'package:pokeview/presentation/view/auth/viewmodel/pokemon_view_model.dart';
import 'package:pokeview/presentation/view/pokemon/viewmodel/pokemon_view_model.dart';
import 'package:get_it/get_it.dart';

final inject = GetIt.instance;

class AppModules {
  setup() {
    _setupMainModule();
    _setupAuthModule();
    _setupArtistModule();
  }

  _setupMainModule() {
    inject.registerSingleton(HttpClient());
  }

  _setupAuthModule() {
    inject.registerFactory(() => AuthRemoteImpl(inject.get()));
    inject.registerFactory<AuthRepository>(() => AuthDataImpl(inject.get()));
    inject.registerFactory(() => AuthViewModel(inject.get()));
  }

  _setupArtistModule() {
    inject.registerFactory(() => PokemonRemoteImpl(inject.get()));
    inject.registerFactory<PokemonsRepository>(() => PokemonDataImpl(inject.get()));
    inject.registerFactory(() => PokemonViewModel(inject.get()));
  }
}
