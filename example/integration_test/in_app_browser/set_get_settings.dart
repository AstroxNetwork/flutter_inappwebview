import 'package:flutter/foundation.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_test/flutter_test.dart';

import '../constants.dart';
import '../util.dart';

void setGetSettings() {
  final shouldSkip = kIsWeb
      ? true
      : ![
          TargetPlatform.android,
          TargetPlatform.iOS,
          TargetPlatform.macOS,
        ].contains(defaultTargetPlatform);

  test('set/get settings', () async {
    var inAppBrowser = new MyInAppBrowser();
    await inAppBrowser.openUrlRequest(
        urlRequest: URLRequest(url: TEST_URL_1),
        settings: InAppBrowserClassSettings(
            browserSettings: InAppBrowserSettings(hideToolbarTop: true)));
    await inAppBrowser.browserCreated.future;
    await inAppBrowser.firstPageLoaded.future;

    InAppBrowserClassSettings? settings = await inAppBrowser.getSettings();
    expect(settings, isNotNull);
    expect(settings!.browserSettings.hideToolbarTop, true);

    await inAppBrowser.setSettings(
        settings: InAppBrowserClassSettings(
            browserSettings: InAppBrowserSettings(hideToolbarTop: false)));

    settings = await inAppBrowser.getSettings();
    expect(settings, isNotNull);
    expect(settings!.browserSettings.hideToolbarTop, false);
  }, skip: shouldSkip);
}
