class PersonModel {
  final int id;
  final String avatarUrl;
  final String username;
  final String fullname;
  final String ic;
  final String about;
  final String ranking;
  final String department;
  final String occupation;
  final int points;
  final int latestUpdatedNumber;
  final String latestUpdatedUnit;

  PersonModel(
      {this.id,
      this.avatarUrl,
      this.username,
      this.fullname,
      this.ic,
      this.about,
      this.ranking,
      this.department,
      this.occupation,
      this.points,
      this.latestUpdatedNumber,
      this.latestUpdatedUnit});

  static List<PersonModel> fetchAll() {
    return dummyDataPersons;
  }

  static PersonModel fetchByID(int personID) {
    //fetch all locations, iterate them and when we find the location
    //with the ID we want, return it immediately.
    List<PersonModel> persons = PersonModel.fetchAll();
    for (var i = 0; i < persons.length; i++) {
      if (persons[i].id == personID) {
        return persons[i];
      }
    }
    return null;
  }
}

List<PersonModel> dummyDataPersons = [
  PersonModel(
    id: 1,
    avatarUrl: "assets/images/person_dp_profile/dp_bad.jpg",
    username: "bad",
    fullname: "Badrul Amin Jaafar",
    ic: "971209-10-8510",
    about: "Be the best among the best.",
    ranking: "N1 in Campus",
    department: "FCMS",
    occupation: "Comp. Mathematician",
    points: 389,
    latestUpdatedNumber: 18,
    latestUpdatedUnit: "min",
  ),
  PersonModel(
    id: 2,
    avatarUrl: "assets/images/person_dp_profile/azzan97.jpg",
    username: "azzan97",
    fullname: "Azzan Amin",
    ic: "971209-10-8507",
    about: "Thinker always be a key person in any situation.",
    ranking: "N2 in Campus",
    department: "FCMS",
    occupation: "Comp. Scientist",
    points: 375,
    latestUpdatedNumber: 18,
    latestUpdatedUnit: "min",
  ),
  PersonModel(
    id: 3,
    avatarUrl: "assets/images/person_dp_profile/dp_iwan.jpg",
    username: "iwanpop",
    fullname: "Muhammad Ridhzuan Abdul Rahim",
    ic: "971209-21-0221",
    about: "Penang mari.....",
    ranking: "N3 in Campus",
    department: "FCMS",
    occupation: "Comp. Mathematician",
    points: 374,
    latestUpdatedNumber: 17,
    latestUpdatedUnit: "min",
  ),
  PersonModel(
    id: 4,
    avatarUrl: "assets/images/person_dp_profile/dp_sharil.jpg",
    username: "sharil",
    fullname: "Mohd Sharil Iqman Mohd Sabri",
    ic: "970817-03-1230",
    about: "Hoki menyatukan mahasiswa",
    ranking: "N4 in Campus",
    department: "FCMS",
    occupation: "Comp. Mathematician",
    points: 300,
    latestUpdatedNumber: 31,
    latestUpdatedUnit: "min",
  ),
  PersonModel(
    id: 5,
    avatarUrl: "assets/images/person_dp_profile/dp_default.png",
    username: "arifhusaini97",
    fullname: "Nur Arif Husaini Norwaza",
    ic: "970623-08-6507",
    about: "I am on a mission to empower everyone around me to achieve more.",
    ranking: "N5 in Campus",
    department: "FSKM",
    occupation: "Comp. Mathematics",
    points: 299,
    latestUpdatedNumber: 2,
    latestUpdatedUnit: "d",
  ),
  PersonModel(
    id: 6,
    avatarUrl: "assets/images/person_dp_profile/mey.jpg",
    username: "mey",
    fullname: "Muhammad Ammar Aziz",
    ic: "971223-10-6917",
    about: "Let's be a better person",
    ranking: "N6 in Campus",
    department: "FCMS",
    occupation: "Comp. Scientist",
    points: 297,
    latestUpdatedNumber: 15,
    latestUpdatedUnit: "min",
  ),
  PersonModel(
    id: 7,
    avatarUrl: "assets/images/person_dp_profile/dp_din.jpg",
    username: "dinstrong",
    fullname: "Muhammad Ridzauddin Ridzwan",
    ic: "971209-10-1107",
    about: "Chaos.",
    ranking: "N7 in Campus",
    department: "FCMS",
    occupation: "Comp. Mathematician",
    points: 250,
    latestUpdatedNumber: 17,
    latestUpdatedUnit: "h",
  ),
  PersonModel(
    id: 8,
    avatarUrl: "assets/images/person_dp_profile/dp_ijat.jpg",
    username: "ijat97",
    fullname: "Muhammad Izzat Isa",
    ic: "970209-01-8107",
    about: "Chaos 2.",
    ranking: "N8 in Campus",
    department: "FCMS",
    occupation: "Comp. Mathematician",
    points: 250,
    latestUpdatedNumber: 18,
    latestUpdatedUnit: "min",
  ),
];
