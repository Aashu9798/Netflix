import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'dart:ui';
import 'models/movie.dart';
import 'widgets/custom_app_bar.dart';
import 'widgets/hero_poster.dart';
import 'widgets/movie_row.dart';
import 'widgets/glass_notification.dart';

class NetflixHomeScreen extends StatefulWidget {
  const NetflixHomeScreen({Key? key}) : super(key: key);

  @override
  State<NetflixHomeScreen> createState() => _NetflixHomeScreenState();
}

class _NetflixHomeScreenState extends State<NetflixHomeScreen>
    with TickerProviderStateMixin {
  late ScrollController _scrollController;
  late AnimationController _backgroundColorController;
  late Animation<Color?> _backgroundColorAnimation;
  
  double _scrollOffset = 0;
  bool _showNotification = false;
  String _notificationTitle = '';
  String _notificationImageUrl = '';

  @override
  void initState() {
    super.initState();

    _backgroundColorController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    // temporary until palette loads
    _backgroundColorAnimation = ColorTween(
      begin: Colors.black,
      end: Colors.black,
    ).animate(_backgroundColorController);

    _scrollController = ScrollController()..addListener(_onScroll);

    _extractDominantColor();
  }

  Future<void> _extractDominantColor() async {
    final palette = await PaletteGenerator.fromImageProvider(
      NetworkImage(Movie.featuredMovie.backdropUrl),
      size: const Size(200, 100),
      maximumColorCount: 20,
    );
    final color = palette.dominantColor?.color ?? Colors.black;

    setState(() {
      Movie.featuredMovie.dominantColor = color;
      _backgroundColorAnimation = ColorTween(
        begin: color,
        end: Colors.black,
      ).animate(
        CurvedAnimation(
          parent: _backgroundColorController,
          curve: Curves.easeInOut,
        ),
      );
    });
  }

  void _onScroll() {
    setState(() => _scrollOffset = _scrollController.offset);
    final progress = (_scrollOffset / 400).clamp(0.0, 1.0);
    _backgroundColorController.animateTo(progress);
  }

  void _showMyListNotification(String title, String imageUrl) {
    setState(() {
      _showNotification = true;
      _notificationTitle = title;
      _notificationImageUrl = imageUrl;
    });
  }

  void _dismissNotification() {
    setState(() {
      _showNotification = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double buttonOpacity = (1 - (_scrollOffset / 200)).clamp(0.0, 1.0);

    return AnimatedBuilder(
      animation: _backgroundColorAnimation,
      builder: (context, child) {
        return Scaffold(
          backgroundColor: _backgroundColorAnimation.value,          body: Stack(
            children: [
              // Main Content
              CustomScrollView(
                controller: _scrollController,
                slivers: [
                  // Hero Section
                  SliverToBoxAdapter(
                    child: Stack(
                      children: [
                        HeroPoster(
                          movie: Movie.featuredMovie,
                          scrollOffset: _scrollOffset,
                          onMyListTap: () => _showMyListNotification(
                            Movie.featuredMovie.title,
                            Movie.featuredMovie.imageUrl,
                          ),
                          onPlayTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Playing movie...')),
                            );
                          },
                          onInfoTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Movie info...')),
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  // Navigation Buttons (Shows, Movies, Categories)
                  SliverToBoxAdapter(
                    child: AnimatedOpacity(
                      opacity: buttonOpacity,
                      duration: const Duration(milliseconds: 200),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.2),
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  _buildNavButton('TV Shows', true),
                                  _buildNavButton('Movies', false),
                                  _buildNavButton('Categories', false),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Movie Rows
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        MovieRow(
                          title: 'Trending Now',
                          movies: Movie.trendingMovies,
                          onSeeAllTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('See all trending...')),
                            );
                          },
                        ),
                        const SizedBox(height: 30),
                        MovieRow(
                          title: 'Popular on Netflix',
                          movies: Movie.popularMovies,
                          onSeeAllTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('See all popular...')),
                            );
                          },
                        ),
                        const SizedBox(height: 30),
                        MovieRow(
                          title: 'My List',
                          movies: [Movie.featuredMovie, ...Movie.trendingMovies],
                        ),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ],
              ),

              // Custom App Bar
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: CustomAppBar(
                  scrollOffset: _scrollOffset,
                  onProfileTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Profile tapped')),
                    );
                  },
                ),
              ),

              // Glass Notification
              if (_showNotification)
                GlassNotification(
                  title: _notificationTitle,
                  imageUrl: _notificationImageUrl,
                  onDismiss: _dismissNotification,
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildNavButton(String title, bool isSelected) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$title selected')),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected 
              ? Colors.white.withOpacity(0.2) 
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.white70,
            fontSize: 16,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _backgroundColorController.dispose();
    super.dispose();
  }
}