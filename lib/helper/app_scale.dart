import 'package:flutter/material.dart';

// class AppScale {
//   BuildContext ctx;

//   AppScale(this.ctx);

//   double fs(double initialFontSize) {
//     return (MediaQuery.of(ctx).size.width * 0.0027) * initialFontSize;
//   }

//   double sh(double initialIcon) {
//     return (MediaQuery.of(ctx).size.height * 0.065) * initialIcon;
//   }
// }

extension Scaler on BuildContext {
  double get statusBar {
    return MediaQuery.of(this).viewPadding.top;
  }

  double scaleFont(double initialFontSize) {
    return (MediaQuery.of(this).size.width * 0.0027) * initialFontSize;
  }

  double scaleHeight(double initialHeight) {
    return (MediaQuery.of(this).size.height * 0.0011) * initialHeight;
  }

  double get deviceWidth {
    return (MediaQuery.of(this).size.width);
  }

  double get deviceHeight {
    return (MediaQuery.of(this).size.height);
  }

  double get keyboardHeight {
    return MediaQuery.of(this).viewInsets.bottom;
  }
}
