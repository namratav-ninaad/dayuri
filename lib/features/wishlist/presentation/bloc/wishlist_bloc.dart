// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'wishlist_event.dart';
import 'wishlist_state.dart';

class BloBloc extends Bloc<BloEvent, BloState> {
  BloBloc() : super(BloState().init());

  Stream<BloState> mapEventToState(BloEvent event) async* {
    if (event is InitEvent) {
      yield await init();
    }
  }

  Future<BloState> init() async {
    return state.clone();
  }
}
