import 'package:flutter/material.dart';
import 'package:travel_planner_app/models/destination_provider.dart';
import 'package:travel_planner_app/screen/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DestinationProvider()),
      ],
    child: TravelPlannerApp()
    )
    );
}

class TravelPlannerApp extends StatelessWidget {
  const TravelPlannerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
         textTheme: GoogleFonts.montserratTextTheme(
            Theme.of(context).textTheme,
          ),
        useMaterial3: true,
    
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}