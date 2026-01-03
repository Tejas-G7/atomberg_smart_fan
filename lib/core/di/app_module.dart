import 'package:atomberg_smart_fan_controller/core/domain/store/token_store.dart';
import 'package:atomberg_smart_fan_controller/core/network/atomberg_client.dart';
import 'package:atomberg_smart_fan_controller/feature/auth_creds/presentation/bloc/auth_creds_bloc.dart';
import 'package:atomberg_smart_fan_controller/feature/smart_fan/domain/repositories/smart_fan_repository.dart';
import 'package:atomberg_smart_fan_controller/feature/smart_fan/presentation/bloc/smart_fan_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../feature/smart_fan/data/repositories/smart_fan_repository_impl.dart';
import '../data/repository/auth_repository_impl.dart';
import '../data/store/token_store_impl.dart';
import '../domain/repository/auth_repository.dart';

final GetIt sl = GetIt.instance;

Future<void> setupDependencies() async {
  sl.registerSingleton<TokenStore>(TokenStoreImpl());
  sl.registerLazySingleton<AtombergClient>(() => AtombergClient(sl()));

  sl.registerLazySingleton<SmartFanRepository>(() => SmartFanRepositoryImpl(sl()));
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl(), sl()),
  );

  sl.registerFactory<AuthCredsBloc>(() => AuthCredsBloc(sl(), sl()));
  sl.registerFactory<SmartFanBloc>(() => SmartFanBloc(sl()));
}
