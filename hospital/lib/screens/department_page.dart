import 'package:flutter/material.dart';
import 'package:hospital/models/department.dart';
import 'package:hospital/screens/doctor_depart.dart';
import 'package:hospital/util/drawer.dart';
import '../services/specialities.service.dart';

class DepartmentPage extends StatefulWidget {
  final String username;
  const DepartmentPage({Key? key, required this.username}) : super(key: key);

  @override
  State<DepartmentPage> createState() => _DepartmentPageState();
}

class _DepartmentPageState extends State<DepartmentPage> {
  List<SpecialityDt> filteredSpecialities = [];
  String? searchQuery;
  final textsearch = TextEditingController();
  Future<List<filter_SpecialityDt>>? specialities;
  String selectedPage = 'Departments';

  @override
  void initState() {
    super.initState();
    refresh(null);
  }

  void refresh(String? search) {
    setState(() {
      specialities = (search == null || search == "")
          ? SpecialistiesServices.getCategories(null)
          : SpecialistiesServices.getCategories(search);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Select a department'),
          backgroundColor: Color.fromARGB(255, 116, 135, 255),
        ),
        drawer: AppDrawer(
          username: widget.username,
          selectedPage: 'Departments', // Replace with actual username
        ),
        backgroundColor: Colors.grey[300],
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SafeArea(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: TextField(
                    controller: textsearch,
                    onTap: () {},
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
                      alignLabelWithHint: true,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                      filled: true,
                      hintText: "Search for Medicine/Health Products..",
                      hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.search,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Expanded(
                  child: FutureBuilder<List<filter_SpecialityDt>?>(
                    future: specialities,
                    builder: (context, snapshot) {
                      if (snapshot.hasData &&
                          snapshot.connectionState == ConnectionState.done) {
                        List<filter_SpecialityDt>? specialitiesData =
                            snapshot.data;
                        return ListView.builder(
                          itemCount: searchQuery == null || searchQuery!.isEmpty
                              ? specialitiesData!.length
                              : filteredSpecialities.length,
                          itemBuilder: (BuildContext context, int index) {
                            final speciality = specialitiesData![index];
                            return GestureDetector(
                              onTap: () {
                                // Navigate to the DoctorDepartPage with the selected speciality
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DoctorDepart(
                                      departmentDetail:
                                          (speciality.sp_id.toString()) ??
                                              0.toString(), // Pass the detail
                                    ),
                                  ),
                                );
                              },
                              child: Card(
                                child: ListTile(
                                    leading: ClipOval(
                                      child: Image.asset(
                                        speciality.image!,
                                        width: 35,
                                        height: 35,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    title: Text(
                                        searchQuery == null ||
                                                searchQuery!.isEmpty
                                            ? speciality.detail ?? ''
                                            : filteredSpecialities[index]
                                                    .detail ??
                                                '',
                                        style: TextStyle(
                                          fontSize: 16,
                                        )),
                                    trailing: Icon(Icons.keyboard_arrow_right)),
                              ),
                            );
                          },
                        );
                      } else {
                        return SizedBox(
                            child: Center(child: CircularProgressIndicator()));
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SearchDelegateWidget extends SearchDelegate<String> {
  final Function(String) onSearch;

  SearchDelegateWidget(this.onSearch);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
          onSearch('');
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text('Search Results'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text('Type to search'),
    );
  }
}
