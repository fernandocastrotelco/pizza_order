import 'package:flutter/foundation.dart' show ChangeNotifier, ValueNotifier;

import 'ingredient.dart';

class PizzaOrderBLoC extends ChangeNotifier {
  final listIngredients = <Ingredient>[];
  final notifierTotal = ValueNotifier(15);
  final notifierDeletedIngredient = ValueNotifier<Ingredient>(null);

  void addListIngredient(Ingredient ingredient) {
    listIngredients.add(ingredient);
    notifierTotal.value++;
  }

  void removeIngredient(Ingredient ingredient) {
    listIngredients.remove(ingredient);
    notifierTotal.value--;
    notifierDeletedIngredient.value = ingredient;
  }

  void refreshDeletedIngredient() {
    notifierDeletedIngredient.value = null;
  }

  bool containsIngredient(Ingredient ingredient) {
    for (Ingredient i in listIngredients) {
      if (i.compare(ingredient)) {
        return true;
      }
    }
    return false;
  }
}
