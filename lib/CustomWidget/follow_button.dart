import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sr_health_care/Pages/homePage/servicesModel/follow_unfollow_api.dart';
import 'package:sr_health_care/Pages/homePage/servicesModel/post_model_class.dart';
import 'package:sr_health_care/const/colors.dart';

class FollowButton extends StatefulWidget {
  // final bool isFollow;
  final User user;
   final VoidCallback onFollowStatusChange;
  const FollowButton({
    super.key,
    required this.user,
    required this.onFollowStatusChange,
  });

  @override
  State<FollowButton> createState() => _FollowButtonState();
}

class _FollowButtonState extends State<FollowButton> {
  bool isFollowing = false; // Toggle state: true = Following, false = Follow

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isFollowing = widget.user.isFollowing ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (isFollowing) {
          // Open confirmation modal bottom sheet when trying to unfollow
          _showUnfollowConfirmation(context, widget.user.name ?? '', () async {
            final result = await FollowUnfollowApi()
                .UnfollowUser(widget.user.id?.toString() ?? '');
            Navigator.pop(context);
            if (result.$1) {
              setState(() {
                isFollowing = false;
              });
            } else {
              // Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('You have unfollowed the ${widget.user.name}'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          });
        } else {
          final result = await FollowUnfollowApi()
              .followUser(widget.user.id?.toString() ?? '');
          if (result.$1) {
            setState(() {
              isFollowing = true;
            });
          }
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        decoration: BoxDecoration(
          border: Border.all(color: isFollowing ? Colors.green : Colors.blue),
          borderRadius: BorderRadius.circular(8),
          color: isFollowing ? Colors.green : Colors.white,
        ),
        child: Row(
          children: [
            Visibility(
              visible: !isFollowing,
              child: const Icon(
                Icons.add,
                color: Colors.blue,
                size: 12,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              isFollowing ? 'Following' : 'Follow',
              style: GoogleFonts.poppins(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: isFollowing ? Colors.white : Colors.blue,
              ),
            ),
            Visibility(visible: isFollowing, child: const SizedBox(width: 10)),
            Visibility(
              visible: isFollowing,
              child: const Icon(
                Icons.close,
                color: Colors.white,
                size: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to show the modal bottom sheet for unfollow confirmation
  void _showUnfollowConfirmation(
      BuildContext context, String username, void Function() onUnfollow) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          padding:
              const EdgeInsets.only(right: 10, left: 10, bottom: 10, top: 5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 50,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Unfollow $username',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Are you sure you want to unfollow Dr. Manish Rajput? You’ll no longer see updates or posts from this creator in your feed.',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[700],
                ),
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Material(
                        color: Colors.transparent,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: blackColor)),
                          child: Ink(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            child: Text(
                              textAlign: TextAlign.center,
                              'Cancel',
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: buttonColor),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: onUnfollow,
                      // onTap: () {
                      //   setState(() {
                      //     isFollowing = false; // Unfollow the user
                      //   });
                      //   Navigator.pop(context); // Close the bottom sheet
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     SnackBar(
                      //       content: Text(
                      //           'You have unfollowed the ${widget.user.name}'),
                      //       behavior: SnackBarBehavior.floating,
                      //     ),
                      //   );
                      // },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        decoration: BoxDecoration(
                            color: buttonColor,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: blackColor)),
                        child: Text(
                          textAlign: TextAlign.center,
                          'Unfollow',
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: whiteColor),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
