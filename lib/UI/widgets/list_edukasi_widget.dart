import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:salv/common/common.dart';

class ListEdukasi extends StatelessWidget {
  final String? tipeLimbah;
  final String? namaTutorial;
  final int? durasiVideo;
  final VoidCallback? onTap;
  final String? gambarLimbah;
  const ListEdukasi(
      {super.key,
      required this.durasiVideo,
      this.onTap,
      required this.namaTutorial,
      required this.gambarLimbah,
      required this.tipeLimbah});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: whiteColor,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 2.0,
                offset: Offset(0, 2), // changes the position of the shadow
              ),
            ],
            borderRadius: BorderRadius.circular(8)),
        width: double.infinity,
        height: 88,
        margin: const EdgeInsets.only(bottom: 20),
        child: Row(children: [
// DecorationImage(
          //           image: gambarLimbah == "" ? AssetImage(gambarLimbah!) : NetworkImage(gambarLimbah!) as ImageProvider, fit: BoxFit.fill)

          Expanded(
            flex: 2,
            child: Container(
              child: Column(children: [
                Expanded(
                    child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            namaTutorial!,
                            style: blueTextStyle.copyWith(
                                fontSize: 16, fontWeight: FontWeight.w700),
                            overflow: TextOverflow.fade,
                            textAlign: TextAlign.start,
                          ),
                        )
                      ]),
                )),
                Expanded(
                    child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          tipeLimbah!,
                          style: greenTextStyle.copyWith(
                              fontSize: 12, fontWeight: FontWeight.w700),
                        ),
                        Text(
                          "${durasiVideo!.toString()} menit ",
                          style: greyTextStyle.copyWith(
                              fontSize: 12, fontWeight: FontWeight.w400),
                        )
                      ]),
                )),
              ]),
            ),
          )
        ]),
      ),
    );
  }
}
