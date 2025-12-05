import 'package:app_clone/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class AppString {
  static AppLocalizations of(BuildContext context) {
    return AppLocalizations.of(context)!;
  }
}

extension AppStringHelper on AppLocalizations {
  String getValue(String key) {
    switch (key) {
      // ==== LOCATION ====
      case "location_danang":
        return location_danang;
      case "location_hcm":
        return location_hcm;
      case "location_hanoi":
        return location_hanoi;

      // ==== PROPERTY TYPES ====
      case "property_land":
        return property_land;
      case "property_apartment":
        return property_apartment;
      case "property_villa":
        return property_villa;
      case "property_officetel":
        return property_officetel;

      default:
        return key;
    }
  }
}
