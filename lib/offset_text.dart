import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OffsetText extends StatefulWidget {
  @override
  _OffsetTextState createState() => _OffsetTextState();
}

class _OffsetTextState extends State<OffsetText>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: Duration(seconds: 10), vsync: this);
    _animationController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return RepaintBoundary(
            child: CustomPaint(
          painter: _TextPainter(TextSpan(
              text: "字体滚动来一波什么东西哈哈哈☂",
              style: TextStyle(fontSize: 100, color: Colors.black,fontWeight: FontWeight.bold))),
          size: MediaQuery.of(context).size.flipped,
        ));
      },
    );
  }

  @override
  void dispose() {
    if (_animationController != null) {
      _animationController.dispose();
    }
    super.dispose();
  }
}

class _TextPainter extends CustomPainter {
  final TextSpan textSpan;

  _TextPainter(this.textSpan);

  TextPainter _textPainter;

  double offsetX;

  @override
  void paint(Canvas canvas, Size size) {
    if (_textPainter == null) {
      _textPainter = TextPainter(text: textSpan);
      _textPainter.textDirection = TextDirection.ltr;
      _textPainter.layout();
    }
    if (offsetX == null) {
      offsetX = size.width;
    }
    var textWidth = _textPainter.width;
    if (offsetX <= -textWidth) {
      offsetX = size.width;
    } else {
      offsetX -= 1;
    }
    canvas.clipRect(Rect.fromLTRB(0, 0, size.width, size.height));
    _textPainter.paint(canvas, Offset(offsetX, 0));
  }

  @override
  bool shouldRepaint(_TextPainter oldDelegate) {
    if (oldDelegate.textSpan == textSpan) {
      _textPainter = oldDelegate._textPainter;
      offsetX = oldDelegate.offsetX;
    }
    return true;
  }
}
