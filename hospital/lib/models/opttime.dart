class Autogenerated {
  ArrayOfPageContentSetupGetDt? arrayOfPAGESetupGetDt;

  Autogenerated({this.arrayOfPAGESetupGetDt});

  Autogenerated.fromJson(Map<String, dynamic> json) {
    arrayOfPAGESetupGetDt = json['ArrayOfPageContentSetupGet_dt'] != null
        ? new ArrayOfPageContentSetupGetDt.fromJson(
            json['ArrayOfPageContentSetupGet_dt'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.arrayOfPAGESetupGetDt != null) {
      data['ArrayOfRefererSetupGet_dt'] = this.arrayOfPAGESetupGetDt!.toJson();
    }
    return data;
  }
}

class ArrayOfPageContentSetupGetDt {
  List<Opttime>? refererSetupGetDt;

  ArrayOfPageContentSetupGetDt({this.refererSetupGetDt});

  ArrayOfPageContentSetupGetDt.fromJson(Map<String, dynamic> json) {
    if (json['RefererSetupGet_dt'] != null) {
      refererSetupGetDt = <Opttime>[];
      json['RefererSetupGet_dt'].forEach((v) {
        refererSetupGetDt!.add(new Opttime.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.refererSetupGetDt != null) {
      data['ArrayOfPageContentSetupGet_dt'] =
          this.refererSetupGetDt!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Opttime {
  int? sn;
  String? pageGroup;
  String? pageTitle;
  String? pageText;
  bool? published;

  Opttime(
      {this.sn, this.pageGroup, this.pageTitle, this.pageText, this.published});

  Opttime.fromJson(Map<String, dynamic> json) {
    sn = json['sn'];
    pageGroup = json['page_group'];
    pageTitle = json['page_title'];
    pageText = json['page_text'];
    published = json['published'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sn'] = this.sn;
    data['page_group'] = this.pageGroup;
    data['page_title'] = this.pageTitle;
    data['page_text'] = this.pageText;
    data['published'] = this.published;
    return data;
  }
}
