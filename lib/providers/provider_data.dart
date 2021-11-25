import 'package:extinct_animals/models/animal_model.dart';
import 'package:extinct_animals/models/person_model.dart';
import 'package:extinct_animals/utils/database_helper.dart';
import 'package:extinct_animals/widgets/person_card.dart';
import 'package:flutter/foundation.dart';

class Data with ChangeNotifier {
  List<Person> ps = [];

  List<Person> get allPersons {
    return [...ps];
  }

  List<PersonCard> pscards = [];

  List<PersonCard> get allPersonsCard {
    return [...pscards];
  }

  
  void getUpdatedPersons(int vers) async {
    ps = await NotesDatabase.instance.getAllPersons(vers) as List<Person>;
    pscards.clear();
    for (int i = 0; i < ps.length; i++) {
      pscards.add(PersonCard(
        i: i,
        id: ps.elementAt(i).getId,
        firstName: ps.elementAt(i).firstName,
        lastName: ps.elementAt(i).lastName,
        phoneNo: ps.elementAt(i).phoneNo,
        mailId: ps.elementAt(i).mailId,
        vers: vers,
        isFav: ps.elementAt(i).fav == "0" ? false : true,
      ));
    }
    notifyListeners();
  }

  void clearAll() {
    pscards.clear();
    notifyListeners();
  }

  List<Animal> animals = [
    Animal(
        name: "Cave Lion",
        imgurl:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b1/Hoehlenloewe_CaveLion_hharder.jpg/188px-Hoehlenloewe_CaveLion_hharder.jpg",
        area: "Asia",
        wikiurl:
            "https://en.wikipedia.org/wiki/Cave_lion#:~:text=Cave%20lions%20are%20large%20extinct,species%2C%20depending%20on%20the%20authority.&text=fossilis%2C%20the%20Early%20Middle%20Pleistocene,lion%20or%20American%20cave%20lion"),
    Animal(
        name: "Giant Tapir",
        imgurl:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/0/05/MegatapirusDB.jpg/188px-MegatapirusDB.jpg",
        area: "Asia",
        wikiurl: 'https://en.wikipedia.org/wiki/Giant_tapir'),
    Animal(
        name: "Stegodon",
        imgurl:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/7/72/Stegodon_ganesaDB.jpg/203px-Stegodon_ganesaDB.jpg",
        area: "Asia",
        wikiurl: 'https://en.wikipedia.org/wiki/Stegodon'),
    Animal(
        name: "Reinoceors",
        imgurl:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/e/ea/Wooly_Rhino15.jpg/188px-Wooly_Rhino15.jpg",
        area: "Asia",
        wikiurl: 'https://en.wikipedia.org/wiki/Rhinoceros'),
    Animal(
        name: "Archaeoindris ",
        imgurl:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b5/Archaeoindris_fontoynonti.jpg/330px-Archaeoindris_fontoynonti.jpg",
        area: "Africa",
        wikiurl: 'https://en.wikipedia.org/wiki/Archaeoindris'),
    Animal(
        name: "Archaeolemur ",
        imgurl:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/c/ca/Archaeolemur_edwardsi.jpg/330px-Archaeolemur_edwardsi.jpg",
        area: "Africa",
        wikiurl: 'https://en.wikipedia.org/wiki/Archaeolemur'),
    Animal(
        name: "BABAKOTIA",
        imgurl:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ad/Babakotia_radofilai.jpg/330px-Babakotia_radofilai.jpg",
        area: "Africa",
        wikiurl: 'https://en.wikipedia.org/wiki/Babakotia'),
    Animal(
        name: "CAMELOPS ",
        imgurl:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/6/69/Camelops_hesternus_Sergiodlarosa.jpg/150px-Camelops_hesternus_Sergiodlarosa.jpg",
        area: "North Ameriaca",
        wikiurl: 'https://en.wikipedia.org/wiki/Camelops'),
  ];

  List<Animal> get allAnimals {
    return [...animals];
  }

