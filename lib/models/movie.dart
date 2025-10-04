import 'dart:ui';

class Movie {
  final String id;
  final String title;
  final String imageUrl;
  final String backdropUrl;
  final String description;
  final double rating;
  final int year;
  final List<String> genres;
  final Color dominantColor;

  Movie({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.backdropUrl,
    required this.description,
    required this.rating,
    required this.year,
    required this.genres,
    required this.dominantColor,
  });

  static final List<Movie> trendingMovies = [
    Movie(
      id: '1',
      title: 'Stranger Things',
      imageUrl: 'https://image.tmdb.org/t/p/w500/49WJfeN0moxb9IPfGn8AIqMGskD.jpg',
      backdropUrl: 'https://image.tmdb.org/t/p/original/56v2KjBlU4XaOv9rVYEQypROD7P.jpg',
      description: 'In 1980s Indiana, a group of young friends witness supernatural forces.',
      rating: 8.7,
      year: 2016,
      genres: ['Drama', 'Fantasy', 'Horror'],
      dominantColor: Color(0xFF8B1538),
    ),
    Movie(
      id: '2',
      title: 'The Witcher',
      imageUrl: 'https://image.tmdb.org/t/p/w500/7vjaCdMw15FEbXyLQTVa04URsPm.jpg',
      backdropUrl: 'https://image.tmdb.org/t/p/original/wmq8AIfzazXA5Yom0CL3DKjqZbg.jpg',
      description: 'Geralt of Rivia, a solitary monster hunter, struggles to find his place.',
      rating: 8.2,
      year: 2019,
      genres: ['Action', 'Adventure', 'Drama'],
      dominantColor: Color(0xFF2C1810),
    ),
  ];

  static final List<Movie> popularMovies = [
    Movie(
      id: '3',
      title: 'The Crown',
      imageUrl: 'https://wallpaperaccess.com/full/1902880.jpg',
      backdropUrl: 'https://image.tmdb.org/t/p/original/7SYS3VlcWHD7EwZqhx9LTblpGRZ.jpg',
      description: 'Follows the political rivalries and romance of Queen Elizabeth II.',
      rating: 8.6,
      year: 2016,
      genres: ['Biography', 'Drama', 'History'],
      dominantColor: Color(0xFF2E4A2E),
    ),
    Movie(
      id: '4',
      title: 'Money Heist',
      imageUrl: 'https://image.tmdb.org/t/p/w500/reEMJA1uzscCbkpeRJeTT2bjqUp.jpg',
      backdropUrl: 'https://image.tmdb.org/t/p/original/3KgBUeqK4KTb7lJMx0fvFrS3WdF.jpg',
      description: 'An unusual group of robbers attempt to carry out the most perfect robbery.',
      rating: 8.3,
      year: 2017,
      genres: ['Action', 'Crime', 'Mystery'],
      dominantColor: Color(0xFF8B0000),
    ),
  ];

  static final Movie featuredMovie = Movie(
    id: 'featured',
    title: 'Wednesday',
    imageUrl: 'https://image.tmdb.org/t/p/w500/9PFonBhy4cQy7Jz20NpMygczOkv.jpg',
    backdropUrl: 'https://image.tmdb.org/t/p/original/iHSwvRVsRyxpX7FE7GbviaDvgGZ.jpg',
    description: 'Smart, sarcastic and a little dead inside, Wednesday Addams investigates a murder spree.',
    rating: 8.1,
    year: 2022,
    genres: ['Comedy', 'Crime', 'Family'],
    dominantColor: Color(0xFF1A1A2E),
  );
}