// // import 'package:agora_uikit/agora_uikit.dart';
// import 'package:flutter/material.dart';

// import '../../ressources/const.dart';

// class VideoCall extends StatefulWidget {
//   const VideoCall({super.key});

//   @override
//   State<VideoCall> createState() => _VideoCallState();
// }
// String channelName = "test";
//   String token = "7336c13814a14b5383762ea8bf65e61d";
// class _VideoCallState extends State<VideoCall> {
//   final AgoraClient client = AgoraClient(
//     agoraConnectionData: AgoraConnectionData(
//       tempToken: token,
//       appId: appId,
//       channelName: channelName,
//       username: "Frank Armel",
//     ),
//   );

//   @override
//   void initState() {
//     super.initState();
//     initAgora();
//   }

//   void initAgora() async {
//     await client.initialize();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Agora VideoUIKit'),
//           centerTitle: true,
//         ),
//         body: SafeArea(
//           child: Stack(
//             children: [
//               AgoraVideoViewer(
//                 client: client,
//                 layoutType: Layout.floating,
//                 enableHostControls: true, // Add this to enable host controls
//               ),
//               AgoraVideoButtons(
//                 client: client,
//                 autoHideButtons: false, // Add this to enable screen sharing
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
