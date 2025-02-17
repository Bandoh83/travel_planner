import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travel_planner_app/constant.dart';
import 'package:travel_planner_app/screen/summary_trip.dart';

class ActivitiesListsScreen extends StatefulWidget {
    final String destination;
  final DateTime? departureDate;
  final DateTime? returnDate;
  final String tripType;
  
  const ActivitiesListsScreen({
    super.key, 
    required this.destination, 
    this.departureDate, 
    this.returnDate, 
    required this.tripType
    });

  @override
  State<ActivitiesListsScreen> createState() => _ActivitiesListsScreenState();
}

class _ActivitiesListsScreenState extends State<ActivitiesListsScreen> {
  String _selectedAccommodation = "";
  String _selectedTransportation = ""; 
  final Set<String> _selectedActivities = {}; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
       // title: const Text('Activities and Items'),
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSection(
              context,
              title: "Accommodation",
              items: [
                _buildItem(Icons.hotel, "Hotel", section: "Accommodation"),
                _buildItem(Icons.attach_money, "Rental", section: "Accommodation"),
                _buildItem(Icons.family_restroom, "Friends/Family", section: "Accommodation"),
                _buildItem(Icons.home, "Second Home", section: "Accommodation"),
                _buildItem(Icons.terrain, "Camping", section: "Accommodation"),
                _buildItem(Icons.directions_boat, "Cruise", section: "Accommodation"),
              ],
            ),
            _buildSection(
              context,
              title: "Transportation",
              items: [
                _buildItem(Icons.flight, "Aeroplane", section: "Transportation"),
                _buildItem(Icons.directions_car, "Car", section: "Transportation"),
                _buildItem(Icons.train, "Train", section: "Transportation"),
                _buildItem(Icons.motorcycle, "Motorcycling", section: "Transportation"),
                _buildItem(Icons.directions_boat, "Boat", section: "Transportation"),
                _buildItem(Icons.directions_bus, "Bus", section: "Transportation"),
              ],
            ),
            _buildSection(
              context,
              title: "Items",
              items: [
                _buildItem(Icons.warning, "Essentials", section: "Activities"),
                _buildItem(Icons.checkroom, "Clothes", section: "Activities"),
                _buildItem(Icons.file_copy_rounded, "Documents", section: "Activities"),
                _buildItem(Icons.bathtub, "Toiletries", section: "Activities"),
                _buildItem(Icons.work, "Working tools", section: "Activities"),
               
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
         Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PlannedTripPage(
                destination: widget.destination,
                departureDate: widget.departureDate,
                returnDate: widget.returnDate,
                tripType: widget.tripType,
                accommodation: _selectedAccommodation,
                transportation: _selectedTransportation,
                activities: _selectedActivities,
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
              'Create Trip',
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

  Widget _buildSection(BuildContext context, {required String title, required List<Widget> items}) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: headertext),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                children: items,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(IconData icon, String label, {required String section}) {
    final bool isSelected = (section == "Accommodation" && _selectedAccommodation == label) ||
        (section == "Transportation" && _selectedTransportation == label) ||
        (section == "Activities" && _selectedActivities.contains(label));

    return GestureDetector(
      onTap: () {
        setState(() {
          if (section == "Accommodation") {
            _selectedAccommodation = _selectedAccommodation == label ? "" : label;
          } else if (section == "Transportation") {
            _selectedTransportation = _selectedTransportation == label ? "" : label;
          } else if (section == "Activities") {
            if (_selectedActivities.contains(label)) {
              _selectedActivities.remove(label);
            } else {
              _selectedActivities.add(label);
            }
          }
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: isSelected ? const Color(0xFF81B29A) : Colors.white,
            child: Icon(icon, size: 28, color: isSelected ? Colors.white : const Color(0xFF81B29A)),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
