import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE5E5E5),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xffE5E5E5),
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        title: Center(
            child: Image.asset(
          'assets/icons/lg.png',
          height: 40,
        )),
        actions: [
          Center(
              child: Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Icon(
              Icons.notifications,
              color: Colors.black,
              size: 30,
            ),
          ))
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          ListTile(
            leading: Image.asset(
              'assets/icons/about.png',
              height: 70,
            ),
            title: Text(
              "About us",
              style: TextStyle(color: Color(0xff28384F)),
            ),
          ),
          SizedBox(height: 15),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              width: double.infinity,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text('\‘\’In the 21st Century, the world belongs to the Geek!\’\’-Unknown.'),
                        ),
                        SizedBox(height: 5),
                        RichText(
                            textAlign: TextAlign.justify,
                            text: TextSpan(
                                style: TextStyle(color: Colors.black),
                                children: [
                                  TextSpan(
                                      text:
                                          "Interior Architecture Hub Africa Limited  (Arhchub Africa) is an organisation born out of a vision to make a marked difference in the development of the African Youth. Understanding that unemployment is a menace and a root cause of any number of social ills in sub-Saharan Africa, Archub is preparing a safe and secure environment for talent to meet with funding. We are about brining young people into the most inclusive employment space the world has to offer.With experts who cumulative have decades worth of experience in the interior architectural sphere, working alongside seasoned veterans in business development and corporate ethics, Archub offers a 360 perspective; giving creatives an environment to flourish and further improve on their diverse talents, furthering providing the less-public, but equally important side which involves translating raw talent into financial opportunities."),
                                  TextSpan(
                                      text:
                                          "\n\nWe are redefining the labour market and putting Africa on the tech map because we understand the unique advantage an under-developed continent holds; there’s plenty of room for innovation and growth, and there’s a teeming market right here!"),
                                  // TextSpan(
                                  //     text:
                                  //         " In nulla pellentesque integer rhoncus, senectus cras curabitur sed magna. Ipsum habitant feugiat interdum arcu. Mi et gravida fermentum justo, etiam at cras commodo varius. Natoque ornare duis sed lacinia maecenas non. Amet facilisi at egestas sed faucibus mattis scelerisque. Tellus amet at vel ac et, sed sagittis."),
                                  // TextSpan(
                                  //     text:
                                  //         "Pharetra, ornare venenatis eget feugiat urna scelerisque urna. Aliquet amet, fermentum mi quis at lobortis et tellus. At sed odio lacinia sagittis quis varius.sed faucibus mattis scelerisque. Tellus amet at vel ac et, sed sagittis. Pharetra, ornare venenatis eget feugiat urna scelerisque urna. "),
                                  // TextSpan(
                                  //     text:
                                  //         "Pharetra, ornare venenatis eget feugiat urna scelerisque urna. Aliquet amet, fermentum mi quis at lobortis et tellus. At sed odio lacinia sagittis quis varius.sed faucibus mattis scelerisque. Tellus amet at vel ac et, sed sagittis. Pharetra, ornare venenatis eget feugiat urna scelerisque urna. ")
                                ]))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ))
        ],
      ),
    );
  }
}
