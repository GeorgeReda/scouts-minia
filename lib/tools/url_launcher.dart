import 'package:scouts_minia/UI/components/mod_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

launchURL(
  url,
) async {
  if (await canLaunch(url.trim())) {
    await launch(url.trim());
  } else {
    ModDialog().showModDialog('Couldn\'t launch url . Please try again !');
  }
}
