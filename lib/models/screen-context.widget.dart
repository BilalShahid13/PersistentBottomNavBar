import '../persistent-tab-view.dart';

class ScreenContext {
  BuildContext context;
  int pushedCount;

  ScreenContext(this.context, {this.pushedCount = 0});
}
