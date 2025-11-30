import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

/// Example page yang mendemonstrasikan penggunaan:
/// 1. Cached Network Image - untuk caching image dari network
/// 2. Shimmer - untuk loading placeholder yang lebih menarik
/// 3. Sizer - untuk responsive UI

class FlutterGemsExamplePage extends StatefulWidget {
  const FlutterGemsExamplePage({super.key});

  @override
  State<FlutterGemsExamplePage> createState() => _FlutterGemsExamplePageState();
}

class _FlutterGemsExamplePageState extends State<FlutterGemsExamplePage> {
  // Sample data dengan URL image dari TheMealDB API
  final List<Map<String, String>> sampleMeals = [
    {
      'name': 'Arrabiata',
      'image':
          'https://www.themealdb.com/images/media/meals/b0atsOu1581011773.jpg',
      'category': 'Pasta',
    },
    {
      'name': 'Carbonara',
      'image':
          'https://www.themealdb.com/images/media/meals/llcga01644817714.jpg',
      'category': 'Pasta',
    },
    {
      'name': 'Biryani',
      'image':
          'https://www.themealdb.com/images/media/meals/2k7a1q1619786992.jpg',
      'category': 'Rice',
    },
    {
      'name': 'Falafel',
      'image':
          'https://www.themealdb.com/images/media/meals/wvpsrr1511736068.jpg',
      'category': 'Vegetarian',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Gems Examples'),
        backgroundColor: Colors.deepOrange,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(2.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Cached Network Image with Shimmer Loading
            _buildSection(
              title: 'CachedNetworkImage + Shimmer',
              description:
                  'Image caching + shimmer loading animation\nBagus untuk network image dengan loading state yang menarik',
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.85,
                  crossAxisSpacing: 2.w,
                  mainAxisSpacing: 2.w,
                ),
                itemCount: sampleMeals.length,
                itemBuilder: (context, index) {
                  return _buildMealCard(meal: sampleMeals[index]);
                },
              ),
            ),

            SizedBox(height: 3.h),

            // 2. Shimmer Effect Example (Manual)
            _buildSection(
              title: 'Shimmer Loading Placeholder',
              description:
                  'Custom shimmer effect untuk loading state\nGunakan saat menunggu data dari API',
              child: _buildShimmerPlaceholder(),
            ),

            SizedBox(height: 3.h),

            // 3. Responsive Example with Sizer
            _buildSection(
              title: 'Responsive UI with Sizer',
              description:
                  'Semua ukuran menggunakan .w (width) dan .h (height)\nOtomatis scale di berbagai ukuran device',
              child: _buildResponsiveDemo(),
            ),

            SizedBox(height: 3.h),

            // 4. Best Practices
            _buildSection(
              title: 'Best Practices',
              description: '',
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildBestPracticeTile(
                      '📦 CachedNetworkImage',
                      '• Otomatis cache image\n'
                          '• Placeholder saat loading\n'
                          '• Error handler\n'
                          '• Fit & alignment options',
                    ),
                    _buildBestPracticeTile(
                      '✨ Shimmer',
                      '• Gunakan untuk loading state\n'
                          '• Lebih menarik dari ProgressBar\n'
                          '• Customizable colors & duration\n'
                          '• Good UX practice',
                    ),
                    _buildBestPracticeTile(
                      '📱 Sizer',
                      '• Responsive di semua device\n'
                          '• Gunakan .w, .h, .sp\n'
                          '• Hindari hardcoded values\n'
                          '• Mobile-first design',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build meal card dengan CachedNetworkImage
  Widget _buildMealCard({required Map<String, String> meal}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image dengan caching
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: CachedNetworkImage(
                imageUrl: meal['image']!,
                fit: BoxFit.cover,
                width: double.infinity,
                placeholder: (context, url) => _buildShimmerLoading(),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey[300],
                  child: const Icon(
                    Icons.error_outline,
                    color: Colors.grey,
                    size: 40,
                  ),
                ),
              ),
            ),
          ),

          // Info
          Padding(
            padding: EdgeInsets.all(2.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  meal['name']!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 0.5.h),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 1.5.w,
                    vertical: 0.5.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.deepOrange.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    meal['category']!,
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Shimmer loading placeholder
  Widget _buildShimmerLoading() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(color: Colors.white),
    );
  }

  /// Example shimmer placeholder (untuk list loading)
  Widget _buildShimmerPlaceholder() {
    return Column(
      children: List.generate(
        3,
        (index) => Padding(
          padding: EdgeInsets.only(bottom: 2.h),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Row(
              children: [
                // Avatar placeholder
                Container(
                  width: 15.w,
                  height: 15.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                SizedBox(width: 3.w),
                // Text placeholders
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 40.w,
                        height: 1.5.h,
                        color: Colors.white,
                      ),
                      SizedBox(height: 1.h),
                      Container(
                        width: 60.w,
                        height: 1.2.h,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Responsive UI demo dengan Sizer
  Widget _buildResponsiveDemo() {
    return Center(
      child: Column(
        children: [
          // Container responsif
          Container(
            width: 70.w,
            height: 20.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepOrange, Colors.orange],
              ),
              borderRadius: BorderRadius.circular(4.w),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Responsive Container',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    'Ukuran: ${70.toStringAsFixed(1)}% width\n${20.toStringAsFixed(1)}% height',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70, fontSize: 12.sp),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 3.h),
          // Buttons dengan ukuran responsif
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: 4.w,
                    vertical: 1.2.h,
                  ),
                  backgroundColor: Colors.deepOrange,
                ),
                child: Text('Button', style: TextStyle(fontSize: 12.sp)),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: 4.w,
                    vertical: 1.2.h,
                  ),
                  backgroundColor: Colors.orange,
                ),
                child: Text('Button', style: TextStyle(fontSize: 12.sp)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Section dengan title dan description
  Widget _buildSection({
    required String title,
    required String description,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: Colors.deepOrange,
          ),
        ),
        if (description.isNotEmpty) ...[
          SizedBox(height: 1.h),
          Text(
            description,
            style: TextStyle(
              fontSize: 11.sp,
              color: Colors.grey[600],
              height: 1.5,
            ),
          ),
        ],
        SizedBox(height: 2.h),
        child,
      ],
    );
  }

  /// Best practice tile
  Widget _buildBestPracticeTile(String title, String content) {
    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
      padding: EdgeInsets.all(2.w),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.deepOrange.shade200),
        borderRadius: BorderRadius.circular(8),
        color: Colors.deepOrange.shade50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.bold,
              color: Colors.deepOrange,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            content,
            style: TextStyle(
              fontSize: 11.sp,
              color: Colors.grey[700],
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