  List<Animal> birds = [
    Animal(
        name: "Eskimo Curlew",
        imgurl:
            "https://www.thoughtco.com/thmb/yQZ51zM4bXqNHHgkxkHzMIP9SKI=/774x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/eskimocurlew-56a2552d3df78cf772747fc0.jpg",
        area: "America",
        wikiurl: 'https://en.wikipedia.org/wiki/Eskimo_curlew'),
    Animal(
        name: "Carolina Parakeet",
        imgurl:
            "https://www.thoughtco.com/thmb/-Co8GiOu_Nf3Zi7G5A-ID7C1VXM=/1250x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/Carolina-Parakeet-5c71c33f46e0fb000143622f.jpg",
        area: "Africa",
        wikiurl: 'https://en.wikipedia.org/wiki/Carolina_parakeet'),
    Animal(
        name: "Passenger Pigeon",
        imgurl:
            "https://th.bing.com/th/id/OIP.bRdfMi_C1fxgcuoDQMJgrAHaEL?w=307&h=180&c=7&r=0&o=5&pid=1.7",
        area: "Asia",
        wikiurl: 'https://en.wikipedia.org/wiki/Passenger_pigeon'),
    Animal(
        name: "Lyall's wren",
        imgurl:
            "https://www.thoughtco.com/thmb/MfEjn5HpMFJyZl_UB8fP6eHERIg=/774x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/1024px-Stephens_Island_Wren-58daf5983df78c51620b097e.png",
        area: "Europe",
        wikiurl: 'https://en.wikipedia.org/wiki/Lyall%27s_wren'),
    Animal(
        name: "Great Auk",
        imgurl:
            "https://www.thoughtco.com/thmb/pbkLjD6ccuQpsB5q9ySRzoZNCyY=/774x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/Great-Auk-5c71c53dc9e77c0001ddcec5.jpg",
        area: "Europe",
        wikiurl: 'https://en.wikipedia.org/wiki/Great_auk'),
    Animal(
        name: "Giant Moa",
        imgurl:
            "https://www.thoughtco.com/thmb/MJPUrqnl3bJbCgNj8EXM135KAMk=/774x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/Giant-Moa-5c71c64d46e0fb00014ef5fa.jpg",
        area: "Australia",
        wikiurl: 'https://en.wikipedia.org/wiki/Dinornis'),
    Animal(
        name: "Dodo Bird",
        imgurl:
            "https://www.thoughtco.com/thmb/QNIRxdOrqxzXrRdOuExbXnT01bQ=/1250x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/Dodo-bird-5c71c7d846e0fb0001b6820c.jpg",
        area: "Africa",
        wikiurl: 'https://en.wikipedia.org/wiki/Dodo'),
  ];
  List<Animal> get allBirds {
    return [...birds];
  }

  List<Animal> amphs = [
    Animal(
        name: "Nannophrys guentheri",
        imgurl:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/0/02/Nannophrys_guentheri.jpg/150px-Nannophrys_guentheri.jpg",
        area: "Asia",
        wikiurl: 'https://en.wikipedia.org/wiki/Nannophrys_guentheri'),
    Animal(
        name: "Pseudophilautus adspersus",
        imgurl:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d9/Pseudophilautus_adspersus.jpg/150px-Pseudophilautus_adspersus.jpg",
        area: "Asia",
        wikiurl: 'https://en.wikipedia.org/wiki/Pseudophilautus_adspersus'),
    Animal(
        name: "Yunnan lake new",
        imgurl:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d2/Cynops_wolterstorffi.JPG/150px-Cynops_wolterstorffi.JPG",
        area: "Asia",
        wikiurl: 'https://en.wikipedia.org/wiki/Yunnan_lake_newt'),
    Animal(
        name: "VOAY",
        imgurl:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Voay.jpg/150px-Voay.jpg",
        area: "Africa",
        wikiurl: 'https://en.wikipedia.org/wiki/Voay'),
    Animal(
        name: "Chioninia coctei ",
        imgurl:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6d/Chioninia_coctei.jpg/150px-Chioninia_coctei.jpg",
        area: "Africa",
        wikiurl: 'https://en.wikipedia.org/wiki/Chioninia_coctei'),
    Animal(
        name: "Cylindraspis peltasteS",
        imgurl:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/1/1e/Cylindraspis_peltastes_1770.png/150px-Cylindraspis_peltastes_1770.png",
        area: "Africa",
        wikiurl:
            'https://en.wikipedia.org/wiki/Domed_Rodrigues_giant_tortoise'),
    Animal(
        name: "Cylindraspis indica",
        imgurl:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/6/69/Cylindraspis_indica_1792.png/150px-Cylindraspis_indica_1792.png",
        area: "Asia",
        wikiurl: 'https://en.wikipedia.org/wiki/R%C3%A9union_giant_tortoise'),
  ];

