// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:very_good_app/bootstrap.dart';
import 'package:very_good_app/src/config/config.dart';

import 'src/app/app.dart';

void main() {
  Environment(
    env: Env.DEV,
    values: EnvValues(
      appVersion: '0.0.1',
      baseApi: 'https://6186ca2fcd8530001765abb8.mockapi.io/api2/',
      debug: false,
      delay: 30000,
      printResponse: true,
    ),
  );
  bootstrap(() => const App());
}
