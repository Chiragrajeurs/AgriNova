// lib/main.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

void main() {
  runApp(const AgriNovaApp());
}

class AgriNovaApp extends StatelessWidget {
  const AgriNovaApp({super.key});

  // Brand colors
  static const Color primaryGreen = Color(0xFF2E7D32);
  static const Color darkGreen = Color(0xFF1B5E20);
  static const Color appBackground = Color(0xFFF6FBF6);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AgriNova',
      theme: ThemeData(
        scaffoldBackgroundColor: appBackground,
        colorScheme: ColorScheme.fromSeed(seedColor: primaryGreen),
        textTheme: GoogleFonts.poppinsTextTheme(),
        useMaterial3: true,
      ),
      // Start with splash screen
      home: SplashScreen(),
      routes: {
        "/home": (context) => const RootScreen(),
      },
    );
  }
}

/// ------------------------------------
/// SplashScreen
/// ------------------------------------
class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 900));
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();

    // navigate after delay to LoginScreen (no const used)
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => LoginScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primary = AgriNovaApp.primaryGreen;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2E8B57), Color(0xFF1B5E20)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: FadeTransition(
            opacity: _fade,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: Icon(Icons.agriculture, size: 70, color: primary),
                ),
                const SizedBox(height: 18),
                Text("AgriNova",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                    )),
                const SizedBox(height: 8),
                Text("Smart Farming Assistant",
                    style: GoogleFonts.poppins(color: Colors.white70)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// ------------------------------------
/// LoginScreen (animated, Google button included)
/// ------------------------------------
class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late final AnimationController _ctrl;
  late final Animation<double> _fadeIn;

  @override
  void initState() {
    super.initState();
    _ctrl =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 700));
    _fadeIn = CurvedAnimation(parent: _ctrl, curve: Curves.easeIn);
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color primary = AgriNovaApp.primaryGreen;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeIn,
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 26),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Logo with scale animation
                  Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      color: primary.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: Icon(Icons.agriculture, size: 70, color: primary),
                  ).animate().scale(duration: 600.ms, curve: Curves.easeOutBack),

                  const SizedBox(height: 18),

                  Text("AgriNova",
                          style: GoogleFonts.poppins(
                              fontSize: 32,
                              fontWeight: FontWeight.w800,
                              color: primary))
                      .animate()
                      .fadeIn(duration: 600.ms)
                      .slideY(begin: 0.2),

                  const SizedBox(height: 6),

                  Text("Smart Farming Assistant",
                          style: GoogleFonts.poppins(color: Colors.black54, fontSize: 14))
                      .animate()
                      .fadeIn(duration: 600.ms)
                      .slideY(begin: 0.25),

                  const SizedBox(height: 28),

                  // Phone
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Phone number",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade800)),
                  ).animate().fadeIn().slideX(begin: -0.2),

                  const SizedBox(height: 8),

                  TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: "Enter phone",
                      filled: true,
                      fillColor: Colors.green.shade50,
                      prefixIcon: const Icon(Icons.phone),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                    ),
                  ).animate().fadeIn(duration: 500.ms).slideX(begin: -0.25),

                  const SizedBox(height: 14),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Password",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade800)),
                  ).animate().fadeIn().slideX(begin: -0.2),

                  const SizedBox(height: 8),

                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Enter password",
                      filled: true,
                      fillColor: Colors.green.shade50,
                      prefixIcon: const Icon(Icons.lock_outline),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                    ),
                  ).animate().fadeIn(duration: 500.ms).slideX(begin: -0.25),

                  const SizedBox(height: 20),

                  // Login button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primary,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                      onPressed: () {
                        // Simple local "login" that moves to RootScreen
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const RootScreen()),
                        );
                      },
                      child: Text("Login", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white)),
                    ),
                  ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.25),

                  const SizedBox(height: 14),

                  // divider
                  Row(children: const [Expanded(child: Divider()), Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: Text("or")), Expanded(child: Divider())]),

                  const SizedBox(height: 14),

                  // Google sign-in UI only
                  GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Google Sign-In coming soon")));
                    },
                    child: Container(
                      height: 52,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: Colors.grey.shade300),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 8, offset: const Offset(0,3))],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // using web image as icon - acceptable for mock UI
                          Image.network("https://upload.wikimedia.org/wikipedia/commons/0/09/IOS_Google_icon.png", height: 24),
                          const SizedBox(width: 12),
                          Text("Continue with Google", style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 15)),
                        ],
                      ),
                    ),
                  ).animate().fadeIn(duration: 700.ms).slideY(begin: 0.3).scale(begin: const Offset(0.98, 0.98)),

                  const SizedBox(height: 12),

                  TextButton(onPressed: () {}, child: Text("Forgot password?", style: GoogleFonts.poppins(color: Colors.black54))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// ------------------------------------
/// RootScreen (Home + bottom nav)
/// ------------------------------------
class RootScreen extends StatefulWidget {
  const RootScreen({super.key});
  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> with TickerProviderStateMixin {
  int _index = 0;
  late final PageController _pageController;

  final List<Widget> _pages = const [
    CombinedHomePage(),
    InsightsPage(),
    DetectorPage(),
    ChatPage(),
    ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  void _onNav(int i) {
    setState(() => _index = i);
    _pageController.jumpToPage(i);
  }

  @override
  Widget build(BuildContext context) {
    final primary = AgriNovaApp.primaryGreen;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('AgriNova', style: GoogleFonts.poppins(fontWeight: FontWeight.w700, color: Colors.white)),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none, color: Colors.white))],
      ),
      body: Stack(
        children: [
          Container(
            height: 240,
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [Color(0xFF2E8B57), Color(0xFF1B5E20)], begin: Alignment.topLeft, end: Alignment.bottomRight),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(36), bottomRight: Radius.circular(36)),
            ),
          ),
          Positioned.fill(
            top: 120,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
              child: Container(
                color: Colors.grey[50],
                child: PageView(controller: _pageController, physics: const NeverScrollableScrollPhysics(), children: _pages),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12),
              child: Row(children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Welcome back,', style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 13)),
                  const SizedBox(height: 4),
                  Text('Chirag 👋', style: GoogleFonts.poppins(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w800)),
                ]),
                const Spacer(),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.12), borderRadius: BorderRadius.circular(12)),
                    child: CircleAvatar(radius: 18, backgroundColor: Colors.white, child: Icon(Icons.person, color: primary)),
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Ask Nova (voice) — coming soon'))),
        backgroundColor: Colors.white,
        icon: Icon(Icons.mic, color: primary),
        label: Text('Ask Nova', style: TextStyle(color: primary, fontWeight: FontWeight.w700)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        color: Colors.white,
        child: SizedBox(
          height: 66,
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            _navItem(Icons.home, 'Home', 0),
            _navItem(Icons.insights, 'Insights', 1),
            const SizedBox(width: 48),
            _navItem(Icons.camera_alt, 'Detect', 2),
            _navItem(Icons.chat_bubble_outline, 'Chat', 3),
          ]),
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, String label, int idx) {
    final active = idx == _index;
    return InkWell(
      onTap: () => _onNav(idx),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8),
          Icon(icon, color: active ? AgriNovaApp.primaryGreen : Colors.grey[600]),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(fontSize: 12, color: active ? AgriNovaApp.primaryGreen : Colors.grey[600])),
        ],
      ),
    );
  }
}

