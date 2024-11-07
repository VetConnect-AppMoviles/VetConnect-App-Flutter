class Booking {
  final int id;
  final int petOwnerId;
  final int vetCenterId;
  final String serviceType;
  final String appointmentDateTime;
  final String additionalInfo;
  final double price;
  final String bookingDate;

  Booking({
    required this.id,
    required this.petOwnerId,
    required this.vetCenterId,
    required this.serviceType,
    required this.appointmentDateTime,
    required this.additionalInfo,
    required this.price,
    required this.bookingDate,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      petOwnerId: json['petOwnerId'],
      vetCenterId: json['vetCenterId'],
      serviceType: json['serviceType'],
      appointmentDateTime: json['appointmentDateTime'],
      additionalInfo: json['additionalInfo'],
      price: json['price'].toDouble(),
      bookingDate: json['bookingDate'],
    );
  }
}