import 'package:flutter/material.dart';
import 'package:pizza_order/pizza_order_provider.dart';

import 'ingredient.dart';

class PizzaIngredients extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = PizzaOrderProvider.of(context);
    return ValueListenableBuilder(
        valueListenable: bloc.notifierTotal,
        builder: (context, value, _) {
          //final list = bloc.listIngredients;
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: ingredients.length,
            itemBuilder: (context, index) {
              final ingredient = ingredients[index];
              return PizzaIngredientItem(
                ingredient: ingredient,
                exists: bloc.containsIngredient(ingredient),
                onTap: () {
                  bloc.removeIngredient(ingredient);
                },
              );
            },
          );
        });
  }
}

class PizzaIngredientItem extends StatelessWidget {
  const PizzaIngredientItem({Key key, this.ingredient, this.exists, this.onTap})
      : super(key: key);
  final Ingredient ingredient;
  final bool exists;
  final VoidCallback onTap;

  Widget _buildChild({bool withImage = true}) {
    return GestureDetector(
      onTap: exists ? onTap : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7.0),
        child: Container(
          height: 45,
          width: 45,
          decoration: BoxDecoration(
            color: exists ? Colors.grey[400] : Color(0xFFF5EED3),
            shape: BoxShape.circle,
            // border: exists ? Border.all(color: Colors.red, width: 2) : null,
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: withImage
                ? Image.asset(ingredient.image, fit: BoxFit.contain)
                : SizedBox.fromSize(),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: exists
          ? _buildChild()
          : Draggable(
              feedback: DecoratedBox(
                decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                  BoxShadow(
                    blurRadius: 15.0,
                    color: Colors.black26,
                    offset: Offset(0.0, 0.5),
                    spreadRadius: 5.0,
                  )
                ]),
                child: _buildChild(),
              ),
              childWhenDragging: _buildChild(withImage: false),
              data: ingredient,
              child: _buildChild(),
            ),
    );
  }
}