/// ------------------------------------
/// CombinedHomePage (contains grouped UI)
/// ------------------------------------
class CombinedHomePage extends StatelessWidget {
  const CombinedHomePage({super.key});
  @override
  Widget build(BuildContext context) {
    final primary = AgriNovaApp.primaryGreen;
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Expanded(child: StatGlassCard(title: 'Soil Health', value: 'Good', subtitle: 'N:28 P:12 K:30', icon: Icons.grass, accent: primary)),
            const SizedBox(width: 12),
            Expanded(child: StatGlassCard(title: 'Weather', value: 'Cloudy', subtitle: '21°C • Rain 40%', icon: Icons.cloud, accent: Colors.blueAccent)),
          ]),
          const SizedBox(height: 16),

          PromoWide(
            title: 'AI Soil Analysis',
            subtitle: 'Upload soil report or image → get fertilizer & micronutrient plan',
            accent1: primary,
            accent2: AgriNovaApp.darkGreen,
            icon: Icons.analytics,
          ),

          const SizedBox(height: 18),

          Text('Pest Hotspots', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          const MapPreviewCard(),

          const SizedBox(height: 16),

          Text('Tool Categories', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 10),

          // Group 1 — Crop Monitoring
          FeatureGroup(
            title: "Crop Monitoring",
            items: [
              FeatureItem('Pest Prediction', Icons.bug_report_outlined, () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => const PestMapScreen()));
              }),
              FeatureItem('Yield Prediction', Icons.show_chart_rounded, () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => const YieldScreen()));
              }),
            ],
          ),
          // Second row in the same group: Disease Detector (we show two tiles per group - we can add second tile)
          FeatureGroup(
            title: "Crop Monitoring (cont.)",
            items: [
              FeatureItem('Disease Detector', Icons.camera_alt, () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => const DetectorPage()));
              }),
              FeatureItem('Crop Recommendation', Icons.agriculture, () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => PlaceholderScreen(title: 'Crop Recommendation')));
              }),
            ],
          ),

          // Group 2 — Soil & Nutrition
          FeatureGroup(
            title: "Soil & Nutrition",
            items: [
              FeatureItem('Micronutrient', Icons.biotech_rounded, () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => const MicronutrientScreen()));
              }),
              FeatureItem('Soil Health', Icons.thermostat, () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => PlaceholderScreen(title: 'Soil Health')));
              }),
            ],
          ),
          FeatureGroup(
            title: "Soil & Nutrition (cont.)",
            items: [
              FeatureItem('Fertilizer Planner', Icons.science, () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => PlaceholderScreen(title: 'Fertilizer Planner')));
              }),
              FeatureItem('Micronutrient Lab', Icons.biotech_outlined, () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => PlaceholderScreen(title: 'Micronutrient Lab')));
              }),
            ],
          ),

          // Group 3 — Market & Finance
          FeatureGroup(
            title: "Market & Finance",
            items: [
              FeatureItem('Agro Credits', Icons.account_balance_wallet, () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => PlaceholderScreen(title: 'Agro Credits')));
              }),
              FeatureItem('Market Prices', Icons.stacked_bar_chart, () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => PlaceholderScreen(title: 'Market Prices')));
              }),
            ],
          ),

          // Group 4 — Community
          FeatureGroup(
            title: "Community",
            items: [
              FeatureItem('Community Learning', Icons.forum, () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => PlaceholderScreen(title: 'Community Learning')));
              }),
              FeatureItem('Ask Experts', Icons.support_agent, () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => PlaceholderScreen(title: 'Ask Experts')));
              }),
            ],
          ),

          // Group 5 — Tools
          FeatureGroup(
            title: "Tools",
            items: [
              FeatureItem('AR View', Icons.view_in_ar_outlined, () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ARPlaceholderScreen()));
              }),
              FeatureItem('Explainability', Icons.psychology_alt_outlined, () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => PlaceholderScreen(title: 'Explainability')));
              }),
            ],
          ),

          const SizedBox(height: 18),
          // Secondary quick-action grid
          const FeatureGrid(),
          const SizedBox(height: 20),
        ]),
      ),
    );
  }
}

