import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:animated_background/animated_background.dart';
import 'package:lottie/lottie.dart';
import 'package:propuesta_noviazgo/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyAnimatedBackground());
}

class MyAnimatedBackground extends StatefulWidget {
  const MyAnimatedBackground({super.key});

  @override
  State<MyAnimatedBackground> createState() => _MyAnimatedBackgroundState();
}

class _MyAnimatedBackgroundState extends State<MyAnimatedBackground>
    with SingleTickerProviderStateMixin {
  ParticleOptions particles = ParticleOptions(
    baseColor: Colors.red[100] ?? Colors.red,
    spawnOpacity: 0.0,
    opacityChangeRate: 0.25,
    minOpacity: 0.1,
    maxOpacity: 0.4,
    particleCount: 70,
    spawnMaxRadius: 15.0,
    spawnMaxSpeed: 100.0,
    spawnMinSpeed: 30,
    spawnMinRadius: 7.0,
  );

  double _redButtonWidth = 200;
  double _greenButtonWidth = 200;
  double _greenButtonTextSize = 16.0;
  double _redButtonTextSize = 12.0;
  bool no = true;
  bool yes = true;
  int _clickCount = 0;
  final List<String> _convincingTexts = [
    "¿No?",
    "¿Estás segura?",
    "¿De verdad segura?",
    "¿Estás realmente, realmente segura?",
    "¿Estás segura segurita?",
    "Solo piénsalo...",
    "Dale, di que si",
    "Si dices que no, estaré triste.",
    "Estaré muy triste",
    "Estaré muy, muy triste.",
    "Estaré muy, muy triste, pero muy triste.",
    "Ok, está bien, dejaré de preguntar.",
    "Es broma, por favor di que sí.",
    "Piensa de nuevo...",
    "Estaré muy, muy, muy, muy triste.",
    "Estás rompiendo mi corazón...",
    "¿Segura? 7w7"
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: AnimatedBackground(
          vsync: this,
          behaviour: RandomParticleBehaviour(options: particles),
          child: Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: yes
                    ? <Widget>[
                        Lottie.asset(
                          'love.json',
                          width: 200,
                          height: 200,
                        ),
                        const Text(
                          '¿Me permitirías ser tu novio y comenzar una historia juntos?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Flexible(
                              child: SizedBox(
                                width: _greenButtonWidth,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      yes = false;
                                    });
                                  },
                                  child: Text(
                                    'Si',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: _greenButtonTextSize,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Flexible(
                              child: SizedBox(
                                width: _redButtonWidth,
                                child: Visibility(
                                  visible: no,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        if (_clickCount <
                                            _convincingTexts.length - 1) {
                                          _clickCount++;
                                          _redButtonWidth -= 5;
                                          _greenButtonWidth += 36;
                                          _redButtonTextSize -= 0.1;
                                          _greenButtonTextSize += 5;
                                        } else {
                                          no = false;
                                        }
                                      });
                                    },
                                    child: Text(
                                      _convincingTexts[_clickCount],
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: _redButtonTextSize,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ]
                    : <Widget>[
                        Image.asset('kiss.gif', width: 200, height: 200),
                        const Text(
                          'Siiiiiiiii!!!! ',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
