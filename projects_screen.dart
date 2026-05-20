import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/chat_message.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  static final _projects = [
    Project(
      id: '1',
      emoji: '🇯🇵',
      name: 'Tokyo Trip',
      subtitle: '12 chats · Updated 2h ago',
      chatCount: 12,
      gradientColors: [0xFF8B5CF6, 0xFFEC4899],
    ),
    Project(
      id: '2',
      emoji: '💼',
      name: 'Work',
      subtitle: '8 chats · Yesterday',
      chatCount: 8,
      gradientColors: [0xFF3B82F6, 0xFF6366F1],
    ),
    Project(
      id: '3',
      emoji: '📚',
      name: 'Study: Calculus',
      subtitle: '23 chats · 3 days ago',
      chatCount: 23,
      gradientColors: [0xFF10B981, 0xFF14B8A6],
    ),
    Project(
      id: '4',
      emoji: '✍️',
      name: 'Novel Draft',
      subtitle: '5 chats · Last week',
      chatCount: 5,
      gradientColors: [0xFFEC4899, 0xFFF43F5E],
    ),
  ];

  static final _memories = [
    MemoryItem(emoji: '🌱', text: 'Vegetarian diet'),
    MemoryItem(emoji: '📍', text: 'Based in Jakarta'),
    MemoryItem(emoji: '💻', text: 'Software engineer'),
    MemoryItem(emoji: '🎯', text: 'Learning Japanese · N4'),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _buildHeader(),
          _buildSearchBar(),
          const SizedBox(height: 20),
          _buildProjectCards(),
          const SizedBox(height: 24),
          _sectionHeader('🧠 AI Memory', 'Manage'),
          const SizedBox(height: 12),
          _buildMemorySection(),
          const SizedBox(height: 24),
          _sectionHeader('💬 Recent Chats', 'See all'),
          const SizedBox(height: 12),
          ..._recentChats(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Projects',
            style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: AppColors.accentPurple.withOpacity(0.4),
                  blurRadius: 12,
                ),
              ],
            ),
            child: const Row(
              children: [
                Icon(Icons.add_rounded, size: 18, color: Colors.white),
                SizedBox(width: 4),
                Text('New',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.surfaceElevated,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Row(
          children: [
            Icon(Icons.search_rounded,
                size: 20, color: AppColors.textSecondary),
            SizedBox(width: 12),
            Text(
              'Search across all chats and projects...',
              style: TextStyle(color: AppColors.textMuted, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectCards() {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: _projects.length,
        itemBuilder: (context, i) {
          final p = _projects[i];
          return Container(
            width: 160,
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surfaceElevated,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Color(p.gradientColors.first).withOpacity(0.4),
                width: 1.5,
              ),
              gradient: LinearGradient(
                colors: [
                  Color(p.gradientColors.first).withOpacity(0.15),
                  Color(p.gradientColors.last).withOpacity(0.05),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(p.emoji, style: const TextStyle(fontSize: 28)),
                const Spacer(),
                Text(
                  p.name,
                  style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                      fontSize: 15),
                ),
                const SizedBox(height: 4),
                Text(
                  p.subtitle,
                  style: const TextStyle(
                      color: AppColors.textSecondary, fontSize: 11),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _sectionHeader(String title, String action) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                  fontSize: 17)),
          Text(action,
              style: const TextStyle(
                  color: AppColors.accentPurple,
                  fontWeight: FontWeight.w600,
                  fontSize: 13)),
        ],
      ),
    );
  }

  Widget _buildMemorySection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surfaceElevated,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _memories
              .map((m) => Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: AppColors.accentPurple.withOpacity(0.3)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(m.emoji, style: const TextStyle(fontSize: 14)),
                        const SizedBox(width: 6),
                        Text(m.text,
                            style: const TextStyle(
                                color: AppColors.textPrimary, fontSize: 12)),
                        const SizedBox(width: 6),
                        const Icon(Icons.close,
                            size: 14, color: AppColors.textMuted),
                      ],
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }

  List<Widget> _recentChats() {
    final items = [
      ('Tokyo Day 2 itinerary', 'Continue planning for Shibuya...', '2h'),
      ('Resume bullet points review', 'Updated the engineering section', '5h'),
      ('Explain neural networks', 'Like I\'m 5 years old', '1d'),
    ];
    return items
        .map((item) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.surfaceElevated,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: const BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.chat_bubble_rounded,
                          size: 16, color: Colors.white),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.$1,
                              style: const TextStyle(
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14)),
                          const SizedBox(height: 2),
                          Text(item.$2,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: AppColors.textSecondary, fontSize: 12)),
                        ],
                      ),
                    ),
                    Text(item.$3,
                        style: const TextStyle(
                            color: AppColors.textMuted, fontSize: 11)),
                  ],
                ),
              ),
            ))
        .toList();
  }
}
