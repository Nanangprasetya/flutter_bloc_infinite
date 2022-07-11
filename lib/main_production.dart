import 'package:very_good_app/bootstrap.dart';
import 'package:very_good_app/src/config/config.dart';

import 'src/app/app.dart';

void main() {
  Environment(
    env: Env.PRODUCTION,
    values: EnvValues(
      appVersion: '0.0.1',
      baseApi: 'https://5f7cba02834b5c0016b058aa.mockapi.io/api2/',
      debug: true,
      delay: 0,
      printResponse: false,
    ),
  );
  bootstrap(() => const App());
}
