// Maki Dice (Linux)
// github.com/andrewmichaelpowell

import 'package:flutter/material.dart';
import '../theme.dart';

class PageChooser extends StatelessWidget {
  final int selectedIndex;
  final List<(String, Widget)> items;
  final ValueChanged<int> onSelect;

  const PageChooser({
    super.key,
    required this.selectedIndex,
    required this.items,
    required this.onSelect,
  });

  static const _itemWidth = 80.0;
  static const _itemHeight = 44.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: ShapeDecoration(
        color: secondaryBackgroundOf(context),
        shape: const StadiumBorder(),
      ),
      child: SizedBox(
        width: _itemWidth * items.length,
        height: _itemHeight,
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOutCubic,
              left: _itemWidth * selectedIndex,
              top: 0,
              width: _itemWidth,
              height: _itemHeight,
              child: const DecoratedBox(
                decoration: ShapeDecoration(
                  color: AppColors.orange,
                  shape: StadiumBorder(),
                ),
              ),
            ),
            Row(
              children: [
                for (var i = 0; i < items.length; i++)
                  Semantics(
                    label: items[i].$1,
                    selected: i == selectedIndex,
                    button: true,
                    excludeSemantics: true,
                    child: SizedBox(
                      width: _itemWidth,
                      height: _itemHeight,
                      child: Material(
                        type: MaterialType.transparency,
                        child: InkWell(
                          customBorder: const StadiumBorder(),
                          onTap: () => onSelect(i),
                          child: Center(child: items[i].$2),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SegmentChooser extends StatelessWidget {
  final int selectedIndex;
  final List<String> labels;
  final ValueChanged<int> onSelect;

  const SegmentChooser({
    super.key,
    required this.selectedIndex,
    required this.labels,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final labelColor = labelColorOf(context);
    return Container(
      height: 50,
      padding: const EdgeInsets.all(4),
      decoration: ShapeDecoration(
        color: secondaryBackgroundOf(context),
        shape: const StadiumBorder(),
      ),
      child: Stack(
        children: [
          AnimatedAlign(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOutCubic,
            alignment: Alignment(
              labels.length == 1 ? 0 : -1 + 2 * selectedIndex / (labels.length - 1),
              0,
            ),
            child: FractionallySizedBox(
              widthFactor: 1 / labels.length,
              heightFactor: 1,
              child: const DecoratedBox(
                decoration: ShapeDecoration(
                  color: AppColors.orange,
                  shape: StadiumBorder(),
                ),
              ),
            ),
          ),
          Row(
            children: [
              for (var i = 0; i < labels.length; i++)
                Expanded(
                  child: Semantics(
                    selected: i == selectedIndex,
                    button: true,
                    child: Material(
                      type: MaterialType.transparency,
                      child: InkWell(
                        customBorder: const StadiumBorder(),
                        onTap: () => onSelect(i),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                labels[i],
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: i == selectedIndex
                                      ? Colors.white
                                      : labelColor.withOpacity(0.6),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class DiceIcon extends StatelessWidget {
  final double size;
  final Color color;

  const DiceIcon({super.key, this.size = 26, required this.color});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(size: Size.square(size), painter: _DiceIconPainter(color));
  }
}

class _DiceIconPainter extends CustomPainter {
  final Color color;

  _DiceIconPainter(this.color);

  static const _origin = Offset(158, 159.2);
  static const _extent = 708.0;
  static const _triangles = <List<double>>[
    [308.88, 618.92, 512, 266.83, 715.12, 618.92],
    [481.53, 261.6, 288.41, 596.37, 210.27, 332.08],
    [813.73, 332.08, 735.59, 596.37, 542.47, 261.6],
    [512, 867.16, 316.53, 647.92, 707.47, 647.92],
    [291.79, 280.94, 497.5, 159.24, 497.5, 227.49],
    [526.5, 227.49, 526.5, 159.24, 732.21, 280.94],
    [206.25, 671.71, 206.25, 420.77, 267.35, 627.44],
    [756.65, 627.44, 817.75, 420.77, 817.75, 671.71],
    [437.38, 827.04, 219.05, 698.25, 281.93, 652.69],
    [742.07, 652.69, 804.95, 698.25, 586.62, 827.04],
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final scale = size.width / _extent;
    final path = Path();
    for (final t in _triangles) {
      Offset point(int i) =>
          (Offset(t[i], t[i + 1]) - _origin) * scale;
      path
        ..moveTo(point(0).dx, point(0).dy)
        ..lineTo(point(2).dx, point(2).dy)
        ..lineTo(point(4).dx, point(4).dy)
        ..close();
    }
    canvas.drawPath(path, Paint()..color = color);
  }

  @override
  bool shouldRepaint(_DiceIconPainter oldDelegate) => oldDelegate.color != color;
}
