import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salv/UI/pages/detail_iklan_page.dart';
import 'package:salv/UI/widgets/list_iklan_widget.dart';
import 'package:salv/blocs/iklan/iklan_bloc.dart';
import 'package:salv/common/common.dart';

class IklanRecommendationPage extends StatefulWidget {
  final dynamic label;
  const IklanRecommendationPage({super.key, required this.label});

  @override
  State<IklanRecommendationPage> createState() =>
      _IklanRecommendationPageState();
}

class _IklanRecommendationPageState extends State<IklanRecommendationPage> {
  bool isRefresh = false;
  late IklanBloc _iklanBloc;
  dynamic getAdvertisementId;

  @override
  void initState() {
    super.initState();
    _iklanBloc = IklanBloc()..add(IklanRecommendationGetAll(widget.label));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            isRefresh = true;
          });
          _iklanBloc.add(IklanRecommendationGetAll(widget.label));
          await Future.delayed(const Duration(milliseconds: 100))
              .timeout(const Duration(seconds: 3));
          setState(() {
            isRefresh = false;
          });
        },
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 37),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 44,
                ),
                Row(children: [Image.asset('assets/image/logo-png.png')]),
                const SizedBox(
                  height: 17,
                ),
                Expanded(
                    child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Lihat Iklan yang \ndirekomendasikan",
                              style: blackTextStyle.copyWith(
                                  fontSize: 20, fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        BlocProvider(
                          create: (context) => _iklanBloc,
                          child: BlocBuilder<IklanBloc, IklanState>(
                            builder: (context, state) {
                              if (state is IklanLoading && !isRefresh ||
                                  isRefresh) {
                                return Container(
                                    margin: const EdgeInsets.only(top: 40),
                                    child: Center(
                                      child: CircularProgressIndicator(
                                          color: greenColor),
                                    ));
                              }
                              if (state is IklanRecommendationGetSuccess) {
                                return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: state.iklanSeller!.data.length,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    var iklan = state.iklanSeller!.data[index];
                                    getAdvertisementId = iklan.id;
                                    return ListIklan(
                                      progressBarIndicator:
                                          iklan.ongoingWeight /
                                              iklan.requestedWeight,
                                      title: iklan.title,
                                      price: iklan.price,
                                      onGoingWeight: iklan.ongoingWeight,
                                      requestedWeight: iklan.requestedWeight,
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                          builder: (context) {
                                            return DetailIklanPage(
                                              maxProgress:
                                                  iklan.requestedWeight,
                                              advertisementId: iklan.id,
                                              iklanProgress:
                                                  (iklan.ongoingWeight /
                                                      iklan.requestedWeight),
                                            );
                                          },
                                        ));
                                      },
                                    );
                                  },
                                );
                              }
                              if (state is IklanFailed) {
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
                      ]),
                ))
              ],
            )),
      ),
    );
  }
}
