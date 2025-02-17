import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:provider/provider.dart';
import 'package:travel_planner_app/constant.dart';
import 'package:travel_planner_app/models/destination_provider.dart';
import 'package:travel_planner_app/screen/plan_trip.dart';
import 'package:travel_planner_app/widgets/destinations.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});

  final _searchEditingController = TextEditingController();
     

  @override
  Widget build(BuildContext context) {
     final destinationProvider = Provider.of<DestinationProvider>(context, listen: false);
    final List<Map<String, dynamic>> destinations = [
      {
        'title': 'Aqua Safari',
        'rating': 4.5,
        'imageUrl':
            'https://foto.hrsstatic.com/fotos/0/2/1600/916/80/000000/http%3A%2F%2Ffoto-origin.hrsstatic.com%2Ffoto%2Fdms%2F1010260%2FAMADEUS%2F537fe251270b49f7ae22497272354eca.jpeg/c75006261d94385bd1d0ef2c5c932a3e/512%2C341/6/THE_ROYAL_SENCHI_RESORT-Akosombo-Restaurant-1010260.jpg',
        'description': 'Relax by the serene waters of Aqua Safari.'
      },
      {
        'title': 'Peduase Valley',
        'rating': 4.0,
        'imageUrl':
            'https://foto.hrsstatic.com/fotos/0/2/1600/916/80/000000/http%3A%2F%2Ffoto-origin.hrsstatic.com%2Ffoto%2Fdms%2F1010260%2FAMADEUS%2Ffc8ad7b152964b3e93aaeb72622cef03.jpeg/6fa8f8b98a05b8c60000581ccbc2649a/512%2C287/6/THE_ROYAL_SENCHI_RESORT-Akosombo-Exterior_view-3-1010260.jpg',
        'description': 'Experience nature like never before.'
      },
      {
        'title': 'Royal Senchi',
        'rating': 5.0,
        'imageUrl':
            'https://q-xx.bstatic.com/xdata/images/hotel/max1024x768/182727233.jpg?k=c468979d59c4ffa856e1fe53e7637b483f27032822a61397b64876037d58a96b&o=?s=375x210&ar=16x9',
        'description': 'Luxury at its finest.'
      },
      {
        'title': 'Ridge condos',
        'rating': 4.2,
        'imageUrl':
            'https://ridgecondos.com.gh/wp-content/uploads/2023/02/20230209_175901-1-scaled.jpg',
        'description': 'A perfect getaway at the coast.'
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(Icons.person, size: 28, color: Colors.black),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Welcome back !', style: headertext),
                  Text('Get started with a dream trip')
                ],
              ),
            ),
            Stack(
              children: [
                CarouselSlider(
                  items: [
                    'https://q-xx.bstatic.com/xdata/images/hotel/max1024x768/182727233.jpg?k=c468979d59c4ffa856e1fe53e7637b483f27032822a61397b64876037d58a96b&o=?s=375x210&ar=16x9',
                    'https://www.203challenges.com/wp-content/uploads/2017/12/nathaniel-kohfield-337185-e1514446401837.jpg',
                    'https://foto.hrsstatic.com/fotos/0/2/1600/916/80/000000/http%3A%2F%2Ffoto-origin.hrsstatic.com%2Ffoto%2Fdms%2F1010260%2FAMADEUS%2F537fe251270b49f7ae22497272354eca.jpeg/c75006261d94385bd1d0ef2c5c932a3e/512%2C341/6/THE_ROYAL_SENCHI_RESORT-Akosombo-Restaurant-1010260.jpg',
                  ].map((imageUrl) {
                    return ClipRRect(
                      child: Image.network(
                        imageUrl,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    );
                  }).toList(),
                  options: CarouselOptions(
                    height: 200,
                    viewportFraction: 1.0,
                    autoPlay: true,
                  ),
                ),
                Positioned(
                  bottom: 16,
                  left: 16,
                  right: 16,
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: GooglePlaceAutoCompleteTextField(
                      googleAPIKey: apiKey,
                      textEditingController: _searchEditingController,
                      inputDecoration: InputDecoration(
                        hintText: 'Search destinations...',
                        prefixIcon: const Icon(Icons.search),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                      ),
                      debounceTime: 300,
                      countries: const ["GH"],
                      isLatLngRequired: true,
                      itemClick: (prediction) {
                        _searchEditingController.text = prediction.description!;
                        destinationProvider.updateSelectedDestination(prediction.description!);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const TripPlannerScreen()),
                  );
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Welcome Text
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('Our top destinations for you', style: headertext),
            ),
            const SizedBox(height: 8),

            // Grid of Destination Cards
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.8,
                ),
                itemCount: destinations.length,
                itemBuilder: (context, index) {
                  final destination = destinations[index];
                  return GestureDetector(
                     onTap: () { destinationProvider.updateSelectedDestination(destination['title']);                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const TripPlannerScreen()),
                    );
                     },
                    child: DestinationCard(
                      title: destination['title'],
                      rating: destination['rating'],
                      imageUrl: destination['imageUrl'],
                      description: destination['description'],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: GestureDetector(
        onTap: () {
          destinationProvider.updateSelectedDestination(_searchEditingController.text);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const TripPlannerScreen()));
                  
        },
        child: Container(
          color: Color(0xFF3D405B),
          height: 60,
          child: Center(
            child: const Text(
              'Plan trip',
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
}
