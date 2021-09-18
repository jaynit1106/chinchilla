import 'package:customer_app/views/widgets/snackbar.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> launchUrl(String url) async => await canLaunch(url)
    ? await launch(url)
    : launchSnack("Error", "Cannot launch: $url");
