import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';

const Color backgroundPaintColor = Color(0xff31B768);

class NormalBackground extends StatelessWidget {
  final Widget? child;

  const NormalBackground({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _NormalBackgroundPainter(),
      child: child,
    );
  }
}

class _NormalBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height),
        Paint()..color = Colors.white);
    final smallArcRadius = size.width / 3.5;
    final bigArcRadius = size.width / 1.9;
    const dashSize = 5.0;
    const gapSize = 7.0;
    const smallSolidStrokeWidth = 6.0;
    const dashedSmallSolidStrokeWidth = 2.0;
    const bigSolidStrokeWidth = 12.0;

    final smallSolidArcPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = backgroundPaintColor.withOpacity(0.5)
      ..strokeWidth = smallSolidStrokeWidth;

    canvas.drawArc(
        Rect.fromCenter(
            center: Offset(size.width * 0.94, smallArcRadius / 4),
            width: smallArcRadius,
            height: smallArcRadius),
        0,
        360,
        false,
        smallSolidArcPaint);

    //
    final dashedSmallSolidArcPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.butt
      ..color = backgroundPaintColor.withOpacity(0.5)
      ..strokeWidth = dashedSmallSolidStrokeWidth;

    final dashedSmallSolidArcPath = Path()
      ..addArc(
          Rect.fromCenter(
              center: Offset(0, size.height - bigArcRadius * 0.80),
              width: smallArcRadius,
              height: smallArcRadius),
          0,
          360);
    canvas.drawPath(
        dashPath(dashedSmallSolidArcPath,
            dashArray: CircularIntervalList<double>([dashSize, gapSize])),
        dashedSmallSolidArcPaint);

    //
    final bigSolidArcPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.butt
      ..color = backgroundPaintColor.withOpacity(0.2)
      ..strokeWidth = bigSolidStrokeWidth;

    canvas.drawArc(
        Rect.fromCenter(
            center: Offset(bigArcRadius / 4, size.height - bigArcRadius / 4),
            width: bigArcRadius,
            height: bigArcRadius),
        0,
        360,
        false,
        bigSolidArcPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
