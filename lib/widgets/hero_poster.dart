// hero_poster.dart

import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:palette_generator/palette_generator.dart';
import '../models/movie.dart';

class HeroPoster extends StatefulWidget {
  final Movie movie;
  final double scrollOffset;
  final VoidCallback onMyListTap;
  final VoidCallback onPlayTap;
  final VoidCallback onInfoTap;

  const HeroPoster({
    Key? key,
    required this.movie,
    required this.scrollOffset,
    required this.onMyListTap,
    required this.onPlayTap,
    required this.onInfoTap,
  }) : super(key: key);

  @override
  _HeroPosterState createState() => _HeroPosterState();
}

class _HeroPosterState extends State<HeroPoster> {
  Color _dominant = Colors.black;

  @override
  void initState() {
    super.initState();
    _extractDominantColor();
  }

  Future<void> _extractDominantColor() async {
    final palette = await PaletteGenerator.fromImageProvider(
      NetworkImage(widget.movie.imageUrl),
      size: const Size(200, 100),
    );
    setState(() {
      _dominant = palette.dominantColor?.color ?? Colors.black;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    final width = screen.width * 0.9;
    final height = screen.height * 0.6;  // slight increase
    final buttonOpacity = (1 - widget.scrollOffset / 300).clamp(0.0, 1.0);

    return Padding(
      padding: const EdgeInsets.only(top: 100),  // below app bar
      child: Center(
        child: SizedBox(
          width: width,
          height: height,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  widget.movie.imageUrl,
                  fit: BoxFit.cover,
                  width: width,
                  height: height,
                  errorBuilder: (_, __, ___) => Container(color: _dominant),
                ),
              ),
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          _dominant.withOpacity(0.8)
                        ],
                        stops: const [0.5, 1.0],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 60,
                left: 20,
                right: 20,
                child: Column(
                  children: [
                    Text(
                      widget.movie.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.movie.genres.join(' • '),
                      style:
                      const TextStyle(color: Colors.white70, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    AnimatedOpacity(
                      opacity: buttonOpacity,
                      duration: const Duration(milliseconds: 200),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton.icon(
                            onPressed: widget.onPlayTap,
                            icon: const Icon(Icons.play_arrow),
                            label: const Text('Play'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: widget.onMyListTap,
                            icon: const Icon(Icons.add),
                            label: const Text('My List'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white54,
                              foregroundColor: Colors.white,
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: widget.onInfoTap,
                            icon: const Icon(Icons.info_outline),
                            label: const Text('Info'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white54,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
