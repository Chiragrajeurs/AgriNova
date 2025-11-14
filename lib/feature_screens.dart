// lib/feature_screens.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'firebase_auth_service.dart';

// small helpers + Root + many placeholder screens (7 groups -> 14 features)

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});
  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> with TickerProviderStateMixin {
  int _index = 0;
  late final PageController _pc;
  final List<Widget> _pages = const [CombinedHomePage(), InsightsPage(), DetectorPage(), ChatPage(), ProfilePage()];

  @override
  void initState() {
    super.initState();
    _pc = PageController(initialPage: 0);
  }

  void _onNav(int i) {
    setState(() => _index = i);
    _pc.jumpToPage(i);
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('AgroVision AI', style: GoogleFonts.poppins(fontWeight: FontWeight.w700, color: Colors.white)),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none, color: Colors.white))],
      ),
      body: Stack(children: [
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
              child: PageView(controller: _pc, physics: const NeverScrollableScrollPhysics(), children: _pages),
            ),
          ),
        ),
        SafeArea(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12), child: Row(children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Welcome back,', style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 13)),
            const SizedBox(height: 4),
            Text('Chirag 👋', style: GoogleFonts.poppins(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w800)),
          ]),
          const Spacer(),
          GestureDetector(onTap: () {}, child: Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.white.withOpacity(0.12), borderRadius: BorderRadius.circular(12)), child: CircleAvatar(radius: 18, backgroundColor: Colors.white, child: Icon(Icons.person, color: primary)))),
        ]))),
      ]),
      floatingActionButton: FloatingActionButton.extended(onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Voice assistant coming soon'))), backgroundColor: Colors.white, icon: Icon(Icons.mic, color: primary), label: Text('Ask Nova', style: TextStyle(color: primary, fontWeight: FontWeight.w700))),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        color: Colors.white,
        child: SizedBox(height: 66, child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          _navItem(Icons.home, 'Home', 0),
          _navItem(Icons.insights, 'Insights', 1),
          const SizedBox(width: 48),
          _navItem(Icons.camera_alt, 'Detect', 2),
          _navItem(Icons.chat_bubble_outline, 'Chat', 3),
        ])),
      ),
    );
  }

  Widget _navItem(IconData icon, String label, int idx) {
    final active = idx == _index;
    final color = active ? AgroVisionAIApp.primaryGreen : Colors.grey[600];
    return InkWell(onTap: () => _onNav(idx), child: Column(mainAxisSize: MainAxisSize.min, children: [const SizedBox(height: 8), Icon(icon, color: color), const SizedBox(height: 4), Text(label, style: TextStyle(fontSize: 12, color: color))]));
  }
}

