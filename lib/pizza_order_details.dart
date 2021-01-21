import 'package:flutter/material.dart';
import 'package:pizza_order/ingredient.dart';
import 'package:pizza_order/pizza_cart_button.dart';
import 'package:pizza_order/pizza_order_bloc.dart';
import 'package:pizza_order/pizza_order_provider.dart';
import 'package:pizza_order/pizza_size_button.dart';

import 'pizza_ingredients.dart';

const _pizzaCartSize = 55.0;

class PizzaOrderDetails extends StatefulWidget {
  @override
  _PizzaOrderDetailsState createState() => _PizzaOrderDetailsState();
}

class _PizzaOrderDetailsState extends State<PizzaOrderDetails> {
  final bloc = PizzaOrderBLoC();
  @override
  Widget build(BuildContext context) {
    return PizzaOrderProvider(
      bloc: bloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Cherry Gourmet',
            style: TextStyle(color: Colors.brown, fontSize: 24),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(Icons.add_shopping_cart_outlined),
              onPressed: () {},
              color: Colors.brown,
            )
          ],
        ),
        body: Stack(children: [
          Positioned.fill(
            bottom: 50,
            left: 10,
            right: 10,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              elevation: 10,
              child: Column(
                children: [
                  Expanded(flex: 4, child: _PizzaDetails()),
                  Expanded(flex: 2, child: PizzaIngredients()),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 25,
            height: _pizzaCartSize,
            width: _pizzaCartSize,
            left: MediaQuery.of(context).size.width / 2 - _pizzaCartSize / 2,
            child: PizzaCartButton(
              onTap: () {
                print('cart');
              },
            ),
          )
        ]),
      ),
    );
  }
}

enum _PizzaSizeValue {
  s,
  m,
  l,
}

class _PizzaSizeState {
  _PizzaSizeState(this.value) : factor = _getFactorBySize(value);
  final _PizzaSizeValue value;
  final double factor;
  static double _getFactorBySize(_PizzaSizeValue value) {
    switch (value) {
      case _PizzaSizeValue.s:
        return 0.75;
      case _PizzaSizeValue.m:
        return 0.85;
      case _PizzaSizeValue.l:
        return 1.0;
      default:
        return 1;
    }
  }
}

class _PizzaDetails extends StatefulWidget {
  @override
  __PizzaDetailsState createState() => __PizzaDetailsState();
}

