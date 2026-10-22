import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  bool _showContent = false;
  late final AnimationController _loadingController;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));

    _loadingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) setState(() => _showContent = true);
    });

    Future.delayed(const Duration(milliseconds: 2500), () {
      if (mounted) Navigator.pushReplacementNamed(context, '/');
    });
  }

  @override
  void dispose() {
    _loadingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A1628),
      body: Center(
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 600),
          opacity: _showContent ? 1.0 : 0.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/splash/splash_animation.json',
                width: 260,
                height: 260,
                fit: BoxFit.contain,
                repeat: true,
                errorBuilder: (_, __, ___) => const _FallbackLogo(),
              ),
              const SizedBox(height: 24),
              const Text(
                'OBD2 HUD SYSTEM',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF00CCFF),
                  letterSpacing: 4,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Kết nối • Theo dõi • An toàn',
                style: TextStyle(color: Color(0xFF8FA4BF), fontSize: 13, letterSpacing: 2),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: 140,
                child: AnimatedBuilder(
                  animation: _loadingController,
                  builder: (_, __) => LinearProgressIndicator(
                    value: _loadingController.value,
                    backgroundColor: const Color(0x1A00CCFF),
                    valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF00CCFF)),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Text('Đang khởi động...', style: TextStyle(color: Color(0xFF8FA4BF), fontSize: 11)),
            ],
          ),
        ),
      ),
    );
  }
}

class _FallbackLogo extends StatelessWidget {
  const _FallbackLogo();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(colors: [const Color(0xFF00CCFF).withValues(alpha: 0.2), Colors.transparent]),
      ),
      child: const Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(Icons.directions_car, size: 80, color: Color(0xFF00CCFF)),
        SizedBox(height: 12),
        Text('OBD2', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
      ]),
    );
  }
}
