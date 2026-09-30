import 'package:flutter/material.dart';

void main() {
runApp(const MyApp());
}

class MyApp extends StatelessWidget {
const MyApp({super.key});

@override
Widget build(BuildContext context) {
return const MaterialApp(
debugShowCheckedModeBanner: false,
home: NameAnimation(),
);
}
}

class NameAnimation extends StatefulWidget {
const NameAnimation({super.key});

@override
State<NameAnimation> createState() => _NameAnimationState();
}

class _NameAnimationState extends State<NameAnimation>
with SingleTickerProviderStateMixin {
late AnimationController controller;

final String name = "Sai Charitha";

@override
void initState() {
super.initState();


controller = AnimationController(
  vsync: this,
  duration: const Duration(seconds: 2),
)..repeat();


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
Color(0xFF6A11CB),
Color(0xFF2575FC),
Color(0xFFFF4ECD),
],
begin: Alignment.topLeft,
end: Alignment.bottomRight,
),
),
child: Center(
child: AnimatedBuilder(
animation: controller,
builder: (context, child) {
return Wrap(
alignment: WrapAlignment.center,
children: List.generate(
name.length,
(index) {
if (name[index] == ' ') {
return const SizedBox(width: 14);
}


                double progress =
                    (controller.value + index * 0.08) % 1.0;

                double wave =
                    (progress < 0.5)
                        ? progress * 2
                        : (1 - progress) * 2;

                double scale =
                    0.75 + (wave * 0.65);

                double moveUp =
                    wave * 35;

                double rotate =
                    (wave - 0.5) * 0.25;

                return Transform.translate(
                  offset: Offset(0, -moveUp),
                  child: Transform.rotate(
                    angle: rotate,
                    child: Transform.scale(
                      scale: scale,
                      child: Text(
                        name[index],
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          letterSpacing: 1.5,
                          shadows: [
                            Shadow(
                              color: Colors.white.withOpacity(0.9),
                              blurRadius: 8,
                            ),
                            Shadow(
                              color: Colors.pinkAccent.withOpacity(0.9),
                              blurRadius: 20,
                            ),
                            Shadow(
                              color: Colors.blueAccent.withOpacity(0.8),
                              blurRadius: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    ),
  ),
);


}

@override
void dispose() {
controller.dispose();
super.dispose();
}
}
