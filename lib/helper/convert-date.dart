String convertDateTime(DateTime dateTime){

  String tahun = dateTime.year.toString();
  String bulan = dateTime.month.toString();
  String tanggal = dateTime.day.toString();
  String combine = tahun + bulan + tanggal;
  return combine;
}

DateTime convertDateTimeM(String tanggal) {
  List<String> tanggalParts = tanggal.split('-');
  int day = int.parse(tanggalParts[0]);
  int month = int.parse(tanggalParts[1]);
  int year = int.parse(tanggalParts[2]);
  return DateTime(year, month, day);
}