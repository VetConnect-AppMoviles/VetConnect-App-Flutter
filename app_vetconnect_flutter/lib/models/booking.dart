class Booking {
  final String petOwnerName;
  final String appointmentDateTime;

  Booking({required this.petOwnerName, required this.appointmentDateTime});

  factory Booking.fromJson(Map<String, dynamic> json, Map<int, String> users) {
    return Booking(
      petOwnerName: users[json['petOwnerId']] ?? 'Unknown',
      appointmentDateTime: json['bookingDetails']['appointmentDateTime'],
    );
  }
}