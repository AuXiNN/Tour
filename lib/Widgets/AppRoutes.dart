import 'package:flutter/material.dart';
import 'package:tour/Pages/PlaceDesc.dart';
import 'package:tour/Pages/login.dart';
import 'package:tour/Pages/signup.dart';
import 'package:tour/Pages/homepage.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      "signup": (context) => const SignUp(),
        "login": (context) => const Login(),
        "homepage": (context) => const HomePage(),
        "amman": (context) => PlaceDesc(
              imagePath: 'images/AmmanDesc.jpg',
              title: 'Amman',
              description:
                  "Amman, the capital of Jordan, is a fascinating city of contrasts - a unique blend of old and new, "
                  "situated on a hilly area between the desert and the fertile Jordan Valley. In the commercial heart of the city, "
                  "ultra-modern buildings, hotels, restaurants, art galleries and boutiques rub shoulders comfortably with traditional "
                  "coffee shops and tiny artisan workshops. Amman’s neighborhoods are diverse and range in cultural and historical context "
                  "from the hustle and bustle of the downtown markets, to the art galleries of Jabal Al Lweibdeh and the modern shopping district of Abdali.",
            ),
        "aqaba": (context) => PlaceDesc(
              imagePath: 'images/AqabaDesc.jpg',
              title: 'Aqaba',
              description:
                  "Aqaba is a coastal city in Jordan known for its stunning beaches along the Red Sea."
                  "It's a bustling port town and a significant tourist destination, offering breathtaking underwater vistas for diving and snorkeling enthusiasts."
                  "Aqaba boasts a rich history, with landmarks like Aqaba Fort adding to its cultural allure."
                  "The city's vibrant markets, waterfront promenade, and proximity to iconic sites like Wadi Rum make it an alluring destination for both relaxation and adventure.",
            ),
        "jerash": (context) => PlaceDesc(
              imagePath: 'images/JerashDesc.jpg',
              title: 'Jerash',
              description:
                  'A close second to Petra on the list of favorite destinations in Jordan, the ancient city of Jerash boasts an unbroken chain of human occupation dating back more than 6,500 years and is only about 45km north of Amman and because of its water the site has been settled at least since Neolithic times. '
                  "The city's golden age came under Roman rule and the site is now generally acknowledged to be one of the best-preserved Roman provincial towns in the world and one of the Decapolis cities once named Gerasa. Hidden for centuries in sand before being excavated and restored over the past 70 years"
                  "Jerash reveals a fine example of the grand, formal provincial Roman urbanism that is found throughout the Middle East, comprising paved and colonnaded streets, soaring hilltop temples, grand theatres, spacious public squares and plazas, baths, fountains and city walls pierced by towers and gates. "
                  "Beneath its external Graeco-Roman veneer, Jerash also preserves a subtle blend of east and west. Its architecture, religion and languages reflect a process by which two powerful cultures meshed and coexisted - The Graeco-Roman world of the Mediterranean basin and the ancient traditions of the Arab Orient.",
            ),
        "ajloun": (context) => PlaceDesc(
              imagePath: 'images/AjlounCastleDesc.jpg',
              title: 'Ajloun',
              description:
                  'The marvels of nature and the genius of medieval Arab military architecture have given northern Jordan two of the most important '
                  "ecological and historical attractions in the Middle East: the sprawling pine forests of the Ajloun-Dibbine area, and the towering Ayyubid castle at Ajloun, "
                  "which helped to defeat the Crusaders eight centuries ago. Locals often take advantage of the green landscapes of Ajloun to take a break from city life and connect with nature.",
            ),
        "petra": (context) => PlaceDesc(
              imagePath: 'images/petra1.png',
              title: 'Petra',
              description:
                  // ignore: prefer_interpolation_to_compose_strings
                  "Petra, often referred to as the \"Rose City,\" is an archaeological marvel " +
                  "nestled in the rugged desert canyons of southern Jordan. Carved into vibrant pink " +
                  "sandstone cliffs, this UNESCO World Heritage Site is renowned for its intricate " +
                  "rock-cut architecture. Petra's most iconic structure, Al-Khazneh or \"The Treasury,\" " +
                  "captivates visitors with its grandeur, revealing the city's rich history as an " +
                  "important trading hub. As you navigate through the narrow Siq, a natural gorge " +
                  "leading to the city, you'll uncover ancient tombs, temples, and dwellings that " +
                  "showcase the engineering prowess of the Nabataean people who once thrived here. " +
                  "Petra stands as a testament to the ingenuity and splendor of an ancient civilization " +
                  "etched into the heart of the Jordanian desert.",
            ),
        "deadsea": (context) => PlaceDesc(
              imagePath: 'images/deadseaDesc.jpg',
              title: 'Dead Sea',
              description:
                  // ignore: prefer_interpolation_to_compose_strings
                  "Nestled at the lowest point on Earth, the Dead Sea is a unique natural wonder bordering Jordan to the east and to the west. " +
                  "Renowned for its hypersaline waters, the Dead Sea allows bathers to effortlessly float on its surface, an unparalleled experience due to the high mineral concentration. " +
                  "The therapeutic mud of the Dead Sea is coveted for its rejuvenating properties, drawing visitors from around the globe for therapeutic spa treatments. " +
                  "Surrounding the sea, the arid landscape enhances the surreal beauty of the region, offering breathtaking views of rugged mountains and the distant shores. " +
                  "The Dead Sea stands as both a geological marvel and a cherished destination for those seeking relaxation and wellness.",
            ),
        "wadirum": (context) => PlaceDesc(
              imagePath: 'images/wadirumDesc.jpg',
              title: 'Wadi Rum',
              description:
                  // ignore: prefer_interpolation_to_compose_strings
                  "Wadi Rum, also known as the Valley of the Moon, is a mesmerizing desert landscape in Jordan, characterized by towering sandstone mountains and vast red sand dunes. " +
                  "This unique destination offers visitors the chance to explore its otherworldly terrain through thrilling jeep tours or camel rides. " +
                  "As the sun sets over Wadi Rum, the colors of the desert come alive, creating a breathtaking spectacle that captivates all who witness it. " +
                  "For those seeking a truly immersive experience, camping under the starry desert sky is an unforgettable adventure in Wadi Rum.",
            ),
      

    };
  }
}
