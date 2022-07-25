import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../../announcement/view/announcement_view.dart';
import '../../l10n/l10n.dart';
import '../../users/users.dart';

class App extends StatelessWidget {
  const App();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit(),
      child: MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
        ],
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        supportedLocales: AppLocalizations.supportedLocales,
        home: UsersView(),
        onGenerateRoute: (RouteSettings i) {
            switch (i.name) {
              case '/user_view':
                return MaterialPageRoute(builder: (context) => UsersView());
              case '/announcement_view':
                return MaterialPageRoute(builder: (context) => AnnouncementView());
            }
          },
      ),
    );
  }
}
