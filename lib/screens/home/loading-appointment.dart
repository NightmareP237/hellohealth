import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

import '../../ressources/const.dart';

class AppointmentLoading extends StatelessWidget {
  const AppointmentLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: List.generate(
            5,
            (index) => Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: 120,
                          decoration: BoxDecoration(
                              color: primaryMain.withOpacity(.3),
                              borderRadius: BorderRadius.circular(10)),
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SkeletonParagraph(
                                            style: SkeletonParagraphStyle(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 4),
                                                lines: 1,
                                                spacing: 6,
                                                lineStyle: SkeletonLineStyle(
                                                  // randomLength: true,
                                                  height: 12,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      5.2,
                                                  // maxLength: MediaQuery.of(context).size.width / 3,
                                                )),
                                          ),
                                          SkeletonParagraph(
                                            style: SkeletonParagraphStyle(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 4),
                                                lines: 1,
                                                spacing: 6,
                                                lineStyle: SkeletonLineStyle(
                                                  // randomLength: true,
                                                  height: 12,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      4.2,
                                                  // maxLength: MediaQuery.of(context).size.width / 3,
                                                )),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SkeletonParagraph(
                                            style: SkeletonParagraphStyle(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 4),
                                                lines: 1,
                                                spacing: 6,
                                                lineStyle: SkeletonLineStyle(
                                                  // randomLength: true,
                                                  height: 12,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      5.2,
                                                  // maxLength: MediaQuery.of(context).size.width / 3,
                                                )),
                                          ),
                                          SkeletonParagraph(
                                            style: SkeletonParagraphStyle(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 4),
                                                lines: 1,
                                                spacing: 6,
                                                lineStyle: SkeletonLineStyle(
                                                  // randomLength: true,
                                                  height: 12,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      4.2,
                                                  // maxLength: MediaQuery.of(context).size.width / 3,
                                                )),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SkeletonParagraph(
                                            style: SkeletonParagraphStyle(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 4),
                                                lines: 1,
                                                spacing: 6,
                                                lineStyle: SkeletonLineStyle(
                                                  // randomLength: true,
                                                  height: 12,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      5.2,
                                                  // maxLength: MediaQuery.of(context).size.width / 3,
                                                )),
                                          ),
                                          SkeletonParagraph(
                                            style: SkeletonParagraphStyle(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 4),
                                                lines: 1,
                                                spacing: 6,
                                                lineStyle: SkeletonLineStyle(
                                                  // randomLength: true,
                                                  height: 12,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      4.2,
                                                  // maxLength: MediaQuery.of(context).size.width / 3,
                                                )),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SkeletonParagraph(
                                            style: SkeletonParagraphStyle(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 4),
                                                lines: 1,
                                                spacing: 6,
                                                lineStyle: SkeletonLineStyle(
                                                  // randomLength: true,
                                                  height: 12,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      5.2,
                                                  // maxLength: MediaQuery.of(context).size.width / 3,
                                                )),
                                          ),
                                          SkeletonParagraph(
                                            style: SkeletonParagraphStyle(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 4),
                                                lines: 1,
                                                spacing: 6,
                                                lineStyle: SkeletonLineStyle(
                                                  // randomLength: true,
                                                  height: 12,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      4.2,
                                                  // maxLength: MediaQuery.of(context).size.width / 3,
                                                )),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SkeletonParagraph(
                                            style: SkeletonParagraphStyle(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 4),
                                                lines: 1,
                                                spacing: 6,
                                                lineStyle: SkeletonLineStyle(
                                                  // randomLength: true,
                                                  height: 12,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      5.2,
                                                  // maxLength: MediaQuery.of(context).size.width / 3,
                                                )),
                                          ),
                                          SkeletonParagraph(
                                            style: SkeletonParagraphStyle(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 4),
                                                lines: 1,
                                                spacing: 6,
                                                lineStyle: SkeletonLineStyle(
                                                  // randomLength: true,
                                                  height: 12,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      4.2,
                                                  // maxLength: MediaQuery.of(context).size.width / 3,
                                                )),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SkeletonAvatar(
                                              style: SkeletonAvatarStyle(
                                                height: 40,
                                                // minWidth: MediaQuery.of(context).size.height / 8,
                                                width: redimw(context) / 4.5,
                                              ),
                                            )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )),
      ),
    ));
  }
}
