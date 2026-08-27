import 'package:clean_architecture_demo/l10n/l10n.dart';
import 'package:flutter/material.dart';

extension LocalizationExtension on BuildContext {
  L10n get l10n => L10n.of(this);
}