/// ---------------- Stat card ----------------
class StatGlassCard extends StatelessWidget {
  final String title, value, subtitle;
  final IconData icon;
  final Color accent;
  const StatGlassCard({required this.title, required this.value, required this.subtitle, required this.icon, required this.accent, super.key});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Row(children: [
        Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: accent.withOpacity(0.12), shape: BoxShape.circle), child: Icon(icon, color: accent)),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: const TextStyle(color: Colors.black54)),
          const SizedBox(height: 6),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 4),
          Text(subtitle, style: const TextStyle(color: Colors.black45, fontSize: 12)),
        ])),
      ]),
    );
  }
}

/// ---------------- PromoWide ----------------
class PromoWide extends StatelessWidget {
  final String title, subtitle;
  final Color accent1, accent2;
  final IconData icon;
  const PromoWide({required this.title, required this.subtitle, required this.accent1, required this.accent2, required this.icon, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('AI Soil Analysis coming soon'))),
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [accent1, accent2]),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: accent1.withOpacity(0.22), blurRadius: 12, offset: const Offset(0, 6))],
        ),
        padding: const EdgeInsets.all(14),
        child: Row(children: [
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w800)),
            const SizedBox(height: 8),
            Text(subtitle, style: const TextStyle(color: Colors.white70)),
          ])),
          CircleAvatar(radius: 30, backgroundColor: Colors.white24, child: Icon(icon, color: Colors.white, size: 30)),
        ]),
      ),
    );
  }
}

