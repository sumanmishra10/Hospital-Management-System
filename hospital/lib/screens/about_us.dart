import 'package:flutter/material.dart';
import 'package:hospital/util/drawer.dart';

class AboutUsPage extends StatefulWidget {
  final String username;

  const AboutUsPage({super.key, required this.username});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  String selectedPage = 'About US';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('About Us'),
          backgroundColor:
              Color.fromARGB(255, 116, 135, 255), // Customize the app bar color
        ),
        drawer: AppDrawer(
          username: widget.username,
          selectedPage: 'About US', // Replace with actual username
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Company Image
                Container(
                  width: 150, // Adjust the image width
                  height: 150, // Adjust the image height
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(
                          'images/koshilogo.png'), // Replace with your company's image
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 20), // Add spacing

                // Company Details
                Text(
                  'About Our Company',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12), // Add spacing
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      'सार्वजनिक स्वास्थ्य सेवाका अस्पतालको इतिहासलाई हेर्दा कोशी अस्पताल १३० बर्ष पुरानो र नेपालकै जेठो अस्पताल रहेको पाइन्छ । वि.सं. १९४७ सालमा वीर शमशेरले पूर्व देखि नम्बर राख्दै देशका विभिन्न भाग हुदै पश्चिम सम्म पुगेका थिए । यसै क्रममा विभिन्न ठाउँमा पि वीर अस्पतालहरु एकै बर्ष खोलेकोमा यस अस्पतालको स्थापना पछि काठमाण्डौंको वीर अस्पतालको स्थापना भएको अभिलेखबाट देखिन्छ। वि.सं. १९२७ सालमा मोरङ्ग जिल्लाको सदरमुकामको रुपमा स्थापित रंगेली बजारमा धेरै जसो सरकारी कार्यालयहरु रहेका थिए । वि.सं. १९४७ सालमा स्थापित १ लम्बर पि वीर अस्पताल त्यही स्थापना भएको कुरा काठमा कुदिएको अभिलेखबाट प्रष्ट हुन्छ र पछि वि.सं. १९७१ सालमा जिल्लाको सदरमुकाम विराटनगर सार्दा यो अस्पताल पनि विराटनगर सारिएको थियो । चिल्लो काठमा राम्रा अक्षरले कुँदेर बनाईएको उक्त पी. वीर १ लम्बर लेखिएको अस्पतालको साईन बोर्ड अहिले पनि अस्पतालमा सुरक्षित छ। यसमा लेखिएको पि शब्दले पृथ्वीवीरविक्रम र वीर शब्दले वीर शमशेर भन्ने जनाउँछ। त्यो बेला राजा र राणा (प्रधानमन्त्री) दुवैको संयुक्त नामले सार्वजनिक महत्वका वस्तुको नाम राख्ने चलन थियो भन्ने बुझिन्छ । यसका अलावा वीर अस्पतालले १०० बर्ष पुगेको अवसरमा प्रकाशित गरेको स्मारिकामा उल्लेख गरेको त्यस बेलाको आलेख सम्पूर्ण तथ्य प्रमाणका आधारमा कोशी अस्पताल नेपालको सबै भन्दा जेठो अस्पताल प्रमाणित भएको छ।'
                      'यो अस्पताल वि.सं. १९७१ सालमा विराटनगर सारिए पछि यसको रेखदेखको जिम्मा र प्रबन्ध मिलाउने कार्य समाजसेवी श्री कृष्ण प्रसाद कोइरालाको हातमा आईपर्‍यो । वहाँले कलकत्ताबाट डा. जीतेन्द्रनाथ चटर्जीलाई ल्याएर राम्रो र व्यवस्थित स्वास्थ्य सेवाको प्रबन्ध मिलाउनु भयो । वि.सं. २००७ सालको परिवर्तन पश्चात वि.स. २०१३ साल फाल्गुण ७ गते देखि यसको नाम त्रिभुवन स्मारक अस्पताल भयो।',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 21, 20, 20),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
