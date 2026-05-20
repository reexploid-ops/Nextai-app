import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../theme/app_theme.dart';

class VoiceScreen extends StatefulWidget {
  const VoiceScreen({super.key});

  @override
  State<VoiceScreen> createState() => _VoiceScreenState();
}

class _VoiceScreenState extends State<VoiceScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          _buildHeader(),
          const SizedBox(height: 24),
          _buildPersonaChip(),
          Expanded(child: _buildOrb()),
          _buildTranscription(),
          const SizedBox(height: 24),
          _buildControls(),
          const SizedBox(height: 16),
          _buildBottomChips(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
            onPressed: () {},
          ),
          const Expanded(
            child: Center(
              child: Text(
                'Voice Conversation',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined, size: 22),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildPersonaChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surfaceElevated,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('🐘  ', style: TextStyle(fontSize: 14)),
          Text('Aria · Friendly',
              style: TextStyle(color: AppColors.textPrimary, fontSize: 13)),
          SizedBox(width: 6),
          Icon(Icons.expand_more, size: 16, color: AppColors.textSecondary),
        ],
      ),
    );
  }

  Widget _buildOrb() {
    return Center(
      child: AnimatedBuilder(
        animation: _pulseController,
        builder: (context, _) {
          final t = _pulseController.value;
          final pulse = 1 + 0.05 * math.sin(t * 2 * math.pi);
          return Stack(
            alignment: Alignment.center,
            children: [
              // Outer pulsing rings
              for (int i = 2; i >= 0; i--)
                Transform.scale(
                  scale: pulse + i * 0.15,
                  child: Container(
                    width: 220,
                    height: 220,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.accentPurple
                            .withOpacity(0.15 - i * 0.04),
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
              // Main orb
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const RadialGradient(
                    colors: [Color(0xFFEC4899), Color(0xFF8B5CF6)],
                    radius: 0.9,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.accentPurple.withOpacity(0.6),
                      blurRadius: 60,
                      spreadRadius: 8,
                    ),
                  ],
                ),
              ),
              // Listening label
              Positioned(
                bottom: 20,
                child: Text(
                  'Listening...',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTranscription() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'You: Hey, what\'s the weather like...',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
          ),
          SizedBox(height: 8),
          Text(
            'Aria: It\'s currently sunny and 24°C in...',
            style: TextStyle(color: AppColors.textPrimary, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _controlButton(Icons.mic_off_rounded, AppColors.surfaceElevated, 56),
        _controlButton(Icons.call_end_rounded, const Color(0xFFEF4444), 72,
            iconColor: Colors.white),
        _controlButton(
            Icons.keyboard_rounded, AppColors.surfaceElevated, 56),
      ],
    );
  }

  Widget _controlButton(IconData icon, Color bg, double size,
      {Color iconColor = AppColors.textPrimary}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: bg,
        shape: BoxShape.circle,
        boxShadow: bg == const Color(0xFFEF4444)
            ? [
                BoxShadow(
                  color: bg.withOpacity(0.5),
                  blurRadius: 16,
                  spreadRadius: 2,
                ),
              ]
            : null,
      ),
      child: Icon(icon, color: iconColor, size: size * 0.4),
    );
  }

  Widget _buildBottomChips() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _chip('🎧 Earphones · HQ'),
        const SizedBox(width: 8),
        _chip('🇺🇸 English · Auto'),
      ],
    );
  }

  Widget _chip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.surfaceElevated,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        text,
        style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
      ),
    );
  }
}