/// ---------------- MapPreviewCard ----------------
class MapPreviewCard extends StatelessWidget {
  const MapPreviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    final primary = AgriNovaApp.primaryGreen;
    return Container(
      height: 180,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 12, offset: const Offset(0,6))]),
      padding: const EdgeInsets.all(12),
      child: Column(children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.green.shade50),
            child: const Center(
              child: Text('Map preview • Pest heatmap placeholder', style: TextStyle(color: Colors.black54)),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(children: [
          Icon(Icons.place, color: primary),
          const SizedBox(width: 8),
          const Expanded(child: Text('Hotspots last 7 days')),
          ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: primary), child: const Text('View Map')),
        ])
      ]),
    );
  }
}

/// ---------------- Feature Grid (secondary) ----------------
class FeatureGrid extends StatelessWidget {
  const FeatureGrid({super.key});
  @override
  Widget build(BuildContext context) {
    final List<_Feature> items = [
      _Feature('Pest', Icons.bug_report_outlined, Colors.teal),
      _Feature('Yield', Icons.show_chart_rounded, Colors.orange),
      _Feature('Micronutrient', Icons.biotech_rounded, Colors.purple),
      _Feature('Alerts', Icons.notifications_active_outlined, Colors.redAccent),
      _Feature('AR', Icons.view_in_ar_outlined, Colors.indigo),
      _Feature('Explain', Icons.psychology_alt_outlined, Colors.brown),
    ];

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [Color(0xFFE9F7EF), Color(0xFFFFFFFF)], begin: Alignment.topCenter, end: Alignment.bottomCenter),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: items.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 0.78),
        itemBuilder: (context, i) {
          final it = items[i];
          return GestureDetector(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => PlaceholderScreen(title: it.title))),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white, boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.18), blurRadius: 8, offset: const Offset(2, 4))], border: Border.all(color: it.color.withOpacity(0.28), width: 2)),
                child: Icon(it.icon, size: 32, color: it.color),
              ),
              const SizedBox(height: 6),
              Text(it.title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.black87)),
            ]),
          );
        },
      ),
    );
  }
}

class _Feature {
  final String title;
  final IconData icon;
  final Color color;
  _Feature(this.title, this.icon, this.color);
}

/// ---------------- SmallCard ----------------
class SmallCard extends StatelessWidget {
  final String title, subtitle;
  final IconData icon;
  final Color color;
  const SmallCard({required this.title, required this.subtitle, required this.icon, required this.color, super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0,6))]),
      child: Row(children: [
        CircleAvatar(radius: 22, backgroundColor: color.withOpacity(0.12), child: Icon(icon, color: color)),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontWeight: FontWeight.w700)), const SizedBox(height: 4), Text(subtitle, style: const TextStyle(color: Colors.black54, fontSize: 12))]))
      ]),
    );
  }
}