// ---------------- Combined Home
class CombinedHomePage extends StatelessWidget {
  const CombinedHomePage({super.key});
  @override
  Widget build(BuildContext context) {
    final primary = AgroVisionAIApp.primaryGreen;
    return SafeArea(child: SingleChildScrollView(padding: const EdgeInsets.fromLTRB(18, 18, 18, 24), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Expanded(child: StatGlassCard(title: 'Soil Health', value: 'Good', subtitle: 'N:28 P:12 K:30', icon: Icons.grass, accent: primary)),
        const SizedBox(width: 12),
        Expanded(child: StatGlassCard(title: 'Weather', value: 'Cloudy', subtitle: '21°C • Rain 40%', icon: Icons.cloud, accent: Colors.blueAccent)),
      ]),
      const SizedBox(height: 16),
      PromoWide(title: 'AI Soil Analysis', subtitle: 'Upload soil report or image → fertilizer plan', accent1: primary, accent2: AgroVisionAIApp.darkGreen, icon: Icons.analytics),
      const SizedBox(height: 18),
      Text('Pest Hotspots', style: Theme.of(context).textTheme.titleMedium),
      const SizedBox(height: 8),
      const MapPreviewCard(),
      const SizedBox(height: 16),
      Text('Tool Categories', style: Theme.of(context).textTheme.titleMedium),
      const SizedBox(height: 10),

      // Group examples (2 tiles per group)
      FeatureGroupFancy(title: 'Crop Monitoring', subtitle: 'Pest & yield', icon: Icons.agriculture, items: [
        FeatureItem('Pest Prediction', Icons.bug_report_outlined, () {}),
        FeatureItem('Yield Prediction', Icons.show_chart_rounded, () {}),
      ]),
      FeatureGroupFancy(title: 'Disease Management', subtitle: 'Detect & recommend', icon: Icons.healing, items: [
        FeatureItem('Disease Detector', Icons.camera_alt, () {}),
        FeatureItem('Crop Recommendation', Icons.support, () {}),
      ]),
      FeatureGroupFancy(title: 'Soil & Nutrient', subtitle: 'Micronutrients & soil health', icon: Icons.biotech, items: [
        FeatureItem('Micronutrient', Icons.biotech_rounded, () {}),
        FeatureItem('Soil Health', Icons.thermostat, () {}),
      ]),
      FeatureGroupFancy(title: 'Soil Tools', subtitle: 'Planner & lab', icon: Icons.science, items: [
        FeatureItem('Fertiliser Planner', Icons.science_outlined, () {}),
        FeatureItem('Micronutrient Lab', Icons.upload_file, () {}),
      ]),
      FeatureGroupFancy(title: 'Market & Finance', subtitle: 'Credits & prices', icon: Icons.account_balance_wallet, items: [
        FeatureItem('Agro Credits', Icons.account_balance_wallet, () {}),
        FeatureItem('Market Prices', Icons.stacked_bar_chart, () {}),
      ]),
      FeatureGroupFancy(title: 'Community', subtitle: 'Learn & ask', icon: Icons.forum, items: [
        FeatureItem('Community Learning', Icons.forum_outlined, () {}),
        FeatureItem('Ask Expert', Icons.support_agent, () {}),
      ]),
      FeatureGroupFancy(title: 'Tools & Alerts', subtitle: 'AR & explainability', icon: Icons.build_circle, items: [
        FeatureItem('AR View', Icons.view_in_ar_outlined, () {}),
        FeatureItem('Explainability', Icons.psychology_alt_outlined, () {}),
      ]),

      const SizedBox(height: 16),
    ])));
  }
}

// small reusable widgets (StatGlassCard, PromoWide, MapPreviewCard, FeatureGroupFancy, etc.)
class GlassCard extends StatelessWidget {
  final Widget child;
  const GlassCard({required this.child, super.key});
  @override
  Widget build(BuildContext context) {
    return Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0,6))]), child: child);
  }
}

class StatGlassCard extends StatelessWidget {
  final String title, value, subtitle;
  final IconData icon; final Color accent;
  const StatGlassCard({required this.title, required this.value, required this.subtitle, required this.icon, required this.accent, super.key});
  @override
  Widget build(BuildContext context) {
    return GlassCard(child: Row(children: [Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: accent.withOpacity(0.12), shape: BoxShape.circle), child: Icon(icon, color: accent)), const SizedBox(width: 12), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.black54)), const SizedBox(height: 6), Text(value, style: const TextStyle(fontWeight: FontWeight.w800)), const SizedBox(height: 4), Text(subtitle, style: const TextStyle(color: Colors.black45, fontSize: 12))]))]));
  }
}

class PromoWide extends StatelessWidget {
  final String title, subtitle; final Color accent1, accent2; final IconData icon;
  const PromoWide({required this.title, required this.subtitle, required this.accent1, required this.accent2, required this.icon, super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('AI Soil Analysis coming soon'))),
      child: Container(height: 110, decoration: BoxDecoration(gradient: LinearGradient(colors: [accent1, accent2]), borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: accent1.withOpacity(0.22), blurRadius: 12, offset: const Offset(0,6))]), padding: const EdgeInsets.all(12), child: Row(children: [Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [Text(title, style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w800)), const SizedBox(height: 6), Text(subtitle, style: const TextStyle(color: Colors.white70))])), CircleAvatar(radius: 26, backgroundColor: Colors.white24, child: Icon(icon, color: Colors.white, size: 28))]));
  }
}

