import 'package:skywalker/misc/checkpoint.dart';
import 'package:skywalker/misc/transport.dart';

class Journey {
  final Checkpoint from;
  final Checkpoint to;
  final Transport transport;
  final double price;
  final String code;

  const Journey(
      {required this.from,
      required this.to,
      this.transport = Transport.flight,
      this.price = 0,
      this.code = ""});

  Journey.fromMap(Map<String, dynamic> map)
      : from = Checkpoint.fromMap(map["from"]),
        to = Checkpoint.fromMap(map["to"]),
        transport = Transport.fromString(map["transport"]),
        price = map["price"],
        code = map["code"];
  
  static Map<String, dynamic> toMap(Journey value) => {
    "from": Checkpoint.toMap(value.from),
    "to": Checkpoint.toMap(value.to),
    "transport": value.transport.toString(),
    "price": value.price,
    "code": value.code
  };
}
