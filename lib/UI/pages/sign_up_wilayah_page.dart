import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:salv/UI/pages/sign_up_wilayah_2_page.dart';
import 'package:salv/models/provinces_model.dart';
import 'package:salv/models/sign_up_form_model.dart';
import 'package:salv/models/subdistricts_model.dart';
import 'package:salv/services/region_service.dart';

import '../../common/common.dart';
import '../../models/city_model.dart';
import '../../shared/shared_methods.dart';
import '../widgets/buttons.dart';
import '../widgets/forms.dart';

class SignupWilayahPage extends StatefulWidget {
  final SignupFormModel? data;
  static const routeName = '/singupwilayah';
  const SignupWilayahPage({super.key, required this.data});

  @override
  State<SignupWilayahPage> createState() => _SignupWilayahPageState();
}

class _SignupWilayahPageState extends State<SignupWilayahPage> {
  dynamic provinceValuess;
  dynamic provinceGetId;
  dynamic selectedProvince;

  dynamic cityValue;
  dynamic cityGetId;
  dynamic selectedCity;

  dynamic subdistrictValue;
  dynamic subdistrictGetId;
  dynamic selectedSubdistrict;

  late Future<Provinsi> provinceList;
  late Future<Kota> cityList;
  late Future<Kecamatan> kecamatanList;
  bool? isloading = false;
  //Location
  // Location location = new Location();
  // bool? serviceEnabled;
  // LocationData? currentPosition;

  //Geolocator
  Position? currentPositions;
  String? _currentAddress;
  Position? _currentPosition;

  // Future<dynamic> getLocation() async {
  //   var permissionStatus = await Permission.location.status;
  //   serviceEnabled = await location.serviceEnabled();
  //   if (serviceEnabled!) serviceEnabled = await location.requestService();
  //   print("hasil : $permissionStatus");
  //   if (permissionStatus.isDenied ||
  //       permissionStatus.isPermanentlyDenied ||
  //       permissionStatus.isRestricted) {
  //     print("denied");

  //     await openAppSettings();
  //   } else {
  //     currentPosition = await location.getLocation();
  //   }