class MapPreviewCard extends StatelessWidget {
  const MapPreviewCard({super.key});
  @override
  Widget build(BuildContext context) {
    final primary = AgroVisionAIApp.primaryGreen;
    return Container(height: 160, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 12, offset: const Offset(0,6))]), padding: const EdgeInsets.all(12), child: Column(children: [Expanded(child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.green.shade50), child: const Center(child: Text('Map preview • Pest heatmap placeholder', style: TextStyle(color: Colors.black54))))), const SizedBox(height: 10), Row(children: [Icon(Icons.place, color: primary), const SizedBox(width: 8), const Expanded(child: Text('Hotspots last 7 days')), ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: primary), child: const Text('View Map'))])]));
  }
}

class FeatureGroupFancy extends StatelessWidget {
  final String title, subtitle; final IconData icon; final List<FeatureItem> items;
  const FeatureGroupFancy({super.key, required this.title, required this.subtitle, required this.icon, required this.items});
  @override
  Widget build(BuildContext context) {
    final primary = AgroVisionAIApp.primaryGreen;
    final itemsSafe = List<FeatureItem>.from(items);
    if (itemsSafe.length == 1) itemsSafe.add(FeatureItem('', Icons.circle_outlined, () {}));
    return Container(margin: const EdgeInsets.only(bottom: 14), padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: const Color(0xFFF7F8F2), borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 6)]), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Row(children: [Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(8)), child: Icon(icon, color: primary)), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: primary)), const SizedBox(height: 4), Text(subtitle, style: const TextStyle(color: Colors.black54, fontSize: 12))])]), const SizedBox(height: 12), Row(children: [_tile(context, itemsSafe[0]), const SizedBox(width: 10), _tile(context, itemsSafe[1])])]));
  }

  Widget _tile(BuildContext context, FeatureItem item) {
    final primary = AgroVisionAIApp.primaryGreen;
    return Expanded(child: GestureDetector(onTap: item.onTap, child: Container(height: 100, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.green.withOpacity(0.06)), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8, offset: const Offset(0,6))]), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Container(height: 48, width: 48, decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(10)), child: Icon(item.icon, color: primary, size: 26)), const SizedBox(height: 8), Text(item.title, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black87, fontSize: 13))]))));
  }
}

class FeatureItem {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  FeatureItem(this.title, this.icon, this.onTap);
}

// ---------------- other pages: Insights, Detector, Chat, Profile ----------------

class InsightsPage extends StatelessWidget {
  const InsightsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Padding(padding: const EdgeInsets.all(16.0), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Insights', style: Theme.of(context).textTheme.titleLarge), const SizedBox(height: 12), GlassCard(child: SizedBox(height: 160, child: Center(child: Text('Yield trend chart placeholder', style: TextStyle(color: Colors.black54))))), const SizedBox(height: 12), Text('Recent Alerts', style: Theme.of(context).textTheme.titleMedium), const SizedBox(height: 8), Expanded(child: ListView(children: [ListTile(leading: Icon(Icons.warning, color: Colors.orange.shade700), title: const Text('Pest alert near Village X'), subtitle: const Text('2 hours ago')), ListTile(leading: Icon(Icons.water_drop, color: Colors.blue.shade700), title: const Text('Irrigation reminder for Field 2'), subtitle: const Text('in 1 day'))]))]));
  }
}

