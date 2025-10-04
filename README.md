# Netflix Home Screen Clone - Flutter

## Overview
This is a complete Netflix home screen clone built with Flutter, featuring:

- ✅ **Hero poster with dynamic background color** - Background changes from movie's dominant color to black on scroll
- ✅ **Glass effect animations** - Beautiful glassmorphism effects on UI elements
- ✅ **Scroll-based button animations** - Shows/Movies/Categories buttons fade out smoothly when scrolling
- ✅ **Add to My List notification** - Glass notification with movie image and title
- ✅ **Smooth transitions** - All animations are smooth and responsive
- ✅ **Netflix-accurate UI** - Pixel-perfect recreation of Netflix's design

## Project Structure
```
lib/
├── main.dart                    # App entry point
├── netflix_home_screen.dart     # Main home screen
├── movie.dart                   # Movie model with sample data
└── widgets/
    ├── custom_app_bar.dart      # Animated app bar
    ├── hero_poster.dart         # Featured movie section
    ├── movie_row.dart           # Horizontal movie lists
    └── glass_notification.dart  # Glass notification widget
```

## Features Implemented

### 1. Hero Poster Section
- Dynamic background color that transitions from movie's dominant color to black
- Featured movie with title, genres, and action buttons
- Play button and My List functionality
- Smooth gradient overlays

### 2. Glass Effect Navigation
- Three navigation buttons (TV Shows, Movies, Categories)
- Glassmorphism effect with blur and transparency
- Buttons fade out smoothly when scrolling down

### 3. Glass Notification System
- Appears when user adds movie to "My List"
- Shows movie poster and title
- Slides in from top with elastic animation
- Auto-dismisses after 3 seconds
- Manual dismiss with close button

### 4. Scroll Animations
- Background color transitions from hero color to black
- App bar becomes more opaque with blur effect
- Navigation buttons fade out based on scroll position
- Smooth performance with proper animation controllers

### 5. Movie Rows
- Horizontal scrolling movie lists
- "Trending Now", "Popular on Netflix", "My List" sections
- Proper error handling for image loading

## How to Run

1. **Clone the repository**
   ```bash
   git clone https://github.com/Aashu9798/Netflix.git
   cd Netflix
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

## Key Technical Implementation

### Background Color Animation
```dart
// Smooth transition from hero color to black
_backgroundColorAnimation = ColorTween(
  begin: Movie.featuredMovie.dominantColor,
  end: Colors.black,
).animate(CurvedAnimation(
  parent: _backgroundColorController,
  curve: Curves.easeInOut,
));
```

### Glass Effect
```dart
// Glassmorphism with backdrop filter
ClipRRect(
  borderRadius: BorderRadius.circular(16),
  child: BackdropFilter(
    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
        ),
      ),
      // ... content
    ),
  ),
)
```

### Scroll-based Opacity
```dart
// Buttons fade out on scroll
final double buttonOpacity = (1 - (scrollOffset / 200)).clamp(0.0, 1.0);
AnimatedOpacity(
  opacity: buttonOpacity,
  duration: const Duration(milliseconds: 200),
  child: // ... navigation buttons
)
```

## Customization

### Adding Your Own Movies
Edit the `movie.dart` file to add your own movie data:

```dart
static final Movie myMovie = Movie(
  id: 'custom',
  title: 'Your Movie Title',
  imageUrl: 'https://your-image-url.jpg',
  backdropUrl: 'https://your-backdrop-url.jpg',
  description: 'Movie description...',
  rating: 8.5,
  year: 2024,
  genres: ['Action', 'Drama'],
  dominantColor: Color(0xFF1A1A2E), // Extracted from poster
);
```

### Changing Colors
Modify the dominant colors in the movie models to match your content's color scheme.

## Performance Notes
- Uses proper animation controllers with dispose methods
- Optimized scroll listener for smooth performance
- Efficient image loading with error handling
- Minimal rebuilds with targeted setState calls

## Next Steps
To make this production-ready, consider adding:
- Real API integration (TMDB, Netflix API)
- Video player integration
- Search functionality
- User authentication
- Offline caching
- More detailed movie screens

---
