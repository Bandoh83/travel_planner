import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:provider/provider.dart';
import 'package:travel_planner_app/models/destination_provider.dart';
import 'package:travel_planner_app/screen/activities.dart';
import '../constant.dart';

class TripPlannerScreen extends StatefulWidget {
  const TripPlannerScreen({super.key});

  @override
  TripPlannerScreenState createState() => TripPlannerScreenState();
}

class TripPlannerScreenState extends State<TripPlannerScreen> {
  
  String _selectedTripType = '';
  final _departureDateController = TextEditingController();
  final _returnDateController = TextEditingController();
  final _searchEditingController = TextEditingController();
  DateTime? _departureDate;
  DateTime? _returnDate;


  int _calculateDaysBetweenDates(DateTime startDate, DateTime endDate) {
    return endDate.difference(startDate).inDays;
  }

  int _calculateNightsBetweenDates(
      DateTime departureDate, DateTime returnDate) {
    return returnDate.difference(departureDate).inDays - 1;
  }

  @override
  Widget build(BuildContext context) {
     final selectedDestination = Provider.of<DestinationProvider>(context).selectedDestination;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const Text(
                'Destination',
                style: headertext,
              ),
              const SizedBox(height: 8),
              GooglePlaceAutoCompleteTextField(
                
                textEditingController: _searchEditingController..text = selectedDestination!,
                googleAPIKey: apiKey,
                inputDecoration: InputDecoration(
                  hintText: 'Where do you want to go',
                  prefixIcon: const Icon(Icons.location_on_outlined,
                      color: Color(0xFF81B29A)),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                debounceTime: 300,
                countries: const ["GH"],
                isLatLngRequired: true,
                itemClick: (prediction) {
                  
                  _searchEditingController.text = prediction.description!;
                
                },
              ),
              const SizedBox(height: 24),
              const Text(
                'Trip dates',
                style: headertext,
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _departureDateController,
                readOnly: true,
                onTap: () async {
                  DateTime selectedDate = await showBottomCalendarPicker(
                        context,
                        initialDate: DateTime.now(),
                      ) ??
                      DateTime.now();
                  setState(() {
                    _departureDate = selectedDate;
                    _departureDateController.text =
                        DateFormat('yyyy-MM-dd').format(selectedDate);
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Departure date',
                  prefixIcon: const Icon(Icons.calendar_today_outlined,
                      color: Color(0xFF81B29A)),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _returnDateController,
                readOnly: true,
                onTap: () async {
                  DateTime selectedDate = await showBottomCalendarPicker(
                        context,
                        initialDate: DateTime.now(),
                      ) ??
                      DateTime.now();
                  setState(() {
                    _returnDate = selectedDate;
                    _returnDateController.text =
                        DateFormat('yyyy-MM-dd').format(selectedDate);
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Return date',
                  prefixIcon: const Icon(Icons.calendar_today_outlined,
                      color: Color(0xFF81B29A)),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 10),
              const SizedBox(height: 8),
              Text(
                _departureDate != null && _returnDate != null
                    ? '${_calculateDaysBetweenDates(_departureDate!, _returnDate!)} days (${_calculateNightsBetweenDates(_departureDate!, _returnDate!)} nights)'
                    : '0 day (0 night)',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              const SizedBox(height: 24),
              const Text(
                'Type of trip',
                style: headertext,
              ),
              const SizedBox(height: 16),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                crossAxisSpacing: 24,
                mainAxisSpacing: 24,
                children: [
                  _buildTripTypeButton(
                      'Business', Icons.work_outline, Colors.black,
                      isSelected: _selectedTripType == 'Business',
                      onPressed: () {
                    setState(() {
                      _selectedTripType = 'Business';
                    });
                  }),
                  _buildTripTypeButton(
                      'Leisure', Icons.beach_access_outlined, Colors.red,
                      isSelected: _selectedTripType == 'Leisure',
                      onPressed: () {
                    setState(() {
                      _selectedTripType = 'Leisure';
                    });
                  }),
                  _buildTripTypeButton(
                      'Nature', Icons.eco_outlined, Colors.green,
                      isSelected: _selectedTripType == 'Nature', onPressed: () {
                    setState(() {
                      _selectedTripType = 'Nature';
                    });
                  }),
                  _buildTripTypeButton(
                      'Culture', Icons.account_balance_outlined, Colors.teal,
                      isSelected: _selectedTripType == 'Culture',
                      onPressed: () {
                    setState(() {
                      _selectedTripType = 'Culture';
                    });
                  }),
                  _buildTripTypeButton(
                      'Education', Icons.school_outlined, Colors.orange,
                      isSelected: _selectedTripType == 'Education',
                      onPressed: () {
                    setState(() {
                      _selectedTripType = 'Education';
                    });
                  }),
                ],
              ),
              const SizedBox(height: 24),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ActivitiesListsScreen(
                 destination: _searchEditingController.text,
                        departureDate: _departureDate,
                        returnDate: _returnDate,
                        tripType: _selectedTripType,
              ),
            ),
          );
        },
        child: Container(
          width: double.infinity,
          color: const Color(0xFF3D405B),
          height: 60,
          child: const Center(
            child: Text(
              'Select activities',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTripTypeButton(String label, IconData icon, Color iconColor,
      {bool isSelected = false, required VoidCallback? onPressed}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(16.0),
        backgroundColor: isSelected ? Color(0xFF81B29A) : Colors.grey[100],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        elevation: 0,
      ),
      onPressed: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: isSelected ? Colors.white : iconColor, size: 32),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(color: isSelected ? Colors.white : Colors.black),
          ),
        ],
      ),
    );
  }

  Future<DateTime?> showBottomCalendarPicker(
    BuildContext context, {
    required DateTime initialDate,
  }) async {
    DateTime? selectedDate = initialDate;

    return showModalBottomSheet<DateTime>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 16),
                  Text(
                    'Pick a Date',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Divider(thickness: 1),
                  SizedBox(
                    height: 300,
                    child: CalendarDatePicker(
                      initialDate: initialDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                      onDateChanged: (newDate) {
                        setState(() {
                          selectedDate = newDate;
                        });
                      },
                    ),
                  ),
                  const Divider(thickness: 1),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(selectedDate);
                    },
                    child: const Text('Done'),
                  ),
                  const SizedBox(height: 16),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