/// ---------------- Insights Page ----------------
class InsightsPage extends StatelessWidget {
  const InsightsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Padding(padding: const EdgeInsets.all(16.0), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Insights', style: Theme.of(context).textTheme.titleLarge),
      const SizedBox(height: 12),
      GlassCard(child: SizedBox(height: 160, child: Center(child: Text('Yield trend chart placeholder', style: TextStyle(color: Colors.black54))))),
      const SizedBox(height: 12),
      Text('Recent Alerts', style: Theme.of(context).textTheme.titleMedium),
      const SizedBox(height: 8),
      Expanded(child: ListView(children: [
        ListTile(leading: Icon(Icons.warning, color: Colors.orange.shade700), title: const Text('Pest alert near Village X'), subtitle: const Text('2 hours ago')),
        ListTile(leading: Icon(Icons.water_drop, color: Colors.blue.shade700), title: const Text('Irrigation reminder for Field 2'), subtitle: const Text('in 1 day')),
      ])),
    ])));
  }
}

/// ---------------- Detector Page (main detector) ----------------
class DetectorPage extends StatelessWidget {
  const DetectorPage({super.key});
  @override
  Widget build(BuildContext context) {
    final primary = AgriNovaApp.primaryGreen;
    return SafeArea(child: Padding(padding: const EdgeInsets.all(16.0), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Detector', style: Theme.of(context).textTheme.titleLarge),
      const SizedBox(height: 12),
      GlassCard(child: Column(children: [
        const SizedBox(height: 8),
        Icon(Icons.camera_alt, size: 64, color: primary),
        const SizedBox(height: 12),
        const Text('Take a photo or upload an image for disease & nutrient suggestions', textAlign: TextAlign.center, style: TextStyle(color: Colors.black54)),
        const SizedBox(height: 12),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.camera), label: const Text('Camera')),
          const SizedBox(width: 12),
          OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.upload_file), label: const Text('Upload')),
        ]),
        const SizedBox(height: 12),
      ])),
      const SizedBox(height: 12),
      Expanded(child: Center(child: Text('Recent analyses will show here', style: TextStyle(color: Colors.black45)))),
    ])));
  }
}

/// ---------------- Chat Page ----------------
class ChatPage extends StatelessWidget {
  const ChatPage({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Column(children: [
      Padding(padding: const EdgeInsets.all(16.0), child: Row(children: [
        CircleAvatar(radius: 24, backgroundColor: Colors.green.shade50, child: Icon(Icons.agriculture, color: AgriNovaApp.primaryGreen)),
        const SizedBox(width: 12),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [Text('Krishi Sakhi', style: TextStyle(fontWeight: FontWeight.w700)), Text('Your farming assistant', style: TextStyle(color: Colors.black54, fontSize: 12))]),
        const Spacer(),
        IconButton(onPressed: () {}, icon: const Icon(Icons.info_outline)),
      ])),
      const Divider(height: 1),
      Expanded(child: ListView(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16), children: const [
        ChatBubble(text: 'Hi! How can I help you today?', isMe: false),
        ChatBubble(text: 'My tomato leaves have spots — what to do?', isMe: true),
        ChatBubble(text: 'Looks like early blight. Remove affected leaves and apply recommended fungicide.', isMe: false),
      ])),
      Padding(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12), child: Row(children: [
        Expanded(child: Container(padding: const EdgeInsets.symmetric(horizontal: 12), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8)]), child: const TextField(decoration: InputDecoration(border: InputBorder.none, hintText: 'Ask Krishi Sakhi...')))),
        const SizedBox(width: 8),
        FloatingActionButton(onPressed: () {}, mini: true, child: const Icon(Icons.send)),
      ])),
    ]));
  }
}

