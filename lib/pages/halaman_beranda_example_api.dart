import 'package:flutter/material.dart';
import 'package:menu_makanan/services/meal_service.dart';
import 'package:menu_makanan/pages/halaman_detail_meal.dart';

/// CONTOH: Widget untuk menampilkan TheMealDB API data di dashboard
/// Sertakan ini di halaman_beranda.dart atau buat halaman terpisah

class MealFromApiWidget extends StatefulWidget {
  final String searchQuery;

  const MealFromApiWidget({super.key, this.searchQuery = ''});

  @override
  State<MealFromApiWidget> createState() => _MealFromApiWidgetState();
}

class _MealFromApiWidgetState extends State<MealFromApiWidget> {
  late Future<List<dynamic>> _mealsFuture;

  @override
  void initState() {
    super.initState();
    // Fetch meals dari TheMealDB API saat widget dimuat
    _loadForQuery(widget.searchQuery);
  }

  @override
  void didUpdateWidget(covariant MealFromApiWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.searchQuery != widget.searchQuery) {
      setState(() {
        _loadForQuery(widget.searchQuery);
      });
    }
  }

  void _loadForQuery(String query) {
    if (query.isEmpty) {
      _mealsFuture = MealService.fetchSemuaMeal();
    } else {
      _mealsFuture = MealService.searchByName(query);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: _mealsFuture,
      builder: (context, snapshot) {
        // Saat loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: CircularProgressIndicator(),
            ),
          );
        }

        // Ada error
        if (snapshot.hasError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, color: Colors.red, size: 48),
                  const SizedBox(height: 16),
                  Text('Error: ${snapshot.error}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => setState(() {
                      _mealsFuture = MealService.fetchSemuaMeal();
                    }),
                    child: const Text('Coba Lagi'),
                  ),
                ],
              ),
            ),
          );
        }

        // Data berhasil dimuat
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Tidak ada meal tersedia'));
        }

        final meals = snapshot.data ?? <dynamic>[];

        // Filter out Patreon-only / special entries that may appear in API results
        final filteredMeals = meals.where((meal) {
          try {
            final name = (meal is Map && meal['strMeal'] != null)
                ? meal['strMeal'].toString().toLowerCase()
                : '';
            if (name.contains('patreon')) return false;
            if (name.contains('only for')) return false;
          } catch (_) {}
          return true;
        }).toList();

        if (filteredMeals.isEmpty) {
          return const Center(child: Text('Tidak ada meal tersedia'));
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Latest Meals from TheMealDB API',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 250,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: filteredMeals.length,
                itemBuilder: (context, index) {
                  final meal = filteredMeals[index];
                  return _buildMealCard(context, meal);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  /// Widget untuk menampilkan satu meal card
  Widget _buildMealCard(BuildContext context, dynamic meal) {
    // TheMealDB mengembalikan Map dengan key: idMeal, strMeal, strMealThumb, strCategory, etc
    final mealName = meal['strMeal'] as String? ?? 'Unknown';
    final mealImage = meal['strMealThumb'] as String? ?? '';
    final mealCategory = meal['strCategory'] as String? ?? 'Unknown';
    final mealId = meal['idMeal'] as String? ?? '';

    return Card(
      margin: const EdgeInsets.only(right: 12),
      child: Container(
        width: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar meal
            if (mealImage.isNotEmpty)
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(8),
                ),
                child: Image.network(
                  mealImage,
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 120,
                      color: Colors.grey[300],
                      child: const Icon(Icons.fastfood),
                    );
                  },
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nama meal
                  Text(
                    mealName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Kategori
                  Chip(
                    label: Text(
                      mealCategory,
                      style: const TextStyle(fontSize: 12),
                    ),
                    padding: EdgeInsets.zero,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  const SizedBox(height: 8),
                  // Tombol detail (opsional)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Buka halaman detail meal (mengambil instruksi & bahan)
                        if (mealId.isNotEmpty) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => HalamanDetailMeal(mealId: mealId),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Meal ID tidak tersedia')),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        backgroundColor: Colors.orange,
                      ),
                      child: const Text(
                        'Lihat',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
