part of 'drawer_bloc.dart';

abstract class DrawerEvent {
  update(DrawerState state) {}
}

class OpenDrawerEvent extends DrawerEvent {
  @override
  DrawerState update(DrawerState state) {
    return DrawerState()..isOpen = true;
  }
}

class CloseDrawerEvent extends DrawerEvent {
  DrawerState update(DrawerState state) {
    return DrawerState()..isOpen = false;
  }
}
