import 'package:flutter/material.dart';
import 'package:tour/AppColors/colors.dart';
import 'package:tour/Pages/ThingsToDoDetails.dart';
import 'package:tour/Widgets/BottomNavigationBar.dart';

class ThingsToDoPage extends StatefulWidget {
  final String city;

  ThingsToDoPage({required this.city});

  @override
  _ThingsToDoPageState createState() => _ThingsToDoPageState();
}

class _ThingsToDoPageState extends State<ThingsToDoPage> {
  late List<ThingsToDoDetails> thingsToDoList;
  late List<ThingsToDoDetails> filteredList;

  @override
  void initState() {
    super.initState();
    thingsToDoList = _generateThingsToDoList(widget.city);
    filteredList = List.from(thingsToDoList);
  }

  static List<ThingsToDoDetails> _generateThingsToDoList(String city) {
    switch (city) {
      case 'Amman':
        return [
          ThingsToDoDetails(
            name: 'The Royal Automobile Museum',
            imagePaths: [
              'images/' + city + '1.jpg',
              'images/' + city + '11.jpg',
              'images/' + city + '12.jpg',
              'images/' + city + '13.jpg',
              'images/' + city + '14.jpg',
              'images/' + city + '15.jpg',
              'images/' + city + '16.jpg',
            ],
            location: 'Al Hussein Public Parks, Amman 11953 Jordan',
            description:
                "The Royal Automobile Museum provides a captivating journey through time, offering visitors a glimpse into the development of automobiles and their cultural significance. The museum features a diverse collection of vintage and modern vehicles, including cars once owned by Jordan's royal family. Each exhibit is carefully curated to highlight the technological advancements, design innovations, and historical context of the showcased automobiles.\n\n" +
                    "Visitors to the museum can explore a wide range of vehicles, from classic cars that represent the early days of automotive engineering to more contemporary models that demonstrate the industry's progression. The exhibits are complemented by informative displays, multimedia presentations, and interactive elements, providing an engaging and educational experience for automotive enthusiasts and casual visitors alike.\n\n" +
                    "The Royal Automobile Museum not only celebrates the evolution of automobiles but also sheds light on the role of these vehicles in shaping the cultural and social landscape of Jordan. It is a must-visit destination for those interested in automotive history, design, and the cultural impact of automobiles on society.",
          ),
          ThingsToDoDetails(
            name: 'AlHussein Public Parks',
            imagePaths: [
              'images/' + city + '2.jpg',
              'images/' + city + '21.jpg',
              'images/' + city + '22.jpg',
              'images/' + city + '23.jpg',
              'images/' + city + '24.jpg',
              'images/' + city + '25.jpg',
            ],
            location: 'King Abdullah II St A208, Amman',
            description: 'Al-Hussein Public Parks serve as a haven for relaxation, family picnics, and social gatherings. ' +
                'The well-maintained greenery, shaded pathways, and open spaces create a welcoming environment for ' +
                'individuals of all ages. Visitors can enjoy a leisurely stroll, jog, or simply unwind amidst nature.\n\n' +
                'The parks feature playgrounds for children, making them family-friendly destinations. These play areas are ' +
                'equipped with swings, slides, and other recreational facilities, providing a safe and enjoyable space for ' +
                'kids to play and have fun.\n\n' +
                'In addition to the natural beauty, Al-Hussein Public Parks often host cultural events, festivals, and ' +
                'community activities. These events contribute to a vibrant atmosphere, fostering a sense of community ' +
                'and bringing people together to celebrate various occasions.\n\n' +
                'The strategic location of these parks within Amman makes them easily accessible to residents and tourists ' +
                'alike. Whether seeking a peaceful retreat from the bustling city life or engaging in outdoor exercises, ' +
                'Al-Hussein Public Parks offer a well-rounded experience for those looking to connect with nature and ' +
                'enjoy recreational pursuits.',
          ),
          ThingsToDoDetails(
            name: 'Amman Citadel',
            imagePaths: [
              'images/' + city + '3.png',
              'images/' + city + '31.jpg',
              'images/' + city + '32.jpg',
              'images/' + city + '33.jpg',
              'images/' + city + '34.jpg',
              'images/' + city + '35.jpg',
            ],
            location: 'K. Ali Ben Al-Hussein St. 146, Amman',
            description: 'Amman Citadel, perched atop one of the city\'s seven hills, stands as a historic site ' +
                'that narrates the rich tapestry of Jordan\'s past. Also known as Jabal al-Qal\'a, the Citadel ' +
                'boasts archaeological remnants spanning multiple civilizations and epochs.\n\n' +
                'The site showcases artifacts from the Bronze Age, as well as remnants from the Roman, Byzantine, ' +
                'and Umayyad periods. Among the notable structures is the Temple of Hercules, a Roman Hercules ' +
                'temple with massive pillars that offer panoramic views of the city.\n\n' +
                'The Umayyad Palace, a significant complex within the Citadel, reveals intricate architectural ' +
                'details and provides insight into the Umayyad dynasty\'s influence in the region. Visitors can ' +
                'explore the expansive courtyards and chambers that once echoed with the footsteps of ancient rulers.\n\n' +
                'Amman Citadel serves not only as an archaeological site but also as an elevated vantage point ' +
                'offering breathtaking vistas of modern Amman. The juxtaposition of ancient ruins against the backdrop ' +
                'of a thriving city adds to the Citadel\'s allure, making it a must-visit destination for history enthusiasts ' +
                'and those eager to uncover the layers of Jordan\'s captivating heritage.',
          ),
          ThingsToDoDetails(
            name: 'The Boulevard JO',
            imagePaths: [
              'images/' + city + '4.jpg',
              'images/' + city + '41.jpg',
              'images/' + city + '42.jpg',
              'images/' + city + '43.jpg',
              'images/' + city + '44.jpg',
            ],
            location: 'JamAl-Al-Juqah St. 38, Amman',
            description: 'Abdali Boulevard stands as a vibrant and modern district in the heart of Amman, ' +
                'Jordan, offering a dynamic blend of entertainment, commerce, and urban living. This ' +
                'pedestrian-friendly boulevard is a bustling hub where locals and visitors converge ' +
                'to experience a diverse array of attractions.\n\n' +
                'Lined with contemporary architecture, Abdali Boulevard features an array of shops, ' +
                'boutiques, cafes, and restaurants, providing a chic and cosmopolitan atmosphere for ' +
                'those exploring its streets. The boulevard is a popular destination for shopping, dining, ' +
                'and socializing, making it an integral part of Amman\'s modern urban landscape.\n\n' +
                'One of the key highlights of Abdali Boulevard is its commitment to hosting cultural ' +
                'events, live performances, and public festivities. This contributes to a lively and ' +
                'engaging environment, fostering a sense of community and enriching the cultural fabric ' +
                'of the city.\n\n' +
                'The strategic location of Abdali Boulevard makes it a central point for business and leisure, ' +
                'connecting various parts of the city and serving as a focal point for both locals and tourists. ' +
                'Whether one is interested in shopping, dining, or simply enjoying the vibrant urban atmosphere, ' +
                'Abdali Boulevard offers a modern and cosmopolitan experience in the heart of Amman.',
          ),
          ThingsToDoDetails(
            name: 'The Jordan Museum',
            imagePaths: [
              'images/' + city + '5.jpg',
              'images/' + city + '51.jpg',
              'images/' + city + '52.jpg',
              'images/' + city + '53.jpg',
              'images/' + city + '54.jpg',
              'images/' + city + '55.jpg',
              'images/' + city + '56.jpg',
              'images/' + city + '57.jpg',
              'images/' + city + '58.jpg',
            ],
            location: 'Ali bin Abi Taleb Street Ras Al-Ayn Area',
            description: 'The Jordan Museum, located in the heart of Amman, stands as a beacon of the ' +
                'country\'s rich cultural heritage and historical significance. This world-class ' +
                'museum offers a captivating journey through time, showcasing the diverse history, ' +
                'archaeological treasures, and cultural legacy of Jordan.\n\n' +
                'The museum\'s extensive collection spans various eras, from prehistoric times to ' +
                'modern-day Jordan. Visitors can explore artifacts, sculptures, and exhibits that ' +
                'illuminate the fascinating stories of the region, including the ancient Nabatean ' +
                'civilization, the Roman period, and the contributions of various cultures that have ' +
                'shaped Jordan\'s history.\n\n' +
                'One of the museum\'s highlights is the presentation of the Dead Sea Scrolls, a ' +
                'priceless collection of ancient manuscripts that provide insights into religious ' +
                'and historical texts. The Jordan Museum\'s commitment to preserving and presenting ' +
                'Jordan\'s heritage is evident in its modern and interactive displays, offering an ' +
                'engaging and educational experience for visitors of all ages.\n\n' +
                'The architectural design of The Jordan Museum itself is a testament to modern ' +
                'sophistication, providing a fitting backdrop for the nation\'s cultural treasures. ' +
                'Whether you are a history enthusiast, art lover, or a curious traveler, a visit ' +
                'to The Jordan Museum promises a profound exploration of Jordan\'s rich and diverse ' +
                'cultural tapestry.',
          ),
          ThingsToDoDetails(
            name: 'Roman Theater',
            imagePaths: [
              'images/' + city + '6.jpg',
              'images/' + city + '61.jpg',
              'images/' + city + '62.jpg',
              'images/' + city + '63.jpg',
            ],
            location: 'Taha Al-Hashemi St., Amman',
            description: 'The Roman Theatre in Amman, Jordan, stands as an iconic testament to the ' +
                'ancient city\'s rich history and architectural prowess. Built during the ' +
                'reign of Emperor Antoninus Pius (138-161 AD), this historic amphitheater ' +
                'is a remarkable showcase of Roman engineering and a focal point of Amman\'s ' +
                'archaeological treasures.\n\n' +
                'Carved into the hillsides of Amman, the Roman Theatre offers visitors ' +
                'a captivating glimpse into the grandeur of Roman entertainment and civic life. ' +
                'With a seating capacity that once accommodated thousands, the theatre was a ' +
                'hub for various performances, including theatrical productions, gladiator ' +
                'contests, and public assemblies.\n\n' +
                'The architectural design of the Roman Theatre reflects the classical style ' +
                'of Roman amphitheaters, featuring a semi-circular orchestra, tiered seating ' +
                'sections, and a stage framed by ornate columns. The theatre\'s location ' +
                'provides panoramic views of downtown Amman and the surrounding hills, ' +
                'adding to the overall enchantment of the site.\n\n' +
                'Today, the Roman Theatre is not only a historical landmark but also a ' +
                'venue for cultural events and performances, connecting the present ' +
                'generation to the ancient legacy of Amman and its enduring cultural ' +
                'significance.',
          ),
          ThingsToDoDetails(
            name: 'King Abdullah I Mosque',
            imagePaths: [
              'images/' + city + '7.jpg',
              'images/' + city + '71.jpg',
              'images/' + city + '72.jpg',
              'images/' + city + '73.jpg',
              'images/' + city + '74.jpg',
            ],
            location: 'XW67+F4H, Amman',
            description: 'The King Abdullah I Mosque, situated in Amman, Jordan, stands as a ' +
                'magnificent symbol of modern Islamic architecture and spiritual significance. ' +
                'Constructed between 1982 and 1989, this grand mosque was built in memory ' +
                'of King Abdullah I, the founder of the Hashemite Kingdom of Jordan.\n\n' +
                'Designed by the architect Abdel-Wahed El-Wakil, the King Abdullah I Mosque ' +
                'showcases a harmonious blend of traditional Islamic elements and contemporary ' +
                'architectural features. The mosque\'s distinctive blue dome, minarets, and ' +
                'ornate geometric patterns reflect the beauty of Islamic art and design.\n\n' +
                'The interior of the mosque is equally impressive, with a central dome ' +
                'adorned with intricate calligraphy and geometric patterns. The prayer hall ' +
                'can accommodate a large congregation, and the mosque\'s design emphasizes ' +
                'an open and inclusive atmosphere.\n\n' +
                'Set against the backdrop of the Amman skyline, the King Abdullah I Mosque ' +
                'is a prominent landmark that not only serves as a place of worship but also ' +
                'as a cultural and architectural gem, welcoming visitors to appreciate ' +
                'Jordan\'s rich heritage and religious diversity.',
          ),
        ];

      case 'Aqaba':
        return [
          ThingsToDoDetails(
            name: 'Saraya Aqaba Waterpark',
            imagePaths: [
              'images/' + city + '6.jpg',
              'images/' + city + '61.jpg',
              'images/' + city + '62.jpg',
              'images/' + city + '63.jpg',
              'images/' + city + '64.jpg',
            ],
            location: 'Saraya Aqaba, Aqaba',
            description:
                'Saraya Aqaba Waterpark is a popular aquatic destination located in Aqaba, Jordan. '
                'This vibrant and entertaining waterpark offers a wide range of attractions and activities '
                'for visitors of all ages. With its thrilling water slides, refreshing wave pool, and relaxing '
                'lazy river, Saraya Aqaba Waterpark provides an ideal escape from the desert heat and a fantastic '
                'venue for enjoying fun and excitement with family and friends.\n\n'
                'The waterpark boasts a variety of slides, each catering to different levels of thrill-seekers. '
                'Whether you prefer heart-pounding rides that send you plummeting down steep chutes or more leisurely '
                'adventures that allow you to unwind as you float along the lazy river, Saraya Aqaba Waterpark has something '
                'for everyone.\n\n'
                'For families, the waterpark often features dedicated areas with kid-friendly attractions, ensuring that '
                'even the youngest visitors can have a memorable and safe experience. The vibrant and colorful surroundings '
                'create a lively atmosphere, making it an excellent place for celebrations, group outings, and memorable vacations.\n\n'
                'With its convenient location in Aqaba, near the shores of the Red Sea, Saraya Aqaba Waterpark offers a delightful '
                'blend of aquatic thrills and beautiful coastal views. Visitors can bask in the sun, enjoy delicious refreshments, '
                'and take in the scenic surroundings.\n\n'
                'Whether you\'re seeking an adrenaline rush, a relaxing day by the water, or a family-friendly adventure, Saraya Aqaba '
                'Waterpark is a fantastic destination to cool off and have a splashing good time in Jordan\'s enchanting city of Aqaba.',
          ),
          ThingsToDoDetails(
            name: 'B12 Beach Club',
            imagePaths: [
              'images/' + city + '7.jpg',
              'images/' + city + '71.jpg',
              'images/' + city + '72.jpg',
              'images/' + city + '73.jpg',
              'images/' + city + '74.jpg',
              'images/' + city + '75.jpg',
            ],
            location: 'Zan Street, Aqaba',
            description:
                'B12 Beach Club is a renowned beachfront destination nestled along the picturesque shores of Aqaba, Jordan. '
                'This exclusive club offers a perfect blend of relaxation and entertainment in a stunning coastal setting.\n\n'
                'With its pristine sandy beaches, crystal-clear waters of the Red Sea, and luxurious amenities, B12 Beach Club '
                'provides an idyllic escape for visitors seeking a tranquil beach experience and vibrant social scene. '
                'Guests can soak up the sun on comfortable lounge chairs, take refreshing dips in the sea, or indulge in water sports '
                'and activities.\n\n'
                'The club features a stylish beachfront restaurant and bar where patrons can savor delicious cuisine and cocktails '
                'while enjoying panoramic views of the Red Sea. The menu offers a variety of international and local dishes, '
                'promising a delightful culinary experience.\n\n'
                'B12 Beach Club is known for its lively atmosphere, often hosting live music performances, beach parties, and '
                'special events. It\'s a popular destination for both tourists and locals, making it an excellent place to socialize, '
                'meet new people, and create lasting memories.\n\n'
                'The club\'s attentive staff and high-end facilities ensure that guests have a comfortable and enjoyable visit. '
                'Whether you\'re looking for a relaxing day at the beach, a vibrant nightlife scene, or a combination of both, '
                'B12 Beach Club is the perfect spot to unwind and savor the beauty of Aqaba.',
          ),
          ThingsToDoDetails(
            name: 'Aqaba Archaeological Museum',
            imagePaths: [
              'images/' + city + '1.jpg',
              'images/' + city + '11.jpg',
              'images/' + city + '12.jpg',
              'images/' + city + '13.jpg',
              'images/' + city + '14.jpg',
              'images/' + city + '15.jpg',
              'images/' + city + '16.jpg',
            ],
            location: 'G2C2+JHG, Aqaba',
            description:
                'Aqaba Archaeological Museum is a fascinating cultural institution located in Aqaba, Jordan. '
                'This museum offers a captivating journey through the history and heritage of the Aqaba region, '
                'making it a must-visit destination for history enthusiasts and curious travelers.\n\n'
                'The museum\'s extensive collection includes archaeological artifacts, ancient relics, and historical treasures '
                'that date back to various periods, including the Nabatean, Roman, and Islamic eras. Visitors can explore '
                'exhibits that showcase the rich cultural tapestry of Aqaba and its significance as a crossroads of ancient civilizations.\n\n'
                'One of the museum\'s highlights is its display of artifacts from the famous shipwreck of the Red Sea, '
                'offering insight into the maritime history of the region. Visitors can also admire intricately crafted pottery, '
                'jewelry, and sculptures that provide glimpses into the daily lives of the people who once inhabited this coastal area.\n\n'
                'Aqaba Archaeological Museum\'s exhibits are thoughtfully curated, with informative displays and historical context '
                'that enhance the visitor\'s understanding of the region. The museum provides a valuable educational experience for '
                'those interested in archaeology, history, and the cultural heritage of Aqaba and its surroundings.\n\n'
                'Set against the backdrop of Aqaba\'s modern landscape, the museum offers a bridge between the past and the present, '
                'inviting visitors to explore the ancient mysteries and stories that have shaped this coastal city.',
          ),
          ThingsToDoDetails(
            name: 'Virtual Reality Museum By Jordan Heritage',
            imagePaths: [
              'images/' + city + '3.jpg',
              'images/' + city + '31.jpg',
              'images/' + city + '32.jpg',
              'images/' + city + '33.jpg',
              'images/' + city + '34.jpg',
            ],
            location: 'Ali Ben Abi Taleb St., Aqaba 77110',
            description:
                'Virtual Reality Museum by Jordan Heritage is an innovative and immersive cultural experience '
                'located in Jordan. This cutting-edge museum combines technology and history to transport visitors '
                'to different eras and places, offering a unique way to explore Jordan\'s rich heritage and historical sites.\n\n'
                'Unlike traditional museums, the Virtual Reality Museum leverages state-of-the-art virtual reality (VR) technology '
                'to provide visitors with an interactive and educational journey. Through VR headsets and simulations, guests '
                'can virtually step into the past and explore ancient archaeological sites, historical landmarks, and cultural '
                'heritage sites.\n\n'
                'The museum offers a diverse range of VR experiences, allowing visitors to walk through the ancient city of Petra, '
                'explore the magnificent ruins of Jerash, or witness historical events and moments from Jordan\'s history.\n\n'
                'What sets this museum apart is its ability to create a sense of presence and immersion, making visitors feel '
                'like they are truly on location in these historical settings. It\'s an excellent way to learn about Jordan\'s heritage, '
                'architecture, and cultural significance while experiencing the past in a new and engaging way.\n\n'
                'Virtual Reality Museum by Jordan Heritage is a testament to the power of technology in preserving and sharing '
                'cultural treasures. It offers an exciting and educational adventure for individuals, families, and history enthusiasts '
                'who want to explore Jordan\'s historical and archaeological wonders through the lens of virtual reality.',
          ),
          ThingsToDoDetails(
            name: 'Ayla Golf Club',
            imagePaths: [
              'images/' + city + '4.jpg',
              'images/' + city + '41.jpg',
              'images/' + city + '42.jpg',
              'images/' + city + '43.jpg',
              'images/' + city + '44.jpg',
              'images/' + city + '45.jpg',
              'images/' + city + '46.jpg',
            ],
            location: 'Oasis, Aqaba',
            description:
                'Ayla Golf Club is a premier golfing destination situated in Aqaba, Jordan, offering golf enthusiasts '
                'an exceptional and scenic experience. Designed by the world-renowned golf course architect Greg Norman, '
                'this championship golf course is nestled along the picturesque shores of the Red Sea, providing golfers '
                'with breathtaking views and an unforgettable round of golf.\n\n'
                'The Ayla Golf Club features an 18-hole, par-72 golf course that blends seamlessly with the natural '
                'landscape of the Aqaba region. Lush fairways, strategically placed bunkers, and challenging water features '
                'create an exciting and dynamic course suitable for players of all skill levels.\n\n'
                'One of the highlights of Ayla Golf Club is its unique location, with several holes offering panoramic '
                'views of the Red Sea, enhancing the overall golfing experience. The course also incorporates elements of '
                'local culture and history, making it a truly distinctive destination for golfers and travelers.\n\n'
                'Besides the exceptional golfing opportunities, Ayla Golf Club provides a range of amenities and services, '
                'including a clubhouse with a restaurant and pro shop. Golfers can relax and enjoy a delicious meal while '
                'overlooking the scenic beauty of the course and the Red Sea.\n\n'
                'Whether you\'re a seasoned golfer looking for a challenging round or a beginner interested in learning the game, '
                'Ayla Golf Club offers an idyllic setting, world-class facilities, and a memorable golfing adventure by the '
                'shores of the Red Sea.',
          ),
          ThingsToDoDetails(
            name: 'Berenice Beach Club',
            imagePaths: [
              'images/' + city + '8.jpg',
              'images/' + city + '81.jpg',
              'images/' + city + '82.jpg',
              'images/' + city + '83.jpg',
              'images/' + city + '84.jpg',
              'images/' + city + '85.jpg',
            ],
            location: 'S Beach Hwy, Aqaba 77110',
            description:
                'Berenice Beach Club is a charming beachfront retreat located in Aqaba, Jordan, '
                'offering a relaxing and enjoyable coastal experience. Situated along the tranquil shores of the Red Sea, '
                'this beach club provides a serene and picturesque setting for visitors looking to unwind and soak up the sun.\n\n'
                'With its pristine sandy beaches and crystal-clear waters, Berenice Beach Club is an ideal destination for '
                'those seeking a beachside escape. Guests can sunbathe on the soft sands, take refreshing swims in the sea, '
                'and enjoy a variety of water sports and activities.\n\n'
                'The beach club offers comfortable lounging areas, beachfront cabanas, and shaded spots to relax and enjoy the '
                'scenic views. Whether you\'re looking for a peaceful day by the water or a more active beach experience, '
                'Berenice Beach Club caters to both leisure seekers and adventure enthusiasts.\n\n'
                'In addition to its natural beauty, the beach club features a restaurant and bar where guests can savor delicious '
                'cuisine and refreshing beverages. The culinary offerings include a variety of local and international dishes, '
                'making it a delightful spot for beachside dining.\n\n'
                'The tranquil ambiance and inviting atmosphere of Berenice Beach Club make it a popular choice for travelers '
                'looking to relax, unwind, and enjoy the beauty of the Red Sea coastline while in Aqaba.',
          ),
        ];

      default:
        return [];
    }
  }

  void _search(String query) {
    setState(() {
      filteredList = thingsToDoList
          .where((thingToDo) =>
              thingToDo.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundcolor,
      appBar: AppBar(
        backgroundColor: AppColors.buttomcolor,
        centerTitle: true,
        title: Text(
          'Things To Do In ${widget.city}',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Here Are Places In ${widget.city} That You Can Enjoy Visiting:',
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: _search,
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        suffixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                children: filteredList.map((thingToDo) {
                  return GestureDetector(
                    onTap: () {
                      // Navigate to a new page when image is clicked
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ThingsToDoDetails(
                            name: thingToDo.name,
                            imagePaths: thingToDo.imagePaths,
                            description: thingToDo.description,
                            location: thingToDo.location,
                          ),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Image.asset(
                          thingToDo.imagePaths.first,
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          thingToDo.name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: AppColors.buttomcolor),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Icon(Icons.location_on, color: Colors.grey),
                            const SizedBox(width: 8),
                            Text(
                              '${thingToDo.location}', // Display the actual location
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 42), // Adjusted spacing
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNav(),
    );
  }
}
