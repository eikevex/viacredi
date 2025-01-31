import 'dart:math';

String getRandomCity() {
  List<String> cities = ['Blumenau', 'Indaial', 'Timbó', 'Gaspar'];
  
  Random random = Random();
  int index = random.nextInt(cities.length);
  
  return cities[index];
}

String getRandomAgency() {
  Random random = Random();
  int agencyNumber = random.nextInt(10) + 1;
  
  return 'Agência $agencyNumber';
}