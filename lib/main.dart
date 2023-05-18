import 'package:flutter/material.dart';
import 'package:learning_mvvm/utils/routes/routes.dart';
import 'package:learning_mvvm/utils/routes/routes_name.dart';
import 'package:learning_mvvm/view%20model/auth_view_model.dart';
import 'package:learning_mvvm/view%20model/user_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MVVM());
}

class MVVM extends StatelessWidget {
  const MVVM({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserViewModel(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Movies App (MVVM Architecture)',
        theme: ThemeData.dark(),
        initialRoute: RoutesName.splash,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
