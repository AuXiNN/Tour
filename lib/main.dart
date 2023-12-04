import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tour/Pages/login.dart';
import 'package:tour/Pages/signup.dart';
import 'package:tour/Pages/homepage.dart';
import 'Pages/CityDesc.dart';
import 'hotel/views/first.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('==========================User is currently signed out!');
      } else {
        print('==========================User is signed in!');
      }
    });
    super.initState();
  }

  @override
  Widget build(context) {  
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirebaseAuth.instance.currentUser == null
          ? const Login()
          : const HomePage(),
      routes: {
        "signup": (context) => const SignUp(),
        "login": (context) => const Login(),
        "homepage": (context) => const HomePage(),
        "hotel" :(context) => const FirstPage(),


        "amman": (context) => CityDesc(
                imagePath: 'images/AmmanDesc.jpg',
                title: 'Amman',
                description:
                    "Amman, the capital of Jordan, is a fascinating city of contrasts - a unique blend of old and new, "
                    "situated on a hilly area between the desert and the fertile Jordan Valley. In the commercial heart of the city, "
                    "ultra-modern buildings, hotels, restaurants, art galleries and boutiques rub shoulders comfortably with traditional "
                    "coffee shops and tiny artisan workshops. Amman’s neighborhoods are diverse and range in cultural and historical context "
                    "from the hustle and bustle of the downtown markets, to the art galleries of Jabal Al Lweibdeh and the modern shopping district of Abdali.",
                imagesPaths: const [
                  
                  'images/umm_ar-rasas.jpg',
                  'images/RomanTheatre.jpg',
                  'images/Telmpe-Of-Hercules.jpg',
                  'images/UmayyadPalace.jpeg',
                  'images/qasr-al-kharrana.jpg',

                  // Add paths to archaeological site images in Amman
                ],
                siteNames: const [
                  
                  'Umm Ar-rases',
                  'Roman Theatre',
                  'Temple Of Hercules',
                  'Umayyyad Palace',
                  'Qasr Al-Harrana',
                ]),






        "aqaba": (context) => CityDesc(
                imagePath: 'images/AqabaDesc.jpg',
                title: 'Aqaba',
                description:
                    "Aqaba is a coastal city in Jordan known for its stunning beaches along the Red Sea."
                    "It's a bustling port town and a significant tourist destination, offering breathtaking underwater vistas for diving and snorkeling enthusiasts."
                    "Aqaba boasts a rich history, with landmarks like Aqaba Fort adding to its cultural allure."
                    "The city's vibrant markets, waterfront promenade, and proximity to iconic sites like Wadi Rum make it an alluring destination for both relaxation and adventure.",
                imagesPaths: const [
                  'images/wadirum.jpg',
                  'images/RedSea.jpg',
                  'images/AqabaFortress.jpg',
                  // Add paths to archaeological site images in Amman
                ],
                siteNames: const [
                  'Wadi Rum',
                  'Red Sea',
                  'Aqaba Fortress',
                ]),





        "zarqa": (context) => CityDesc(
                imagePath: 'images/ZarqaDesc.jpg',
                title: 'Zarqa',
                description:
                    'Zarqa, a vibrant city in Jordan, serves as the capital of the Zarqa Governorate, located approximately 20 km northeast of Amman, '
                    "Jordan's capital. It stands as the country's third-largest city, renowned as Jordan's industrial hub,"
                    "pulsating with dynamic commercial activity and bustling markets.",
                imagesPaths: const [
                  'images/QasrAmra.jpg',
                  'images/QasrAl-Hallabat.jpg',
                  'images/QasrAlAzrag.jpg',
                  // Add paths to archaeological site images in Amman
                ],
                siteNames: const [
                  'Qasr Amra',
                  'Qasr Al-Hallabat',
                  'Qasr Al-Azrag',
                ]),

        "irbid": (context) => CityDesc(
                imagePath: 'images/IrbidDesc.jpeg',
                title: 'Irbid',
                description:
                    'Located in the north of Jordan with the second largest population in the kingdom, '
                    "Irbid is a mix of authentic Arabian society with flashes of western influence. "
                    "Boasting panoramic views of the West Bank and ancient architectures from the Roman era, Irbid tells a tale of its own. ",
                imagesPaths: const [
                  'images/UmmQais.jpeg',
                  'images/DarAsSarayaMuseum.jpg',
                  'images/WadiShalala.jpg',
                  // Add paths to archaeological site images in Amman
                ],
                siteNames: const [
                  'Umm Qais',
                  'Dar As Saraya Osmanli Museum',
                  'Wadi Shalala',
                ]),



        "madaba": (context) => CityDesc(
                imagePath: 'images/MadabaDesc.jpeg',
                title: 'Madaba',
                description:
                    'Madaba, known as the "City of Mosaics," is a historic town located in Jordan, about 30 kilometers southwest of Amman.'
                    "It holds immense historical and religious significance due to its rich cultural heritage and ancient mosaic art. "
                    ,
                imagesPaths: const [
                  'images/QasrAmra.jpg',
                  'images/QasrAl-Hallabat.jpg',
                  'images/QasrAlAzrag.jpg',
                  // Add paths to archaeological site images in Amman
                ],
                siteNames: const [
                  'Qasr Amra',
                  'Qasr Al-Hallabat',
                  'Qasr Al-Azrag',
                ]),
                        

        "mafraq": (context) => CityDesc(
                imagePath: 'images/MafraqDesc.jpg',
                title: 'Mafraq',
                description:
                    'Mafraq, nestled in northern Jordan, is a bustling hub characterized by its strategic location near the Syrian border. '
                    "Renowned for its vibrant markets and cultural diversity, Mafraq serves as a key transit point for travelers and refugees, embodying resilience amid geopolitical complexities. "
                    "This city, known for its hospitable locals and evolving urban landscape, reflects the dynamic spirit of Jordan's northern region.",
                imagesPaths: const [
                  'images/QasrAmra.jpg',
                  'images/QasrAl-Hallabat.jpg',
                  'images/QasrAlAzrag.jpg',
                  // Add paths to archaeological site images in Amman
                ],
                siteNames: const [
                  'Qasr Amra',
                  'Qasr Al-Hallabat',
                  'Qasr Al-Azrag',
                ]),



        "ma'an": (context) => CityDesc(
                imagePath: "images/Ma'anDesc.jpeg",
                title: "Ma'an",
                description:
                    "Ma'an, situated in southern Jordan, stands as a gateway to breathtaking desert landscapes and historical treasures. "
                    "Known for its rich Bedouin heritage, Ma'an exudes a serene charm, offering glimpses into traditional Jordanian life. "
                    "This city, nestled amidst stunning natural vistas, captivates with its cultural authenticity and echoes of ancient civilizations.",
                imagesPaths: const [
                  'images/QasrAmra.jpg',
                  'images/QasrAl-Hallabat.jpg',
                  'images/QasrAlAzrag.jpg',
                  // Add paths to archaeological site images in Amman
                ],
                siteNames: const [
                  'Qasr Amra',
                  'Qasr Al-Hallabat',
                  'Qasr Al-Azrag',
                ]),
                        

        "at-tafilah": (context) => CityDesc(
                imagePath: 'images/At-TafilahDesc.jpeg',
                title: 'At-Tafilah',
                description:
                    "At-Tafilah, perched in Jordan's southwestern region, holds a serene ambiance amid picturesque valleys and historical ruins. "
                    "Renowned for its stunning landscapes, this city embodies Jordan's cultural heritage with remnants of ancient civilizations. "
                    "At-Tafilah invites exploration, offering a serene retreat amidst its scenic beauty and storied past.",
                imagesPaths: const [
                  'images/QasrAmra.jpg',
                  'images/QasrAl-Hallabat.jpg',
                  'images/QasrAlAzrag.jpg',
                  // Add paths to archaeological site images in Amman
                ],
                siteNames: const [
                  'Qasr Amra',
                  'Qasr Al-Hallabat',
                  'Qasr Al-Azrag',
                ]),


 
        "wadi as-seir": (context) => CityDesc(
                imagePath: 'images/Wadi-As-Seir.jpg',
                title: 'Wadi As-Seir',
                description:
                    "Wadi as-Seir, nestled in Jordan's western terrain, captivates with its rugged beauty and deep-rooted historical significance."
                    "Embracing striking natural vistas and ancient heritage, this city epitomizes tranquility amidst its breathtaking landscapes and echoes of antiquity. "
                    "Wadi as-Seir beckons adventurers to explore its scenic wonders and uncover its rich cultural tapestry.",
                imagesPaths: const [
                  'images/QasrAmra.jpg',
                  'images/QasrAl-Hallabat.jpg',
                  'images/QasrAlAzrag.jpg',
                  // Add paths to archaeological site images in Amman
                ],
                siteNames: const [
                  'Qasr Amra',
                  'Qasr Al-Hallabat',
                  'Qasr Al-Azrag',
                ]),



        "jerash": (context) => CityDesc(
                imagePath: 'images/JerashDesc.jpg',
                title: 'Jerash',
                description:
                    'A close second to Petra on the list of favorite destinations in Jordan, the ancient city of Jerash boasts an unbroken chain of human occupation dating back more than 6,500 years and is only about 45km north of Amman and because of its water the site has been settled at least since Neolithic times. '
                    "The city's golden age came under Roman rule and the site is now generally acknowledged to be one of the best-preserved Roman provincial towns in the world and one of the Decapolis cities once named Gerasa. Hidden for centuries in sand before being excavated and restored over the past 70 years"
                    "Jerash reveals a fine example of the grand, formal provincial Roman urbanism that is found throughout the Middle East, comprising paved and colonnaded streets, soaring hilltop temples, grand theatres, spacious public squares and plazas, baths, fountains and city walls pierced by towers and gates. "
                    "Beneath its external Graeco-Roman veneer, Jerash also preserves a subtle blend of east and west. Its architecture, religion and languages reflect a process by which two powerful cultures meshed and coexisted - The Graeco-Roman world of the Mediterranean basin and the ancient traditions of the Arab Orient.",
                imagesPaths: const [
                  'images/QasrAmra.jpg',
                  'images/QasrAl-Hallabat.jpg',
                  'images/QasrAlAzrag.jpg',
                  // Add paths to archaeological site images in Amman
                ],
                siteNames: const [
                  'Qasr Amra',
                  'Qasr Al-Hallabat',
                  'Qasr Al-Azrag',
                ]),

         "ajloun": (context) => CityDesc(
                imagePath: 'images/AjlounCastleDesc.jpg',
                title: 'Ajloun',
                description:
                    'The marvels of nature and the genius of medieval Arab military architecture have given northern Jordan two of the most important '
                    "ecological and historical attractions in the Middle East: the sprawling pine forests of the Ajloun-Dibbine area, and the towering Ayyubid castle at Ajloun, "
                    "which helped to defeat the Crusaders eight centuries ago. Locals often take advantage of the green landscapes of Ajloun to take a break from city life and connect with nature.",
                imagesPaths: const [
                  'images/QasrAmra.jpg',
                  'images/QasrAl-Hallabat.jpg',
                  'images/QasrAlAzrag.jpg',
                  // Add paths to archaeological site images in Amman
                ],
                siteNames: const [
                  'Qasr Amra',
                  'Qasr Al-Hallabat',
                  'Qasr Al-Azrag',
                ]),




      },
    );
  }
}
