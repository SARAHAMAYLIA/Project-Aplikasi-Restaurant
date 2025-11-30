# Panduan Menggunakan Fitur-Fitur Baru

## 1. Menggunakan CounterCubit di Widget

```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu_makanan/bloc/counter_cubit.dart';

// Di widget
BlocBuilder<CounterCubit, int>(
  builder: (context, count) {
    return Column(
      children: [
        Text('Count: $count'),
        ElevatedButton(
          onPressed: () => context.read<CounterCubit>().increment(),
          child: Text('Tambah'),
        ),
        ElevatedButton(
          onPressed: () => context.read<CounterCubit>().decrement(),
          child: Text('Kurang'),
        ),
      ],
    );
  },
);
```

## 2. Menggunakan GoRouter untuk Navigation

```dart
import 'package:go_router/go_router.dart';

// Simple navigation
context.pushNamed('beranda');

// Dengan parameters
context.pushNamed(
  'detail',
  extra: {
    'produk': produkEntity,
    'onTambah': () { /* callback */ }
  }
);

// Replace current route
context.goNamed('login');
```

## 3. Menggunakan Dio untuk API Calls

```dart
import 'package:menu_makanan/services/meal_service.dart';

// Fetch data
final meals = await MealService.fetchSemuaMeal();
final mealDetail = await MealService.fetchMealById('123');
final searchResult = await MealService.searchByName('Pasta');
```

## 4. Menggunakan ProdukBloc dari Clean Architecture

```dart
import 'package:menu_makanan/features/produk/presentation/bloc/produk_bloc.dart';
import 'package:menu_makanan/features/produk/data/datasources/produk_local_datasource.dart';
import 'package:menu_makanan/features/produk/data/repositories/produk_repository_impl.dart';
import 'package:menu_makanan/features/produk/domain/usecases/get_all_produk_usecase.dart';
import 'package:menu_makanan/features/produk/domain/usecases/search_produk_usecase.dart';

// Setup dependency injection
final repository = ProdukRepositoryImpl(
  dataSource: ProdukLocalDataSource(),
);

final produkBloc = ProdukBloc(
  getAllProdukUseCase: GetAllProdukUseCase(repository),
  searchProdukUseCase: SearchProdukUseCase(repository),
);

// Wrap widget
BlocProvider(
  create: (context) => produkBloc..add(GetAllProdukEvent()),
  child: ProdukListPage(),
);

// Use in widget
BlocBuilder<ProdukBloc, ProdukState>(
  builder: (context, state) {
    if (state is ProdukLoading) {
      return CircularProgressIndicator();
    } else if (state is ProdukLoaded) {
      return ListView(
        children: state.produkList.map((produk) {
          return ListTile(title: Text(produk.nama));
        }).toList(),
      );
    }
    return SizedBox();
  },
);
```

## 5. Menggunakan Responsive Sizes dengan Sizer

```dart
import 'package:sizer/sizer.dart';

// Width percentage
Container(width: 80.w) // 80% of screen width

// Height percentage
Container(height: 40.h) // 40% of screen height

// Font size (responsive)
Text('Title', style: TextStyle(fontSize: 18.sp))

// Padding (responsive)
Padding(
  padding: EdgeInsets.all(2.w),
  child: Text('Content'),
)
```

## 6. Request Location Permission

```dart
import 'package:location/location.dart';

final location = Location();

// Request permission
PermissionStatus permission = await location.requestPermission();

if (permission == PermissionStatus.granted) {
  final userLocation = await location.getLocation();
  print('Lat: ${userLocation.latitude}, Lon: ${userLocation.longitude}');
}
```

## 7. Menggunakan CachedNetworkImage dengan Shimmer

```dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

CachedNetworkImage(
  imageUrl: 'https://example.com/image.jpg',
  fit: BoxFit.cover,
  placeholder: (context, url) => Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Container(color: Colors.white),
  ),
  errorWidget: (context, url, error) => Icon(Icons.error),
)
```

## 8. Testing dengan Clean Architecture

### Unit Test untuk UseCase
```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

void main() {
  group('GetAllProdukUseCase', () {
    test('should return list of ProdukEntity', () async {
      // Arrange
      final mockRepository = MockProdukRepository();
      when(mockRepository.getAllProduk())
          .thenAnswer((_) async => [
            ProdukEntity(
              id: '1',
              nama: 'Test Produk',
              deskripsi: 'Test',
              harga: 10000,
              gambar: 'test.jpg',
              rating: 4.5,
            ),
          ]);
      
      final usecase = GetAllProdukUseCase(mockRepository);
      
      // Act
      final result = await usecase.call();
      
      // Assert
      expect(result, isA<List<ProdukEntity>>());
      expect(result.length, 1);
      expect(result[0].nama, 'Test Produk');
    });
  });
}
```

### BLoC Test
```dart
import 'package:bloc_test/bloc_test.dart';

void main() {
  group('ProdukBloc', () {
    blocTest<ProdukBloc, ProdukState>(
      'emits [ProdukLoading, ProdukLoaded] when GetAllProdukEvent is added',
      build: () => produkBloc,
      act: (bloc) => bloc.add(GetAllProdukEvent()),
      expect: () => [
        isA<ProdukLoading>(),
        isA<ProdukLoaded>(),
      ],
    );
  });
}
```

## 📝 Catatan Penting

- **Halaman contoh Flutter Gems**: `lib/features/produk/presentation/pages/flutter_gems_example_page.dart`
- **Dokumentasi Clean Architecture**: `lib/features/CLEAN_ARCHITECTURE_README.md`
- **Dokumentasi Flutter Gems**: `FLUTTER_GEMS_GUIDE.md`
- **Summary implementasi**: `IMPLEMENTATION_SUMMARY.md`

## ⚠️ Common Issues & Solutions

### Issue: "Target of URI doesn't exist"
**Solution**: Pastikan file sudah dibuat dan import path benar

### Issue: "undefined_identifier"
**Solution**: Pastikan import sudah ditambahkan di bagian atas file

### Issue: "Bloc state tidak berubah"
**Solution**: Pastikan BlocProvider di-inject dengan benar dan event ditambahkan dengan `bloc.add()`

### Issue: "Shimmer tidak muncul"
**Solution**: Pastikan placeholder placeholder widget ada di CachedNetworkImage

## 🔗 Resources

- [BLoC Documentation](https://bloclibrary.dev/)
- [GoRouter Documentation](https://pub.dev/packages/go_router)
- [Dio Documentation](https://pub.dev/packages/dio)
- [Clean Architecture Guide](https://resocoder.com/clean-architecture-tdd)
- [Shimmer Package](https://pub.dev/packages/shimmer)
- [CachedNetworkImage](https://pub.dev/packages/cached_network_image)
