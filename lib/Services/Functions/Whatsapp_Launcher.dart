import 'package:url_launcher/url_launcher.dart';


Future<void> sendWhatsAppMessage(String phoneNumber, String message) async {
  final url = 'whatsapp://send?phone=$phoneNumber&text=$message';

  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch WhatsApp';
  }
}