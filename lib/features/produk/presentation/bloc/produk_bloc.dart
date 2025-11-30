import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu_makanan/features/produk/domain/entities/produk_entity.dart';
import 'package:menu_makanan/features/produk/domain/usecases/get_all_produk_usecase.dart';
import 'package:menu_makanan/features/produk/domain/usecases/search_produk_usecase.dart';

/// Events untuk ProdukBloc
abstract class ProdukEvent {}

class GetAllProdukEvent extends ProdukEvent {}

class SearchProdukEvent extends ProdukEvent {
  final String query;
  SearchProdukEvent(this.query);
}

/// States untuk ProdukBloc
abstract class ProdukState {}

class ProdukInitial extends ProdukState {}

class ProdukLoading extends ProdukState {}

class ProdukLoaded extends ProdukState {
  final List<ProdukEntity> produkList;
  ProdukLoaded(this.produkList);
}

class ProdukError extends ProdukState {
  final String message;
  ProdukError(this.message);
}

/// Bloc untuk manage produk state
class ProdukBloc extends Bloc<ProdukEvent, ProdukState> {
  final GetAllProdukUseCase getAllProdukUseCase;
  final SearchProdukUseCase searchProdukUseCase;

  ProdukBloc({
    required this.getAllProdukUseCase,
    required this.searchProdukUseCase,
  }) : super(ProdukInitial()) {
    on<GetAllProdukEvent>((event, emit) async {
      emit(ProdukLoading());
      try {
        final produkList = await getAllProdukUseCase.call();
        emit(ProdukLoaded(produkList));
      } catch (e) {
        emit(ProdukError(e.toString()));
      }
    });

    on<SearchProdukEvent>((event, emit) async {
      emit(ProdukLoading());
      try {
        final produkList = await searchProdukUseCase.call(event.query);
        emit(ProdukLoaded(produkList));
      } catch (e) {
        emit(ProdukError(e.toString()));
      }
    });
  }
}
