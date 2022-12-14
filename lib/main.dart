import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:places_app/helpers/page_routing.dart';
import 'package:places_app/providers/great_places.dart';
import 'package:places_app/screens/add_place_screen.dart';
import 'package:places_app/screens/place_detail_screen.dart';
import 'package:places_app/screens/places_list_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final myLightTheme = FlexThemeData.light(
            useMaterial3: true,
            scheme: FlexScheme.purpleBrown,
            typography: Typography.material2021(
              platform: TargetPlatform.android,
            ))
        .copyWith(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            pageTransitionsTheme: PageTransitionsTheme(builders: {
              TargetPlatform.android: PageRouting(),
              TargetPlatform.iOS: PageRouting()
            }));

    final myDarkTheme = FlexThemeData.dark(
            useMaterial3: true,
            scheme: FlexScheme.purpleBrown,
            typography: Typography.material2021(
              platform: TargetPlatform.android,
            ))
        .copyWith(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            pageTransitionsTheme: PageTransitionsTheme(builders: {
              TargetPlatform.android: PageRouting(),
              TargetPlatform.iOS: PageRouting()
            }));

    return ChangeNotifierProvider(
      create: (context) => GreatPlaces(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Great Places',
        theme: myLightTheme,
        darkTheme: myDarkTheme,
        themeMode: ThemeMode.dark,
        home: const PlacesListScreen(),
        routes: {
          PlacesListScreen.routeName: (context) => const PlacesListScreen(),
          AddPlaceScreen.routeName: (context) => const AddPlaceScreen(),
          PlaceDetailScreen.routeName: (context) => const PlaceDetailScreen(),
        },
      ),
    );
  }
}
