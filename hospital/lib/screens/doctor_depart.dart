import 'package:flutter/material.dart';
import 'package:hospital/screens/appointment_form_page.dart';
import 'package:hospital/services/doctor.service.dart';

import '../models/doctorslist.dart';

class DoctorDepart extends StatefulWidget {
  final String departmentDetail;

  // Add this field

  DoctorDepart({
    required this.departmentDetail,
  });

  @override
  State<DoctorDepart> createState() => _DoctorDepartState();
}

class _DoctorDepartState extends State<DoctorDepart> {
  late Future<List<RefererSetupGetDt>> doctorsFuture;
  List<RefererSetupGetDt> filteredSpecialities = [];
  String? searchQuery;
  final TextEditingController textsearch = TextEditingController();

  get doctors => null;

  @override
  void initState() {
    super.initState();
    refresh(null);
    //_departmentDetail;
  }

  void refresh(String? search) {
    setState(() {
      doctorsFuture = (search == null || search == "")
          ? DoctorServices.getDoctorsList(null)
          : DoctorServices.getDoctorsList(search);
    });
  }

  //filter by spid
  var spId;

  // @override
  // void initState() {
  //   super.initState();
  //   doctorsFuture = fetchDoctors(null);
  // }

  // Future<List<RefererSetupGetDt>> fetchDoctors(String? search) async {
  //   var url = 'https://bluecross.com.np/MediproWebApi/api/GetWebReferer';
  //   url = (search == null) ? url : url + '?search=' + search;

  //   final response = await http.get(Uri.parse(url));

  //   if (response.statusCode == 200) {
  //     final List<dynamic> responseData = json.decode(response.body);
  //     return responseData
  //         .map((data) => RefererSetupGetDt.fromJson(data))
  //         .toList();
  //   } else {
  //     throw Exception('Failed to load doctor');
  //   }
  // }
  List<RefererSetupGetDt> _filteredDocs = [];

  void filterSpecialities(String query) {
    setState(() {
      //searchQuery = "101";
      if (query.isNotEmpty) {
        _filteredDocs = doctors!.where((i) => i.spId == query).toList();

        // filteredSpecialities = _filteredDocs
        //     .where((speciality) => speciality.spId == searchQuery
        //          .contains(query.toLowerCase()
        //         )
        //     .toList();
        print("hello");
      } else {
        filteredSpecialities.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Doctors'),
          backgroundColor: Color.fromARGB(255, 116, 135, 255),
        ),
        body: Column(
          children: [
            Container(
              color: Colors.grey[300],
              padding: EdgeInsets.all(16),
              child: TextField(
                  controller: textsearch,
                  onChanged: (value) {
                    if (value.length != 0) {
                      refresh(value);
                    } else {}
                  },
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(color: Colors.grey, width: 0.0),
                    ),
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                    filled: true,
                    hintText: "Search for Doctors..",
                    hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
                    suffixIcon: IconButton(
                      onPressed: () {
                        filterSpecialities("109");
                        //print("hello1");
                        // showSearch(
                        //   context: context,
                        //   delegate: SearchDelegateWidget(filterSpecialities),
                        // );
                      },
                      icon: Icon(
                        Icons.search,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  )),
            ),
            // SizedBox(
            //   height: 5,
            // ),
            Expanded(
              child: FutureBuilder<List<RefererSetupGetDt>?>(
                future: doctorsFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasData &&
                      snapshot.connectionState == ConnectionState.done) {
                    var spid = widget.departmentDetail;
                    List<RefererSetupGetDt>? doctors = snapshot.data;
                    List<RefererSetupGetDt> _filteredDocs = [];
                    _filteredDocs = doctors!
                        .where((i) => i.spId == int.parse(spid))
                        .toList();
                    return ListView.builder(
                      // itemCount: searchQuery == null || searchQuery!.isEmpty
                      //     ? doctors!.length
                      //     : filteredSpecialities.length,
                      itemCount: _filteredDocs.length,
                      itemBuilder: (BuildContext context, int index) {
                        final doctor = _filteredDocs[index];
                        return DoctorWidget(doctor: doctors[index]);
                      },
                    );
                  } else {
                    return SizedBox(
                        child: Center(child: CircularProgressIndicator()));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DoctorWidget extends StatelessWidget {
  final RefererSetupGetDt doctor;

  DoctorWidget({required this.doctor});

  //get doctorName => null;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        //borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Doctor Image
          if (doctor.image != null)
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(doctor.image!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          SizedBox(width: 16), // Add some spacing between image and details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doctor.referer ?? '',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                // SizedBox(height: 8),
                // Text(
                //   'spid: ${doctor.spId ?? ''}',
                //   style: TextStyle(
                //       color: Colors.grey, fontWeight: FontWeight.w700),
                // ),
                // SizedBox(height: 8),
                // Text(
                //   'ref_id: ${doctor.refid ?? ''}',
                //   style: TextStyle(
                //       color: Colors.grey, fontWeight: FontWeight.w700),
                // ),
                // Text('sp_id: ${doctor.spId ?? ''}'),
                SizedBox(height: 8),
                Text(
                  'Detail: ${doctor.detail ?? ''}',
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 8),
                Text(
                  'Email: ${doctor.email ?? ''}',
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 8),
                Text(
                  'Qualification: ${doctor.qualification ?? ''}',
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.w700),
                ),
                // SizedBox(height: 8),
                // Text('Referring Physicians: ${doctor.referer ?? ''}'),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to the appointment form with the selected doctor
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DoctorAppointmentPage(
                          // doctorName: doctorName,
                          doctor: doctor.referer ?? '', referer: '',
                          detail: doctor.detail ?? '',
                          //refid: '', //doctorName: '',
                          // doctor: doctor,
                        ),
                      ),
                    );
                  },
                  child: Text('Make Appointment'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
