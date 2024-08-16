import 'package:flutter/material.dart'; 
class Palette { 
  static const MaterialColor kToDark = const MaterialColor( 
    0xff277bc0, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch. 
    const <int, Color>{ 
      50: const Color(0xff236fad ),//10% 
      100: const Color(0xff1f629a),//20% 
      200: const Color(0xff1b5686),//30% 
      300: const Color(0xff174a73),//40% 
      400: const Color(0xff143e60),//50% 
      500: const Color(0xff10314d),//60% 
      600: const Color(0xff0c253a),//70% 
      700: const Color(0xff081926),//80% 
      800: const Color(0xff040c13),//90% 
      900: const Color(0xff000000),//100% 
    }, 
  ); 
} 