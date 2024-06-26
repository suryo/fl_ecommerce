part of core;

class ProgressUtils extends PopupRoute {
  /*
  * Show message.
  * */
  static Future<void> showMessage(BuildContext context, String message,
      {bool isSucceess = false, isHideIcon = false}) async {
    try {
      if (_currentHud != null) {
        _currentHud!.navigator!.pop();
      }
      ProgressUtils hud = ProgressUtils();
      hud.message = message;
      hud.isSucceess = isSucceess;
      hud.isHideIcon = isHideIcon;
      _currentHud = hud;
      Navigator.push(context, hud);
      Future.delayed(hud.delayed).then((val) {
        _currentHud!.navigator!.pop();
        _currentHud = null;
      });
    } catch (e) {
      _currentHud = null;
    }
  }

  static Future<void> showUpCommingMessage(BuildContext context) async {
    try {
      if (_currentHud != null) {
        _currentHud!.navigator!.pop();
      }
      ProgressUtils hud = ProgressUtils();
      hud.message = "Coming Soon, still on progress!  😇🙏";
      hud.isUpComming = true;
      _currentHud = hud;
      Navigator.push(context, hud);
      Future.delayed(const Duration(milliseconds: 1700)).then((val) {
        _currentHud?.navigator?.pop();
        _currentHud = null;
      });
    } catch (e) {
      _currentHud = null;
    }
  }

  /*
  * show an hud.
  * when you want to do anything, you can call this show.
  * for example： begin network request
  * */
  static Future<void> show(BuildContext context) async {
    try {
      if (_currentHud != null) {
        _currentHud!.navigator!.pop();
      }
      ProgressUtils hud = ProgressUtils();
      _currentHud = hud;
      Navigator.push(context, hud);
    } catch (e) {
      _currentHud = null;
    }
  }

  /*
  * hide hud
  * when you complete something,you can call this hide to hide hud.
  * */
  static Future<void> hide() async {
    try {
      if (_currentHud != null) {
        _currentHud!.navigator!.pop();
      }
      _currentHud = null;
    } catch (e) {
      _currentHud = null;
    }
  }

// hud show this message, default null. when you set ,it will show message hud, not progress hud.
  String? message;
  bool isSucceess = false;
  bool isHideIcon = false;
  bool isUpComming = false;
  Color progressColor = Colors.grey;
  Color progressBackgroundColor = Colors.white;
  Color coverColor = const Color.fromRGBO(0, 0, 0, 0.4);
  Duration delayed = const Duration(milliseconds: 3000);
  TextStyle loadingTextStyle = const TextStyle(
      fontSize: 13.0,
      color: Colors.black87,
      fontWeight: FontWeight.normal,
      fontFamily: 'Sans',
      decoration: TextDecoration.none);
  TextStyle messageTextStyle = const TextStyle(
      fontSize: 14.0,
      color: Colors.black87,
      fontWeight: FontWeight.w500,
      fontFamily: 'Sans',
      decoration: TextDecoration.none);

  String loadingMessage = 'loading ...';

  static ProgressUtils? _currentHud;

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  Duration get transitionDuration => kThemeAnimationDuration;

  @override
  bool get barrierDismissible => true;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return Container(
      color: const Color.fromRGBO(0, 0, 0, 0.4),
      child: Center(
        child: _getProgress(context),
      ),
    );
  }

  Widget _getProgress(BuildContext context) {
    if (message == null) {
      return Container(
          width: 150.0,
          height: 150.0,
          decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Stack(
            children: <Widget>[
              Center(
                child: SpinKitWave(
                  color: Theme.of(context).primaryColor,
                  duration: const Duration(milliseconds: 1500),
                  size: 35.0,
                ),
              ),
            ],
          ));
    } else {
      return Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: isHideIcon ? 0 : 15.0),
              child: isHideIcon
                  ? const SizedBox(
                      height: 0,
                      width: 0,
                    )
                  : isUpComming
                      ? const Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Icon(FontAwesomeIcons.gears, size: 20.0, color: Colors.blue),
                        )
                      : isSucceess
                          ? const Icon(FontAwesomeIcons.circleCheck, size: 20.0, color: Colors.green)
                          : const Icon(FontAwesomeIcons.exclamation, size: 20.0, color: Colors.red),
            ),
            Flexible(
              child: Text(
                message!,
                style: messageTextStyle,
              ),
            ),
          ],
        ),
      );
    }
  }
}
