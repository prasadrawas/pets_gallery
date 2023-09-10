import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pets_app/constants/string_constants.dart';
import 'package:pets_app/styles/text_styles.dart';

class PetCard extends StatefulWidget {
  final String name;
  final String description;
  final String imageUrl;
  final String age;
  final String color;
  final VoidCallback? onPressed;

  const PetCard({
    Key? key,
    this.onPressed,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.age,
    required this.color,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PetCardState createState() => _PetCardState();
}

class _PetCardState extends State<PetCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    double imageWidth = 80.0; // Default image size

    // Adjust image size based on screen width
    if (screenWidth >= 600 && screenWidth < 1200) {
      // Medium screen
      imageWidth = 120.0;
    } else if (screenWidth >= 1200) {
      // Large screen
      imageWidth = 160.0;
    }

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 100 * (1 - _animation.value)), // Adjust Y offset
          child: Opacity(
            opacity: _animation.value, // Adjust opacity
            child: GestureDetector(
              onTap: widget.onPressed,
              child: Card(
                color: Colors.white,
                surfaceTintColor: Colors.white,
                elevation: 2.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Center(
                      child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: widget.imageUrl,
                          width: imageWidth,
                          height: imageWidth,
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.name,
                            style: AppTextStyles.medium(fontSize: 14),
                          ),
                          const SizedBox(height: 1),
                          Text(
                            widget.description,
                            maxLines: 1,
                            style: AppTextStyles.extraLight(fontSize: 12),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          RichText(
                            text: TextSpan(
                              style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                TextSpan(
                                  text: '${StringConstants.color}: ',
                                  style: AppTextStyles.medium(fontSize: 12),
                                ),
                                TextSpan(
                                  text: widget.color,
                                  style: AppTextStyles.extraLight(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 1),
                          RichText(
                            text: TextSpan(
                              style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                TextSpan(
                                  text: '${StringConstants.age}: ',
                                  style: AppTextStyles.medium(fontSize: 12),
                                ),
                                TextSpan(
                                  text: widget.age,
                                  style: AppTextStyles.extraLight(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
