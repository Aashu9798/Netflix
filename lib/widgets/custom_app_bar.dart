import 'package:flutter/material.dart';
import 'dart:ui';

class CustomAppBar extends StatelessWidget {
  final double scrollOffset;
  final VoidCallback? onProfileTap;

  const CustomAppBar({
    Key? key,
    required this.scrollOffset,
    this.onProfileTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double opacity = (scrollOffset / 200).clamp(0.0, 1.0);
    
    return Container(
      height: 100,
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: opacity * 10,
            sigmaY: opacity * 10,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(opacity * 0.7),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Netflix Logo
                  const Text(
                    'NETFLIX',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                  
                  // Profile Icon
                  GestureDetector(
                    onTap: onProfileTap,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.red,
                      ),
                      child: const Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
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