import 'package:rive/rive.dart';

class TeddyController {
  static final _success = SimpleAnimation('success', autoplay: false);
  static final _idle = SimpleAnimation('idle');
  static final _lookIdle = SimpleAnimation('look_idle');
  static final _fail = SimpleAnimation('fail', autoplay: false);
  static final _pass = SimpleAnimation('hands_up', autoplay: false);
  static final _viewpass = SimpleAnimation('hands_down');
  static final _left = SimpleAnimation('Look_down_left', autoplay: false);
  static final _right = SimpleAnimation('Look_down_right', autoplay: false);

  List<SimpleAnimation> get listControllers =>
      [_fail, _pass, _viewpass, _left, _right, _idle, _success, _lookIdle];

  void email() {
    resetLoop();
    if (_pass.isActive) {
      _viewpass.isActive = true;
      _viewpass.reset();
      _pass.isActive = false;
    } else {
      _pass.isActive = false;

      _viewpass.isActive = false;
      _viewpass.reset();
    }
    _idle.isActive = true;
  }

  void resetLoop() {
    _success.reset();
    _idle.reset();
    _pass.reset();
    _viewpass.reset();
    _fail.reset();
    _left.reset();
    _right.reset();
    _lookIdle.reset();
  }

  void onLongPressStart() {
    _success.isActive = true;
    _success.reset();
  }

  void onLongPressEnd() {
    _success.isActive = false;
  }

  void pass() {
    resetLoop();
    _pass.isActive = true;
    _viewpass.isActive = false;
  }

  void check(String value) {
    _success.isActive = false;
    if (value.length <= 17) {
      _left.isActive = true;
    } else {
      _right.isActive = true;
    }
  }

  void error() {
    resetLoop();
    if (_pass.isActive) {
      _viewpass.isActive = true;
      _viewpass.reset();
      _pass.isActive = false;
    } else {
      _pass.isActive = false;

      _viewpass.isActive = false;
      _viewpass.reset();
    }
    _fail.isActive = true;
    _fail.reset();
  }
}
