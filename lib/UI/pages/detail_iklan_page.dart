import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:salv/UI/pages/form_jual_limbah_page.dart';
import 'package:salv/UI/widgets/buttons.dart';
import 'package:salv/blocs/iklan/iklan_bloc.dart';
import 'package:salv/common/common.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../blocs/auth/auth_bloc.dart';
import '../../models/jual_limbah_form_model.dart';
import '../../models/user_model.dart';
import '../../shared/shared_methods.dart';
import 'holder_page.dart';

class DetailIklanPage extends StatefulWidget {
  final String? advertisementId;
  final dynamic? iklanProgress;
  final dynamic maxProgress;
  DetailIklanPage(
      {super.key, this.advertisementId, this.iklanProgress, this.maxProgress});
  static const routeName = '/detailiklan';

  @override
  State<DetailIklanPage> createState() => _DetailIklanPageState();
}

class _DetailIklanPageState extends State<DetailIklanPage> {
  @override
  dynamic userId;
  dynamic userType;
  JualLimbahForm? jualLimbahForm;

  void initState() {
    // TODO: implement initState

    super.initState();
    final authState = context.read<AuthBloc>().state;

    if (authState is AuthSuccess) {
      userType = authState.user!.type;
      userId = authState.user!.id;
    }
  }


void _launchMapsUrl(double lat, double lon) async {
  final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lon';
  if (await canLaunchUrlString(url)) {
    await launchUrlString(url);
  } else {
    throw 'Could not launch $url';
  }
}


  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Detail Iklan")),
        body: userType == "buyer"
            ? BlocProvider(
                create: (context) => IklanBloc()
                  ..add(IklanGetDetailBuyer(widget.advertisementId)),
                child: BlocConsumer<IklanBloc, IklanState>(
                  listener: (context, state) {
                    // TODO: implement listener
                    if (state is IklanFailed) {
                      showCustomSnacKbar(context, state.e);
                    }
                  },
                  builder: (context, state) {
                    if (state is IklanBuyerGetDetailSuccess) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 36, vertical: 14),
                        child: Container(
                          child: CustomScrollView(
                            slivers: [
                              SliverFillRemaining(
                                hasScrollBody: false,
                                child: Column(children: [
                                  //Only for Mahasiswa

                                  // if pabrik
                                  Flexible(
                                      flex: userType == "buyer" ? 2 : 4,
                                      child: Container(
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 17,
                                                        vertical: 16),
                                                decoration: BoxDecoration(
                                                  color: whiteColor,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.5),
                                                      blurRadius: 5.0,
                                                      offset: Offset(0,
                                                          3), // changes the position of the shadow
                                                    ),
                                                  ],
                                                ),
                                                child: Column(children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Flexible(
                                                          child: Wrap(
                                                        children: [
                                                          Text(
                                                            state
                                                                .iklanBuyerDetail!
                                                                .data
                                                                .title,
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: blackTextStyle
                                                                .copyWith(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                          )
                                                        ],
                                                      ))
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 12,
                                                  ),
                                                  Divider(
                                                    color: greyColor,
                                                  ),
                                                  const SizedBox(
                                                    height: 12,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Kategori",
                                                        style: blackTextStyle,
                                                      ),
                                                      Text(
                                                        state.iklanBuyerDetail!
                                                            .data.category,
                                                        style: blackTextStyle
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                      )
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 12,
                                                  ),
                                                  Divider(
                                                    color: greyColor,
                                                  ),
                                                  const SizedBox(
                                                    height: 12,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Ketersediaan Sistem",
                                                        style: blackTextStyle,
                                                      ),
                                                      Flexible(
                                                          child: Container(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Text(
                                                              state.iklanBuyerDetail!.data
                                                                          .retrievalSystem
                                                                          .toString() ==
                                                                      0
                                                                  ? "Diantar pemilik Limbah"
                                                                  : "Diambil di pemilik limbah",
                                                              textAlign:
                                                                  TextAlign
                                                                      .right,
                                                              style: blackTextStyle
                                                                  .copyWith(
                                                                      fontWeight:
                                                                          semiBold),
                                                            )
                                                          ],
                                                        ),
                                                      ))
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 12,
                                                  ),
                                                  Divider(
                                                    color: greyColor,
                                                  ),
                                                  const SizedBox(
                                                    height: 12,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Lokasi Tujuan",
                                                        style: blackTextStyle,
                                                      ),
                                                      Text(
                                                        state.iklanBuyerDetail!
                                                            .data.location,
                                                        style: blackTextStyle
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                      )
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 12,
                                                  ),
                                                  Divider(
                                                    color: greyColor,
                                                  ),
                                                  const SizedBox(
                                                    height: 12,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Spesifikasi",
                                                        style: blackTextStyle,
                                                      ),
                                                      Text(
                                                        state
                                                            .iklanBuyerDetail!
                                                            .data
                                                            .additionalInformation,
                                                        style: blackTextStyle
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                      )
                                                    ],
                                                  ),
                                                ]),
                                              ),
                                              const SizedBox(
                                                height: 14,
                                              ),
                                              Text(
                                                "Ketentuan",
                                                style: blackTextStyle.copyWith(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 20),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Container(
                                                width: double.infinity,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 17,
                                                        vertical: 16),
                                                decoration: BoxDecoration(
                                                    color: whiteColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                child: Column(children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Berat Minimum",
                                                        style: blackTextStyle,
                                                      ),
                                                      Text(
                                                        "${state.iklanBuyerDetail!.data.minimumWeight.toString()} kg",
                                                        style: blackTextStyle
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                      )
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 12,
                                                  ),
                                                  Divider(
                                                    color: greyColor,
                                                  ),
                                                  const SizedBox(
                                                    height: 12,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Berat Maksimum",
                                                        style: blackTextStyle,
                                                      ),
                                                      Text(
                                                        "${state.iklanBuyerDetail!.data.maximumWeight.toString()} kg",
                                                        style: blackTextStyle
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                      )
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 12,
                                                  ),
                                                  Divider(
                                                    color: greyColor,
                                                  ),
                                                  const SizedBox(
                                                    height: 12,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Pengeluaran",
                                                        style: blackTextStyle,
                                                      ),
                                                      Text(
                                                        "${state.iklanBuyerDetail!.data.price.toString()},- / Kilogram",
                                                        style: blackTextStyle
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                      )
                                                    ],
                                                  ),
                                                ]),
                                              ),
                                              const SizedBox(
                                                height: 50,
                                              ),
                                              if (widget.advertisementId !=
                                                  "") ...[
                                                Container(
                                                  width: double.infinity,
                                                  height: 160,
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 12),
                                                  decoration: BoxDecoration(
                                                      color: whiteColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  child: Column(children: [
                                                    const SizedBox(
                                                      height: 15,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Tidak ada Batas Kadaluarsa",
                                                          style: blackTextStyle
                                                              .copyWith(
                                                                  fontWeight:
                                                                      semiBold,
                                                                  fontSize: 12),
                                                        )
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 12,
                                                    ),
                                                    Flexible(
                                                        child: Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              left: 9),
                                                      child:
                                                          LinearPercentIndicator(
                                                        trailing: Text(
                                                          "${state.iklanBuyerDetail!.data.maximumWeight.toString()} Kg",
                                                          style: blackTextStyle
                                                              .copyWith(
                                                                  fontWeight:
                                                                      semiBold,
                                                                  fontSize: 15),
                                                        ),
                                                        lineHeight: 11,
                                                        percent: widget
                                                            .iklanProgress,
                                                        animation: true,
                                                        progressColor:
                                                            Colors.yellow,
                                                        backgroundColor:
                                                            greyColor,
                                                        barRadius:
                                                            Radius.circular(8),
                                                      ),
                                                    )),
                                                    const SizedBox(
                                                      height: 12,
                                                    ),
                                                    if (state.iklanBuyerDetail!
                                                            .data.status ==
                                                        "ongoing") ...[
                                                      BlocProvider(
                                                        create: (context) =>
                                                            IklanBloc(),
                                                        child: BlocConsumer<
                                                            IklanBloc,
                                                            IklanState>(
                                                          listener:
                                                              (context, state) {
                                                            // TODO: implement listener
                                                            if (state
                                                                is IklanFailed) {
                                                              showCustomSnacKbar(
                                                                  context,
                                                                  state.e);
                                                            }
                                                            if (state
                                                                is IklanCancelBuyerSuccess) {
                                                              Navigator.pushNamedAndRemoveUntil(
                                                                  context,
                                                                  HolderPage
                                                                      .routeName,
                                                                  (route) =>
                                                                      false);
                                                            }
                                                          },
                                                          builder:
                                                              (context, state) {
                                                            return ElevatedButton(
                                                                style: ElevatedButton.styleFrom(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .red
                                                                            .shade900),
                                                                onPressed: () {
                                                                  context
                                                                      .read<
                                                                          IklanBloc>()
                                                                      .add(IklanCancelBuyer(
                                                                          widget
                                                                              .advertisementId));
                                                                },
                                                                child: Text(
                                                                  "Batalkan Iklan",
                                                                ));
                                                          },
                                                        ),
                                                      ),
                                                    ] else ...[
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(12),
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8)),
                                                        child: Text(
                                                          "Iklan diNon-Aktifkan.",
                                                          style:
                                                              redTextStyle.copyWith(
                                                                  fontWeight:
                                                                      semiBold,
                                                                  fontSize: 12),
                                                        ),
                                                      )
                                                    ],
                                                    Expanded(
                                                        child: Container(
                                                      child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Text(
                                                              "Dibuat: 11 Februari 2021",
                                                              style: blackTextStyle
                                                                  .copyWith(
                                                                      fontWeight:
                                                                          medium,
                                                                      fontSize:
                                                                          9),
                                                            )
                                                          ]),
                                                    ))
                                                  ]),
                                                )
                                              ]
                                            ]),
                                      )),
                                ]),
                              )
                            ],
                          ),
                        ),
                      );
                    }
                    return Container();
                  },
                ),
              )
            : BlocProvider(
                create: (context) => IklanBloc()
                  ..add(IklanGetDetailSeller(widget.advertisementId)),
                child: BlocConsumer<IklanBloc, IklanState>(
                  listener: (context, state) {
                    if (state is IklanFailed) {
                      showCustomSnacKbar(context, state.e);
                    }
                  },
                  builder: (context, state) {
                    if (state is IklanSellerGetDetailSuccess) {
                      
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 36, vertical: 14),
                        child: Container(
                          child: CustomScrollView(
                            slivers: [
                              SliverFillRemaining(
                                hasScrollBody: false,
                                child: Column(children: [
                                  //Only for Mahasiswa

                                  Flexible(
                                      child: Container(
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "${state.iklanSellerDetail!.data.ongoingWeight.toString()} / ${widget.maxProgress}",
                                              style: blueTextStyle.copyWith(
                                                  fontSize: 48,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              "Kg",
                                              style: blueTextStyle.copyWith(
                                                  fontSize: 16),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Iklan dibuat pada 14/04/23",
                                              style: blueTextStyle.copyWith(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 29,
                                        ),
                                        Flexible(
                                            child: Container(
                                          margin:
                                              const EdgeInsets.only(left: 9),
                                          child: LinearPercentIndicator(
                                            lineHeight: 27,
                                            percent: widget.iklanProgress,
                                            animation: true,
                                            progressColor: greenColor,
                                            backgroundColor: Colors.grey[350],
                                            barRadius: Radius.circular(8),
                                          ),
                                        )),
                                        const SizedBox(
                                          height: 6,
                                        ),
                                        Flexible(
                                            child: Container(
                                          padding: const EdgeInsets.only(
                                              right: 20, left: 21),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "0 Kg",
                                                style: blueTextStyle.copyWith(
                                                    fontSize: 16),
                                              ),
                                              Text(
                                                "${widget.maxProgress}Kg",
                                                style: blueTextStyle.copyWith(
                                                    fontSize: 16),
                                              )
                                            ],
                                          ),
                                        )),
                                        const SizedBox(height: 20),
                                        CustomFilledButton(
                                          width: 200,
                                          title: "Buat Penawaran",
                                          onPressed: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                              builder: (context) {
                                                return FormJualLimbahPage(
                                                  adsId: widget.advertisementId,
                                                  userId: userId,
                                                );
                                              },
                                            ));
                                          },
                                        ),
                                      ],
                                    ),
                                  )),

                                  // if pabrik
                                  Expanded(
                                      flex: 2,
                                      child: Container(
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 17,
                                                        vertical: 16),
                                                decoration: BoxDecoration(
                                                    color: whiteColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                child: Column(children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Flexible(
                                                          child:
                                                              Wrap(children: [
                                                        Text(
                                                          state
                                                              .iklanSellerDetail!
                                                              .data
                                                              .title,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: blackTextStyle
                                                              .copyWith(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                        )
                                                      ]))
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 12,
                                                  ),
                                                  Divider(
                                                    color: greyColor,
                                                  ),
                                                  const SizedBox(
                                                    height: 12,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Kategori",
                                                        style: blackTextStyle,
                                                      ),
                                                      Text(
                                                        state.iklanSellerDetail!
                                                            .data.category,
                                                        style: blackTextStyle
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                      )
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 12,
                                                  ),
                                                  Divider(
                                                    color: greyColor,
                                                  ),
                                                  const SizedBox(
                                                    height: 12,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Ketersediaan Sistem",
                                                        style: blackTextStyle,
                                                      ),
                                                      Flexible(
                                                          child: Column(
                                                        children: [
                                                          Text(
                                                            state.iklanSellerDetail!.data
                                                                        .retrievalSystem
                                                                        .toString() ==
                                                                    0
                                                                ? "Diantar pemilik Limbah"
                                                                : "Diambil di pemilik limbah",
                                                            style: blackTextStyle
                                                                .copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                            textAlign:
                                                                TextAlign.end,
                                                            overflow:
                                                                TextOverflow
                                                                    .visible,
                                                          ),
                                                        ],
                                                      ))
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 12,
                                                  ),
                                                  Divider(
                                                    color: greyColor,
                                                  ),
                                                  const SizedBox(
                                                    height: 12,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Lokasi Tujuan",
                                                        style: blackTextStyle,
                                                      ),
                                                      Text(
                                                        state.iklanSellerDetail!
                                                            .data.location,
                                                        style: blackTextStyle
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                      )
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 12,
                                                  ),
                                                  Divider(
                                                    color: greyColor,
                                                  ),
                                                  const SizedBox(
                                                    height: 12,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Spesifikasi",
                                                        style: blackTextStyle,
                                                      ),
                                                      Text(
                                                        state.iklanSellerDetail!.data
                                                                    .additionalInformation !=
                                                                ""
                                                            ? state
                                                                .iklanSellerDetail!
                                                                .data
                                                                .additionalInformation
                                                            : "-",
                                                        style: blackTextStyle
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                      )
                                                    ],
                                                  ),
                                                  //location
                                                  const SizedBox(
                                                    height: 12,
                                                  ),
                                                  Divider(
                                                    color: greyColor,
                                                  ),
                                                  const SizedBox(
                                                    height: 12,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Detail Lokasi",
                                                        style: blackTextStyle,
                                                      ),

                                                      ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            primary:
                                                                greenColor, // Set the button's background color
                                                            onPrimary: Colors
                                                                .white, // Set the button's text color
                                                          ),
                                                          onPressed: () {
                                                            print(state
                                                                .iklanSellerDetail!
                                                                .data
                                                                .latitude);
                                                                print(state.iklanSellerDetail!.data.longitude);
                                                            _launchMapsUrl(
                                                                state
                                                                    .iklanSellerDetail!
                                                                    .data
                                                                    .latitude
                                                                    ,
                                                                state
                                                                    .iklanSellerDetail!
                                                                    .data
                                                                    .longitude
                                                                    );
                                                          },
                                                          child: Row(
                                                            children: [
                                                              Icon(Icons
                                                                  .location_on),
                                                              Text(
                                                                  "Lihat lokasi")
                                                            ],
                                                          ))
                                                      // Text(
                                                      //   state.iklanSellerDetail!.data
                                                      //               .additionalInformation !=
                                                      //           ""
                                                      //       ? state
                                                      //           .iklanSellerDetail!
                                                      //           .data
                                                      //           .latitude.toString()
                                                      //       : "-",
                                                      //   style: blackTextStyle
                                                      //       .copyWith(
                                                      //           fontWeight:
                                                      //               FontWeight
                                                      //                   .w600),
                                                      // )
                                                    ],
                                                  ),
                                                ]),
                                              ),
                                              const SizedBox(
                                                height: 14,
                                              ),
                                              Text(
                                                "Ketentuan",
                                                style: blackTextStyle.copyWith(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 20),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Container(
                                                width: double.infinity,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 17,
                                                        vertical: 16),
                                                decoration: BoxDecoration(
                                                    color: whiteColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                child: Column(children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Berat Minimum",
                                                        style: blackTextStyle,
                                                      ),
                                                      Text(
                                                        "${state.iklanSellerDetail!.data.minimumWeight.toString()} kg",
                                                        style: blackTextStyle
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                      )
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 12,
                                                  ),
                                                  Divider(
                                                    color: greyColor,
                                                  ),
                                                  const SizedBox(
                                                    height: 12,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Berat Maksimum",
                                                        style: blackTextStyle,
                                                      ),
                                                      Text(
                                                        "${state.iklanSellerDetail!.data.maximumWeight.toString()} kg",
                                                        style: blackTextStyle
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                      )
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 12,
                                                  ),
                                                  Divider(
                                                    color: greyColor,
                                                  ),
                                                  const SizedBox(
                                                    height: 12,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Pengeluaran",
                                                        style: blackTextStyle,
                                                      ),
                                                      Text(
                                                        "+Rp.${state.iklanSellerDetail!.data.price},- / Kilogram",
                                                        style: blackTextStyle
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                      )
                                                    ],
                                                  ),
                                                ]),
                                              ),
                                            ]),
                                      )),

                                  const SizedBox(
                                    height: 23,
                                  ),

                                  if (userType == "buyer") ...[
                                    Expanded(
                                        child: Container(
                                      child: Column(children: [
                                        Flexible(
                                            child: Container(
                                                child: Column(
                                          children: [
                                            SvgPicture.asset(
                                                "assets/image/image_details_iklan_pabrik.svg"),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text("Berlangsung"),
                                                Text("Selesai"),
                                                Text("Dibatalkan")
                                              ],
                                            )
                                          ],
                                        ))),
                                        Expanded(
                                            flex: 2,
                                            child: Column(
                                              children: [
                                                Expanded(
                                                    child: Container(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 12),
                                                  decoration: BoxDecoration(
                                                      color: whiteColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  child: Column(children: [
                                                    const SizedBox(
                                                      height: 15,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Tidak ada Batas Kadaluarsa",
                                                          style: blackTextStyle
                                                              .copyWith(
                                                                  fontWeight:
                                                                      semiBold,
                                                                  fontSize: 12),
                                                        )
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 12,
                                                    ),
                                                    Flexible(
                                                        child: Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              left: 9),
                                                      child:
                                                          LinearPercentIndicator(
                                                        trailing: Text(
                                                          "Kg",
                                                          style: blackTextStyle
                                                              .copyWith(
                                                                  fontWeight:
                                                                      semiBold,
                                                                  fontSize: 15),
                                                        ),
                                                        lineHeight: 11,
                                                        percent: widget
                                                            .iklanProgress,
                                                        animation: true,
                                                        progressColor:
                                                            blueColor,
                                                        backgroundColor:
                                                            greyColor,
                                                        barRadius:
                                                            Radius.circular(8),
                                                      ),
                                                    )),
                                                    const SizedBox(
                                                      height: 12,
                                                    ),
                                                    ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                backgroundColor:
                                                                    Colors.red
                                                                        .shade900),
                                                        onPressed: () {},
                                                        child: Text(
                                                          "Batalkan Iklan",
                                                        )),
                                                    Expanded(
                                                        child: Container(
                                                      child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Text(
                                                              "Dibuat: 11 Februari 2021",
                                                              style: blackTextStyle
                                                                  .copyWith(
                                                                      fontWeight:
                                                                          medium,
                                                                      fontSize:
                                                                          9),
                                                            )
                                                          ]),
                                                    ))
                                                  ]),
                                                ))
                                              ],
                                            )),
                                      ]),
                                    )),
                                  ]
                                ]),
                              )
                            ],
                          ),
                        ),
                      );
                    }
                    return Container();
                  },
                ),
              ));
  }
}
