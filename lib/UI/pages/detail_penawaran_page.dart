import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:salv/UI/pages/holder_page.dart';
import 'package:salv/UI/widgets/buttons.dart';
import 'package:salv/blocs/auth/auth_bloc.dart';
import 'package:salv/blocs/transaksi/transaksi_bloc.dart';
import 'package:salv/common/common.dart';
import 'package:salv/models/aksi_transaksi_seller_model.dart';
import 'package:salv/models/user_model.dart';

class DetailPenawaranPage extends StatefulWidget {
  final String? transactionId;
  final int? statusPenawaran;
  static const routeName = '/detailpenawaran';
  const DetailPenawaranPage(
      {super.key, this.transactionId, this.statusPenawaran});

  @override
  State<DetailPenawaranPage> createState() => _DetailPenawaranPageState();
}

class _DetailPenawaranPageState extends State<DetailPenawaranPage> {
  int status = 0;
  dynamic userId;
  dynamic userType;
  @override
  void initState() {
    super.initState();

    final authState = context.read<AuthBloc>().state;

    if (authState is AuthSuccess) {
      userType = authState.user!.type;
      userId = authState.user!.id;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detail Penawaran")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 17),
        child: Container(
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(children: [
                  Flexible(
                      child: Container(
                    child: Column(
                      children: [
                        Flexible(
                            child: Container(
                          child: Row(children: [
                            Expanded(
                                flex: 2,
                                child: Container(
                                  child: Column(children: [
                                    Flexible(
                                        child: Container(
                                      child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text("Sisa Limbah yang Dibutuhkan")
                                          ]),
                                    )),
                                    if (userType == "buyer") ...[
                                      BlocProvider(
                                        create: (context) => TransaksiBloc()
                                          ..add(TransaksiGetDetailBuyer(
                                              widget.transactionId)),
                                        child: BlocBuilder<TransaksiBloc,
                                            TransaksiState>(
                                          builder: (context, state) {
                                            if (state
                                                is DetailTransaksiLoading) {
                                              return Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 40),
                                                  child: Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                            color: whiteColor),
                                                  ));
                                            }
                                            if (state
                                                is DetailTransaksiBuyerGetSuccess) {
                                              var detailTransaksi = state
                                                  .detailTransaksiBuyer!.data;
                                              return Expanded(
                                                  flex: 2,
                                                  child: Container(
                                                    child: Row(children: [
                                                      Flexible(
                                                        child: Text(
                                                          detailTransaksi.weight
                                                              .toString(),
                                                          style: blueTextStyle
                                                              .copyWith(
                                                                  fontSize: 48,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                        ),
                                                      ),
                                                      Expanded(
                                                          child: Container(
                                                        child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              Container(
                                                                margin:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        bottom:
                                                                            12),
                                                                child: Row(
                                                                  children: [
                                                                    Text(
                                                                        "dari"),
                                                                    const SizedBox(
                                                                      width: 2,
                                                                    ),
                                                                    Text(
                                                                      detailTransaksi
                                                                          .maximumWeight
                                                                          .toString(),
                                                                      style: blueTextStyle.copyWith(
                                                                          fontSize:
                                                                              16,
                                                                          fontWeight:
                                                                              FontWeight.w700),
                                                                    )
                                                                  ],
                                                                ),
                                                              )
                                                            ]),
                                                      ))
                                                    ]),
                                                  ));
                                            }
                                            if (state
                                                is DetailTransaksiBuyerFailed) {
                                              return Center(
                                                child: Text(
                                                  "Terjadi Kesalahan :(",
                                                  style:
                                                      blackTextStyle.copyWith(
                                                          fontSize: 16,
                                                          fontWeight: semiBold),
                                                ),
                                              );
                                            }
                                            return Container();
                                          },
                                        ),
                                      )
                                    ] else if (userType == "seller") ...[
                                      BlocProvider(
                                        create: (context) => TransaksiBloc()
                                          ..add(TransaksiGetDetailSeller(
                                              widget.transactionId)),
                                        child: BlocBuilder<TransaksiBloc,
                                            TransaksiState>(
                                          builder: (context, state) {
                                            if (state
                                                is DetailTransaksiSellerGetSuccess) {
                                              var detailTransaksi = state
                                                  .detailTransaksiSeller!.data;
                                              return Expanded(
                                                  flex: 2,
                                                  child: Container(
                                                    child: Row(children: [
                                                      Flexible(
                                                        child: Text(
                                                          detailTransaksi.weight
                                                              .toString(),
                                                          style: blueTextStyle
                                                              .copyWith(
                                                                  fontSize: 48,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                        ),
                                                      ),
                                                      Expanded(
                                                          child: Container(
                                                        child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              Container(
                                                                margin:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        bottom:
                                                                            12),
                                                                child: Row(
                                                                  children: [
                                                                    Text(
                                                                        "dari"),
                                                                    const SizedBox(
                                                                      width: 2,
                                                                    ),
                                                                    Text(
                                                                      detailTransaksi
                                                                          .maximumWeight
                                                                          .toString(),
                                                                      style: blueTextStyle.copyWith(
                                                                          fontSize:
                                                                              16,
                                                                          fontWeight:
                                                                              FontWeight.w700),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ]),
                                                      )),
                                                    ]),
                                                  ));
                                            }
                                            if (state
                                                is DetailTransaksiSellerFailed) {
                                              return Center(
                                                child: Text(
                                                  "Terjadi Kesalahan :(",
                                                  style:
                                                      blackTextStyle.copyWith(
                                                          fontSize: 16,
                                                          fontWeight: semiBold),
                                                ),
                                              );
                                            }
                                            return Container();
                                          },
                                        ),
                                      )
                                    ]
                                  ]),
                                )),
                            Flexible(
                                child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/image/image_detail_penawaranpng.png"),
                                      fit: BoxFit.fitWidth)),
                            )),
                          ]),
                        )),
                        if (userType == "buyer") ...[
                          BlocProvider(
                            create: (context) => TransaksiBloc()
                              ..add(TransaksiGetDetailBuyer(
                                  widget.transactionId)),
                            child: BlocBuilder<TransaksiBloc, TransaksiState>(
                              builder: (context, state) {
                                if (state is DetailTransaksiBuyerGetSuccess) {
                                  var detailTransaksi =
                                      state.detailTransaksiBuyer!.data;
                                  return Flexible(
                                      child: Container(
                                    child: Column(children: [
                                      Flexible(
                                          child: Container(
                                        child: LinearPercentIndicator(
                                          lineHeight: 27,
                                          percent: 0.5,
                                          animation: true,
                                          progressColor: greenColor,
                                          backgroundColor: greyColor,
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
                                              "0 kg",
                                              style: blueTextStyle.copyWith(
                                                  fontSize: 16),
                                            ),
                                            Text(
                                              "${detailTransaksi.maximumWeight} kg",
                                              style: blueTextStyle.copyWith(
                                                  fontSize: 16),
                                            )
                                          ],
                                        ),
                                      )),
                                    ]),
                                  ));
                                }
                                if (state is DetailTransaksiBuyerFailed) {
                                  return Center(
                                    child: Text(
                                      "Terjadi Kesalahan :(",
                                      style: blackTextStyle.copyWith(
                                          fontSize: 16, fontWeight: semiBold),
                                    ),
                                  );
                                }
                                return Container();
                              },
                            ),
                          ),

                          //CHECKING STATUS CODE OF BUYER
                          // HEREEEE
                        ] else if (userType == "seller") ...[
                          BlocProvider(
                            create: (context) => TransaksiBloc()
                              ..add(TransaksiGetDetailSeller(
                                  widget.transactionId)),
                            child: BlocBuilder<TransaksiBloc, TransaksiState>(
                              builder: (context, state) {
                                if (state is DetailTransaksiSellerGetSuccess) {
                                  return Flexible(
                                      child: Container(
                                    child: Column(children: [
                                      Flexible(
                                          child: Container(
                                        child: LinearPercentIndicator(
                                          lineHeight: 27,
                                          percent: 0.5,
                                          animation: true,
                                          progressColor: greenColor,
                                          backgroundColor: greyColor,
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
                                              "${state.detailTransaksiSeller!.data.maximumWeight.toString()} Kg",
                                              style: blueTextStyle.copyWith(
                                                  fontSize: 16),
                                            )
                                          ],
                                        ),
                                      )),
                                    ]),
                                  ));
                                }

                                if (state is DetailTransaksiSellerFailed) {
                                  return Center(
                                    child: Text(
                                      "Terjadi Kesalahan :(",
                                      style: blackTextStyle.copyWith(
                                          fontSize: 16, fontWeight: semiBold),
                                    ),
                                  );
                                }
                                return Container();
                              },
                            ),
                          ),
                          if (userType == "seller") ...[
                            const SizedBox(height: 30),
                            if (widget.statusPenawaran == 0) ...[
                              BlocProvider(
                                create: (context) => TransaksiBloc(),
                                child:
                                    BlocConsumer<TransaksiBloc, TransaksiState>(
                                  listener: (context, state) {
                                    // TODO: implement listener
                                    if (state
                                        is AksiTransaksiSellerGetSuccess) {
                                      Navigator.pushNamedAndRemoveUntil(
                                          context,
                                          HolderPage.routeName,
                                          (route) => false);
                                    }
                                  },
                                  builder: (context, state) {
                                    if (state is AksiTransaksiLoading) {}

                                    return GestureDetector(
                                      onTap: () {},
                                      child: SizedBox(
                                        width: double.infinity,
                                        height: 50,
                                        child: TextButton(
                                          style: TextButton.styleFrom(
                                              backgroundColor: greenColor,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8))),
                                          onPressed: () {
                                            context.read<TransaksiBloc>().add(
                                                AksiTransaksiGetSeller(
                                                    widget.transactionId));
                                          },
                                          child: Text(
                                            "Batalkan Penawaran",
                                            style: whiteTextStyle.copyWith(
                                                fontSize: 16,
                                                fontWeight: semiBold),
                                          ),
                                        ),
                                      ),
                                    );

                                    if (state is AksiTransaksiSellerFailed) {}
                                    return Container();
                                  },
                                ),
                              )
                            ],
                            if (widget.statusPenawaran == 1) ...[
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.green.shade600),
                                width: double.infinity,
                                child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    text: '',
                                    style: TextStyle(
                                        fontSize: 20, fontWeight: semiBold),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text:
                                              "Penawaran Telah Diterima oleh Pembeli !",
                                          style: whiteTextStyle.copyWith(
                                              fontSize: 20,
                                              fontWeight: medium)),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 12,
                              )
                            ] else if (widget.statusPenawaran == 3) ...[
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: redColor),
                                width: double.infinity,
                                child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    text: '',
                                    style: TextStyle(
                                        fontSize: 20, fontWeight: semiBold),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: "Penawaran Telah Dibatalkan!",
                                          style: whiteTextStyle.copyWith(
                                              fontSize: 20,
                                              fontWeight: semiBold)),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 12,
                              )
                            ] else if (widget.statusPenawaran == 2) ...[
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: whiteColor),
                                width: double.infinity,
                                child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    text: '',
                                    style: TextStyle(
                                        fontSize: 20, fontWeight: semiBold),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text:
                                              "Yuk Segera Antar Penawaran Limbahmu !",
                                          style: blackTextStyle.copyWith(
                                              fontSize: 20,
                                              fontWeight: semiBold)),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 12,
                              )
                            ]
                          ]
                        ]
                      ],
                    ),
                  )),
                  if (userType == "buyer") ...[
                    if (widget.statusPenawaran == 0) ...[
                      BlocProvider(
                        create: (context) => TransaksiBloc()
                          ..add(TransaksiGetDetailBuyer(widget.transactionId)),
                        child: BlocConsumer<TransaksiBloc, TransaksiState>(
                          listener: (context, state) {
                            if (state is AksiTransaksiBuyerGetSuccess) {
                              Navigator.pushNamedAndRemoveUntil(context,
                                  HolderPage.routeName, (route) => false);
                            }
                          },
                          builder: (context, state) {
                            if (state is DetailTransaksiBuyerGetSuccess) {
                              // var detailTransaksi =
                              //     state.detailTransaksiBuyer!.data;
                              return Flexible(
                                  child: Container(
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Flexible(
                                          child: Container(
                                              child: GestureDetector(
                                        onTap: () {},
                                        child: SizedBox(
                                          width: 144,
                                          height: 50,
                                          child: TextButton(
                                            style: TextButton.styleFrom(
                                                backgroundColor: Colors.red,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8))),
                                            onPressed: () {
                                              //TODO: Tolak
                                              status = 3;
                                              print("TOLAK: Status ${status}");
                                              context.read<TransaksiBloc>().add(
                                                  AksiTransaksiGetBuyer(
                                                      widget.transactionId,
                                                      status));
                                            },
                                            child: Text(
                                              "Tolak",
                                              style: blackTextStyle.copyWith(
                                                  fontSize: 16,
                                                  fontWeight: semiBold),
                                            ),
                                          ),
                                        ),
                                      ))),
                                      SizedBox(
                                        width: 12,
                                      ),
                                      Flexible(
                                        child: Container(
                                            child: GestureDetector(
                                          onTap: () {},
                                          child: SizedBox(
                                            width: 144,
                                            height: 50,
                                            child: TextButton(
                                              style: TextButton.styleFrom(
                                                  backgroundColor: Colors.green,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8))),
                                              onPressed: () {
                                                //TODO: Terima
                                                status = 2;
                                                print(
                                                    "Konfirmasi: Status ${status}");
                                                context
                                                    .read<TransaksiBloc>()
                                                    .add(AksiTransaksiGetBuyer(
                                                        widget.transactionId,
                                                        status));
                                              },
                                              child: Text(
                                                "Terima",
                                                style: blackTextStyle.copyWith(
                                                    fontSize: 16,
                                                    fontWeight: semiBold),
                                              ),
                                            ),
                                          ),
                                        )),
                                      )
                                    ]),
                              ));
                            }
                            if (state is DetailTransaksiBuyerFailed) {
                              return Center(
                                child: Text(
                                  "Terjadi Kesalahan :(",
                                  style: blackTextStyle.copyWith(
                                      fontSize: 16, fontWeight: semiBold),
                                ),
                              );
                            }
                            return Container();
                          },
                        ),
                      )
                    ],
                    if (widget.statusPenawaran == 1) ...[
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12)),
                        child: Column(children: [
                          Image.asset(
                            "assets/image/check.png",
                            width: 100,
                            height: 100,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Penawaran Telah Diterima",
                            style: greenTextStyle.copyWith(
                                fontSize: 16, fontWeight: semiBold),
                          )
                        ]),
                      ),
                      const SizedBox(
                        height: 12,
                      )
                    ],
                    if (widget.statusPenawaran == 3) ...[
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12)),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Text("data"),
                              Image.asset(
                                "assets/image/cross.png",
                                width: 60,
                                height: 60,
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Text(
                                "Penawaran Dibatalkan",
                                style: blackTextStyle.copyWith(
                                    fontSize: 16, fontWeight: semiBold),
                              )
                            ]),
                      ),
                      const SizedBox(
                        height: 12,
                      )
                    ],
                    if (widget.statusPenawaran == 4) ...[
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12)),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/image/cross.png",
                                width: 60,
                                height: 60,
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Text(
                                "Penawaran Ditolak",
                                style: blackTextStyle.copyWith(
                                    fontSize: 16, fontWeight: semiBold),
                              )
                            ]),
                      ),
                      const SizedBox(
                        height: 12,
                      )
                    ],
                    if (widget.statusPenawaran == 2) ...[
                      BlocProvider(
                        create: (context) => TransaksiBloc()
                          ..add(AksiTransaksiGetBuyer(
                              widget.transactionId, status)),
                        child: BlocConsumer<TransaksiBloc, TransaksiState>(
                          listener: (context, state) {
                            if (state is AksiTransaksiBuyerGetSuccess) {
                              Navigator.pushNamedAndRemoveUntil(context,
                                  HolderPage.routeName, (route) => false);
                            }
                          },
                          builder: (context, state) {
                            // var detailTransaksi =
                            //     state.detailTransaksiBuyer!.data;
                            return Flexible(
                                child: Container(
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Flexible(
                                        child: Container(
                                            child: GestureDetector(
                                      onTap: () {},
                                      child: SizedBox(
                                        width: 144,
                                        height: 50,
                                        child: TextButton(
                                          style: TextButton.styleFrom(
                                              backgroundColor: Colors.red,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8))),
                                          onPressed: () {
                                            //TODO: Tolak
                                            status = 3;
                                            print("Batal: Status ${status}");
                                            context.read<TransaksiBloc>().add(
                                                AksiTransaksiGetBuyer(
                                                    widget.transactionId,
                                                    status));
                                          },
                                          child: Text(
                                            "Batalkan",
                                            style: whiteTextStyle.copyWith(
                                                fontSize: 16,
                                                fontWeight: semiBold),
                                          ),
                                        ),
                                      ),
                                    ))),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    Flexible(
                                      child: Container(
                                          child: GestureDetector(
                                        onTap: () {},
                                        child: SizedBox(
                                          width: 144,
                                          height: 50,
                                          child: TextButton(
                                            style: TextButton.styleFrom(
                                                backgroundColor: Colors.green,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8))),
                                            onPressed: () {
                                              //TODO: Terima
                                              status = 1;
                                              print("TERIMA: Status ${status}");
                                              context.read<TransaksiBloc>().add(
                                                  AksiTransaksiGetBuyer(
                                                      widget.transactionId,
                                                      status));
                                            },
                                            child: Text(
                                              "Selesai",
                                              style: whiteTextStyle.copyWith(
                                                  fontSize: 16,
                                                  fontWeight: semiBold),
                                            ),
                                          ),
                                        ),
                                      )),
                                    )
                                  ]),
                            ));

                            if (state is DetailTransaksiBuyerFailed) {
                              return Center(
                                child: Text(
                                  "Terjadi Kesalahan :(",
                                  style: blackTextStyle.copyWith(
                                      fontSize: 16, fontWeight: semiBold),
                                ),
                              );
                            }
                            return Container();
                          },
                        ),
                      )
                    ],
                  ],
                  const SizedBox(
                    height: 12,
                  ),
                  if (userType == "buyer") ...[
                    BlocProvider(
                      create: (context) => TransaksiBloc()
                        ..add(TransaksiGetDetailBuyer(widget.transactionId)),
                      child: BlocConsumer<TransaksiBloc, TransaksiState>(
                        listener: (context, state) {
                          if (state is AksiTransaksiBuyerGetSuccess) {
                            Navigator.pushNamedAndRemoveUntil(context,
                                HolderPage.routeName, (route) => false);
                          }
                        },
                        builder: (context, state) {
                          if (state is DetailTransaksiBuyerGetSuccess) {
                            var detailTransaksi =
                                state.detailTransaksiBuyer!.data;
                                print(detailTransaksi.image);
                            return Flexible(
                                flex: 4,
                                child: Container(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                       if (detailTransaksi.image != "" ||
                                                detailTransaksi != null) ...[
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    top: 12, bottom: 12),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Image.network(
                                                      detailTransaksi.image!,
                                                      width: 200,
                                                      height: 200,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ] else ...[
                                              Container(),
                                            ],
                                        Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 17, vertical: 16),
                                          decoration: BoxDecoration(
                                              color: whiteColor,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: Column(children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Flexible(
                                                    child: Wrap(
                                                  children: [
                                                    Text(
                                                      detailTransaksi.title
                                                          .toString(),
                                                      style: blackTextStyle
                                                          .copyWith(
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
                                                  detailTransaksi.category
                                                      .toString(),
                                                  style:
                                                      blackTextStyle.copyWith(
                                                          fontWeight:
                                                              FontWeight.w600),
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
                                                  detailTransaksi
                                                      .additionalInformation
                                                      .toString(),
                                                  style:
                                                      blackTextStyle.copyWith(
                                                          fontWeight:
                                                              FontWeight.w600),
                                                )
                                              ],
                                            ),
                                          ]),
                                        ),
                                        const SizedBox(
                                          height: 25,
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
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 17, vertical: 16),
                                          decoration: BoxDecoration(
                                              color: whiteColor,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: Column(children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Tanggal Kadaluarsa",
                                                  style: blackTextStyle,
                                                ),
                                                Text(
                                                  "-",
                                                  style:
                                                      blackTextStyle.copyWith(
                                                          fontWeight:
                                                              FontWeight.w600),
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
                                                  "Berat Minimum",
                                                  style: blackTextStyle,
                                                ),
                                                Text(
                                                  "${detailTransaksi.minimumWeight} g",
                                                  style:
                                                      blackTextStyle.copyWith(
                                                          fontWeight:
                                                              FontWeight.w600),
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
                                                  "${detailTransaksi.minimumWeight} kg",
                                                  style:
                                                      blackTextStyle.copyWith(
                                                          fontWeight:
                                                              FontWeight.w600),
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
                                                  "Pendapatan",
                                                  style: blackTextStyle,
                                                ),
                                                Text(
                                                  "+ Rp${detailTransaksi.price},- / kg",
                                                  style:
                                                      blackTextStyle.copyWith(
                                                          fontWeight:
                                                              FontWeight.w600),
                                                )
                                              ],
                                            ),
                                          ]),
                                        ),
                                        const SizedBox(
                                          height: 25,
                                        ),
                                        Text(
                                          "Data Pengiriman",
                                          style: blackTextStyle.copyWith(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 20),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 17, vertical: 16),
                                          decoration: BoxDecoration(
                                              color: whiteColor,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: Column(children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Berat yang Diberikan",
                                                  style: blackTextStyle,
                                                ),
                                                Text(
                                                  "${detailTransaksi.weight} kg",
                                                  style:
                                                      blackTextStyle.copyWith(
                                                          fontWeight:
                                                              FontWeight.w600),
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
                                                  "Lokasi",
                                                  style: blackTextStyle,
                                                ),
                                                Text(
                                                  "${detailTransaksi.location}",
                                                  style:
                                                      blackTextStyle.copyWith(
                                                          fontWeight:
                                                              FontWeight.w600),
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
                                                  "Sistem",
                                                  style: blackTextStyle,
                                                ),
                                                Text(
                                                  "${detailTransaksi.retrievalSystem}",
                                                  style:
                                                      blackTextStyle.copyWith(
                                                          fontWeight:
                                                              FontWeight.w600),
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
                                                  "Total Pendapatan",
                                                  style: blackTextStyle,
                                                ),
                                                Text(
                                                  "+Rp. ${detailTransaksi.totalPrice}",
                                                  style:
                                                      blackTextStyle.copyWith(
                                                          fontWeight:
                                                              FontWeight.w600),
                                                )
                                              ],
                                            ),
                                          ]),
                                        ),
                                      ]),
                                ));
                          }
                          if (state is DetailTransaksiBuyerFailed) {
                            return Center(
                              child: Text(
                                "Terjadi Kesalahan :(",
                                style: blackTextStyle.copyWith(
                                    fontSize: 16, fontWeight: semiBold),
                              ),
                            );
                          }
                          return Container();
                        },
                      ),
                    )
                  ] else if (userType == "seller") ...[
                    BlocProvider(
                      create: (context) => TransaksiBloc()
                        ..add(TransaksiGetDetailSeller(widget.transactionId)),
                      child: BlocConsumer<TransaksiBloc, TransaksiState>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          if (state is DetailTransaksiSellerGetSuccess) {
                            var detailTransaksi =
                                state.detailTransaksiSeller!.data;
                            return Flexible(
                                flex: 3,
                                child: Container(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 17, vertical: 16),
                                          decoration: BoxDecoration(
                                              color: whiteColor,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: Column(children: [
                                            if (detailTransaksi.image != "" ||
                                                detailTransaksi != null) ...[
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    top: 12, bottom: 12),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Image.network(
                                                      detailTransaksi.image!,
                                                      width: 200,
                                                      height: 200,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ] else ...[
                                              Container(),
                                            ],
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Flexible(
                                                    child: Wrap(
                                                  children: [
                                                    Text(
                                                      "${detailTransaksi.title}",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: blackTextStyle
                                                          .copyWith(
                                                              fontSize: 16,
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
                                                  "${detailTransaksi.category}",
                                                  style:
                                                      blackTextStyle.copyWith(
                                                          fontWeight:
                                                              FontWeight.w600),
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
                                                  "${detailTransaksi.additionalInformation}",
                                                  style:
                                                      blackTextStyle.copyWith(
                                                          fontWeight:
                                                              FontWeight.w600),
                                                )
                                              ],
                                            ),
                                          ]),
                                        ),
                                        const SizedBox(
                                          height: 25,
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
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 17, vertical: 16),
                                          decoration: BoxDecoration(
                                              color: whiteColor,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: Column(children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Tanggal Kadaluarsa",
                                                  style: blackTextStyle,
                                                ),
                                                Text(
                                                  "-",
                                                  style:
                                                      blackTextStyle.copyWith(
                                                          fontWeight:
                                                              FontWeight.w600),
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
                                                  "Berat Minimum",
                                                  style: blackTextStyle,
                                                ),
                                                Text(
                                                  "${detailTransaksi.minimumWeight} g",
                                                  style:
                                                      blackTextStyle.copyWith(
                                                          fontWeight:
                                                              FontWeight.w600),
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
                                                  "${detailTransaksi.minimumWeight} kg",
                                                  style:
                                                      blackTextStyle.copyWith(
                                                          fontWeight:
                                                              FontWeight.w600),
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
                                                  "Pendapatan",
                                                  style: blackTextStyle,
                                                ),
                                                Text(
                                                  "+ Rp${detailTransaksi.price},- / kg",
                                                  style:
                                                      blackTextStyle.copyWith(
                                                          fontWeight:
                                                              FontWeight.w600),
                                                )
                                              ],
                                            ),
                                          ]),
                                        ),
                                        const SizedBox(
                                          height: 25,
                                        ),
                                        Text(
                                          "Data Pengiriman",
                                          style: blackTextStyle.copyWith(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 20),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 17, vertical: 16),
                                          decoration: BoxDecoration(
                                              color: whiteColor,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: Column(children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Berat yang Diberikan",
                                                  style: blackTextStyle,
                                                ),
                                                Text(
                                                  "${detailTransaksi.weight} kg",
                                                  style:
                                                      blackTextStyle.copyWith(
                                                          fontWeight:
                                                              FontWeight.w600),
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
                                                  "Lokasi",
                                                  style: blackTextStyle,
                                                ),
                                                Text(
                                                  "${detailTransaksi.location}",
                                                  style:
                                                      blackTextStyle.copyWith(
                                                          fontWeight:
                                                              FontWeight.w600),
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
                                                  "Sistem",
                                                  style: blackTextStyle,
                                                ),
                                                Text(
                                                  "${detailTransaksi.retrievalSystem}",
                                                  style:
                                                      blackTextStyle.copyWith(
                                                          fontWeight:
                                                              FontWeight.w600),
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
                                                  "Total Pendapatan",
                                                  style: blackTextStyle,
                                                ),
                                                Text(
                                                  "+Rp. ${detailTransaksi.totalPrice}",
                                                  style:
                                                      blackTextStyle.copyWith(
                                                          fontWeight:
                                                              FontWeight.w600),
                                                )
                                              ],
                                            ),
                                          ]),
                                        ),
                                      ]),
                                ));
                          }
                          if (state is DetailTransaksiBuyerFailed) {
                            return Center(
                              child: Text(
                                "Terjadi Kesalahan :(",
                                style: blackTextStyle.copyWith(
                                    fontSize: 16, fontWeight: semiBold),
                              ),
                            );
                          }
                          return Container();
                        },
                      ),
                    )
                  ],
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