/// ---------------- Profile Page ----------------
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    final primary = AgriNovaApp.primaryGreen;
    return SafeArea(child: Padding(padding: const EdgeInsets.all(16.0), child: Column(children: [
      Row(children: [
        CircleAvatar(radius: 36, backgroundColor: Colors.green.shade100, child: Icon(Icons.person, size: 36, color: primary)),
        const SizedBox(width: 12),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [Text('Chirag Raje Urs', style: TextStyle(fontWeight: FontWeight.w700)), Text('Farmer • Karnataka', style: TextStyle(color: Colors.black54, fontSize: 12))]),
      ]),
      const SizedBox(height: 18),
      GlassCard(child: ListTile(leading: Icon(Icons.language, color: primary), title: const Text('Language'), subtitle: const Text('Kannada, Hindi, English'))),
      const SizedBox(height: 8),
      GlassCard(child: ListTile(leading: Icon(Icons.history, color: primary), title: const Text('Activity'), subtitle: const Text('Recent analyses & chats'))),
      const SizedBox(height: 8),
      GlassCard(child: ListTile(leading: Icon(Icons.account_balance_wallet, color: primary), title: const Text('Agro Credits'), subtitle: const Text('Balance: ₹1,200'))),
      const SizedBox(height: 18),
      ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.logout), label: const Text('Sign out'), style: ElevatedButton.styleFrom(backgroundColor: primary)),
    ])));
  }
}

/// ---------------- Pest Map Screen ----------------
class PestMapScreen extends StatelessWidget {
  const PestMapScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final primary = AgriNovaApp.primaryGreen;
    return Scaffold(
      appBar: AppBar(title: const Text('Pest Prediction Map'), backgroundColor: primary),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0,6))]),
              child: const Center(
                child: Text('Interactive map will be here (flutter_map / google_maps)', style: TextStyle(color: Colors.black54)),
              ),
            ),
          ),
          const SizedBox(height: 12),
          GlassCard(child: Column(children: [
            Row(children: [Icon(Icons.place, color: primary), const SizedBox(width: 8), const Expanded(child: Text('Hotspots near your area (last 7 days)'))]),
            const SizedBox(height: 10),
            Wrap(spacing: 8, children: [
              Chip(label: const Text('Locust (12)'), backgroundColor: Colors.orange.shade50),
              Chip(label: const Text('Leaf Miner (8)'), backgroundColor: Colors.brown.shade50),
              Chip(label: const Text('Stem Borer (4)'), backgroundColor: Colors.red.shade50),
            ]),
          ])),
        ]),
      ),
    );
  }
}

/// ---------------- Yield Screen ----------------
class YieldScreen extends StatelessWidget {
  const YieldScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final primary = AgriNovaApp.primaryGreen;
    return Scaffold(
      appBar: AppBar(title: const Text('Yield Prediction'), backgroundColor: primary),
      body: Padding(padding: const EdgeInsets.all(16.0), child: Column(children: [
        GlassCard(child: Column(children: [
          const Text('Enter crop details', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          TextField(decoration: InputDecoration(labelText: 'Crop', border: OutlineInputBorder())),
          const SizedBox(height: 8),
          TextField(decoration: InputDecoration(labelText: 'Area (ha)', border: OutlineInputBorder())),
          const SizedBox(height: 8),
          ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: primary), child: const Text('Predict')),
        ])),
        const SizedBox(height: 12),
        Expanded(child: Center(child: Text('Prediction result will appear here', style: TextStyle(color: Colors.black45)))),
      ])),
    );
  }
}

