// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:tour/Pages/ThingsToDoDetails.dart';

class ThingsToDoDataProvider {
  static List<ThingsToDoDetails> generateThingsToDoList(String city) {
    switch (city) {
      case 'Amman':
        return [
          ThingsToDoDetails(
            name: 'The Royal Automobile Museum',
            imagePaths: [
              'images/${city}1.jpg',
              'images/${city}11.jpg',
              'images/${city}12.jpg',
              'images/${city}13.jpg',
              'images/${city}14.jpg',
              'images/${city}15.jpg',
              'images/${city}16.jpg',
            ],
            location: 'Al Hussein Public Parks, Amman 11953 Jordan',
            description:
                "The Royal Automobile Museum provides a captivating journey through time, offering visitors a glimpse into the development of automobiles and their cultural significance. The museum features a diverse collection of vintage and modern vehicles, including cars once owned by Jordan's royal family. Each exhibit is carefully curated to highlight the technological advancements, design innovations, and historical context of the showcased automobiles.\n\nVisitors to the museum can explore a wide range of vehicles, from classic cars that represent the early days of automotive engineering to more contemporary models that demonstrate the industry's progression. The exhibits are complemented by informative displays, multimedia presentations, and interactive elements, providing an engaging and educational experience for automotive enthusiasts and casual visitors alike.\n\nThe Royal Automobile Museum not only celebrates the evolution of automobiles but also sheds light on the role of these vehicles in shaping the cultural and social landscape of Jordan. It is a must-visit destination for those interested in automotive history, design, and the cultural impact of automobiles on society.",
            workingHours: [
              WorkingHours(
                  days: 'Saturday - Thursday',
                  openTime: '10:00 AM',
                  closeTime: '7:00 PM'),
              WorkingHours(
                  days: 'Friday', openTime: '11:00 AM', closeTime: '7:00 PM'),
              WorkingHours(days: 'Tuesday', openTime: 'Closed', closeTime: ''),
            ],
          ),
          ThingsToDoDetails(
            name: 'AlHussein Public Parks',
            imagePaths: [
              'images/${city}2.jpg',
              'images/${city}21.jpg',
              'images/${city}22.jpg',
              'images/${city}23.jpg',
              'images/${city}24.jpg',
              'images/${city}25.jpg',
            ],
            location: 'King Abdullah II St A208, Amman',
            description:
                'Al-Hussein Public Parks serve as a haven for relaxation, family picnics, and social gatherings. The well-maintained greenery, shaded pathways, and open spaces create a welcoming environment for individuals of all ages. Visitors can enjoy a leisurely stroll, jog, or simply unwind amidst nature.\n\nThe parks feature playgrounds for children, making them family-friendly destinations. These play areas are equipped with swings, slides, and other recreational facilities, providing a safe and enjoyable space for kids to play and have fun.\n\nIn addition to the natural beauty, Al-Hussein Public Parks often host cultural events, festivals, and community activities. These events contribute to a vibrant atmosphere, fostering a sense of community and bringing people together to celebrate various occasions.\n\nThe strategic location of these parks within Amman makes them easily accessible to residents and tourists alike. Whether seeking a peaceful retreat from the bustling city life or engaging in outdoor exercises, Al-Hussein Public Parks offer a well-rounded experience for those looking to connect with nature and enjoy recreational pursuits.',
            workingHours: [
              WorkingHours(
                  days: 'Monday', openTime: '6:00 AM', closeTime: '11:00 PM'),
              WorkingHours(days: 'Tuesday', openTime: 'Closed', closeTime: ''),
              WorkingHours(
                  days: 'Wednesday', openTime: '6:00 AM', closeTime: '1:00 PM'),
              WorkingHours(
                  days: 'Thursday', openTime: '6:00 AM', closeTime: '1:00 PM'),
              WorkingHours(
                  days: 'Friday', openTime: '6:00 AM', closeTime: '1:00 PM'),
              WorkingHours(
                  days: 'Saturday', openTime: '6:00 AM', closeTime: '1:00 PM'),
              WorkingHours(
                  days: 'Sunday', openTime: '6:00 AM', closeTime: '1:00 PM'),
            ],
          ),
          ThingsToDoDetails(
            name: 'Amman Citadel',
            imagePaths: [
              'images/${city}3.png',
              'images/${city}31.jpg',
              'images/${city}32.jpg',
              'images/${city}33.jpg',
              'images/${city}34.jpg',
              'images/${city}35.jpg',
            ],
            location: 'K. Ali Ben Al-Hussein St. 146, Amman',
            description:
                'Amman Citadel, perched atop one of the city\'s seven hills, stands as a historic site that narrates the rich tapestry of Jordan\'s past. Also known as Jabal al-Qal\'a, the Citadel boasts archaeological remnants spanning multiple civilizations and epochs.\n\nThe site showcases artifacts from the Bronze Age, as well as remnants from the Roman, Byzantine, and Umayyad periods. Among the notable structures is the Temple of Hercules, a Roman Hercules temple with massive pillars that offer panoramic views of the city.\n\nThe Umayyad Palace, a significant complex within the Citadel, reveals intricate architectural details and provides insight into the Umayyad dynasty\'s influence in the region. Visitors can explore the expansive courtyards and chambers that once echoed with the footsteps of ancient rulers.\n\nAmman Citadel serves not only as an archaeological site but also as an elevated vantage point offering breathtaking vistas of modern Amman. The juxtaposition of ancient ruins against the backdrop of a thriving city adds to the Citadel\'s allure, making it a must-visit destination for history enthusiasts and those eager to uncover the layers of Jordan\'s captivating heritage.',
            workingHours: [
              WorkingHours(
                  days: 'Monday', openTime: '8:00 AM', closeTime: '7:00 PM'),
              WorkingHours(
                  days: 'Tuesday', openTime: '8:00 AM', closeTime: '7:00 PM'),
              WorkingHours(
                  days: 'Wednesday', openTime: '8:00 AM', closeTime: '7:00 PM'),
              WorkingHours(
                  days: 'Thursday', openTime: '8:00 AM', closeTime: '7:00 PM'),
              WorkingHours(
                  days: 'Friday', openTime: '8:00 AM', closeTime: '7:00 PM'),
              WorkingHours(
                  days: 'Saturday', openTime: '8:00 AM', closeTime: '7:00 PM'),
              WorkingHours(
                  days: 'Sunday', openTime: '8:00 AM', closeTime: '7:00 PM'),
            ],
          ),
          ThingsToDoDetails(
            name: 'Abdali Boulevard',
            imagePaths: [
              'images/${city}4.jpg',
              'images/${city}41.jpg',
              'images/${city}42.jpg',
              'images/${city}43.jpg',
              'images/${city}44.jpg',
            ],
            location: 'JamAl-Al-Juqah St. 38, Amman',
            description:
                'Abdali Boulevard stands as a vibrant and modern district in the heart of Amman, Jordan, offering a dynamic blend of entertainment, commerce, and urban living. This pedestrian-friendly boulevard is a bustling hub where locals and visitors converge to experience a diverse array of attractions.\n\nLined with contemporary architecture, Abdali Boulevard features an array of shops, boutiques, cafes, and restaurants, providing a chic and cosmopolitan atmosphere for those exploring its streets. The boulevard is a popular destination for shopping, dining, and socializing, making it an integral part of Amman\'s modern urban landscape.\n\nOne of the key highlights of Abdali Boulevard is its commitment to hosting cultural events, live performances, and public festivities. This contributes to a lively and engaging environment, fostering a sense of community and enriching the cultural fabric of the city.\n\nThe strategic location of Abdali Boulevard makes it a central point for business and leisure, connecting various parts of the city and serving as a focal point for both locals and tourists. Whether one is interested in shopping, dining, or simply enjoying the vibrant urban atmosphere, Abdali Boulevard offers a modern and cosmopolitan experience in the heart of Amman.',
            workingHours: [
              WorkingHours(
                  days: 'Monday', openTime: '8:00 AM', closeTime: '10:00 PM'),
              WorkingHours(
                  days: 'Tuesday', openTime: '8:00 AM', closeTime: '10:00 PM'),
              WorkingHours(
                  days: 'Wednesday',
                  openTime: '8:00 AM',
                  closeTime: '10:00 PM'),
              WorkingHours(
                  days: 'Thursday', openTime: '8:00 AM', closeTime: '10:00 PM'),
              WorkingHours(
                  days: 'Friday', openTime: '8:00 AM', closeTime: '10:00 PM'),
              WorkingHours(
                  days: 'Saturday', openTime: '8:00 AM', closeTime: '10:00 PM'),
              WorkingHours(
                  days: 'Sunday', openTime: '8:00 AM', closeTime: '10:00 PM'),
            ],
          ),
          ThingsToDoDetails(
            name: 'The Jordan Museum',
            imagePaths: [
              'images/${city}5.jpg',
              'images/${city}51.jpg',
              'images/${city}52.jpg',
              'images/${city}53.jpg',
              'images/${city}54.jpg',
              'images/${city}55.jpg',
              'images/${city}56.jpg',
              'images/${city}57.jpg',
              'images/${city}58.jpg',
            ],
            location: 'Ali bin Abi Taleb Street Ras Al-Ayn Area',
            description:
                'The Jordan Museum, located in the heart of Amman, stands as a beacon of the country\'s rich cultural heritage and historical significance. This world-class museum offers a captivating journey through time, showcasing the diverse history, archaeological treasures, and cultural legacy of Jordan.\n\nThe museum\'s extensive collection spans various eras, from prehistoric times to modern-day Jordan. Visitors can explore artifacts, sculptures, and exhibits that illuminate the fascinating stories of the region, including the ancient Nabatean civilization, the Roman period, and the contributions of various cultures that have shaped Jordan\'s history.\n\nOne of the museum\'s highlights is the presentation of the Dead Sea Scrolls, a priceless collection of ancient manuscripts that provide insights into religious and historical texts. The Jordan Museum\'s commitment to preserving and presenting Jordan\'s heritage is evident in its modern and interactive displays, offering an engaging and educational experience for visitors of all ages.\n\nThe architectural design of The Jordan Museum itself is a testament to modern sophistication, providing a fitting backdrop for the nation\'s cultural treasures. Whether you are a history enthusiast, art lover, or a curious traveler, a visit to The Jordan Museum promises a profound exploration of Jordan\'s rich and diverse cultural tapestry.',
            workingHours: [
              WorkingHours(
                  days: 'Monday', openTime: '9:00 AM', closeTime: '4:00 PM'),
              WorkingHours(days: 'Tuesday', openTime: 'Closed', closeTime: ''),
              WorkingHours(
                  days: 'Wednesday', openTime: '9:00 AM', closeTime: '4:00 PM'),
              WorkingHours(
                  days: 'Thursday', openTime: '9:00 AM', closeTime: '4:00 PM'),
              WorkingHours(
                  days: 'Friday', openTime: '2:00 PM', closeTime: '5:30 PM'),
              WorkingHours(
                  days: 'Saturday', openTime: '9:00 AM', closeTime: '4:00 PM'),
              WorkingHours(
                  days: 'Sunday', openTime: '9:00 AM', closeTime: '4:00 PM'),
            ],
          ),
          ThingsToDoDetails(
            name: 'Roman Theater',
            imagePaths: [
              'images/${city}6.jpg',
              'images/${city}61.jpg',
              'images/${city}62.jpg',
              'images/${city}63.jpg',
            ],
            location: 'Taha Al-Hashemi St., Amman',
            description:
                'The Roman Theatre in Amman, Jordan, stands as an iconic testament to the ancient city\'s rich history and architectural prowess. Built during the reign of Emperor Antoninus Pius (138-161 AD), this historic amphitheater is a remarkable showcase of Roman engineering and a focal point of Amman\'s archaeological treasures.\n\nCarved into the hillsides of Amman, the Roman Theatre offers visitors a captivating glimpse into the grandeur of Roman entertainment and civic life. With a seating capacity that once accommodated thousands, the theatre was a hub for various performances, including theatrical productions, gladiator contests, and public assemblies.\n\nThe architectural design of the Roman Theatre reflects the classical style of Roman amphitheaters, featuring a semi-circular orchestra, tiered seating sections, and a stage framed by ornate columns. The theatre\'s location provides panoramic views of downtown Amman and the surrounding hills, adding to the overall enchantment of the site.\n\nToday, the Roman Theatre is not only a historical landmark but also a venue for cultural events and performances, connecting the present generation to the ancient legacy of Amman and its enduring cultural significance.',
            workingHours: [
              WorkingHours(
                  days: 'Monday', openTime: '8:00 AM', closeTime: '8:00 PM'),
              WorkingHours(
                  days: 'Tuesday', openTime: '8:00 AM', closeTime: '8:00 PM'),
              WorkingHours(
                  days: 'Wednesday', openTime: '8:00 AM', closeTime: '8:00 PM'),
              WorkingHours(
                  days: 'Thursday', openTime: '8:00 AM', closeTime: '8:00 PM'),
              WorkingHours(
                  days: 'Friday', openTime: '8:00 PM', closeTime: '10:00 PM'),
              WorkingHours(
                  days: 'Saturday', openTime: '8:00 AM', closeTime: '10:00 PM'),
              WorkingHours(
                  days: 'Sunday', openTime: '8:00 AM', closeTime: '8:00 PM'),
            ],
          ),
          ThingsToDoDetails(
            name: 'King Abdullah I Mosque',
            imagePaths: [
              'images/${city}7.jpg',
              'images/${city}71.jpg',
              'images/${city}72.jpg',
              'images/${city}73.jpg',
              'images/${city}74.jpg',
            ],
            location: 'XW67+F4H, Amman',
            description:
                'The King Abdullah I Mosque, situated in Amman, Jordan, stands as a magnificent symbol of modern Islamic architecture and spiritual significance. Constructed between 1982 and 1989, this grand mosque was built in memory of King Abdullah I, the founder of the Hashemite Kingdom of Jordan.\n\nDesigned by the architect Abdel-Wahed El-Wakil, the King Abdullah I Mosque showcases a harmonious blend of traditional Islamic elements and contemporary architectural features. The mosque\'s distinctive blue dome, minarets, and ornate geometric patterns reflect the beauty of Islamic art and design.\n\nThe interior of the mosque is equally impressive, with a central dome adorned with intricate calligraphy and geometric patterns. The prayer hall can accommodate a large congregation, and the mosque\'s design emphasizes an open and inclusive atmosphere.\n\nSet against the backdrop of the Amman skyline, the King Abdullah I Mosque is a prominent landmark that not only serves as a place of worship but also as a cultural and architectural gem, welcoming visitors to appreciate Jordan\'s rich heritage and religious diversity.',
            workingHours: [
              WorkingHours(
                  days: 'Monday', openTime: '3:20 AM', closeTime: '10:00 PM'),
              WorkingHours(
                  days: 'Tuesday', openTime: '3:20 AM', closeTime: '10:00 PM'),
              WorkingHours(
                  days: 'Wednesday',
                  openTime: '3:20 AM',
                  closeTime: '10:00 PM'),
              WorkingHours(
                  days: 'Thursday', openTime: '3:20 AM', closeTime: '10:00 PM'),
              WorkingHours(
                  days: 'Friday', openTime: '3:20 AM', closeTime: '10:00 PM'),
              WorkingHours(
                  days: 'Saturday', openTime: '3:20 AM', closeTime: '10:00 PM'),
              WorkingHours(
                  days: 'Sunday', openTime: '3:20 AM', closeTime: '10:00 PM'),
            ],
          ),
        ];

      case 'Aqaba':
        return [
          ThingsToDoDetails(
            name: 'Saraya Aqaba Waterpark',
            imagePaths: [
              'images/${city}6.jpg',
              'images/${city}61.jpg',
              'images/${city}62.jpg',
              'images/${city}63.jpg',
              'images/${city}64.jpg',
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
            workingHours: [
              WorkingHours(
                  days: 'Monday', openTime: '11:00 AM', closeTime: '6:00 PM'),
              WorkingHours(
                  days: 'Tuesday', openTime: '11:00 AM', closeTime: '6:00 PM'),
              WorkingHours(
                  days: 'Wednesday',
                  openTime: '11:00 AM',
                  closeTime: '6:00 PM'),
              WorkingHours(
                  days: 'Thursday', openTime: '11:00 AM', closeTime: '6:00 PM'),
              WorkingHours(
                  days: 'Friday', openTime: '11:00 AM', closeTime: '6:00 PM'),
              WorkingHours(
                  days: 'Saturday', openTime: '11:00 AM', closeTime: '6:00 PM'),
              WorkingHours(
                  days: 'Sunday', openTime: '11:00 AM', closeTime: '6:00 PM'),
            ],
          ),
          ThingsToDoDetails(
            name: 'B12 Beach Club',
            imagePaths: [
              'images/${city}7.jpg',
              'images/${city}71.jpg',
              'images/${city}72.jpg',
              'images/${city}73.jpg',
              'images/${city}74.jpg',
              'images/${city}75.jpg',
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
            workingHours: [
              WorkingHours(
                  days: 'Monday', openTime: '10:00 AM', closeTime: '7:00 PM'),
              WorkingHours(
                  days: 'Tuesday', openTime: '10:00 AM', closeTime: '7:00 PM'),
              WorkingHours(
                  days: 'Wednesday',
                  openTime: '10:00 AM',
                  closeTime: '7:00 PM'),
              WorkingHours(
                  days: 'Thursday', openTime: '10:00 AM', closeTime: '7:00 PM'),
              WorkingHours(
                  days: 'Friday', openTime: '10:00 AM', closeTime: '7:00 PM'),
              WorkingHours(
                  days: 'Saturday', openTime: '10:00 AM', closeTime: '7:00 PM'),
              WorkingHours(
                  days: 'Sunday', openTime: '10:00 AM', closeTime: '7:00 PM'),
            ],
          ),
          ThingsToDoDetails(
            name: 'Aqaba Archaeological Museum',
            imagePaths: [
              'images/${city}1.jpg',
              'images/${city}11.jpg',
              'images/${city}12.jpg',
              'images/${city}13.jpg',
              'images/${city}14.jpg',
              'images/${city}15.jpg',
              'images/${city}16.jpg',
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
            workingHours: [
              WorkingHours(
                  days: 'Monday', openTime: '8:00 AM', closeTime: '5:00 PM'),
              WorkingHours(
                  days: 'Tuesday', openTime: '8:00 AM', closeTime: '5:00 PM'),
              WorkingHours(
                  days: 'Wednesday', openTime: '8:00 AM', closeTime: '5:00 PM'),
              WorkingHours(
                  days: 'Thursday', openTime: '8:00 AM', closeTime: '5:00 PM'),
              WorkingHours(
                  days: 'Friday', openTime: '10:00 AM', closeTime: '6:00 PM'),
              WorkingHours(
                  days: 'Saturday', openTime: '10:00 AM', closeTime: '6:00 PM'),
              WorkingHours(
                  days: 'Sunday', openTime: '8:00 AM', closeTime: '5:00 PM'),
            ],
          ),
          ThingsToDoDetails(
            name: 'Virtual Reality Museum By Jordan Heritage',
            imagePaths: [
              'images/${city}3.jpg',
              'images/${city}31.jpg',
              'images/${city}32.jpg',
              'images/${city}33.jpg',
              'images/${city}34.jpg',
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
            workingHours: [
              WorkingHours(
                  days: 'Monday', openTime: '9:00 AM', closeTime: '9:00 PM'),
              WorkingHours(
                  days: 'Tuesday', openTime: '9:00 AM', closeTime: '9:00 PM'),
              WorkingHours(
                  days: 'Wednesday', openTime: '9:00 AM', closeTime: '9:00 PM'),
              WorkingHours(
                  days: 'Thursday', openTime: '9:00 AM', closeTime: '9:00 PM'),
              WorkingHours(
                  days: 'Friday', openTime: '9:00 AM', closeTime: '9:00 PM'),
              WorkingHours(
                  days: 'Saturday', openTime: '9:00 AM', closeTime: '9:00 PM'),
              WorkingHours(
                  days: 'Sunday', openTime: '9:00 AM', closeTime: '9:00 PM'),
            ],
          ),
          ThingsToDoDetails(
            name: 'Ayla Golf Club',
            imagePaths: [
              'images/${city}4.jpg',
              'images/${city}41.jpg',
              'images/${city}42.jpg',
              'images/${city}43.jpg',
              'images/${city}44.jpg',
              'images/${city}45.jpg',
              'images/${city}46.jpg',
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
            workingHours: [
              WorkingHours(
                  days: 'Monday', openTime: '8:00 AM', closeTime: '10:00 PM'),
              WorkingHours(
                  days: 'Tuesday', openTime: '8:00 AM', closeTime: '10:00 PM'),
              WorkingHours(
                  days: 'Wednesday',
                  openTime: '8:00 AM',
                  closeTime: '10:00 PM'),
              WorkingHours(
                  days: 'Thursday', openTime: '8:00 AM', closeTime: '10:00 PM'),
              WorkingHours(
                  days: 'Friday', openTime: '8:00 AM', closeTime: '10:00 PM'),
              WorkingHours(
                  days: 'Saturday', openTime: '8:00 AM', closeTime: '10:00 PM'),
              WorkingHours(
                  days: 'Sunday', openTime: '8:00 AM', closeTime: '10:00 PM'),
            ],
          ),
          ThingsToDoDetails(
            name: 'Berenice Beach Club',
            imagePaths: [
              'images/${city}8.jpg',
              'images/${city}81.jpg',
              'images/${city}82.jpg',
              'images/${city}83.jpg',
              'images/${city}84.jpg',
              'images/${city}85.jpg',
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
            workingHours: [
              WorkingHours(
                  days: 'Monday', openTime: '9:00 AM', closeTime: '6:00 PM'),
              WorkingHours(
                  days: 'Tuesday', openTime: '9:00 AM', closeTime: '6:00 PM'),
              WorkingHours(
                  days: 'Wednesday', openTime: '9:00 AM', closeTime: '6:00 PM'),
              WorkingHours(
                  days: 'Thursday', openTime: '9:00 AM', closeTime: '6:00 PM'),
              WorkingHours(
                  days: 'Friday', openTime: '9:00 AM', closeTime: '7:00 PM'),
              WorkingHours(
                  days: 'Saturday', openTime: '9:00 AM', closeTime: '6:00 PM'),
              WorkingHours(
                  days: 'Sunday', openTime: '9:00 AM', closeTime: '6:00 PM'),
            ],
          ),
        ];

      case 'Jerash':
        return [
          ThingsToDoDetails(
            name: 'Oval Plaza - Jerash',
            imagePaths: [
              'images/${city}1.jpg',
              'images/${city}11.jpg',
              'images/${city}12.jpg',
              'images/${city}13.jpg',
              'images/${city}14.jpg',
            ],
            location: 'Archaeological Site Jerash, Jerash',
            description: 'Oval Plaza in Jerash, also known as the Forum, is a stunning example of Roman urban architecture ' +
                'and one of the most iconic landmarks in Jordan. Spanning a vast area of approximately 90 meters in length ' +
                'and 80 meters in width, this elliptical space is surrounded by a remarkable colonnade of 1st-century Ionic columns, ' +
                'which are still remarkably intact. The plaza served as a social and commercial hub in the ancient city of Gerasa, ' +
                'part of the Decapolis league of cities. Its unique shape and grandeur are a testament to the advanced engineering ' +
                'and architectural prowess of the Romans. Today, Oval Plaza stands as a symbol of the rich history and cultural heritage ' +
                'of Jerash, attracting thousands of visitors annually who come to marvel at its timeless beauty and the echoes of ancient civilization it holds.',
            workingHours: [
              WorkingHours(
                  days: 'Monday', openTime: '9:00 AM', closeTime: '5:00 PM'),
              WorkingHours(
                  days: 'Tuesday', openTime: '9:00 AM', closeTime: '5:00 PM'),
              WorkingHours(
                  days: 'Wednesday', openTime: '9:00 AM', closeTime: '5:00 PM'),
              WorkingHours(
                  days: 'Thursday', openTime: '9:00 AM', closeTime: '5:00 PM'),
              WorkingHours(
                  days: 'Friday', openTime: '9:00 AM', closeTime: '5:00 PM'),
              WorkingHours(
                  days: 'Saturday', openTime: '9:00 AM', closeTime: '4:00 PM'),
              WorkingHours(
                  days: 'Sunday', openTime: '9:00 AM', closeTime: '4:00 PM'),
            ],
          ),
          ThingsToDoDetails(
            name: 'Nympheum - Jerash',
            imagePaths: [
              'images/${city}2.jpg',
              'images/${city}21.jpg',
              'images/${city}22.jpg',
            ],
            location: 'XW2P+4C5, Al-Hashemi St., Amman',
            // ignore: prefer_interpolation_to_compose_strings
            description: 'The Nymphaeum in Jerash is an exquisite example of Roman-era architecture and a remarkable archaeological treasure. ' +
                'Dedicated to the nymphs, this ornate public fountain was a centerpiece of ancient Gerasa, now modern-day Jerash in Jordan. ' +
                'Built around the 2nd century AD, the Nymphaeum is distinguished by its semi-circular facade adorned with fine masonry and ' +
                'decorative carvings. At its peak, water cascaded through a series of channels and pools, providing a spectacular display ' +
                'for the city\'s inhabitants. The remains of the Nymphaeum, with its detailed Corinthian columns and intricate motifs, offer ' +
                'insight into the grandeur and sophistication of Roman urban design. It remains a significant attraction for visitors, ' +
                'showcasing the historical and cultural richness of Jerash.',
            workingHours: [
              WorkingHours(
                  days: 'Monday', openTime: '8:00 AM', closeTime: '5:00 PM'),
              WorkingHours(
                  days: 'Tuesday', openTime: '8:00 AM', closeTime: '5:00 PM'),
              WorkingHours(
                  days: 'Wednesday', openTime: '8:00 AM', closeTime: '5:00 PM'),
              WorkingHours(
                  days: 'Thursday', openTime: '8:00 AM', closeTime: '5:00 PM'),
              WorkingHours(
                  days: 'Friday', openTime: '8:00 AM', closeTime: '5:00 PM'),
              WorkingHours(
                  days: 'Saturday', openTime: '8:00 AM', closeTime: '5:00 PM'),
              WorkingHours(
                  days: 'Sunday', openTime: '8:00 AM', closeTime: '5:00 PM'),
            ],
          ),
          ThingsToDoDetails(
            name: 'Temple of Zeus - Jerash',
            imagePaths: [
              'images/${city}3.jpg',
              'images/${city}31.jpg',
              'images/${city}32.jpg',
            ],
            location: '20 67, Jerash',
            description: 'The Temple of Zeus in Jerash, Jordan, is a magnificent remnant of the ancient Greco-Roman world. ' +
                'Erected in the 2nd century AD, this temple was dedicated to Zeus, the chief deity of the Greek pantheon. ' +
                'Positioned atop a hill, it offers a commanding view of the surrounding ruins of Jerash. The structure\'s ' +
                'grandiose design is characterized by its towering Corinthian columns and elaborate capitals, reflecting the ' +
                'architectural prowess of the era. Despite the ravages of time, several columns still stand, evoking the ' +
                'temple’s former glory. The Temple of Zeus not only exemplifies ancient religious practices but also ' +
                'serves as a testament to the rich cultural and historical tapestry that defines Jerash. Its monumental ruins ' +
                'continue to fascinate archaeologists and visitors alike, drawing them into a world where mythology and history intertwine.',
            workingHours: [
              WorkingHours(
                  days: 'Monday', openTime: '8:00 AM', closeTime: '6:00 PM'),
              WorkingHours(
                  days: 'Tuesday', openTime: '8:00 AM', closeTime: '6:00 PM'),
              WorkingHours(
                  days: 'Wednesday', openTime: '8:00 AM', closeTime: '6:00 PM'),
              WorkingHours(
                  days: 'Thursday', openTime: '8:00 AM', closeTime: '6:00 PM'),
              WorkingHours(
                  days: 'Friday', openTime: '10:00 AM', closeTime: '3:00 PM'),
              WorkingHours(
                  days: 'Saturday', openTime: '10:00 AM', closeTime: '3:00 PM'),
              WorkingHours(
                  days: 'Sunday', openTime: '8:00 AM', closeTime: '6:00 PM'),
            ],
          ),
          ThingsToDoDetails(
            name: 'Jerash Archaeological Museum ',
            imagePaths: [
              'images/${city}4.jpg',
              'images/${city}41.jpg',
              'images/${city}42.jpg',
              'images/${city}43.jpg',
              'images/${city}44.jpg',
              'images/${city}45.jpg',
            ],
            location: '7VHR+5MC, Jerash',
            description: 'The Jerash Archaeological Museum, located within the ancient city of Jerash in Jordan, is a treasure trove of ' +
                'historical and cultural artifacts. Established in 1923, this museum showcases an extensive collection of items ' +
                'unearthed from the Jerash ruins and surrounding regions. Visitors can marvel at a range of exhibits, including ' +
                'pottery, coins, sculptures, mosaics, and inscriptions, all offering a glimpse into the daily life and artistry ' +
                'of the Greco-Roman and Byzantine periods. One of the museum’s highlights is its collection of striking ' +
                'limestone and basalt sculptures, which beautifully capture the artistic skill of ancient craftsmen. The Jerash ' +
                'Archaeological Museum not only provides insights into the rich history of Jerash but also serves as a crucial ' +
                'repository for preserving Jordan’s ancient heritage. It is a must-visit for those keen on exploring the ' +
                'depths of Jordan’s archaeological and historical legacy.',
            workingHours: [
              WorkingHours(
                  days: 'Monday', openTime: '9:00 AM', closeTime: '5:00 PM'),
              WorkingHours(
                  days: 'Tuesday', openTime: '9:00 AM', closeTime: '5:00 PM'),
              WorkingHours(
                  days: 'Wednesday', openTime: '9:00 AM', closeTime: '5:00 PM'),
              WorkingHours(
                  days: 'Thursday', openTime: '9:00 AM', closeTime: '5:00 PM'),
              WorkingHours(
                  days: 'Friday', openTime: '9:00 AM', closeTime: '5:00 PM'),
              WorkingHours(
                  days: 'Saturday', openTime: '9:00 AM', closeTime: '4:00 PM'),
              WorkingHours(
                  days: 'Sunday', openTime: '9:00 AM', closeTime: '4:00 PM'),
            ],
          ),
          ThingsToDoDetails(
            name: 'Church of Marianos',
            imagePaths: [
              'images/${city}5.jpg',
              'images/${city}51.jpg',
              'images/${city}52.jpg',
              'images/${city}53.jpg',
            ],
            location: '7VFR+4GG, Jarash',
            description: 'The Church of Marianos in Jerash, Jordan, is an exquisite example of early Christian architecture and artistry. ' +
                'Constructed in the 6th century AD, this church is renowned for its intricate mosaics that adorn the floors, ' +
                'depicting a variety of religious and pastoral scenes. The mosaics are remarkably well-preserved, showcasing ' +
                'vibrant colors and detailed depictions of animals, plants, and geometric patterns. The church is named after ' +
                'Bishop Marianos, who is believed to have commissioned its construction. It stands as a testament to the ' +
                'spiritual and cultural life of the early Christian community in Jerash. The Church of Marianos is a significant ' +
                'historical site, offering visitors a chance to step back in time and experience the artistic and religious heritage ' +
                'of this ancient city. It is a vital piece of the mosaic that makes up the rich tapestry of Jordan’s historical and ' +
                'archaeological landscape.',
            workingHours: [
              WorkingHours(
                  days: 'Monday', openTime: '9:00 AM', closeTime: '5:00 PM'),
              WorkingHours(
                  days: 'Tuesday', openTime: '9:00 AM', closeTime: '5:00 PM'),
              WorkingHours(
                  days: 'Wednesday', openTime: '9:00 AM', closeTime: '5:00 PM'),
              WorkingHours(
                  days: 'Thursday', openTime: '9:00 AM', closeTime: '5:00 PM'),
              WorkingHours(
                  days: 'Friday', openTime: '9:00 AM', closeTime: '5:00 PM'),
              WorkingHours(
                  days: 'Saturday', openTime: '9:00 AM', closeTime: '4:00 PM'),
              WorkingHours(
                  days: 'Sunday', openTime: '9:00 AM', closeTime: '4:00 PM'),
            ],
          ),
        ];

      case 'Ajloun':
        return [
          ThingsToDoDetails(
            name: 'Ajloun Castle',
            imagePaths: [
              'images/${city}1.jpg',
              'images/${city}11.jpg',
              'images/${city}12.jpg',
              'images/${city}13.jpg',
              'images/${city}14.jpg',
              'images/${city}15.jpg',
              'images/${city}16.jpg',
              'images/${city}17.jpg',
            ],
            location: 'Ajloun Castle, Ajloun',
            description: "The Qala'a ar-Rabad, also known as Ajloun Castle, is a historic fortress located in Jordan's " +
                "Ajloun district. Built in the 12th century by the Muslim military leader Saladin, the castle was strategically " +
                "positioned on a hilltop to control the local iron mines and counter Crusader advances. Qala'a ar-Rabad stands " +
                "as an architectural marvel of medieval Islamic military architecture, characterized by its massive walls, towers, " +
                "and parapets.\n\nThe fortress was later expanded and renovated during the Ayyubid and Mamluk periods, adding to " +
                "its strength and grandeur. Today, visitors can explore the labyrinthine passages, chambers, and galleries that comprise " +
                "the castle's interior. The fortress also offers panoramic views of the surrounding countryside, including the Jordan Valley " +
                "and the highlands of Galilee.\n\nQala'a ar-Rabad is not only a significant historical site but also a symbol of the Islamic " +
                "military prowess and the rich cultural heritage of the region. Its preservation and restoration efforts have made it a popular " +
                "destination for tourists and history enthusiasts, eager to experience the legacy of this formidable medieval fortress.",
            workingHours: [
              WorkingHours(
                  days: 'Monday', openTime: '7:00 AM', closeTime: '8:00 PM'),
              WorkingHours(
                  days: 'Tuesday', openTime: '7:00 AM', closeTime: '8:00 PM'),
              WorkingHours(
                  days: 'Wednesday', openTime: '7:00 AM', closeTime: '8:00 PM'),
              WorkingHours(
                  days: 'Thursday', openTime: '7:00 AM', closeTime: '8:00 PM'),
              WorkingHours(
                  days: 'Friday', openTime: '7:00 AM', closeTime: '8:00 PM'),
              WorkingHours(
                  days: 'Saturday', openTime: '7:00 AM', closeTime: '8:00 PM'),
              WorkingHours(
                  days: 'Sunday', openTime: '7:00 AM', closeTime: '8:00 PM'),
            ],
          ),
          ThingsToDoDetails(
            name: 'Ajloun Forest Reserve Zipline',
            imagePaths: [
              'images/${city}2.jpg',
              'images/${city}21.jpg',
              'images/${city}22.jpg',
            ],
            location: '9QG7+XJF, Unnamed Road, Ajloun',
            description: "The Ajloun Forest Reserve Zipline is an exhilarating outdoor adventure located in the heart of Jordan's " +
                "Ajloun region. Surrounded by the lush greenery of the forest reserve, the zipline offers a unique and thrilling " +
                "way to experience the area's natural beauty. The zipline stretches across a significant length, allowing participants " +
                "to soar over the treetops and enjoy stunning views of the forest and its diverse wildlife.\n\n" +
                "Designed for adventure seekers of all ages, the zipline provides a safe yet thrilling ride, complete with all the necessary " +
                "safety gear and guidance from experienced instructors. The experience is not just about the thrill of zipping through the air " +
                "but also about connecting with nature and appreciating the serene environment of the Ajloun Forest Reserve.\n\n" +
                "Participants get to witness the rich biodiversity of the reserve, including evergreen oak trees, wild pistachio trees, " +
                "and a variety of bird species. The Ajloun Forest Reserve Zipline is more than just an adventure; it's an opportunity to " +
                "immerse oneself in the natural splendor of Jordan and create lasting memories in one of the country's most beautiful settings.",
            workingHours: [
              WorkingHours(
                  days: 'Monday', openTime: '9:00 AM', closeTime: '6:00 PM'),
              WorkingHours(
                  days: 'Tuesday', openTime: '9:00 AM', closeTime: '6:00 PM'),
              WorkingHours(
                  days: 'Wednesday', openTime: '9:00 AM', closeTime: '6:00 PM'),
              WorkingHours(
                  days: 'Thursday', openTime: '9:00 AM', closeTime: '6:00 PM'),
              WorkingHours(
                  days: 'Friday', openTime: '9:00 AM', closeTime: '6:00 PM'),
              WorkingHours(
                  days: 'Saturday', openTime: '9:00 AM', closeTime: '6:00 PM'),
              WorkingHours(
                  days: 'Sunday', openTime: '9:00 AM', closeTime: '6:00 PM'),
            ],
          ),
        ];

      case 'Petra':
        return [
          ThingsToDoDetails(
            name: 'Al-Siq',
            imagePaths: [
              'images/${city}1.jpg',
              'images/${city}11.jpg',
              'images/${city}12.jpg',
              'images/${city}13.jpg',
            ],
            location: '8FF4+5FW, Wadi Musa',
            description: "The Siq in Petra, Jordan, is a breathtaking natural gorge that serves as the main entrance to the ancient " +
                "Nabatean city. This narrow passage, stretching about 1.2 kilometers, is framed by towering cliffs reaching " +
                "up to 80 meters in height. The Siq was formed over millions of years by the natural splitting of the mountains " +
                "and further shaped by the Nabateans to serve as a grand entrance to their capital.\n\n" +
                "As visitors walk through the Siq, they are greeted by a fusion of natural beauty and human artistry, with " +
                "the walls of the gorge displaying a tapestry of colors and formations. The Nabateans skillfully incorporated " +
                "elements of their architecture into the Siq, including water channels and sacred niches, adding to its allure " +
                "and mystery.\n\n" +
                "The journey through the Siq is an experience filled with anticipation and wonder, culminating in the stunning " +
                "reveal of Petra's most iconic structure, Al-Khazneh, or the Treasury. The dramatic and narrow entrance " +
                "of the Siq enhances the impact of this first glimpse, leaving an indelible impression on all who visit. " +
                "Exploring the Siq in Petra is not only a journey through a geological marvel but also a walk through history, " +
                "where the past and present of Jordan's rich heritage intertwine to create an unforgettable experience.",
            workingHours: [
              WorkingHours(
                  days: 'Monday', openTime: '8:00 AM', closeTime: '3:00 PM'),
              WorkingHours(
                  days: 'Tuesday', openTime: '8:00 AM', closeTime: '3:00 PM'),
              WorkingHours(
                  days: 'Wednesday', openTime: '8:00 AM', closeTime: '3:00 PM'),
              WorkingHours(
                  days: 'Thursday', openTime: '8:00 AM', closeTime: '3:00 PM'),
              WorkingHours(
                  days: 'Friday', openTime: '8:00 AM', closeTime: '3:00 PM'),
              WorkingHours(
                  days: 'Saturday', openTime: '8:00 AM', closeTime: '3:00 PM'),
              WorkingHours(
                  days: 'Sunday', openTime: '8:00 AM', closeTime: '3:00 PM'),
            ],
          ),
          ThingsToDoDetails(
            name: 'Al-Khazneh',
            imagePaths: [
              'images/${city}2.jpg',
              'images/${city}21.jpg',
              'images/${city}22.jpg',
            ],
            location: '8FF4+5FW, Wadi Musa',
            description: "The Siq in Petra, Jordan, is a breathtaking natural gorge that serves as the main entrance to the ancient " +
                "Nabatean city. This narrow passage, stretching about 1.2 kilometers, is framed by towering cliffs reaching " +
                "up to 80 meters in height. The Siq was formed over millions of years by the natural splitting of the mountains " +
                "and further shaped by the Nabateans to serve as a grand entrance to their capital.\n\n" +
                "As visitors walk through the Siq, they are greeted by a fusion of natural beauty and human artistry, with " +
                "the walls of the gorge displaying a tapestry of colors and formations. The Nabateans skillfully incorporated " +
                "elements of their architecture into the Siq, including water channels and sacred niches, adding to its allure " +
                "and mystery.\n\n" +
                "The journey through the Siq is an experience filled with anticipation and wonder, culminating in the stunning " +
                "reveal of Petra's most iconic structure, Al-Khazneh, or the Treasury. The dramatic and narrow entrance " +
                "of the Siq enhances the impact of this first glimpse, leaving an indelible impression on all who visit. " +
                "Exploring the Siq in Petra is not only a journey through a geological marvel but also a walk through history, " +
                "where the past and present of Jordan's rich heritage intertwine to create an unforgettable experience.",
            workingHours: [
              WorkingHours(
                  days: 'Monday', openTime: '6:00 AM', closeTime: '6:00 PM'),
              WorkingHours(
                  days: 'Tuesday', openTime: '6:00 AM', closeTime: '6:00 PM'),
              WorkingHours(
                  days: 'Wednesday', openTime: '6:00 AM', closeTime: '6:00 PM'),
              WorkingHours(
                  days: 'Thursday', openTime: '6:00 AM', closeTime: '6:00 PM'),
              WorkingHours(
                  days: 'Friday', openTime: '6:00 AM', closeTime: '6:00 PM'),
              WorkingHours(
                  days: 'Saturday', openTime: '6:00 AM', closeTime: '6:00 PM'),
              WorkingHours(
                  days: 'Sunday', openTime: '6:00 AM', closeTime: '6:00 PM'),
            ],
          ),
          ThingsToDoDetails(
            name: 'The Petra Museum',
            imagePaths: [
              'images/${city}3.webp',
              'images/${city}31.jpg',
              'images/${city}32.jpg',
              'images/${city}33.jpg',
              'images/${city}34.jpg',
              'images/${city}35.jpg',
              'images/${city}36.jpg',
              'images/${city}37.jpg',
              'images/${city}38.jpg',
              'images/${city}39.jpg',
            ],
            location: '8FG9+46R, Wadi Musa',
            description: "The Petra Museum, located near the entrance of the ancient city of Petra in Jordan, is a modern " +
                "and informative cultural facility that offers visitors an enriching insight into the history and " +
                "archaeology of Petra. The museum showcases a wide array of artifacts, sculptures, and exhibits that " +
                "chronicle the rise and fall of the Nabatean civilization, which thrived in Petra.\n\n" +
                "The museum's collection includes items dating back to the prehistoric period, as well as artifacts " +
                "from the Nabatean, Roman, Byzantine, and Islamic eras. These exhibits provide a comprehensive overview " +
                "of the daily life, religious practices, and architectural achievements of the people who inhabited Petra. " +
                "The museum also highlights the extensive archaeological research and conservation efforts undertaken to " +
                "preserve this UNESCO World Heritage site.\n\n" +
                "Interactive displays, multimedia presentations, and educational panels enhance the visitor experience, " +
                "making the complex history of Petra accessible and engaging for all ages. The Petra Museum serves not " +
                "only as a gateway to the ancient city but also as a testament to Jordan's commitment to preserving and " +
                "sharing its rich cultural heritage. A visit to the Petra Museum is an essential complement to exploring " +
                "the archaeological wonders of Petra, providing context and depth to the remarkable story of this ancient city.",
            workingHours: [
              WorkingHours(
                  days: 'Monday', openTime: '8:30 AM', closeTime: '8:30 PM'),
              WorkingHours(
                  days: 'Tuesday', openTime: '8:30 AM', closeTime: '8:30 PM'),
              WorkingHours(
                  days: 'Wednesday', openTime: '8:30 AM', closeTime: '8:30 PM'),
              WorkingHours(
                  days: 'Thursday', openTime: '8:30 AM', closeTime: '8:30 PM'),
              WorkingHours(
                  days: 'Friday', openTime: '8:30 AM', closeTime: '8:30 PM'),
              WorkingHours(
                  days: 'Saturday', openTime: '8:30 AM', closeTime: '8:30 PM'),
              WorkingHours(
                  days: 'Sunday', openTime: '8:30 AM', closeTime: '8:30 PM'),
            ],
          ),
          ThingsToDoDetails(
            name: 'Byzantine Church - Petra',
            imagePaths: [
              'images/${city}4.jpg',
              'images/${city}41.jpg',
              'images/${city}42.jpg',
              'images/${city}43.jpg',
              'images/${city}44.jpg',
              'images/${city}45.jpg',
            ],
            location: '8CJV+6PV, Wadi Musa',
            description: "The Byzantine Church in Petra, also known as the Petra Church, is a significant archaeological " +
                "site that offers a glimpse into the religious and cultural landscape of ancient Petra during the Byzantine era. " +
                "Located within the renowned archaeological park of Petra in Jordan, this church dates back to the 5th and 6th centuries AD.\n\n" +
                "The church is primarily known for its exquisite floor mosaics, which are among the finest examples of Byzantine art in the Middle East. " +
                "These mosaics depict a variety of religious and floral motifs, showcasing the craftsmanship and artistic sophistication of the period. " +
                "The intricate designs and vibrant colors of the mosaics have been remarkably preserved, providing visitors with a vivid representation of " +
                "Byzantine aesthetic sensibilities.\n\n" +
                "Excavations at the site have uncovered a wealth of artifacts, including pottery, glasswork, and religious relics, " +
                "which offer insights into the everyday life and spiritual practices of the Christian community in Petra. " +
                "The church's architectural remnants, such as columns, capitals, and walls, also contribute to understanding the " +
                "construction techniques and styles prevalent during the Byzantine period in the region.\n\n" +
                "Visiting the Byzantine Church in Petra allows travelers to explore an often-overlooked aspect of Petra's rich history. " +
                "It provides a unique perspective on the religious diversity and artistic achievements that characterized this ancient city. " +
                "The church is a testament to the enduring legacy of Petra and the intricate tapestry of civilizations that have contributed to its storied past.",
            workingHours: [
              WorkingHours(
                  days: 'Monday', openTime: '6:00 AM', closeTime: '6:00 PM'),
              WorkingHours(
                  days: 'Tuesday', openTime: '6:00 AM', closeTime: '6:00 PM'),
              WorkingHours(
                  days: 'Wednesday', openTime: '6:00 AM', closeTime: '6:00 PM'),
              WorkingHours(
                  days: 'Thursday', openTime: '6:00 AM', closeTime: '6:00 PM'),
              WorkingHours(
                  days: 'Friday', openTime: '6:00 AM', closeTime: '6:00 PM'),
              WorkingHours(
                  days: 'Saturday', openTime: '6:00 AM', closeTime: '6:00 PM'),
              WorkingHours(
                  days: 'Sunday', openTime: '6:00 AM', closeTime: '6:00 PM'),
            ],
          ),
        ];

      case 'Dead Sea':
        return [
          ThingsToDoDetails(
            name: 'Wadi Al Mujibh',
            imagePaths: [
              'images/${city}1.jpeg',
              'images/${city}11.jpeg',
              'images/${city}12.jpeg',
              'images/${city}13.jpeg',
              'images/${city}14.jpeg',
              'images/${city}15.jpg',
            ],
            location: 'FH4V+6PQ, Dead sea road, Sweimeh',
            description: "Wadi Mujib, often referred to as the 'Grand Canyon of Jordan,' is a breathtaking natural wonder " +
                "located near the eastern shore of the Dead Sea. This majestic canyon features a stunning gorge that has been carved " +
                "out by the Mujib River over millennia, creating a landscape of rugged beauty and dramatic cliffs.\n\n" +
                "Wadi Mujib is renowned for its diverse ecosystem, which includes a range of flora and fauna unique to this region. " +
                "The reserve is a haven for nature enthusiasts and offers a variety of outdoor activities such as hiking, canyoning, " +
                "and bird watching. The river running through the canyon provides opportunities for refreshing swims and adventurous water trails.\n\n" +
                "The Wadi Mujib Biosphere Reserve, covering an area of over 200 square kilometers, is committed to the conservation of " +
                "this unique environment. Visitors can explore the reserve's numerous trails, which range from easy walks to more challenging " +
                "routes requiring swimming and climbing. These trails offer spectacular views of the canyon's towering sandstone walls " +
                "and the lush vegetation along the riverbanks.\n\n" +
                "The breathtaking scenery and the thrill of navigating through the canyon's natural obstacles make Wadi Mujib a popular " +
                "destination for adventure tourism in Jordan. The combination of natural beauty, biodiversity, and the excitement of " +
                "exploring this extraordinary landscape make Wadi Mujib a must-visit destination for those seeking to experience the " +
                "untouched wilderness of Jordan.",
            workingHours: [
              WorkingHours(
                  days: 'Monday', openTime: '8:00 AM', closeTime: '3:00 PM'),
              WorkingHours(
                  days: 'Tuesday', openTime: '8:00 AM', closeTime: '3:00 PM'),
              WorkingHours(
                  days: 'Wednesday', openTime: '8:00 AM', closeTime: '3:00 PM'),
              WorkingHours(
                  days: 'Thursday', openTime: '8:00 AM', closeTime: '3:00 PM'),
              WorkingHours(
                  days: 'Friday', openTime: '8:00 AM', closeTime: '3:00 PM'),
              WorkingHours(
                  days: 'Saturday', openTime: '8:00 AM', closeTime: '3:00 PM'),
              WorkingHours(
                  days: 'Sunday', openTime: '8:00 AM', closeTime: '3:00 PM'),
            ],
          ),
          ThingsToDoDetails(
            name: 'Dead Sea Museum',
            imagePaths: [
              'images/${city}2.jpg',
              'images/${city}21.jpg',
              'images/${city}22.jpg',
              'images/${city}23.jpg',
              'images/${city}24.jpg',
              'images/${city}25.jpg',
              'images/${city}26.jpg',
              'images/${city}27.jpg',
            ],
            location: 'Dead Sea Parkway, Sweimah 11941',
            description: "The Dead Sea Museum is a fascinating institution dedicated to showcasing the unique geological, " +
                "historical, and ecological aspects of the Dead Sea, one of the world's most remarkable natural wonders. " +
                "Located in the vicinity of the Dead Sea, this museum provides visitors with an in-depth understanding of " +
                "why the Dead Sea is so unique and significant on a global scale.\n\n" +
                "The museum features a variety of interactive exhibits and informative displays that explore the Dead Sea's " +
                "extreme salinity, its rich mineral content, and the diverse flora and fauna that manage to thrive in this " +
                "harsh environment. Visitors can learn about the geological history of the Dead Sea, including how it was " +
                "formed and the factors contributing to its current state.\n\n" +
                "Among the highlights of the museum are exhibits that delve into the historical and cultural significance of " +
                "the Dead Sea region. This includes its importance to various civilizations throughout history and its " +
                "mention in religious texts. Additionally, the museum addresses environmental concerns, such as the " +
                "ongoing decrease in the Dead Sea's water level and the efforts to preserve this unique body of water.\n\n" +
                "Equipped with modern facilities and engaging for all ages, the Dead Sea Museum serves as an educational " +
                "hub, offering a comprehensive and enjoyable learning experience. It's a must-visit for those who wish to " +
                "gain a deeper appreciation of the Dead Sea's wonders and the challenges it faces.",
            workingHours: [
              WorkingHours(
                  days: 'Monday', openTime: '9:15 AM', closeTime: '11:00 PM'),
              WorkingHours(
                  days: 'Tuesday', openTime: '9:00 AM', closeTime: '11:00 PM'),
              WorkingHours(
                  days: 'Wednesday',
                  openTime: '9:00 AM',
                  closeTime: '11:00 PM'),
              WorkingHours(
                  days: 'Thursday', openTime: '9:00 AM', closeTime: '11:00 PM'),
              WorkingHours(
                  days: 'Friday', openTime: '9:00 AM', closeTime: '11:00 PM'),
              WorkingHours(
                  days: 'Saturday', openTime: '9:00 AM', closeTime: '11:00 PM'),
              WorkingHours(
                  days: 'Sunday', openTime: '9:00 AM', closeTime: '11:00 PM'),
            ],
          ),
          ThingsToDoDetails(
            name: 'Lot\'s Cave',
            imagePaths: [
              'images/${city}3.jpg',
              'images/${city}31.jpg',
              'images/${city}32.jpg',
              'images/${city}33.webp',
              'images/${city}34.jpg',
            ],
            location: 'Dead Sea Parkway, Sweimah 11941',
            description:
                "Lot's Cave, located near the Dead Sea, is an archaeological and religious site of significant importance. "
                "According to biblical tradition, it is believed to be the refuge of Lot and his daughters after the destruction "
                "of Sodom and Gomorrah. The cave is situated above the town of Safi and offers a panoramic view of the Dead Sea and "
                "the surrounding rugged terrain. Excavations in the cave have unearthed artifacts and pottery dating back to various "
                "historical periods, offering insights into the site's long-standing significance.\n\n"
                "Visitors to Lot's Cave can explore the small museum that displays findings from the area and interpretive signs "
                "that recount the story of Lot as per the Bible and Islamic tradition. The site serves not only as a point of "
                "historical interest but also as a place of religious contemplation. Its location near the Dead Sea makes it a "
                "popular stop for tourists visiting the region, who are drawn to its historical, religious, and natural significance.",
            workingHours: [
              WorkingHours(
                  days: 'Monday', openTime: '8:00 AM', closeTime: '7:00 PM'),
              WorkingHours(
                  days: 'Tuesday', openTime: '8:00 AM', closeTime: '7:00 PM'),
              WorkingHours(
                  days: 'Wednesday', openTime: '8:00 AM', closeTime: '7:00 PM'),
              WorkingHours(
                  days: 'Thursday', openTime: '8:00 AM', closeTime: '7:00 PM'),
              WorkingHours(
                  days: 'Friday', openTime: '8:00 AM', closeTime: '7:00 PM'),
              WorkingHours(
                  days: 'Saturday', openTime: '8:00 AM', closeTime: '7:00 PM'),
              WorkingHours(
                  days: 'Sunday', openTime: '9:00 AM', closeTime: '11:00 PM'),
            ],
          ),
          ThingsToDoDetails(
            name: 'Ma\'in Hot Springs',
            imagePaths: [
              'images/${city}4.jpg',
              'images/${city}41.jpg',
              'images/${city}42.jpg',
              'images/${city}43.jpg',
              'images/${city}44.jpg',
            ],
            location: 'Ma\'in-Ma\'in Hot Springs, address',
            description: "Ma'in Hot Springs, nestled in a serene valley surrounded by towering cliffs, offers a unique natural spa experience. " +
                "This remarkable geological site is renowned for its hot mineral-rich springs, which emerge from the earth's crust and cascade into a series of pools and waterfalls. " +
                "The naturally heated water is believed to have therapeutic properties and provides a tranquil environment for relaxation and rejuvenation.\n\n" +
                "Visitors to Ma'in Hot Springs can indulge in a variety of spa treatments, including mud wraps, mineral baths, and massages, all utilizing the hot springs' mineral-rich waters. " +
                "The springs are set against a backdrop of stunning natural beauty, featuring lush vegetation and a peaceful atmosphere, making it an ideal retreat for those seeking a break from the hustle and bustle of daily life.\n\n" +
                "In addition to the hot springs, the area offers opportunities for hiking and exploring the nearby natural landscapes. The springs are located near the Dead Sea, allowing for easy access to its unique attractions and the chance to float in its saline waters.\n\n" +
                "Ma'in Hot Springs is not only a haven for those seeking wellness and relaxation but also an enchanting destination for nature lovers and adventure seekers. Its unique combination of natural thermal waters, scenic beauty, and peaceful ambiance make it a must-visit destination in Jordan.",
            workingHours: [
              WorkingHours(
                  days: 'Monday', openTime: '9:00 AM', closeTime: '9:00 PM'),
              WorkingHours(
                  days: 'Tuesday', openTime: '9:00 AM', closeTime: '9:00 PM'),
              WorkingHours(
                  days: 'Wednesday', openTime: '9:00 AM', closeTime: '9:00 PM'),
              WorkingHours(
                  days: 'Thursday', openTime: '9:00 AM', closeTime: '9:00 PM'),
              WorkingHours(
                  days: 'Friday', openTime: '9:00 AM', closeTime: '9:00 PM'),
              WorkingHours(
                  days: 'Saturday', openTime: '9:00 AM', closeTime: '9:00 PM'),
              WorkingHours(
                  days: 'Sunday', openTime: '9:00 AM', closeTime: '9:00 PM'),
            ],
          ),
        ];

      case 'Wadi Rum':
        return [
          ThingsToDoDetails(
            name: 'Jebel Khazali',
            imagePaths: [
              'images/${city}1.jpg',
              'images/${city}11.jpg',
              'images/${city}12.jpg',
              'images/${city}13.jpg',
              'images/${city}14.jpg',
              'images/${city}15.jpg',
              'images/${city}16.jpg',
              'images/${city}17.jpg',
              'images/${city}18.jpg',
              'images/${city}19.jpg',
            ],
            location: 'GC99+442, Unnamed Road, Wadi Rum Village',
            description:
                "Jebel Khazali is a captivating and historically significant site located in the heart of Wadi Rum, Jordan. "
                "Known for its towering cliffs and narrow canyons, Jebel Khazali stands as a testament to the natural beauty and "
                "geological marvels of Wadi Rum. The site is particularly famous for its ancient petroglyphs and inscriptions, "
                "which are etched onto the rock surfaces. These carvings provide a window into the lives of the people who inhabited "
                "this area thousands of years ago, depicting animals, humans, and symbols that reflect their culture and daily activities.\n\n"
                "Visitors to Jebel Khazali can embark on a trek through the narrow siq (canyon) where these carvings are found, "
                "experiencing the awe-inspiring landscape of Wadi Rum. The siq reveals the intricate rock formations and the play "
                "of light and shadow, creating an almost mystical atmosphere. Jebel Khazali is not only a site of historical and "
                "cultural importance but also a popular destination for hikers, photographers, and nature enthusiasts who are drawn to "
                "its unique geological features and the serene beauty of the surrounding desert landscape.",
            workingHours: [
              WorkingHours(
                  days: 'Monday', openTime: 'Open 24 hours', closeTime: ''),
              WorkingHours(
                  days: 'Tuesday', openTime: 'Open 24 hours', closeTime: ''),
              WorkingHours(
                  days: 'Wednesday', openTime: 'Open 24 hours', closeTime: ''),
              WorkingHours(
                  days: 'Thursday', openTime: 'Open 24 hours', closeTime: ''),
              WorkingHours(
                  days: 'Friday', openTime: 'Open 24 hours', closeTime: ''),
              WorkingHours(
                  days: 'Saturday', openTime: 'Open 24 hours', closeTime: ''),
              WorkingHours(
                  days: 'Sunday', openTime: 'Open 24 hours', closeTime: ''),
            ],
          ),
          ThingsToDoDetails(
            name: 'Jabal Umm ad Dami',
            imagePaths: [
              'images/${city}2.jpeg',
              'images/${city}21.jpeg',
              'images/${city}22.jpeg',
              'images/${city}23.jpeg',
              'images/${city}24.jpeg',
              'images/${city}25.jpg',
              'images/${city}26.jpg',
            ],
            location: 'Wadi Rum',
            description:
                "Jabal Umm ad Dami, the highest peak in Jordan, is located in the majestic Wadi Rum desert. Standing at an elevation "
                "of around 1,854 meters above sea level, this towering mountain offers breathtaking views of the vast desert landscape "
                "and, on clear days, the Red Sea and even the Saudi Arabian border. The ascent to the summit of Jabal Umm ad Dami is "
                "a popular challenge for hikers and adventure enthusiasts, providing an exhilarating experience amidst the dramatic "
                "and rugged terrain of Wadi Rum.\n\n"
                "The hike to the top requires a moderate level of fitness but rewards climbers with unparalleled panoramic vistas. "
                "The journey to the summit passes through a variety of terrains, from rocky paths to sandy stretches, each offering its "
                "own unique beauty. The peak is often cooler than the desert floor, offering a refreshing respite from the heat. Climbing "
                "Jabal Umm ad Dami is not only an opportunity to witness the stunning natural beauty of Wadi Rum but also a chance to "
                "connect with the raw and unspoiled spirit of the Jordanian wilderness.",
            workingHours: [],
          ),
          ThingsToDoDetails(
            name: 'Royal Balloon - Jordan',
            imagePaths: [
              'images/${city}3.jpg',
              'images/${city}31.jpg',
              'images/${city}32.jpg',
              'images/${city}33.jpg',
              'images/${city}34.jpg',
            ],
            location: 'Wadi Rum Village 06450',
            description:
                "The Royal Balloon in Wadi Rum offers an unforgettable and majestic experience, soaring through the skies above the "
                "iconic Jordanian desert landscape. This hot air balloon ride provides a unique perspective on the vast, reddish sands "
                "and towering rock formations of Wadi Rum, often referred to as the 'Valley of the Moon.'\n\n"
                "Passengers aboard the Royal Balloon are treated to stunning aerial views of the desert, witnessing the sunrise or sunset "
                "paint the sky in brilliant hues, casting ever-changing shadows across the dunes and cliffs. The serene and gentle flight "
                "allows for a peaceful yet exhilarating experience, perfect for capturing breathtaking photos or simply absorbing the "
                "natural beauty of Wadi Rum.\n\n"
                "Flying in the Royal Balloon is more than just a sightseeing tour; it's a unique adventure that combines the thrill of "
                "ballooning with the awe-inspiring scenery of one of Jordan's most famous natural wonders. The experience is often "
                "highlighted by the knowledgeable guides who share insights about the region's history and geology, enhancing the "
                "enchantment of the journey. The Royal Balloon in Wadi Rum is a must-try experience for those seeking a different and "
                "memorable way to explore the stunning landscapes of Jordan.",
            workingHours: [
              WorkingHours(
                  days: 'Monday', openTime: 'Open 24 hours', closeTime: ''),
              WorkingHours(
                  days: 'Tuesday', openTime: 'Open 24 hours', closeTime: ''),
              WorkingHours(
                  days: 'Wednesday', openTime: 'Open 24 hours', closeTime: ''),
              WorkingHours(
                  days: 'Thursday', openTime: 'Open 24 hours', closeTime: ''),
              WorkingHours(
                  days: 'Friday', openTime: 'Open 24 hours', closeTime: ''),
              WorkingHours(
                  days: 'Saturday', openTime: 'Open 24 hours', closeTime: ''),
              WorkingHours(
                  days: 'Sunday', openTime: 'Open 24 hours', closeTime: ''),
            ],
          ),
          ThingsToDoDetails(
            name: 'RumSky Stargazing Adventure',
            imagePaths: [
              'images/${city}4.jpg',
              'images/${city}41.jpg',
              'images/${city}42.jpg',
              'images/${city}43.jpg',
              'images/${city}44.jpg',

            ],
            location: 'Wadi Rum - Disi Street Aqaba',
            description:
                "RumSky Stargazing Adventure offers a mesmerizing experience for astronomy enthusiasts and nature lovers. "
                "Located in the majestic Wadi Rum, known as the Valley of the Moon, this adventure lets visitors explore the wonders of the night sky in one of the world's best stargazing locations. "
                "The clear desert skies, free from light pollution, provide an unparalleled view of the stars, planets, and galaxies.\n\n"
                "Guided by professional astronomers, guests are treated to a tour of the constellations, learning about various celestial objects and their significance in ancient Bedouin culture. "
                "The use of powerful telescopes enhances the experience, allowing for up-close views of the moon's craters, the rings of Saturn, or the moons of Jupiter. "
                "RumSky also educates visitors on how to identify different stars and constellations and share fascinating stories and legends from Arabic astronomy.\n\n"
                "This unique experience combines the natural beauty of Wadi Rum's landscapes with the awe-inspiring beauty of the night sky, making it a truly unforgettable adventure. "
                "Whether you are an avid stargazer or simply looking for a unique way to experience the desert at night, RumSky Stargazing Adventure offers an enchanting and educational journey through the cosmos.",
           workingHours: [
              WorkingHours(
                  days: 'Monday', openTime: '12 AM', closeTime: '12 PM'),
              WorkingHours(
                  days: 'Tuesday', openTime: '12 AM', closeTime: '12 PM'),
              WorkingHours(
                  days: 'Wednesday', openTime: '12 AM', closeTime: '12 PM'),
              WorkingHours(
                  days: 'Thursday', openTime: '12 AM', closeTime: '12 PM'),
              WorkingHours(
                  days: 'Friday', openTime: '12 AM', closeTime: '12 PM'),
              WorkingHours(
                  days: 'Saturday', openTime: '12 AM', closeTime: '12 PM'),
              WorkingHours(
                  days: 'Sunday', openTime: '12 AM', closeTime: '12 PM'),
            ],
          ),
        ];

      default:
        return [];
    }
  }
}
