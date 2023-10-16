// Gelin Eguinosa
// 2023

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/models.dart';
import '../screens/screens.dart';


class AppRouter {
  final AppStateManager appStateManager;
  final ProfileManager profileManager;
  final GroceryManager groceryManager;

  AppRouter(
    this.appStateManager,
    this.profileManager,
    this.groceryManager,
  );

  late final router = GoRouter(
    debugLogDiagnostics: true,
    refreshListenable: appStateManager,
    initialLocation: '/login',
    routes: [
      // Add Login Route.
      GoRoute(
        name: 'login',
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      // Add Onboarding Route.
      GoRoute(
        name: 'onboarding',
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      // Add Home Route.
      GoRoute(
        name: 'home',
        // 1
        path: '/:tab',
        builder: (context, state) {
          // 2
          final tab = int.tryParse(state.params['tab'] ?? '') ?? 0;
          // 3
          return Home(
            key: state.pageKey, currentTab: tab,
          );
        },
        // 4
        routes: [
          // Add Item Subroute.
          GoRoute(
            name: 'item',
            path: 'item/:id',
            builder: (context, state) {
              final itemId = state.params['id'] ?? '';
              final item = groceryManager.getGroceryItem(itemId);
              return GroceryItemScreen(
                originalItem: item,
                onCreate: (item) {
                  groceryManager.addItem(item);
                },
                onUpdate: (item) {
                  groceryManager.updateItem(item);
                },
              );
            },
          ),
          // TODO: Add Profile Subroute.
        ],
      ),
    ],
    // Add Error Handler.
    errorPageBuilder: (context, state) {
      return MaterialPage(
        key: state.pageKey,
        child: Scaffold(
          body: Center(
            child: Text(
              state.error.toString(),
            ),
          ),
        ),
      );
    },
    // Add Redirect Handler.
    redirect: (state) {
      final loggedIn = appStateManager.isLoggedIn;
      final loggingIn = state.subloc == '/login';
      if (!loggedIn) {
        return loggingIn ? null : '/login';
      }

      final isOnboardingComplete = appStateManager.isOnboardingComplete;
      final onboarding = state.subloc == '/onboarding';
      if (!isOnboardingComplete) {
        return onboarding ? null : '/onboarding';
      }
      if (loggingIn || onboarding) {
        // This value only matters when we first go to the Home widget.
        // We can't use this to change from one Home Tab to another.
        return '/${FoodSocialTab.explore}';
      }
      return null;
    },
  );
}