  //   return currentPosition;
  // }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<Kota> getCities(dynamic provId) async {
    dynamic listCity;
    await RegionService().getCity(int.parse(provId)).then((value) {
      setState(() {
        listCity = value;
      });
    });
    return listCity;
  }

  Future<Kecamatan> getSubDistricts(dynamic cityId) async {
    dynamic listSubdistricts;
    await RegionService().getSubDistrict(int.parse(cityId)).then((value) {
      setState(() {
        listSubdistricts = value;
      });
    });
    return listSubdistricts;
  }

  bool validate() {
    if (selectedProvince == null ||
        selectedCity == null ||
        selectedSubdistrict == null || _currentPosition == null) {
      return false;
    }
    return true;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    provinceList = RegionService().getProvinces();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 44, horizontal: 37),
        child: Container(
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(children: [Image.asset('assets/image/logo-png.png')]),
                  const SizedBox(
                    height: 53,
                  ),
                  Row(
                    children: [
                      Text(
                        "Masukkan Data \nWilayah Anda",
                        style: blackTextStyle.copyWith(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 23,
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 23, horizontal: 19),
                    decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(8)),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Provinsi",
                            style: blackTextStyle.copyWith(
                                fontWeight: FontWeight.w600, fontSize: 14),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Container(
                            child: FutureBuilder(
                              future: provinceList,
                              builder:
                                  ((context, AsyncSnapshot<Provinsi> snapshot) {
                                var state = snapshot.connectionState;
                                if (state != ConnectionState.done) {
                                  return DropdownButtonFormField(
                                    hint: Text("Tunggu Sebentar.."),
                                    decoration: InputDecoration(
                                        focusColor: greenColor,
                                        contentPadding:
                                            const EdgeInsets.all(12),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8))),
                                    items: [],
                                    onChanged: (value) {},
                                  );
                                } else {
                                  if (snapshot.hasData) {
                                    return DropdownButtonFormField(
                                      hint: selectedProvince == null
                                          ? Text("Pilih Provinsi")
                                          : Text(selectedProvince.toString()),
                                      value: selectedProvince,
                                      isExpanded: true,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedProvince = value;
                                          selectedProvince.toString();
                                          provinceGetId = selectedProvince.id;
                                          selectedCity = null;
                                          cityValue = getCities(provinceGetId);
                                        });
                                      },
                                      decoration: InputDecoration(
                                          focusColor: greenColor,
                                          contentPadding:
                                              const EdgeInsets.all(12),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8))),
                                      items: snapshot.data!.provinsiValue
                                          .map((val) {
                                        return DropdownMenuItem(
                                          value: val,
                                          child: Text(
                                            val.name,
                                          ),
                                        );
                                      }).toList(),
                                    );
                                  } else if (snapshot.hasError) {
                                    return DropdownButtonFormField(
                                      hint: Text("No Internet"),
                                      decoration: InputDecoration(
                                          focusColor: greenColor,
                                          contentPadding:
                                              const EdgeInsets.all(12),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8))),
                                      items: [],
                                      onChanged: (value) {},
                                    );
                                  } else {
                                    return const Material(
                                      child: Text(""),
                                    );
                                  }
                                }
                              }),
                            ),
                          ),
                          const SizedBox(
                            height: 17,
                          ),
                          Text(
                            "Kota",
                            style: blackTextStyle.copyWith(
                                fontWeight: FontWeight.w600, fontSize: 14),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Container(
                              child: selectedProvince != null
                                  ? FutureBuilder<Kota>(
                                      future: cityValue,
                                      builder: ((context, snapshot) {
                                        if (snapshot.connectionState !=
                                            ConnectionState.done) {
                                          return DropdownButtonFormField(
                                            hint: Text("Tunggu Sebentar.."),
                                            decoration: InputDecoration(
                                                focusColor: greenColor,
                                                contentPadding:
                                                    const EdgeInsets.all(12),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8))),
                                            items: [],
                                            onChanged: (value) {},
                                          );
                                        } else if (snapshot.hasData) {
                                          return DropdownButtonFormField(
                                              decoration: InputDecoration(
                                                  focusColor: greenColor,
                                                  contentPadding:
                                                      const EdgeInsets.all(12),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8))),
                                              hint: selectedCity == null
                                                  ? Text("Pilih Kota")
                                                  : Text(
                                                      "${selectedCity.name}"),
                                              isExpanded: true,
                                              icon: Icon(Icons.arrow_drop_down),
                                              value: selectedCity,
                                              iconSize: 30,
                                              elevation: 16,
                                              items: snapshot.data!.value.map<
                                                      DropdownMenuItem<
                                                          KotaValue>>(
                                                  (KotaValue value) {
                                                return DropdownMenuItem(
                                                    value: value,
                                                    child: Text(value.name!
                                                        .toString()));
                                              }).toList(),
                                              onChanged: (value) {
                                                setState(() {
                                                  // cityData = getCities(provId);
                                                  selectedCity = value;
                                                  selectedCity.toString();
                                                  cityGetId = selectedCity.id;
                                                  subdistrictValue =
                                                      getSubDistricts(
                                                          cityGetId);
                                                  selectedSubdistrict = null;
                                                });
                                              });
                                        } else if (snapshot.hasError) {
                                          return DropdownButtonFormField(
                                            hint: Text("No Internet"),
                                            decoration: InputDecoration(
                                                focusColor: greenColor,
                                                contentPadding:
                                                    const EdgeInsets.all(12),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8))),
                                            items: [],
                                            onChanged: (value) {},
                                          );
                                        }

                                        return CircularProgressIndicator();
                                      }))
                                  : DropdownButtonFormField(
                                      hint: Text("Pilih Kota"),
                                      decoration: InputDecoration(
                                          focusColor: greenColor,
                                          contentPadding:
                                              const EdgeInsets.all(12),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8))),
                                      items: [],
                                      onChanged: (value) {},
                                    )),
                          const SizedBox(
                            height: 17,
                          ),
                          Text(
                            "Kecamatan",
                            style: blackTextStyle.copyWith(
                                fontWeight: FontWeight.w600, fontSize: 14),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Container(
                              child: selectedCity != null
                                  ? FutureBuilder<Kecamatan>(
                                      future: subdistrictValue,
                                      builder: ((context, snapshot) {
                                        if (snapshot.connectionState !=
                                            ConnectionState.done) {
                                          return DropdownButtonFormField(
                                            hint: Text("Tunggu Sebentar.."),
                                            decoration: InputDecoration(
                                                focusColor: greenColor,
                                                contentPadding:
                                                    const EdgeInsets.all(12),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8))),
                                            items: [],
                                            onChanged: (value) {},
                                          );
                                        } else if (snapshot.hasData) {
                                          return DropdownButtonFormField(
                                              decoration: InputDecoration(
                                                  focusColor: greenColor,
                                                  contentPadding:
                                                      const EdgeInsets.all(12),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8))),
                                              hint: selectedSubdistrict == null
                                                  ? Text("Pilih Kecamatan")
                                                  : Text(
                                                      "${selectedSubdistrict}"),
                                              isExpanded: true,
                                              icon: Icon(Icons.arrow_drop_down),
                                              value: selectedSubdistrict,
                                              iconSize: 30,
                                              elevation: 16,
                                              items: snapshot.data!.value.map<
                                                      DropdownMenuItem<
                                                          KecamatanValue>>(
                                                  (KecamatanValue value) {
                                                return DropdownMenuItem(
                                                    value: value,
                                                    child: Text(
                                                        value.name.toString()));
                                              }).toList(),
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedSubdistrict = value;
                                                  selectedSubdistrict
                                                      .toString();
                                                });
                                              });
                                        } else if (snapshot.hasError) {
                                          return DropdownButtonFormField(
                                            hint: Text("No Internet"),
                                            decoration: InputDecoration(
                                                focusColor: greenColor,
                                                contentPadding:
                                                    const EdgeInsets.all(12),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8))),
                                            items: [],
                                            onChanged: (value) {},
                                          );
                                        }

                                        return CircularProgressIndicator();
                                      }))
                                  : DropdownButtonFormField(
                                      hint: Text("Pilih Kecamatan"),
                                      decoration: InputDecoration(
                                          focusColor: greenColor,
                                          contentPadding:
                                              const EdgeInsets.all(12),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8))),
                                      items: [],
                                      onChanged: (value) {},
                                    )),
                          if (widget.data!.type == "buyer") ...[
                            const SizedBox(
                              height: 17,
                            ),
                            Text(
                              "Ambil Lokasi Anda",
                              style: blackTextStyle.copyWith(
                                  fontWeight: FontWeight.w600, fontSize: 14),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 60,
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStatePropertyAll<Color>(
                                              whiteColor),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ))),
                                  onPressed: () async {
                                    //Location
                                    // await getLocation().then((value) {
                                    //   print(value);
                                    // });
                                    setState(() {
                                      isloading = true;
                                    });
                                    await _getCurrentPosition();
                                    
                                    setState(() {
                                      isloading = false;
                                    });
                                    print(_currentPosition!.latitude.toString());
                                    print(_currentPosition!.longitude.toString());
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Row(children: [
                                          Icon(
                                            Icons.location_on_outlined,
                                            color: Colors.black45,
                                          ),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          Flexible(
                                            child: Text(
                                              (_currentPosition == null &&
                                                      isloading == false)
                                                  ? "Ketuk untuk mengambil lokasi anda"
                                                  : (_currentPosition != null &&
                                                          isloading == false)
                                                      ? _currentAddress
                                                          .toString()
                                                      : (isloading == true)
                                                          ? "Mengambil.."
                                                          : "",
                                              style: greyTextStyle.copyWith(
                                                  fontWeight: medium,
                                                  fontSize: 14),
                                            ),
                                          )
                                        ]),
                                      ),
                                    ],
                                  )),
                            ),
                          ],
                          const SizedBox(
                            height: 35,
                          ),
                          CustomFilledButton(
                            title: "Selanjutnya",
                            onPressed: () {
                              if (validate()) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SignupWilayah2Page(
                                          data: widget.data!.copyWith(
                                            latitude: _currentPosition == null ? 0 : _currentPosition?.latitude,
                                            longitude: _currentPosition == null ? 0: _currentPosition?.longitude,
                                              province: selectedProvince.name
                                                  .toString(),
                                              city:
                                                  selectedCity.name.toString(),
                                              KecamatanId: selectedSubdistrict
                                                  .id
                                                  .toString(),
                                              subdistrict: selectedSubdistrict
                                                  .name
                                                  .toString())),
                                    ));
                                //
                              } else {
                                showCustomSnacKbar(
                                    context, "Form tidak boleh kosong");
                              }
                            },
                          ),
                          const SizedBox(
                            height: 17,
                          )
                        ]),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
