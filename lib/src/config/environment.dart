
import '../utils/utils.dart';

enum Env { DEV, STAGING, PRODUCTION }

class EnvValues {
  final String? baseApi;
  final int? delay;
  final bool? debug;
  final bool? printResponse;
  final String? appVersion;

  EnvValues(
      {required this.baseApi,
      required this.delay,
      required this.debug,
      required this.printResponse,
      required this.appVersion});
}

class Environment {
  final Env? env;
  final String? name;
  final EnvValues? values;

  static Environment? _instance;

  factory Environment({required Env? env, required EnvValues? values}) {
    _instance ??= Environment._internal(
      env: env,
      name: StringUtils.enumName(env.toString()),
      values: values,
    );
    return _instance!;
  }

  Environment._internal({this.env, this.name, this.values});

  static Environment get instance {
    return _instance!;
  }

  static bool isProduction() => _instance!.env == Env.PRODUCTION;

  static bool isDevelopment() => _instance!.env == Env.DEV;

  static bool isStaging() => _instance!.env == Env.STAGING;
}
