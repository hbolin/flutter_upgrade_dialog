import 'package:flutter/material.dart';

/// 升级弹窗
void showUpgradeDialog(
  BuildContext context, {
  required String title,
  required String content,
  required String upgradeButtonText,
  required GestureTapCallback onTapUpgrade,
  bool forceUpdate = false,
}) {
  showDialog(
    context: context,
    barrierDismissible: forceUpdate != true,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: UpgradeDialog(
          title: title,
          content: content,
          upgradeButtonText: upgradeButtonText,
          forceUpdate: forceUpdate,
          onTapUpgrade: onTapUpgrade,
        ),
      );
    },
  );
}

class UpgradeDialog extends StatelessWidget {
  final String title;
  final String content;
  final String upgradeButtonText;
  final bool forceUpdate;
  final GestureTapCallback onTapUpgrade;

  const UpgradeDialog({
    super.key,
    required this.title,
    required this.content,
    required this.upgradeButtonText,
    required this.forceUpdate,
    required this.onTapUpgrade,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return forceUpdate != true;
      },
      child: LayoutBuilder(builder: (context, constraints) {
        double width = constraints.maxWidth;
        double height = constraints.maxWidth * (696 / 1312);
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: height),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 40,
                            height: 1,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  const Color(0xffFFFFFF).withOpacity(0.82),
                                  const Color(0xff73A3FF),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            width: 40,
                            height: 1,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  const Color(0xff73A3FF),
                                  const Color(0xffFFFFFF).withOpacity(0.82),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        content,
                        style: const TextStyle(
                          color: Color(0xff666666),
                        ),
                      ),
                      const SizedBox(height: 24),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          onTapUpgrade();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Theme.of(context).primaryColor,
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 40),
                          child: Text(
                            upgradeButtonText,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                    ],
                  ),
                ),
                Image.asset(
                  "assets/upgrade_background.png",
                  package: "flutter_upgrade_dialog",
                  width: width,
                  height: height,
                  fit: BoxFit.cover,
                ),
              ],
            ),
            Visibility(
              visible: forceUpdate != true,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 36),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white.withOpacity(0.2),
                      ),
                      padding: const EdgeInsets.all(4),
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