/// ---------------- Micronutrient Screen ----------------
class MicronutrientScreen extends StatelessWidget {
  const MicronutrientScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final primary = AgriNovaApp.primaryGreen;
    return Scaffold(
      appBar: AppBar(title: const Text('Micronutrient Detection'), backgroundColor: primary),
      body: Padding(padding: const EdgeInsets.all(16.0), child: Column(children: [
        GlassCard(child: Column(children: [
          const Text('Upload soil lab or leaf image', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [ElevatedButton(onPressed: () {}, child: const Text('Upload')), const SizedBox(width: 8), OutlinedButton(onPressed: () {}, child: const Text('Camera'))]),
        ])),
        const SizedBox(height: 12),
        Expanded(child: Center(child: Text('Micronutrient analysis results will appear here', style: TextStyle(color: Colors.black45)))),
      ])),
    );
  }
}

/// ---------------- AR Placeholder ----------------
class ARPlaceholderScreen extends StatelessWidget {
  const ARPlaceholderScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final primary = AgriNovaApp.primaryGreen;
    return Scaffold(
      appBar: AppBar(title: const Text('AR View'), backgroundColor: primary),
      body: Center(child: Padding(padding: const EdgeInsets.all(18.0), child: Column(mainAxisSize: MainAxisSize.min, children: const [
        Icon(Icons.view_in_ar, size: 80, color: Colors.grey),
        SizedBox(height: 12),
        Text('AR View will overlay disease markers on live camera', textAlign: TextAlign.center, style: TextStyle(color: Colors.black54)),
      ]))),
    );
  }
}

/// ---------------- Reusable Widgets ----------------
class GlassCard extends StatelessWidget {
  final Widget child;
  const GlassCard({required this.child, super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0,6))]),
      child: child,
    );
  }
}

class PlaceholderScreen extends StatelessWidget {
  final String title;
  const PlaceholderScreen({required this.title, super.key});
  @override
  Widget build(BuildContext context) {
    final primary = AgriNovaApp.primaryGreen;
    return Scaffold(appBar: AppBar(title: Text(title), backgroundColor: primary), body: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
      const Icon(Icons.construction, size: 80, color: Colors.grey),
      const SizedBox(height: 12),
      Text('$title is coming soon', style: const TextStyle(color: Colors.black54, fontSize: 16)),
    ])));
  }
}

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isMe;
  const ChatBubble({required this.text, required this.isMe, super.key});
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        decoration: BoxDecoration(color: isMe ? AgriNovaApp.primaryGreen : Colors.grey[200], borderRadius: BorderRadius.circular(12)),
        child: Text(text, style: TextStyle(color: isMe ? Colors.white : Colors.black87)),
      ),
    );
  }
}

/// ---------------- FeatureGroup widget (two tiles per group) ----------------
class FeatureGroup extends StatelessWidget {
  final String title;
  final List<FeatureItem> items;
  const FeatureGroup({super.key, required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    final primary = AgriNovaApp.primaryGreen;
    final rowItems = List<FeatureItem>.from(items);
    if (rowItems.length == 1) rowItems.add(FeatureItem('', Icons.circle_outlined, () {}));

    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8F2),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6)],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(8)), child: Icon(Icons.grid_view, color: primary)),
          const SizedBox(width: 10),
          Text(title, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: primary)),
        ]),
        const SizedBox(height: 14),
        Row(children: [
          _buildTile(context, rowItems[0]),
          const SizedBox(width: 12),
          _buildTile(context, rowItems[1]),
        ]),
      ]),
    );
  }

  Widget _buildTile(BuildContext context, FeatureItem item) {
    final primary = AgriNovaApp.primaryGreen;
    return Expanded(
      child: GestureDetector(
        onTap: item.onTap,
        child: Container(
          height: 110,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.green.withOpacity(0.06)),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8, offset: const Offset(0, 6))],
          ),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(height: 52, width: 52, decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(12)), child: Icon(item.icon, color: primary, size: 26)),
            const SizedBox(height: 10),
            Text(item.title, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black87)),
          ]),
        ),
      ),
    );
  }
}

class FeatureItem {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  FeatureItem(this.title, this.icon, this.onTap);
}
