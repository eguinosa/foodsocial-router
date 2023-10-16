// Gelin Eguinosa
// 2023

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'foodsocial_theme.dart';
import 'models/models.dart';
import 'navigation/app_router.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appStateManager = AppStateManager();
  await appStateManager.initializeApp();
  runApp(FoodSocial(appStateManager: appStateManager));
}

class FoodSocial extends StatefulWidget {
  final AppStateManager appStateManager;

  const FoodSocial({
    super.key,
    required this.appStateManager,
  });

  @override
  State<FoodSocial> createState() => FoodSocialState();
}

class FoodSocialState extends State<FoodSocial> {
  late final _groceryManager = GroceryManager();
  late final _profileManager = ProfileManager();
  // Initialize AppRouter.
  late final _appRouter = AppRouter(
    widget.appStateManager,
    _profileManager,
    _groceryManager,
  );

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => _groceryManager,
        ),
        ChangeNotifierProvider(
          create: (context) => _profileManager,
        ),
        ChangeNotifierProvider(
          create: (context) => widget.appStateManager,
        )
      ],
      child: Consumer<ProfileManager>(
        builder: (context, profileManager, child) {
          ThemeData theme;
          if (profileManager.darkMode) {
            theme = FoodSocialTheme.dark();
          } else {
            theme = FoodSocialTheme.light();
          }

          // Use Router.
          final router = _appRouter.router;
          return MaterialApp.router(
            theme: theme,
            title: 'FoodSocial',
            routerDelegate: router.routerDelegate,
            routeInformationParser: router.routeInformationParser,
            routeInformationProvider: router.routeInformationProvider,
          );
        },
      ),
    );
  }
}
