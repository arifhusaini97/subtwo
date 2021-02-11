class OrganizationModel {
  final int id;
  final String avatarUrl;
  final String username;
  final String fullname;
  final String regRos;
  final String about;
  final String ranking;
  final String isUnder;
  final String industry;
  final int points;
  final int latestUpdatedNumber;
  final String latestUpdatedUnit;

  OrganizationModel(
      {this.id,
      this.avatarUrl,
      this.username,
      this.fullname,
      this.regRos,
      this.about,
      this.ranking,
      this.isUnder,
      this.industry,
      this.points,
      this.latestUpdatedNumber,
      this.latestUpdatedUnit});
  static List<OrganizationModel> fetchAll() {
    return dummyDataOrganizations;
  }

  static OrganizationModel fetchByID(int organizationID) {
    //fetch all locations, iterate them and when we find the location
    //with the ID we want, return it immediately.
    List<OrganizationModel> organizations = OrganizationModel.fetchAll();
    for (var i = 0; i < organizations.length; i++) {
      if (organizations[i].id == organizationID) {
        return organizations[i];
      }
    }
    return null;
  }
}

List<OrganizationModel> dummyDataOrganizations = [
  OrganizationModel(
    id: 1,
    avatarUrl: "assets/images/organization_dp_profile/logo_demath.jpg",
    username: "demaths",
    fullname: "Degree in Mathematics Society",
    regRos: "TR011213-S",
    about: "Together We Strong!",
    ranking: "N1 in Campus",
    isUnder: "UiTM N9",
    industry: "Mathematics",
    points: 3001,
    latestUpdatedNumber: 3,
    latestUpdatedUnit: "d",
  ),
  OrganizationModel(
    id: 2,
    avatarUrl: "assets/images/organization_dp_profile/logo_mpp_uitm.jpg",
    username: "mppuitmn9",
    fullname: "Majlis Perwakilan Pelajar UiTM N9",
    regRos: "TR011222-S",
    about: "Berkhidmat untuk mahasiswa.",
    ranking: "N2 in Campus",
    isUnder: "UiTM N9",
    industry: "Social",
    points: 3000,
    latestUpdatedNumber: 18,
    latestUpdatedUnit: "min",
  ),
  OrganizationModel(
    id: 3,
    avatarUrl: "assets/images/organization_dp_profile/logo_jpksrmbn3.jpg",
    username: "jpksrmbn3",
    fullname: "Jawatankuasa Perwakilan Kolej",
    regRos: "TR011220-S",
    about: "Berkhidmat untuk mahasiswa.",
    ranking: "N3 in Campus",
    isUnder: "UiTM N9",
    industry: "Social",
    points: 2995,
    latestUpdatedNumber: 18,
    latestUpdatedUnit: "min",
  ),
  OrganizationModel(
    id: 4,
    avatarUrl: "assets/images/organization_dp_profile/logo_dipac.png",
    username: "dipacsrmbn",
    fullname: "Diploma in Public Admin. & Corp.",
    regRos: "TR011223-S",
    about: "Be better is not a choice.",
    ranking: "N4 in Campus",
    isUnder: "UiTM N9",
    industry: "Corporate",
    points: 2990,
    latestUpdatedNumber: 15,
    latestUpdatedUnit: "min",
  ),
  OrganizationModel(
    id: 5,
    avatarUrl: "assets/images/organization_dp_profile/logo_gpms.jpg",
    username: "gpmsn9",
    fullname: "GPMS N9",
    regRos: "TR011222-S",
    about: "Bersatu kita bersatu.",
    ranking: "N5 in Campus",
    isUnder: "UiTM N9",
    industry: "Social",
    points: 2800,
    latestUpdatedNumber: 18,
    latestUpdatedUnit: "min",
  ),
  OrganizationModel(
    id: 6,
    avatarUrl: "assets/images/organization_dp_profile/logo_ipm.jpg",
    username: "ipmn9",
    fullname: "Institut Pemimpin Muda UiTM N9",
    regRos: "TR0112123-S",
    about: "Kepimpinan melalui tauladan.",
    ranking: "N6 in Campus",
    isUnder: "UiTM N9",
    industry: "Social",
    points: 2767,
    latestUpdatedNumber: 37,
    latestUpdatedUnit: "min",
  ),
];

class CreateOrganizationModel {
  // static const String PassionHiking = 'hiking';
  // static const String PassionSwimming = 'swimming';
  // static const String PassionFlying = 'flying';

  int id = 0;
  String avatarUrl = '';
  String username = '';
  String fullname = '';
  String regRos = '';
  String about = '';
  String ranking = '';
  String isUnder = '';
  String industry = '';
  String telNo = '';
  String email = '';
  String type = '';
  int points = 0;
  int latestUpdatedNumber = 0;
  String latestUpdatedUnit = '';

  // Map<String, bool> passions = {
  //   PassionHiking: false,
  //   PassionSwimming: false,
  //   PassionFlying: false,
  // };

  // bool newsletter = false;

  save() {
    print('saving user using web servis');
  }
}
