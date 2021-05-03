import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tile_blue/setting/blue_scan_setting.dart';

class Prefs {

  final SharedPreferences preferences;

  Prefs({
    required this.preferences,
  });

  Future<bool> saveBackEndDomain({
    String? domain,
  }) async {
    List<String> listOfDomains = getBackEndDomains();
    if (listOfDomains.contains(domain)) {
      return false;
    } else {
      listOfDomains.add(domain!);
    }
    bool result = await preferences.setString(
      "listOfDomains",
      json.encode(listOfDomains),
    );
    return result;
  }

  List<String> getBackEndDomains() {
    List<String> listOfDomains = [];
    if (preferences.getString("listOfDomains") != null) {
      listOfDomains = json.decode(
        preferences.getString("listOfDomains")!,
      ).cast<String>();
    }
    return listOfDomains;
  }

  String getDomain() {
    if (preferences.getString('domain') != null) {
      return preferences.getString('domain')!;
    }
    return '';
  }

  Future<bool> saveChosenDomain ({
    required String domain,
  }) async {
    bool result = await preferences.setString('domain', domain,);
    return result;
  }

  Future<String> saveScanSetting ({
    int? mode,
    int? maxRssi,
    int? minRssi,
    String? bleMac,
  }) async {
    String errorString = '';

    if ( mode != null ) {
      await preferences.setInt(
        "scanMode",
        mode,
      );
    }

    await preferences.setString(
      'bleMac',
      bleMac??'',
    );

    if ( maxRssi != null && minRssi != null ) {
      if (minRssi > maxRssi) {
        errorString = 'maxRssi需大於minRssi';
      } else {
        await preferences.setInt(
          "maxRssi",
          maxRssi,
        );
        await preferences.setInt(
          "minRssi",
          minRssi,
        );
      }
    }

    if ( minRssi == null && maxRssi == null ) {
      await preferences.remove("maxRssi");
      await preferences.remove("minRssi");
    }

    if (( minRssi == null && maxRssi != null ) || ( minRssi != null && maxRssi == null )) {
      errorString = 'rssi欄位需要填寫的話，兩欄都須填寫，且maxRssi需大於minRssi';
    }

    return errorString;
  }

  void getScanSetting() {

    if (preferences.getInt("scanMode") != null) {
      BlueScanSetting.mode = preferences.getInt(
        "scanMode",
      );
    }

    if (preferences.getInt("maxRssi") != null) {
      BlueScanSetting.maxRssi = preferences.getInt(
        "maxRssi",
      );
    }

    if (preferences.getInt("minRssi") != null) {
      BlueScanSetting.minRssi = preferences.getInt(
        "minRssi",
      );
    }

    if (preferences.getString("bleMac") != null && preferences.getString("bleMac") != '') {
      BlueScanSetting.bleMac = preferences.getString(
        "bleMac",
      );
    }

    if (preferences.getString('domain') != null) {
      BlueScanSetting.serverDomain = preferences.getString(
        'domain',
      );
    }
  }

}