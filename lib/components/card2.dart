// Gelin Eguinosa
// 2023

import 'package:flutter/material.dart';

import '../foodsocial_theme.dart';
import '../models/models.dart';
import 'author_card.dart';


class Card2 extends StatelessWidget {
  final ExploreRecipe recipe;

  const Card2({
    super.key,
    required this.recipe,
  });

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Container(
        constraints: const BoxConstraints.expand(
          width: 400,
          height: 515,
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(recipe.backgroundImage),
            fit: BoxFit.cover,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Column(
          children: [
            AuthorCard(
              authorName: recipe.authorName,
              title: recipe.role,
              imageProvider: AssetImage(recipe.profileImage),
            ),
            Expanded(
              child: Stack(
                children: [
                  Positioned(
                    bottom: 16,
                    right: 16,
                    child: Text(
                      recipe.title,
                      style: FoodSocialTheme.lightTextTheme.headline1,
                    ),
                  ),
                  Positioned(
                    bottom: 70,
                    left: 16,
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: Text(
                        recipe.subtitle,
                        style: FoodSocialTheme.lightTextTheme.headline1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}
