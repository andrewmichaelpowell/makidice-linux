// Maki Dice (Linux)
// github.com/andrewmichaelpowell

import 'dart:math';
import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/dice_button.dart';

class D10View extends StatefulWidget {
  const D10View({super.key});

  @override
  State<D10View> createState() => _D10ViewState();
}

class _D10ViewState extends State<D10View> {
  String _diceString = '';
  int _diceValue = 0;
  String _difficultyString = '';
  int _difficultyValue = 0;
  int _selected = 1; // 1 = editing dice pool, 2 = editing difficulty
  String _successesString = '';
  int _successesValue = 0;
  final _random = Random();

  void _clear() {
    setState(() {
      _diceValue = 0;
      _difficultyValue = 0;
      _successesValue = 0;
      _diceString = '';
      _difficultyString = '';
      _successesString = '';
    });
  }

  void _addValueToSide(int value) {
    setState(() {
      if (_selected == 1) {
        _diceValue = value;
        _diceString = value.toString();
      } else if (_selected == 2) {
        _difficultyValue = value;
        _difficultyString = value.toString();
      }
    });
  }

  Future<void> _roll() async {
    if (_diceValue == 0 || _difficultyValue == 0) return;

    var successes = 0;
    for (var i = 0; i < _diceValue; i++) {
      final r = 1 + _random.nextInt(10); // 1-10 inclusive
      if (r == 1) {
        successes -= 1;
      } else if (r == 10) {
        successes += 2;
      } else if (r >= _difficultyValue) {
        successes += 1;
      }
    }
    _successesValue = successes;

    setState(() => _successesString = '');
    await Future.delayed(const Duration(milliseconds: 100));
    if (!mounted) return;
    setState(() => _successesString = _successesValue.toString());
  }

  Widget _backButton(BuildContext context) {
    final secondaryBg = secondaryBackgroundOf(context);
    final labelColor = labelColorOf(context);
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Material(
          color: secondaryBg,
          shape: const CircleBorder(),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: () => Navigator.of(context).pop(),
            child: SizedBox(
              width: 36,
              height: 36,
              child: Icon(Icons.chevron_left, color: labelColor, size: 22),
            ),
          ),
        ),
      ),
    );
  }

  Widget _labelRow(String name, String value, {Color? nameColor}) {
    final labelColor = labelColorOf(context);
    return Row(
      children: [
        Expanded(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(name, style: TextStyle(fontSize: 34, color: nameColor ?? labelColor)),
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              value,
              style: TextStyle(fontSize: 34, color: labelColor),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final secondaryBg = secondaryBackgroundOf(context);
    final labelColor = labelColorOf(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              _backButton(context),
              const Spacer(),
              _labelRow('Dice', _diceString, nameColor: _selected == 1 ? AppColors.teal : null),
              const SizedBox(height: 4),
              _labelRow('Difficulty', _difficultyString, nameColor: _selected == 2 ? AppColors.teal : null),
              const SizedBox(height: 4),
              _labelRow('Successes', _successesString),
              const SizedBox(height: 16),
              Row(children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: DiceButton(
                      label: 'Dice',
                      tint: _selected == 1 ? AppColors.teal : secondaryBg,
                      contentColor: _selected == 1 ? Colors.white : labelColor,
                      onPressed: () => setState(() => _selected = 1),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: DiceButton(
                      label: 'Difficulty',
                      tint: _selected == 2 ? AppColors.teal : secondaryBg,
                      contentColor: _selected == 2 ? Colors.white : labelColor,
                      onPressed: () => setState(() => _selected = 2),
                    ),
                  ),
                ),
              ]),
              Padding(
                padding: const EdgeInsets.only(top: 32, bottom: 32),
                child: Column(
                  children: [
                    Row(children: [
                      Expanded(child: Padding(padding: const EdgeInsets.all(4), child: DiceButton(label: '1', tint: secondaryBg, contentColor: labelColor, onPressed: () => _addValueToSide(1)))),
                      Expanded(child: Padding(padding: const EdgeInsets.all(4), child: DiceButton(label: '2', tint: secondaryBg, contentColor: labelColor, onPressed: () => _addValueToSide(2)))),
                      Expanded(child: Padding(padding: const EdgeInsets.all(4), child: DiceButton(label: '3', tint: secondaryBg, contentColor: labelColor, onPressed: () => _addValueToSide(3)))),
                    ]),
                    Row(children: [
                      Expanded(child: Padding(padding: const EdgeInsets.all(4), child: DiceButton(label: '4', tint: secondaryBg, contentColor: labelColor, onPressed: () => _addValueToSide(4)))),
                      Expanded(child: Padding(padding: const EdgeInsets.all(4), child: DiceButton(label: '5', tint: secondaryBg, contentColor: labelColor, onPressed: () => _addValueToSide(5)))),
                      Expanded(child: Padding(padding: const EdgeInsets.all(4), child: DiceButton(label: '6', tint: secondaryBg, contentColor: labelColor, onPressed: () => _addValueToSide(6)))),
                    ]),
                    Row(children: [
                      Expanded(child: Padding(padding: const EdgeInsets.all(4), child: DiceButton(label: '7', tint: secondaryBg, contentColor: labelColor, onPressed: () => _addValueToSide(7)))),
                      Expanded(child: Padding(padding: const EdgeInsets.all(4), child: DiceButton(label: '8', tint: secondaryBg, contentColor: labelColor, onPressed: () => _addValueToSide(8)))),
                      Expanded(child: Padding(padding: const EdgeInsets.all(4), child: DiceButton(label: '9', tint: secondaryBg, contentColor: labelColor, onPressed: () => _addValueToSide(9)))),
                    ]),
                    Row(children: [
                      Expanded(child: Padding(padding: const EdgeInsets.all(4), child: DiceButton(label: 'Clear', tint: AppColors.orange, onPressed: _clear))),
                      Expanded(child: Padding(padding: const EdgeInsets.all(4), child: DiceButton(label: '10', tint: secondaryBg, contentColor: labelColor, onPressed: () => _addValueToSide(10)))),
                      Expanded(child: Padding(padding: const EdgeInsets.all(4), child: DiceButton(label: 'Roll', tint: AppColors.orange, onPressed: _roll))),
                    ]),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
