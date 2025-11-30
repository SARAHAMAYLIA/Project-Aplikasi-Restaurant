# 🍽️ Panduan Penggunaan TheMealDB API dengan Dio

## Overview
Aplikasi sekarang menggunakan **TheMealDB API** untuk fetch data makanan. API ini adalah public API yang menyediakan database meal/resep gratis.

---

## 📚 Service yang Tersedia

### 1. **MealService** (meal_service.dart)
Menggunakan **Dio** HTTP client untuk komunikasi dengan TheMealDB API.

**Methods:**

#### `fetchSemuaMeal()`
Mengambil 10 meal terbaru dari TheMealDB.
```dart
try {
  List<dynamic> meals = await MealService.fetchSemuaMeal();
  // meals = [
  //   {
  //     'idMeal': '52977',
  //     'strMeal': 'Corba',
  //     'strMealThumb': 'https://www.themealdb.com/images/media/meals/58ede5.jpg',
  //     'strCategory': 'Seafood',
  //     'strArea': 'Turkish',
  //     'strInstructions': '...'
  //   },
  //   ...
  // ]
} catch (e) {
  print('Error: $e');
}
```

#### `searchByName(String mealName)`
Mencari meal berdasarkan nama.
```dart
List<dynamic> results = await MealService.searchByName('Pasta');
// Mencari semua meal dengan nama mengandung "Pasta"
```

#### `searchByIngredient(String ingredient)`
Mencari meal berdasarkan ingredient.
```dart
List<dynamic> results = await MealService.searchByIngredient('Chicken');
// Mencari semua meal yang menggunakan ingredient "Chicken"
```

---

## 🎨 Widget Siap Pakai

### 1. **MealFromApiWidget** (halaman_beranda_example_api.dart)
Widget horizontal scrollable list dengan meal cards.

**Penggunaan:**
```dart
import 'package:menu_makanan/halaman_beranda_example_api.dart';

// Tambahkan di dalam build method widget apapun
const MealFromApiWidget(),
```

**Features:**
- Auto fetch latest meals saat widget mount
- Loading indicator
- Error handling dengan retry button
- Horizontal scroll card list
- Shows meal image, name, dan category

### 2. **MealSearchWidget** (meal_search_page.dart)
Full page dengan search functionality dan grid view.

**Penggunaan:**
```dart
import 'package:menu_makanan/meal_search_page.dart';

// Di GoRouter routes, tambahkan:
GoRoute(
  path: '/meal-search',
  builder: (context, state) => const MealSearchPage(),
),

// Akses dari button:
context.push('/meal-search');
```

**Features:**
- Search bar untuk mencari meal by name
- Filter by ingredient support
- Grid view display
- Real-time search
- Loading state

---

## 📱 Implementasi di Dashboard

### Option 1: Tambahkan Widget ke halaman_beranda.dart

```dart
import 'package:menu_makanan/halaman_beranda_example_api.dart';

class _HalamanBerandaState extends State<HalamanBeranda> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Banner promo (existing)
        Container(...),
        
        // NEW: Tambahkan MealFromApiWidget di sini
        const MealFromApiWidget(),
        
        // Search box (existing)
        Container(...),
      ],
    );
  }
}
```

### Option 2: Buat Halaman Terpisah (Recommended)

Buat file baru: `lib/meal_dashboard_page.dart`

```dart
import 'package:flutter/material.dart';
import 'package:menu_makanan/meal_search_page.dart';

class MealDashboardPage extends StatelessWidget {
  const MealDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meals from TheMealDB'),
        backgroundColor: Colors.orange,
      ),
      body: const MealSearchWidget(),
    );
  }
}
```

Kemudian di `main.dart`, tambahkan route:

```dart
GoRoute(
  path: '/meals',
  builder: (context, state) => const MealDashboardPage(),
),
```

Dan tambahkan menu di navigation/sidebar untuk akses halaman ini.

---

## 🔍 Response Structure dari TheMealDB

Setiap meal object memiliki struktur:

```json
{
  "idMeal": "52977",
  "strMeal": "Corba",
  "strDrinkAlternate": null,
  "strCategory": "Seafood",
  "strArea": "Turkish",
  "strInstructions": "Pick through the lentils for any debris...",
  "strMealThumb": "https://www.themealdb.com/images/media/meals/58ede5.jpg",
  "strTags": "Soup,Vegetarian",
  "strYoutube": "https://www.youtube.com/watch?v=...",
  "strIngredient1": "Lentils",
  "strIngredient2": "Onion",
  ...
  "strMeasure1": "1 cup",
  "strMeasure2": "2 large",
  ...
  "strSource": "https://www.bbcgoodfood.com/recipes/lentil-soup",
  "strImageSource": null,
  "strCreativeCommonsConfirmed": null,
  "dateModified": "2019-01-17 11:17:32"
}
```

---

## ⚙️ Konfigurasi

### API Key
- **Key:** `1` (public key untuk testing)
- **Base URL:** `https://www.themealdb.com/api/json/v1/1`

### Timeout
- **Connect Timeout:** 5 detik
- **Receive Timeout:** 5 detik

Jika perlu ubah, edit di `lib/services/meal_service.dart`:

```dart
static final Dio _dio = Dio(
  BaseOptions(
    baseUrl: 'https://www.themealdb.com/api/json/v1/1',
    connectTimeout: const Duration(milliseconds: 5000), // ubah di sini
    receiveTimeout: const Duration(milliseconds: 5000), // ubah di sini
  ),
);
```

---

## 🐛 Error Handling

Semua methods di `MealService` throw Exception jika error:

```dart
try {
  final meals = await MealService.fetchSemuaMeal();
} on SocketException {
  print('No internet connection');
} catch (e) {
  print('Error: $e');
}
```

Jenis error yang mungkin:
- **Connection timeout** - API response lambat
- **Bad response** - Server error (5xx)
- **No internet** - Tidak ada koneksi
- **Parse error** - Response format tidak sesuai

---

## 🚀 Next Steps

1. **Tambahkan navigation menu** untuk akses meal search
2. **Integrasi dengan cart** - allow users to "order" meals
3. **Favorit meals** - save ke local storage
4. **Detail page** - show full recipe dan ingredients
5. **Filter advanced** - by category, area, ingredient
6. **Offline caching** - cache meal data locally

---

## 📚 TheMealDB API Docs
Official docs: https://www.themealdb.com/api.php

---

**Status:** ✅ Ready to use
**Last Updated:** November 26, 2025