class DetectorPage extends StatelessWidget {
  const DetectorPage({super.key});
  @override
  Widget build(BuildContext context) {
    final primary = AgroVisionAIApp.primaryGreen;
    return SafeArea(child: Padding(padding: const EdgeInsets.all(16.0), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Detector', style: Theme.of(context).textTheme.titleLarge), const SizedBox(height: 12), GlassCard(child: Column(children: [const SizedBox(height: 8), Icon(Icons.camera_alt, size: 64, color: Colors.green), const SizedBox(height: 12), const Text('Take a photo or upload an image for disease & nutrient suggestions', textAlign: TextAlign.center, style: TextStyle(color: Colors.black54)), const SizedBox(height: 12), Row(mainAxisAlignment: MainAxisAlignment.center, children: [ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.camera), label: const Text('Camera')), const SizedBox(width: 12), OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.upload_file), label: const Text('Upload'))]), const SizedBox(height: 12)]) ), const SizedBox(height: 12), Expanded(child: Center(child: Text('Recent analyses will show here', style: TextStyle(color: Colors.black45))))])));
  }
}

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Column(children: [Padding(padding: const EdgeInsets.all(16.0), child: Row(children: [CircleAvatar(radius: 24, backgroundColor: Colors.green.shade50, child: Icon(Icons.agriculture, color: AgroVisionAIApp.primaryGreen)), const SizedBox(width: 12), Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [Text('Krishi Sakhi', style: TextStyle(fontWeight: FontWeight.w700)), Text('Your farming assistant', style: TextStyle(color: Colors.black54, fontSize: 12))]), const Spacer(), IconButton(onPressed: () {}, icon: const Icon(Icons.info_outline))])), const Divider(height: 1), Expanded(child: ListView(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16), children: const [ChatBubble(text: 'Hi! How can I help you today?', isMe: false), ChatBubble(text: 'My tomato leaves have spots — what to do?', isMe: true), ChatBubble(text: 'Looks like early blight. Remove affected leaves and apply recommended fungicide.', isMe: false)])), Padding(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12), child: Row(children: [Expanded(child: Container(padding: const EdgeInsets.symmetric(horizontal: 12), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8)]), child: const TextField(decoration: InputDecoration(border: InputBorder.none, hintText: 'Ask Krishi Sakhi...')))), const SizedBox(width: 8), FloatingActionButton(onPressed: () {}, mini: true, child: const Icon(Icons.send))]))]));
  }
}

class ChatBubble extends StatelessWidget {
  final String text; final bool isMe;
  const ChatBubble({required this.text, required this.isMe, super.key});
  @override
  Widget build(BuildContext context) {
    return Align(alignment: isMe ? Alignment.centerRight : Alignment.centerLeft, child: Container(margin: const EdgeInsets.symmetric(vertical: 6), padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10), constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75), decoration: BoxDecoration(color: isMe ? AgroVisionAIApp.primaryGreen : Colors.grey[200], borderRadius: BorderRadius.circular(12)), child: Text(text, style: TextStyle(color: isMe ? Colors.white : Colors.black87))));
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    final primary = AgroVisionAIApp.primaryGreen;
    return SafeArea(child: Padding(padding: const EdgeInsets.all(16.0), child: Column(children: [Row(children: [CircleAvatar(radius: 36, backgroundColor: Colors.green.shade100, child: Icon(Icons.person, size: 36, color: primary)), const SizedBox(width: 12), const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Chirag Raje Urs', style: TextStyle(fontWeight: FontWeight.w700)), Text('Farmer • Karnataka', style: TextStyle(color: Colors.black54, fontSize: 12))])]), const SizedBox(height: 18), GlassCard(child: ListTile(leading: Icon(Icons.language, color: primary), title: const Text('Language'), subtitle: const Text('Kannada, Hindi, English'))), const SizedBox(height: 8), GlassCard(child: ListTile(leading: Icon(Icons.history, color: primary), title: const Text('Activity'), subtitle: const Text('Recent analyses & chats'))), const SizedBox(height: 8), GlassCard(child: ListTile(leading: Icon(Icons.account_balance_wallet, color: primary), title: const Text('Agro Credits'), subtitle: const Text('Balance: ₹1,200'))), const SizedBox(height: 18), ElevatedButton.icon(onPressed: () async { await FirebaseAuthService.instance.signOut(); Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const Scaffold(body: Center(child: Text('Signed out. Please restart app.'))))); }, style: ElevatedButton.styleFrom(backgroundColor: primary), icon: const Icon(Icons.logout), label: const Text('Sign out'))])));
  }
}
