import 'dart:developer';
import 'dart:io';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:integration_test/integration_test_driver_extended.dart';
//Future<void> main() => integrationDriver();

Future<void> main() async {
  final FlutterDriver driver = await FlutterDriver.connect();

  try {
    await integrationDriver(
      driver: driver,
      onScreenshot: (String screenshotName, List<int> screenshotBytes, [Map<String, Object?>? args]) async {
        final File image = await File('integration_test/screenshots/$screenshotName.png').create(recursive: true);
        image.writeAsBytesSync(screenshotBytes);
        return true;
      },
    );
  } catch (e) {
    log('Error occured: $e');
  }
}