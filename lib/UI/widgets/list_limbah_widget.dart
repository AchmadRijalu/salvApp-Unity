import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:salv/common/common.dart';

class LimbahBerandaPage extends StatelessWidget {
  final String? title;
  final int? price;
  final VoidCallback? onTap;
  LimbahBerandaPage(
      {super.key, this.onTap, required this.title, required this.price});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 18),
        decoration: BoxDecoration(
            color: greenColor, borderRadius: BorderRadius.circular(8)),
        height: 130,
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Expanded(
              child: Container(
                  child: Column(
            children: [
              Expanded(
                child: Row(children: [
                  Expanded(
                      child: Container(
                    child: Column(children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                            padding: const EdgeInsets.only(left: 21, top: 23),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  child: Text(
                                    title!,
                                    overflow: TextOverflow.clip,
                                    style:
                                        whiteTextStyle.copyWith(fontSize: 22, fontWeight: medium),
                                  ),
                                )
                                
                              ],
                            )),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ]),
                  )),
                  // Expanded(
                  //     flex: 2,
                  //     child: Container(
                  //       child: Align(
                  //           alignment: Alignment.topRight,
                  //           child: Image.asset(
                  //             "assets/image/image_sampah.png",
                  //             fit: BoxFit.fill,
                  //           )),
                  //     )),
                ]),
              ),
              Flexible(
                  child: Container(
                child: Column(children: [
                  Expanded(
                      child: Container(
                    padding: const EdgeInsets.only(right: 20, left: 21),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: Container(
                          child: Column(
                            children: [
                              Flexible(
                                  child: Container(
                                margin: const EdgeInsets.only(top: 2),
                                child: Row(
                                  children: [
                                    Text(
                                      "Pencapaian ",
                                      style:
                                          whiteTextStyle.copyWith(fontSize: 10),
                                    ),
                                  ],
                                ),
                              )),
                              Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      price!.toString(),
                                      style:
                                          whiteTextStyle.copyWith(fontSize: 32),
                                    ),
                                    Text(
                                      "Kg",
                                      style:
                                          whiteTextStyle.copyWith(fontSize: 16),
                                    ),
                                  ]),
                            ],
                          ),
                        )),
                      ],
                    ),
                  ))
                ]),
              ))
            ],
          ))),
          const SizedBox(
            height: 5,
          ),
        ]),
      ),
    );
  }
}