  List<Animal> get allAmphs {
    return [...amphs];
  }

  List<Animal> plants = [
    Animal(
        name: "Cooksonia",
        imgurl:
            "https://floweraura-blog-img.s3.ap-south-1.amazonaws.com/Plant+Dec+2019-+Dec+2020/cooksonia.jpg",
        area: "ASIA",
        wikiurl: 'https://en.wikipedia.org/wiki/Cooksonia'),
    Animal(
        name: "Lepidodendron",
        imgurl:
            "https://floweraura-blog-img.s3.ap-south-1.amazonaws.com/Plant+Dec+2019-+Dec+2020/lepidodendron.jpg",
        area: "ASIA",
        wikiurl: 'https://en.wikipedia.org/wiki/Lepidodendron'),
    Animal(
        name: "Rhynia",
        imgurl:
            "https://floweraura-blog-img.s3.ap-south-1.amazonaws.com/Plant+Dec+2019-+Dec+2020/rhynia.jpg",
        area: "ASIA",
        wikiurl: 'https://en.wikipedia.org/wiki/Rhynia'),
    Animal(
        name: "orchid ",
        imgurl:
            "https://ichef.bbci.co.uk/news/976/cpsprodpb/9654/production/_109748483_stevart4hr.jpg",
        area: "AFRICA",
        wikiurl: 'https://en.wikipedia.org/wiki/Orchidaceae'),
    Animal(
        name: "Mace Pagoda",
        imgurl:
            "http://www.biodiversityexplorer.info/plants/proteaceae/images/160306CPJ16ed_497h.jpg",
        area: "AFRICA",
        wikiurl: ''),
    Animal(
        name: "Adenocarpus faurei",
        imgurl:
            "https://static.scientificamerican.com/blogs/cache/file/C93F6B6E-B4D4-4722-BCEABB36E43E6209_source.jpg?w=590&h=800&A17F9FA0-C727-4DDD-8FCE395547A96589",
        area: "AFRICA",
        wikiurl: 'https://en.wikipedia.org/wiki/Mimetes_stokoei'),
    Animal(
        name: "Franklinia Tree",
        imgurl:
            "https://static01.nyt.com/images/2020/10/09/science/00SCI-PLANTEXTINCTION-franklinia/00SCI-PLANTEXTINCTION-franklinia-jumbo.jpg?quality=75&auto=webp",
        area: "NORTH AMERICA",
        wikiurl: 'https://en.wikipedia.org/wiki/Franklinia'),
    Animal(
        name: " Barbara’s-buttons",
        imgurl:
            "https://static01.nyt.com/images/2020/10/20/science/00SCI-PLANTEXTINCTION-grandiflora/00SCI-PLANTEXTINCTION-grandiflora-superJumbo.jpg?quality=75&auto=webp",
        area: "NORTH AMERICA",
        wikiurl: 'https://www.wildflower.org/plants/result.php?id_plant=maca7'),
    Animal(
        name: "Small Solomon’s Seals",
        imgurl:
            "https://static01.nyt.com/images/2020/10/20/science/00SCI-PLANTEXTINCTION-polygonatum/00SCI-PLANTEXTINCTION-polygonatum-superJumbo.jpg?quality=75&auto=webp",
        area: "NORTH AMERICA",
        wikiurl:
            'https://www.finegardening.com/plant/small-solomons-seal-polygonatum-biflorum'),
  ];
  List<Animal> get allPlants {
    return [...plants];
  }
}
