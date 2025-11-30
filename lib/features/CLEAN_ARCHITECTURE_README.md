# Clean Architecture Implementation

## Struktur Folder

```
lib/features/
└── produk/
    ├── data/
    │   ├── datasources/
    │   │   ├── produk_datasource.dart          (Abstract interface)
    │   │   └── produk_local_datasource.dart    (Implementasi)
    │   └── repositories/
    │       └── produk_repository_impl.dart     (Implementasi repository)
    ├── domain/
    │   ├── entities/
    │   │   └── produk_entity.dart              (Domain model)
    │   ├── repositories/
    │   │   └── produk_repository.dart          (Abstract repository)
    │   └── usecases/
    │       ├── get_all_produk_usecase.dart     (Business logic)
    │       └── search_produk_usecase.dart      (Business logic)
    └── presentation/
        ├── bloc/
        │   └── produk_bloc.dart                (State management)
        └── pages/
            └── produk_page.dart                (UI)
```

## Penjelasan Layer

### 1. **Domain Layer** (Business Rules)
- **Entity**: Pure Dart classes yang represent domain concepts
- **Repository**: Abstract interfaces yang mendefinisikan contracts
- **UseCase**: Encapsulate business logic, satu usecase = satu fitur

**Keuntungan**: Tidak depend pada framework atau external library

### 2. **Data Layer** (Data Sources)
- **DataSource**: Abstract interface untuk data fetching (local/remote)
- **Repository Implementation**: Concrete implementation dari domain repository
- **Models**: Convert dari API/local format ke domain entity

**Keuntungan**: Mudah untuk switch data source (contoh: dari dummy ke API real)

### 3. **Presentation Layer** (UI)
- **Bloc/Cubit**: State management untuk UI logic
- **Pages/Widgets**: UI components
- **States & Events**: Manage UI state transitions

**Keuntungan**: UI logic terpisah dari business logic

## Contoh Penggunaan di Widget

```dart
// 1. Setup Bloc dengan dependency injection
final produkRepository = ProdukRepositoryImpl(
  dataSource: ProdukLocalDataSource(),
);

final produkBloc = ProdukBloc(
  getAllProdukUseCase: GetAllProdukUseCase(produkRepository),
  searchProdukUseCase: SearchProdukUseCase(produkRepository),
);

// 2. Wrap widget dengan BlocProvider
BlocProvider(
  create: (context) => produkBloc..add(GetAllProdukEvent()),
  child: ProdukPage(),
);

// 3. Gunakan di widget dengan BlocBuilder
BlocBuilder<ProdukBloc, ProdukState>(
  builder: (context, state) {
    if (state is ProdukLoading) {
      return CircularProgressIndicator();
    } else if (state is ProdukLoaded) {
      return ListView(
        children: state.produkList.map((produk) {
          return ListTile(
            title: Text(produk.nama),
            subtitle: Text('Rp${produk.harga}'),
          );
        }).toList(),
      );
    } else if (state is ProdukError) {
      return Text('Error: ${state.message}');
    }
    return SizedBox();
  },
);
```

## Testing (TDD)

### Unit Test untuk UseCase
```dart
test('GetAllProdukUseCase should return list of ProdukEntity', () async {
  // Arrange
  final mockRepository = MockProdukRepository();
  when(mockRepository.getAllProduk())
      .thenAnswer((_) async => [ProdukEntity(...)]);
  
  final usecase = GetAllProdukUseCase(mockRepository);
  
  // Act
  final result = await usecase.call();
  
  // Assert
  expect(result, isA<List<ProdukEntity>>());
});
```

### Unit Test untuk Bloc
```dart
blocTest<ProdukBloc, ProdukState>(
  'emits [ProdukLoading, ProdukLoaded] when GetAllProdukEvent is added',
  build: () => produkBloc,
  act: (bloc) => bloc.add(GetAllProdukEvent()),
  expect: () => [
    isA<ProdukLoading>(),
    isA<ProdukLoaded>(),
  ],
);
```

## Migration Path

Struktur ini memudahkan untuk:
- ✅ Migrate dari dummy data ke API real (hanya ubah DataSource)
- ✅ Add local caching (create new DataSource)
- ✅ Add offline-first capability
- ✅ Easy to test (all layers are testable)
- ✅ Scalable dan maintainable
