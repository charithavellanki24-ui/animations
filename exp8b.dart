import 'package:flutter/material.dart';
import 'dart:math';

void main() {
runApp(const MyApp());
}

class MyApp extends StatelessWidget {
const MyApp({super.key});

@override
Widget build(BuildContext context) {
return const MaterialApp(
debugShowCheckedModeBanner: false,
home: CherryAnimation(),
);
}
}

class CherryAnimation extends StatefulWidget {
const CherryAnimation({super.key});

@override
State<CherryAnimation> createState() => _CherryAnimationState();
}

class _CherryAnimationState extends State<CherryAnimation>
with TickerProviderStateMixin {
final List<CherryData> cherries = [];

@override
void initState() {
super.initState();


cherries.add(
  CherryData(
    controller: AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(),
    x: 0,
    y: 0,
    size: 1,
  ),
);


}

void addCherry() {
if (cherries.length >= 15) return;


final random = Random();

final controller = AnimationController(
  vsync: this,
  duration: Duration(
    milliseconds: 2500 + random.nextInt(2000),
  ),
)..repeat();

setState(() {
  cherries.add(
    CherryData(
      controller: controller,
      x: random.nextDouble() * 2 - 1,
      y: random.nextDouble() * 2 - 1,
      size: 0.65 + random.nextDouble() * 0.45,
    ),
  );
});


}

@override
Widget build(BuildContext context) {
return Scaffold(
body: Container(
width: double.infinity,
height: double.infinity,
decoration: const BoxDecoration(
gradient: LinearGradient(
colors: [
Color(0xFFFCE4EC),
Color(0xFFE8D5F9),
Color(0xFFD8C4F1),
Color(0xFFF8D7E8),
],
begin: Alignment.topLeft,
end: Alignment.bottomRight,
),
),
child: Stack(
children: [
...cherries.map(
(cherry) {
return AnimatedBuilder(
animation: cherry.controller,
builder: (context, child) {
final value = cherry.controller.value;


                final moveX =
                    cherry.x * 110 * sin(value * 2 * pi);

                final moveY =
                    cherry.y * 110 * cos(value * 2 * pi);

                final rotation =
                    value * 2 * pi;

                return Center(
                  child: Transform.translate(
                    offset: Offset(moveX, moveY),
                    child: Transform.rotate(
                      angle: rotation,
                      child: Transform.scale(
                        scale: cherry.size,
                        child: GestureDetector(
                          onTap: addCherry,
                          child: const CherryFruit(),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),

        Positioned(
          bottom: 40,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 14,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.purple.withOpacity(0.2),
                    blurRadius: 15,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: const Text(
                '🍒 Touch the Cherry',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF9C27B0),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  ),
);


}

@override
void dispose() {
for (final cherry in cherries) {
cherry.controller.dispose();
}
super.dispose();
}
}

class CherryData {
final AnimationController controller;
final double x;
final double y;
final double size;

CherryData({
required this.controller,
required this.x,
required this.y,
required this.size,
});
}

class CherryFruit extends StatelessWidget {
const CherryFruit({super.key});

@override
Widget build(BuildContext context) {
return SizedBox(
width: 160,
height: 160,
child: Stack(
alignment: Alignment.center,
children: [
Positioned(
left: 22,
top: 62,
child: cherryBall(),
),
Positioned(
right: 22,
top: 62,
child: cherryBall(),
),
Positioned(
top: 8,
left: 68,
child: CustomPaint(
size: const Size(40, 70),
painter: StemPainter(),
),
),
Positioned(
top: 15,
right: 28,
child: Transform.rotate(
angle: -0.5,
child: Container(
width: 50,
height: 28,
decoration: BoxDecoration(
color: const Color(0xFF4CAF50),
borderRadius: BorderRadius.circular(30),
boxShadow: [
BoxShadow(
color: Colors.green.withOpacity(0.25),
blurRadius: 8,
),
],
),
),
),
),
],
),
);
}

Widget cherryBall() {
return Container(
width: 65,
height: 65,
decoration: BoxDecoration(
shape: BoxShape.circle,
gradient: const RadialGradient(
center: Alignment(-0.35, -0.4),
radius: 0.8,
colors: [
Color(0xFFFF8FA3),
Color(0xFFE91E63),
Color(0xFFAD1457),
Color(0xFF720026),
],
),
boxShadow: [
BoxShadow(
color: Colors.pink.withOpacity(0.45),
blurRadius: 18,
spreadRadius: 3,
),
],
),
child: const Align(
alignment: Alignment(-0.4, -0.45),
child: CircleAvatar(
radius: 8,
backgroundColor: Colors.white70,
),
),
);
}
}

class StemPainter extends CustomPainter {
@override
void paint(Canvas canvas, Size size) {
final paint = Paint()
..color = const Color(0xFF33691E)
..strokeWidth = 6
..style = PaintingStyle.stroke
..strokeCap = StrokeCap.round;


final path = Path();

path.moveTo(18, 65);
path.quadraticBezierTo(10, 30, 32, 5);

canvas.drawPath(path, paint);


}

@override
bool shouldRepaint(CustomPainter oldDelegate) {
return false;
}
}
