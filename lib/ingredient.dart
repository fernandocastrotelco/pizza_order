import 'package:flutter/cupertino.dart';

class Ingredient {
  const Ingredient(this.image, this.imageUnit, this.positions);
  final String image;
  final String imageUnit;
  final List<Offset> positions;
  bool compare(Ingredient i) => i.image == image;
}

final ingredients = const <Ingredient>[
  Ingredient('assets/chili.png',
  'assets/chili_unit.png',
   <Offset>[
    Offset(0.2, 0.2),
    Offset(0.6, 0.2),
    Offset(0.4, 0.25),
    Offset(0.5, 0.3),
    Offset(0.4, 0.65),
  ]),
  Ingredient('assets/mushroom.png', 
  'assets/mushroom_unit.png',
  <Offset>[
    Offset(0.2, 0.35),
    Offset(0.65, 0.35),
    Offset(0.3, 0.23),
    Offset(0.5, 0.2),
    Offset(0.3, 0.5),
  ]),
  Ingredient('assets/olive.png', 
  'assets/olive_unit.png',
  <Offset>[
    Offset(0.25, 0.5),
    Offset(0.65, 0.6),
    Offset(0.2, 0.3),
    Offset(0.4, 0.2),
    Offset(0.2, 0.6),
  ]),
  Ingredient('assets/onion.png', 
    'assets/onion.png',
    <Offset>[
    Offset(0.2, 0.65),
    Offset(0.65, 0.3),
    Offset(0.25, 0.25),
    Offset(0.45, 0.35),
    Offset(0.4, 0.65),
  ]),
  Ingredient('assets/pea.png', 
  'assets/pea_unit.png',
  <Offset>[
    Offset(0.2, 0.35),
    Offset(0.65, 0.35),
    Offset(0.3, 0.23),
    Offset(0.5, 0.2),
    Offset(0.3, 0.5),
  ]),
  Ingredient('assets/pickle.png', 
  'assets/pickle_unit.png',
  <Offset>[
    Offset(0.2, 0.65),
    Offset(0.65, 0.3),
    Offset(0.25, 0.25),
    Offset(0.45, 0.35),
    Offset(0.4, 0.65),
  ]),
  Ingredient('assets/potato.png', 
  'assets/potato_unit.png',
  <Offset>[
    Offset(0.2, 0.2),
    Offset(0.6, 0.2),
    Offset(0.4, 0.25),
    Offset(0.5, 0.3),
    Offset(0.4, 0.65),
  ]),
];