class __PizzaDetailsState extends State<_PizzaDetails>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  AnimationController _animationRotationController;

  final _notifierFocused = ValueNotifier(false);
  BoxConstraints _pizzaConstraints;
  List<Animation> _animationList = <Animation>[];
  final _notifierPizzaSize =
      ValueNotifier<_PizzaSizeState>(_PizzaSizeState(_PizzaSizeValue.m));

  Widget _buildIngredientWidget(Ingredient deletedIngredient) {
    List<Widget> elements = [];
    final listIngredients =
        List.from(PizzaOrderProvider.of(context).listIngredients);
    if (deletedIngredient != null) {
      listIngredients.add(deletedIngredient);
    }
    if (_animationList.isNotEmpty) {
      for (int i = 0; i < listIngredients.length; i++) {
        Ingredient ingredient = listIngredients[i];
        final ingredientWidget = Image.asset(
          ingredient.imageUnit,
          height: 40,
        );
        for (int j = 0; j < ingredient.positions.length; j++) {
          final animation = _animationList[j];
          final position = ingredient.positions[j];
          final positionX = position.dx;
          final positionY = position.dy;
          if (i == listIngredients.length - 1 && _animationController.isAnimating) {
            double fromY = 0.0, fromX = 0.0;
            //define el inicio de la animación
            if (j < 1) {
              fromX = -_pizzaConstraints.maxWidth * (1 - animation.value);
            } else if (j < 2) {
              fromX = _pizzaConstraints.maxWidth * (1 - animation.value);
            } else if (j < 4) {
              fromY = -_pizzaConstraints.maxHeight * (1 - animation.value);
            } else {
              fromY = _pizzaConstraints.maxHeight * (1 - animation.value);
            }

            final opacity = animation.value;

            if (animation.value > 0) {
              elements.add(
                Opacity(
                  opacity: opacity,
                  child: Transform(
                      transform: Matrix4.identity()
                        ..translate(
                            fromX + _pizzaConstraints.maxWidth * positionX,
                            fromY + _pizzaConstraints.maxHeight * positionY),
                      child: ingredientWidget),
                ),
              );
            }
          } else {
            elements.add(
              Transform(
                  transform: Matrix4.identity()
                    ..translate(_pizzaConstraints.maxWidth * positionX,
                        _pizzaConstraints.maxHeight * positionY),
                  child: ingredientWidget),
            );
          }
        }
      }
      return Stack(
        children: elements,
      );
    }
    return SizedBox.fromSize();
  }

  void _buildIngredientsAnimation() {
    _animationList.clear();
    _animationList.add(CurvedAnimation(
      curve: Interval(0.0, 0.8, curve: Curves.decelerate),
      parent: _animationController,
    ));
    _animationList.add(CurvedAnimation(
      curve: Interval(0.2, 0.8, curve: Curves.decelerate),
      parent: _animationController,
    ));
    _animationList.add(CurvedAnimation(
      curve: Interval(0.4, 1.0, curve: Curves.decelerate),
      parent: _animationController,
    ));
    _animationList.add(CurvedAnimation(
      curve: Interval(0.1, 0.7, curve: Curves.decelerate),
      parent: _animationController,
    ));
    _animationList.add(CurvedAnimation(
      curve: Interval(0.3, 1.0, curve: Curves.decelerate),
      parent: _animationController,
    ));
  }

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 900));
    _animationRotationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _animationRotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = PizzaOrderProvider.of(context);
    return Column(children: [
      Expanded(
        child: DragTarget<Ingredient>(onAccept: (ingredient) {
          print('accept');

          _notifierFocused.value = false;
          bloc.addListIngredient(ingredient);
          _buildIngredientsAnimation();
          _animationController.forward(from: 0.0);
        }, onWillAccept: (ingredient) {
          print('onWillAccept');

          _notifierFocused.value = true;

          return !bloc.containsIngredient(ingredient);
        }, onLeave: (ingredient) {
          print('onLeave');

          _notifierFocused.value = false;
        }, builder: (context, list, rejects) {
          return LayoutBuilder(builder: (context, constraints) {
            _pizzaConstraints = constraints;
            return ValueListenableBuilder<_PizzaSizeState>(
                valueListenable: _notifierPizzaSize,
                builder: (context, pizzaSize, _) {
                  return RotationTransition(
                    turns: CurvedAnimation(
                      curve: Curves.elasticOut,
                      parent: _animationRotationController,
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: ValueListenableBuilder<bool>(
                              valueListenable: _notifierFocused,
                              builder: (context, focused, _) {
                                return AnimatedContainer(
                                  duration: const Duration(milliseconds: 400),
                                  height: focused
                                      ? constraints.maxHeight * pizzaSize.factor
                                      : constraints.maxHeight *
                                              pizzaSize.factor -
                                          10,
                                  child: Stack(
                                    children: [
                                      DecoratedBox(
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              boxShadow: [
                                                BoxShadow(
                                                    blurRadius: 15.0,
                                                    color: Colors.black26,
                                                    offset: Offset(0.0, 5.0),
                                                    spreadRadius: 5.0),
                                              ]),
                                          child:
                                              Image.asset('assets/dish.png')),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child:
                                            Image.asset('assets/pizza-1.png'),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                        ValueListenableBuilder<Ingredient>(
                            valueListenable: bloc.notifierDeletedIngredient,
                            builder: (context, deletedIngredient, _) {
                              _animateDeletedIngredient(deletedIngredient);
                              return AnimatedBuilder(
                                  animation: _animationController,
                                  builder: (context, _) {
                                    return _buildIngredientWidget(
                                        deletedIngredient);
                                  });
                            }),
                      ],
                    ),
                  );
                });
          });
        }),
      ),
      const SizedBox(
        height: 5,
      ),
      ValueListenableBuilder<int>(
          valueListenable: bloc.notifierTotal,
          builder: (context, totalValue, _) {
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                      position: animation.drive(Tween<Offset>(
                        begin: Offset(0.0, 0.0),
                        end: Offset(0.0, animation.value),
                      )),
                      child: child),
                );
              },
              child: Text(
                '\$$totalValue',
                key: UniqueKey(),
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown),
              ),
            );
          }),
      const SizedBox(
        height: 15,
      ),
      ValueListenableBuilder<_PizzaSizeState>(
          valueListenable: _notifierPizzaSize,
          builder: (context, pizzaSize, _) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PizzaSizeButton(
                  text: 'S',
                  onTap: () {
                    _updatePizzaSize(_PizzaSizeValue.s);
                  },
                  selected: pizzaSize.value == _PizzaSizeValue.s,
                ),
                PizzaSizeButton(
                  text: 'M',
                  onTap: () {
                    _updatePizzaSize(_PizzaSizeValue.m);
                  },
                  selected: pizzaSize.value == _PizzaSizeValue.m,
                ),
                PizzaSizeButton(
                  text: 'L',
                  onTap: () {
                    _updatePizzaSize(_PizzaSizeValue.l);
                  },
                  selected: pizzaSize.value == _PizzaSizeValue.l,
                ),
              ],
            );
          }),
    ]);
  }

  Future<void> _animateDeletedIngredient(Ingredient deletedIngredient) async {
    if (deletedIngredient != null) {
      await _animationController.reverse(from: 1.0);
      PizzaOrderProvider.of(context).refreshDeletedIngredient();
    }
  }

  void _updatePizzaSize(_PizzaSizeValue value) {
    _notifierPizzaSize.value = _PizzaSizeState(value);
    _animationRotationController.forward(from: 0.0);
  }
}
