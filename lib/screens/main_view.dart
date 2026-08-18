// Maki Dice (Linux)
// github.com/andrewmichaelpowell

import 'dart:math';
import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/dice_button.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  String _diceNumber = '';
  String _diceType = '';
  int _editSide = 1; // 1 = editing diceNumber, 2 = editing diceType
  int _resetInput = 1; // 1 = next digit should clear prior roll first
  String _resultString = '';
  int _resultValue = 0;
  final _random = Random();

  Future<void> _revealAfterDelay(String value) async {
    setState(() => _resultString = '');
    await Future.delayed(const Duration(milliseconds: 100));
    if (!mounted) return;
    setState(() => _resultString = value);
  }

  void _quickRoll(int sides) {
    _resultValue = 1 + _random.nextInt(sides);
    _editSide = 1;
    _resetInput = 1;
    _diceNumber = '1';
    _diceType = sides.toString();
    _revealAfterDelay(_resultValue.toString());
  }

  void _clear() {
    setState(() {
      _editSide = 1;
      _diceNumber = '';
      _diceType = '';
      _resultString = '';
    });
  }

  void _setRight(int digit) {
    if (_diceType.length < 3) {
      setState(() {
        _diceType += digit.toString();
        _resultString = '${_diceNumber}d$_diceType';
      });
    }
  }

  void _setLeft(int digit) {
    if (_resetInput == 1) {
      _diceNumber = '';
      _diceType = '';
      _resetInput = 0;
    }
    if (_diceNumber.length < 3) {
      setState(() {
        _diceNumber += digit.toString();
        _resultString = _diceNumber;
      });
    }
  }

  void _appendDigit(int digit) {
    if (_editSide == 1) _setLeft(digit);
    if (_editSide == 2) _setRight(digit);
  }

  void _zero() {
    if (_editSide == 1 && _diceNumber != '' && _resetInput == 0) _appendDigit(0);
    if (_editSide == 2 && _diceType != '' && _resetInput == 0) _appendDigit(0);
  }

  void _pressD() {
    if (_editSide == 1 && _resetInput == 0) {
      setState(() {
        _editSide = 2;
        _resultString = '${_diceNumber}d';
      });
    }
  }

  void _roll() {
    if (_diceNumber != '' && _diceType != '') {
      final n = int.parse(_diceNumber);
      final sides = int.parse(_diceType);
      var total = 0;
      for (var i = 0; i < n; i++) {
        total += 1 + _random.nextInt(sides);
      }
      _resultValue = total;
      _revealAfterDelay(_resultValue.toString());
      _editSide = 1;
      _resetInput = 1;
    }
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
              const Spacer(),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  _resultString,
                  style: TextStyle(fontSize: 34, color: labelColor),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 32),
                child: Column(
                  children: [
                    Row(children: [
                      Expanded(child: Padding(padding: const EdgeInsets.all(4), child: DiceButton(label: '1d4', tint: secondaryBg, contentColor: labelColor, onPressed: () => _quickRoll(4)))),
                      Expanded(child: Padding(padding: const EdgeInsets.all(4), child: DiceButton(label: '1d6', tint: secondaryBg, contentColor: labelColor, onPressed: () => _quickRoll(6)))),
                      Expanded(child: Padding(padding: const EdgeInsets.all(4), child: DiceButton(label: '1d8', tint: secondaryBg, contentColor: labelColor, onPressed: () => _quickRoll(8)))),
                    ]),
                    Row(children: [
                      Expanded(child: Padding(padding: const EdgeInsets.all(4), child: DiceButton(label: '1d10', tint: secondaryBg, contentColor: labelColor, onPressed: () => _quickRoll(10)))),
                      Expanded(child: Padding(padding: const EdgeInsets.all(4), child: DiceButton(label: '1d12', tint: secondaryBg, contentColor: labelColor, onPressed: () => _quickRoll(12)))),
                      Expanded(child: Padding(padding: const EdgeInsets.all(4), child: DiceButton(label: '1d20', tint: secondaryBg, contentColor: labelColor, onPressed: () => _quickRoll(20)))),
                    ]),
                    Row(children: [
                      Expanded(child: Padding(padding: const EdgeInsets.all(4), child: DiceButton(label: 'Clear', tint: AppColors.orange, onPressed: _clear))),
                      Expanded(child: Padding(padding: const EdgeInsets.all(4), child: DiceButton(label: '1d100', tint: secondaryBg, contentColor: labelColor, onPressed: () => _quickRoll(100)))),
                      Expanded(child: Padding(padding: const EdgeInsets.all(4), child: DiceButton(label: 'D10', tint: AppColors.teal, onPressed: () => Navigator.of(context).pushNamed('/d10')))),
                    ]),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 32),
                child: Column(
                  children: [
                    Row(children: [
                      Expanded(child: Padding(padding: const EdgeInsets.all(4), child: DiceButton(label: '1', tint: secondaryBg, contentColor: labelColor, onPressed: () => _appendDigit(1)))),
                      Expanded(child: Padding(padding: const EdgeInsets.all(4), child: DiceButton(label: '2', tint: secondaryBg, contentColor: labelColor, onPressed: () => _appendDigit(2)))),
                      Expanded(child: Padding(padding: const EdgeInsets.all(4), child: DiceButton(label: '3', tint: secondaryBg, contentColor: labelColor, onPressed: () => _appendDigit(3)))),
                    ]),
                    Row(children: [
                      Expanded(child: Padding(padding: const EdgeInsets.all(4), child: DiceButton(label: '4', tint: secondaryBg, contentColor: labelColor, onPressed: () => _appendDigit(4)))),
                      Expanded(child: Padding(padding: const EdgeInsets.all(4), child: DiceButton(label: '5', tint: secondaryBg, contentColor: labelColor, onPressed: () => _appendDigit(5)))),
                      Expanded(child: Padding(padding: const EdgeInsets.all(4), child: DiceButton(label: '6', tint: secondaryBg, contentColor: labelColor, onPressed: () => _appendDigit(6)))),
                    ]),
                    Row(children: [
                      Expanded(child: Padding(padding: const EdgeInsets.all(4), child: DiceButton(label: '7', tint: secondaryBg, contentColor: labelColor, onPressed: () => _appendDigit(7)))),
                      Expanded(child: Padding(padding: const EdgeInsets.all(4), child: DiceButton(label: '8', tint: secondaryBg, contentColor: labelColor, onPressed: () => _appendDigit(8)))),
                      Expanded(child: Padding(padding: const EdgeInsets.all(4), child: DiceButton(label: '9', tint: secondaryBg, contentColor: labelColor, onPressed: () => _appendDigit(9)))),
                    ]),
                    Row(children: [
                      Expanded(child: Padding(padding: const EdgeInsets.all(4), child: DiceButton(label: 'd', tint: AppColors.orange, onPressed: _pressD))),
                      Expanded(child: Padding(padding: const EdgeInsets.all(4), child: DiceButton(label: '0', tint: secondaryBg, contentColor: labelColor, onPressed: _zero))),
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
