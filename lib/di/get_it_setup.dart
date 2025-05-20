import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:githubactions/home/repository/home_repository.dart';
import 'package:githubactions/home/store/home_store.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  getIt.registerLazySingleton<Dio>(() => Dio());

  getIt.registerFactory<HomeRepository>(
    () => HomeRepository(
      dio: getIt<Dio>(),
    ),
  );

  getIt.registerSingleton<HomeStore>(
    HomeStore(
      getIt<HomeRepository>(),
    ),
    dispose: (param) {
      param.dispose();
    },
  );
}
