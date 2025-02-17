import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:travel_planner_app/constant.dart';
import 'package:travel_planner_app/screen/home_screen.dart';

class PlannedTripPage extends StatelessWidget {
  final String destination;
  final DateTime? departureDate;
  final DateTime? returnDate;
  final String tripType;
  final String accommodation;
  final String transportation;
  final Set<String> activities;

  const PlannedTripPage({
    super.key,
    required this.destination,
    required this.departureDate,
    required this.returnDate,
    required this.tripType,
    required this.accommodation,
    required this.transportation,
    required this.activities,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Summary'),
         systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SummarySection(title: "Destination", content: destination),
              SummarySection(
                title: "Departure Date",
                content: departureDate != null
                    ? DateFormat('yyyy-MM-dd').format(departureDate!)
                    : 'N/A',
              ),
              SummarySection(
                title: "Return Date",
                content: returnDate != null
                    ? DateFormat('yyyy-MM-dd').format(returnDate!)
                    : 'N/A',
              ),
              SummarySection(title: "Trip Type", content: tripType),
              SummarySection(title: "Accommodation", content: accommodation),
              SummarySection(title: "Transportation", content: transportation),
              SummarySection(
                title: "Item(s)",
                content: activities.join(', '),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
          );
        },
        child: Container(
          width: double.infinity,
          color: const Color(0xFF3D405B),
          height: 60,
          child: const Center(
            child: Text(
              'Back to home',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      )
    );
  }
}

class SummarySection extends StatelessWidget {
  final String title;
  final String content;

  const SummarySection({super.key, 
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: const EdgeInsets.all(16.0),
            child: Text(title, style: headertext.copyWith(fontSize: 15),),
          ),
          const SizedBox(height: 8.0),
          Text(content),
           const SizedBox(height: 15.0),
        ],
      ),
    );
  }
}
