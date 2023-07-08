import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:lottie/lottie.dart';
import 'package:skeletons/skeletons.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../ressources/const.dart';

class Homeloading extends StatelessWidget {
  const Homeloading({super.key});

  @override
  Widget build(BuildContext context) {
    final pages = List.generate(
        10,
        (index) => GestureDetector(
              onTap: () {
                // nav(DoctorView(doctorName: 'Dr Etondy'), context);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: primaryMain.withOpacity(.5),
                ),
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                child: Container(
                  height: 280,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 5),
                                SkeletonParagraph(
                                  style: SkeletonParagraphStyle(
                                      lines: 1,
                                      spacing: 2,
                                      lineStyle: SkeletonLineStyle(
                                        randomLength: true,
                                        height: 20,
                                        borderRadius: BorderRadius.circular(8),
                                        minLength:
                                            MediaQuery.of(context).size.width /
                                                2,
                                      )),
                                ),
                                SkeletonParagraph(
                                  style: SkeletonParagraphStyle(
                                      lines: 1,
                                      spacing: 2,
                                      lineStyle: SkeletonLineStyle(
                                        randomLength: true,
                                        height: 16,
                                        borderRadius: BorderRadius.circular(8),
                                        minLength:
                                            MediaQuery.of(context).size.width /
                                                5,
                                      )),
                                ),
                                SkeletonParagraph(
                                  style: SkeletonParagraphStyle(
                                      lines: 1,
                                      spacing: 2,
                                      lineStyle: SkeletonLineStyle(
                                        randomLength: true,
                                        height: 12,
                                        borderRadius: BorderRadius.circular(8),
                                        minLength:
                                            MediaQuery.of(context).size.width /
                                                5,
                                      )),
                                ),
                                SkeletonParagraph(
                                  style: SkeletonParagraphStyle(
                                      lines: 1,
                                      spacing: 2,
                                      lineStyle: SkeletonLineStyle(
                                        randomLength: true,
                                        height: 16,
                                        borderRadius: BorderRadius.circular(8),
                                        minLength:
                                            MediaQuery.of(context).size.width /
                                                5,
                                      )),
                                ),
                                SkeletonParagraph(
                                  style: SkeletonParagraphStyle(
                                      lines: 1,
                                      spacing: 2,
                                      lineStyle: SkeletonLineStyle(
                                        randomLength: true,
                                        height: 12,
                                        borderRadius: BorderRadius.circular(8),
                                        minLength:
                                            MediaQuery.of(context).size.width /
                                                5,
                                      )),
                                ),
                                SkeletonParagraph(
                                  style: SkeletonParagraphStyle(
                                      lines: 1,
                                      spacing: 2,
                                      lineStyle: SkeletonLineStyle(
                                        randomLength: true,
                                        height: 20,
                                        borderRadius: BorderRadius.circular(8),
                                        minLength:
                                            MediaQuery.of(context).size.width /
                                                2,
                                      )),
                                ),
                                SizedBox(height: 5),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SkeletonAvatar(
                        style: SkeletonAvatarStyle(
                          height: double.infinity,
                          // minWidth: MediaQuery.of(context).size.height / 8,
                          width: MediaQuery.of(context).size.height / 6.5,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ));
    // Future<void> getdata() async {}
    final controller = PageController(viewportFraction: 0.8, keepPage: true);

    double doublewidth = MediaQuery.of(context).size.width;
    double doubleheight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 16),

                Row(
                  children: [
                    SizedBox(width: 16),
                    SkeletonAvatar(
                      style: SkeletonAvatarStyle(
                          shape: BoxShape.circle, width: 60, height: 60),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: SkeletonParagraph(
                        style: SkeletonParagraphStyle(
                            lines: 2,
                            spacing: 6,
                            lineStyle: SkeletonLineStyle(
                              randomLength: true,
                              height: 16,
                              borderRadius: BorderRadius.circular(8),
                              minLength:
                                  MediaQuery.of(context).size.width / 6,
                              maxLength:
                                  MediaQuery.of(context).size.width / 3,
                            )),
                      ),
                    ),
                    const Spacer(),
                    SkeletonAvatar(
                      style: SkeletonAvatarStyle(
                          shape: BoxShape.circle, width: 40, height: 40),
                    ),
                    SizedBox(width: 10),
                    SkeletonAvatar(
                      style: SkeletonAvatarStyle(
                          shape: BoxShape.circle, width: 40, height: 40),
                    ),
                    SizedBox(width: 12),
                  ],
                ),
                const SizedBox(height: 16),

                SizedBox(
                  height: 240,
                  child: PageView.builder(
                    controller: controller,
                    // itemCount: pages.length,
                    itemBuilder: (_, index) {
                      return pages[index % pages.length];
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24, bottom: 12),
                  child: RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: "",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: "Loading... ",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black87,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SmoothPageIndicator(
                  controller: controller,
                  count: pages.length,
                  effect: WormEffect(
                    dotHeight: 16,
                    dotWidth: 16,
                    dotColor: Colors.grey.shade400,
                    activeDotColor: primaryMain,
                    type: WormType.thinUnderground,
                  ),
                ),
                //
                Padding(
                  padding:
                      const EdgeInsets.only(top: 16, bottom: 4, left: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SkeletonParagraph(
                        style: SkeletonParagraphStyle(
                            lines: 1,
                            spacing: 6,
                            lineStyle: SkeletonLineStyle(
                              // randomLength: true,
                              height: 12,
                              borderRadius: BorderRadius.circular(8),
                              width: MediaQuery.of(context).size.width / 4,
                            )),
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(children: [
                    for (int i = 0; i <= 3; i++)
                      Container(
                        height: 100,
                        width: 120,
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: primaryMain.withOpacity(.1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 5,
                            ),
                            SkeletonAvatar(
                                style: SkeletonAvatarStyle(
                                    width: 50, height: 50)),
                            SizedBox(
                              height: 5,
                            ),
                            SkeletonParagraph(
                              style: SkeletonParagraphStyle(
                                  lines: 1,
                                  spacing: 6,
                                  lineStyle: SkeletonLineStyle(
                                    // randomLength: true,
                                    height: 14,
                                    width: double.infinity,
                                    borderRadius: BorderRadius.circular(8),
                                  )),
                            ),
                          ],
                        ),
                      ),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 16, bottom: 8, left: 16, right: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkeletonParagraph(
                        style: SkeletonParagraphStyle(
                            lines: 1,
                            spacing: 6,
                            lineStyle: SkeletonLineStyle(
                              // randomLength: true,
                              height: 12,
                              borderRadius: BorderRadius.circular(8),
                              width: MediaQuery.of(context).size.width / 4,
                              // maxLength: MediaQuery.of(context).size.width / 3,
                            )),
                      ),
                      SkeletonParagraph(
                        style: SkeletonParagraphStyle(
                            lines: 1,
                            spacing: 6,
                            lineStyle: SkeletonLineStyle(
                              // randomLength: true,
                              height: 12,
                              borderRadius: BorderRadius.circular(8),
                              width:
                                  MediaQuery.of(context).size.width / 5.2,
                              // maxLength: MediaQuery.of(context).size.width / 3,
                            )),
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                        children: List.generate(
                            6,
                            (index) => Container(
                                  // height: 300,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: primaryMain.withOpacity(.5),
                                  ),
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 4),
                                  child: Container(
                                    height: 280,
                                    child: Row(
                                      children: [
                                        Container(
                                          child: Padding(
                                            padding: EdgeInsets.all(12.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SkeletonParagraph(
                                                  style:
                                                      SkeletonParagraphStyle(
                                                          lines: 6,
                                                          spacing: 8,
                                                          lineStyle:
                                                              SkeletonLineStyle(
                                                            // randomLength: true,
                                                            height: 16,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                2.4,
                                                            minLength: MediaQuery.of(context).size.width / 3,
                                                          )),
                                                ),
SkeletonAvatar(
                                          style: SkeletonAvatarStyle(
                                            height: 40,
                                            // minWidth: MediaQuery.of(context).size.height / 8,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                4.4,
                                          ),
                                        ),
                                                SizedBox(height: 4),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                                                  children: [
                                                    SizedBox(
                                                      width: 25,
                                                    ),
                                                    SkeletonAvatar(
                                          style: SkeletonAvatarStyle(
                                            height: 60,
                                            // minWidth: MediaQuery.of(context).size.height / 8,
                                            width: 60,
                                            shape: BoxShape.circle
                                          ),
                                        ),
                                                    SizedBox(
                                                      width: 20,
                                                    ),
                                                    SkeletonAvatar(
                                          style: SkeletonAvatarStyle(
                                            shape: BoxShape.circle,
                                            height: 60,
                                            // minWidth: MediaQuery.of(context).size.height / 8,
                                            width: 60,
                                          ),
                                        ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        SkeletonAvatar(
                                          style: SkeletonAvatarStyle(
                                            height: double.infinity,
                                            // minWidth: MediaQuery.of(context).size.height / 8,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                6,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ))))
              ]),
        )

            // Container(
            //   child: SmoothPageIndicator(
            //     controller: controller,
            //     count: pages.length,
            //     effect: JumpingDotEffect(
            //       dotHeight: 16,
            //       dotWidth: 16,
            //       jumpScale: .7,
            //       verticalOffset: 15,
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(top: 16, bottom: 12),
            //   child: Text(
            //     'Scrolling Dots',
            //     style: TextStyle(color: Colors.black54),
            //   ),
            // ),
            // SmoothPageIndicator(
            //     controller: controller,
            //     count: pages.length,
            //     effect: ScrollingDotsEffect(
            //       activeStrokeWidth: 2.6,
            //       activeDotScale: 1.3,
            //       maxVisibleDots: 5,
            //       radius: 8,
            //       spacing: 10,
            //       dotHeight: 12,
            //       dotWidth: 12,
            //     )),
            // Padding(
            //   padding: const EdgeInsets.only(top: 16, bottom: 16),
            //   child: Text(
            //     'Customizable Effect',
            //     style: TextStyle(color: Colors.black54),
            //   ),
            // ),
            // Container(
            //   // color: Colors.red.withOpacity(.4),
            //   child: SmoothPageIndicator(
            //     controller: controller,
            //     count: pages.length,
            //     effect: CustomizableEffect(
            //       activeDotDecoration: DotDecoration(
            //         width: 32,
            //         height: 12,
            //         color: Colors.indigo,
            //         rotationAngle: 180,
            //         verticalOffset: -10,
            //         borderRadius: BorderRadius.circular(24),
            //         // dotBorder: DotBorder(
            //         //   padding: 2,
            //         //   width: 2,
            //         //   color: Colors.indigo,
            //         // ),
            //       ),
            //       dotDecoration: DotDecoration(
            //         width: 24,
            //         height: 12,
            //         color: Colors.grey,
            //         // dotBorder: DotBorder(
            //         //   padding: 2,
            //         //   width: 2,
            //         //   color: Colors.grey,
            //         // ),
            //         // borderRadius: BorderRadius.only(
            //         //     topLeft: Radius.circular(2),
            //         //     topRight: Radius.circular(16),
            //         //     bottomLeft: Radius.circular(16),
            //         //     bottomRight: Radius.circular(2)),
            //         borderRadius: BorderRadius.circular(16),
            //         verticalOffset: 0,
            //       ),
            //       spacing: 6.0,
            //       // activeColorOverride: (i) => colors[i],
            //       inActiveColorOverride: (i) => colors[i],
            //     ),
            //   ),
            // ),
            // const SizedBox(height: 32.0),
            ));
  }
}
