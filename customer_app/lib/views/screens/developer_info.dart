import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:customer_app/services/url_launcher.dart';
import 'package:customer_app/utils/constants/string.dart';

class DeveloperInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Developer Info'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.network(
                "https://github.com/GEPTON-INFOTECH/GEPTON-INFOTECH/raw/main/branding/gepton_header_invert.png"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      launchUrl("mailto:notify@gepton.com");
                    },
                    icon: FaIcon(FontAwesomeIcons.envelope)),
                IconButton(
                    onPressed: () {
                      launchUrl("https://www.instagram.com/geptonofficial/");
                    },
                    icon: FaIcon(FontAwesomeIcons.instagram)),
                IconButton(
                    onPressed: () {
                      launchUrl("https://twitter.com/geptonofficial");
                    },
                    icon: FaIcon(FontAwesomeIcons.twitter)),
                IconButton(
                    onPressed: () {
                      launchUrl("https://www.linkedin.com/company/gepton");
                    },
                    icon: FaIcon(FontAwesomeIcons.linkedin)),
                IconButton(
                    onPressed: () {
                      launchUrl("https://github.com/gepton-infotech");
                    },
                    icon: FaIcon(FontAwesomeIcons.github)),
              ],
            ),
            SizedBox(
              height: Get.height * 0.03,
            ),
            Text(cAboutGepton),
            SizedBox(
              height: Get.height * 0.05,
            ),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    launchUrl("https://gepton.com");
                  },
                  child: Text(
                    'Website',
                    style: TextStyle(fontSize: 18),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
