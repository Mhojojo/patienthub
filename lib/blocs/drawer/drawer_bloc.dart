import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'drawer_event.dart';
part 'drawer_state.dart';

class DrawerBloc extends Bloc<DrawerEvent, DrawerState> {
  DrawerBloc() : super(DrawerState());

  Stream<DrawerState> mapEventToState(DrawerEvent event) async* {
    if (event is OpenDrawerEvent) {
      yield DrawerState()..isOpen = true;
    } else if (event is CloseDrawerEvent) {
      yield DrawerState()..isOpen = false;
    }
  }
}
