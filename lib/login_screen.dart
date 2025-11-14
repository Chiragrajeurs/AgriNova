// lib/login_screen.dart
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'firebase_auth_service.dart';
import 'feature_screens.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with TickerProviderStateMixin {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final List<_Leaf> leaves = [];
  late final Timer _timer;
  final Random _rnd = Random();

  @override
  void initState() {
    super.initState();
    // create floating leaves with random positions
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final w = MediaQuery.of(context).size.width;
      final h = MediaQuery.of(context).size.height;
      for (int i = 0; i < 20; i++) {
        leaves.add(_Leaf(
          x: _rnd.nextDouble() * w,
          y: _rnd.nextDouble() * h,
          size: 8 + _rnd.nextDouble() * 18,
          speed: 0.2 + _rnd.nextDouble() * 0.8,
          tilt: (_rnd.nextDouble() - 0.5) * 0.6,
        ));
      }
      _timer = Timer.periodic(const Duration(milliseconds: 40), (_) {
        setState(() {
          for (final leaf in leaves) {
            leaf.y += leaf.speed;
            leaf.x += sin(leaf.y / 30 + leaf.tilt) * 0.6;
            if (leaf.y > h + 20) {
              leaf.y = -20;
              leaf.x = _rnd.nextDouble() * w;
            }
          }
        });
      });
    });
  }

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    _timer.cancel();
    super.dispose();
  }

  Future<void> _handleGoogleSignIn() async {
    try {
      final userCred = await FirebaseAuthService.instance.signInWithGoogle();
      if (userCred != null) {
        // Navigate into app
        if (!mounted) return;
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const RootScreen()));
      }
    } catch (e) {
      // Show a simple error
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sign-in failed: $e')));
    }
  }

  void _doLogin() {
    // placeholder local login
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const RootScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // floating leaves
          ...leaves.map((leaf) {
            return Positioned(
              left: leaf.x,
              top: leaf.y,
              child: Opacity(
                opacity: 0.35,
                child: Transform.rotate(
                  angle: leaf.tilt,
                  child: Icon(Icons.eco, size: leaf.size, color: AgroVisionAIApp.primaryGreen.withOpacity(0.6)),
                ),
              ),
            );
          }).toList(),

          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(color: primary.withOpacity(0.12), borderRadius: BorderRadius.circular(20)),
                    child: Icon(Icons.agriculture, size: 56, color: primary),
                  ).animate().scale(begin: 0.9, duration: 450.ms, curve: Curves.easeOutBack),
                  const SizedBox(height: 16),
                  Text('AgroVision AI', style: GoogleFonts.poppins(fontSize: 26, fontWeight: FontWeight.w800, color: AgroVisionAIApp.primaryGreen)),
                  const SizedBox(height: 6),
                  Text('Smart Farming Assistant', style: GoogleFonts.poppins(color: Colors.black54)),
                  const SizedBox(height: 20),

                  // normal fields
                  TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: 'Phone number',
                      filled: true,
                      fillColor: Colors.green.shade50,
                      prefixIcon: const Icon(Icons.phone),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                    ),
                  ).animate().fadeIn(duration: 300.ms),
                  const SizedBox(height: 12),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      filled: true,
                      fillColor: Colors.green.shade50,
                      prefixIcon: const Icon(Icons.lock_outline),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                    ),
                  ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.02),
                  const SizedBox(height: 16),

                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: AgroVisionAIApp.primaryGreen, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                      onPressed: _doLogin,
                      child: Text('Login', style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w700)),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // OR divider
                  Row(children: const [Expanded(child: Divider()), Padding(padding: EdgeInsets.symmetric(horizontal: 10), child: Text('or')), Expanded(child: Divider())]),
                  const SizedBox(height: 12),

                  // ===== Full-width Google button style C =====
                  GestureDetector(
                    onTap: _handleGoogleSignIn,
                    child: Container(
                      height: 52,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.shade300),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6, offset: const Offset(0,4))],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // left G icon box
                          Container(
                            width: 44,
                            height: 44,
                            margin: const EdgeInsets.only(right: 12),
                            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
                            child: Image.network('https://upload.wikimedia.org/wikipedia/commons/0/09/IOS_Google_icon.png', width: 20, height: 20),
                          ),
                          Expanded(
                            child: Text('Sign in with Google', textAlign: TextAlign.start, style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600)),
                          ),
                          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black54),
                          const SizedBox(width: 10),
                        ],
                      ),
                    ),
                  ).animate().fadeIn(duration: 400.ms),
                  const SizedBox(height: 14),

                  TextButton(onPressed: () {}, child: Text('Forgot password?', style: GoogleFonts.poppins(color: Colors.black54))),
                ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Leaf {
  double x;
  double y;
  double size;
  double speed;
  double tilt;
  _Leaf({required this.x, required this.y, required this.size, required this.speed, required this.tilt});
}
