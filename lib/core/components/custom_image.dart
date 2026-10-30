import 'dart:async';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:camerasync/core/components/custom_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/app_colors.dart';



class CustomImage extends StatelessWidget {
  final double? width;
  final double? height;
  final double? size;
  final String? baseUrl;
  final String? placeHolder;
  final Color? bgColor;
  final BoxFit? fit;
  final double radius;
  final bool oneSideRadius;
  final bool innerShadow;
  final bool isCircle;

  const CustomImage({
    super.key,
    this.width,
    this.height,
    this.size,
    this.placeHolder,
    this.fit,
    this.baseUrl,
    this.radius = 0,
    this.oneSideRadius = false,
    this.innerShadow = false,
    this.isCircle = false,
    this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    final container = Container(
      clipBehavior: Clip.antiAlias,
      width: isCircle ? size : width,
      height: isCircle ? size : height,
      decoration: isCircle
          ? const BoxDecoration(shape: BoxShape.circle)
          : BoxDecoration(
        color: bgColor ?? AppColors.kWhiteColor,
        borderRadius: oneSideRadius
            ? BorderRadius.only(
          bottomLeft: Radius.circular(radius),
          topLeft: Radius.circular(radius),
        )
            : BorderRadius.circular(radius),
      ),
      child: _buildImage(context),
    );

    return container;
  }

  Widget _buildImage(BuildContext context) {
    if (baseUrl != null && baseUrl!.isNotEmpty && baseUrl != "null") {
      if (baseUrl!.startsWith('http')) {
        // ✅ Load network image
        return CachedNetworkImage(
          imageUrl: baseUrl!,
          fit: fit ?? BoxFit.cover,
          color: innerShadow ? Colors.black.withValues(alpha: .3) : null,
          colorBlendMode: innerShadow ? BlendMode.darken : null,
          placeholder: (context, url) => Center(
            child: SizedBox(
              height: 24.r,
              width: 24.r,
              child: const CircularProgressIndicator(),
            ),
          ),
          errorWidget: (context, url, error) => _buildErrorWidget(),
        );
      } else {
        // ✅ Load local asset
        return Image.asset(
          baseUrl!,
          fit: fit ?? BoxFit.cover,
        );
      }
    } else {
      // ✅ Fallback placeholder
      return _buildErrorWidget();
    }
  }

  Widget _buildErrorWidget() {
    if (isCircle) {
      return Container(
        height: size,
        width: size,
        padding: EdgeInsets.all(5.r),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: bgColor ?? Colors.white,
        ),
        child: (placeHolder != null && placeHolder!.isNotEmpty)
            ? CustomSvg(
                icon: placeHolder!,
                fit: fit ?? BoxFit.fill,
              )
            : const SizedBox.shrink(),
      );
    } else {
      return (placeHolder != null && placeHolder!.isNotEmpty)
          ? CustomSvg(
              icon: placeHolder!,
              fit: fit ?? BoxFit.fill,
            )
          : const SizedBox.shrink();
    }
  }
}


class CustomImageUpdate extends StatelessWidget {
  final double? width;
  final double? height;
  final double? size;
  final String? baseUrl;
  final String? placeHolder;
  final Color? bgColor;
  final Color? placeHolderColor;
  final BoxFit? fit;
  final double radius;
  final bool oneSideRadius;
  final bool innerShadow;
  final bool isCircle;
  final bool isPlaceHolderImage;

  const CustomImageUpdate({
    super.key,
    this.width,
    this.height,
    this.size,
    this.placeHolder,
    this.fit,
    this.baseUrl,
    this.radius = 0,
    this.oneSideRadius = false,
    this.innerShadow = false,
    this.isCircle = false,
    this.isPlaceHolderImage = false,
    this.bgColor,
    this.placeHolderColor,
  });
  bool _looksLikeNetwork(String? s) {
    if (s == null || s.isEmpty) return false;
    return s.startsWith('http://') || s.startsWith('https://');
  }

  bool _looksLikeFile(String? s) {
    if (s == null || s.isEmpty) return false;
    return !_looksLikeNetwork(s);
  }

  Future<Widget> _loadFileImageWidget(String path) async {
    final file = File(path);
    if (!await file.exists()) {
      return _buildErrorWidget();
    }

    final provider = FileImage(file);
    final completer = Completer<Widget>();

    final stream = provider.resolve(const ImageConfiguration());
    late final ImageStreamListener listener;

    listener = ImageStreamListener(
          (imageInfo, synchronousCall) {
        stream.removeListener(listener);
        completer.complete(
          Image(
            image: provider,
            fit: fit ?? BoxFit.cover,
            color: innerShadow ? Colors.black.withValues(alpha: .3) : null,
            colorBlendMode: innerShadow ? BlendMode.darken : null,
          ),
        );
      },
      onError: (error, stackTrace) {
        stream.removeListener(listener);
        completer.complete(_buildErrorWidget());
      },
    );

    stream.addListener(listener);
    return completer.future;
  }

  Widget _buildLoadingPlaceholder() {
    return Center(
      child: SizedBox(
        height: 24.r,
        width: 24.r,
        child: const CircularProgressIndicator(
          color: AppColors.kPrimaryColor,
          strokeWidth: 2,
        ),
      ),
    );
  }

  Widget _buildErrorWidget() {
    return isCircle
        ? Container(
      height: size,
      width: size,
      padding: EdgeInsets.all(5.r),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: bgColor ?? Colors.white,
      ),
      child: (placeHolder != null && placeHolder!.isNotEmpty)
          ? CustomSvg(
              icon: placeHolder!,
              color: placeHolderColor ?? Colors.white,
            )
          : const SizedBox.shrink(),
    )
        : isPlaceHolderImage
        ? Container(
      padding: EdgeInsets.all(5.r),
      decoration: BoxDecoration(
        color: bgColor ?? AppColors.kWhiteColor,
        borderRadius: BorderRadius.circular(radius),
        image: (placeHolder != null && placeHolder!.isNotEmpty)
            ? DecorationImage(
                image: AssetImage(
                  placeHolder!,
                ),
              )
            : null,
      ),
    )
        : (placeHolder != null && placeHolder!.isNotEmpty)
            ? CustomSvg(
                icon: placeHolder!,
                fit: fit ?? BoxFit.cover,
              )
            : const SizedBox.shrink();
  }


  @override
  Widget build(BuildContext context) {
    final hasValidBase =
        baseUrl != null && baseUrl!.isNotEmpty && baseUrl != "null";

    Widget imageChild;

    if (hasValidBase && _looksLikeNetwork(baseUrl)) {
      imageChild = CachedNetworkImage(
        imageUrl: baseUrl!,
        imageBuilder: (context, provider) => Image(
          image: provider,
          fit: fit ?? BoxFit.cover,
          color: innerShadow ? Colors.black.withValues(alpha: .3) : null,
          colorBlendMode: innerShadow ? BlendMode.darken : null,
        ),
        placeholder: (context, url) => _buildLoadingPlaceholder(),
        errorWidget: (context, url, error) => _buildErrorWidget(),
        fadeInDuration: const Duration(milliseconds: 150),
        fadeOutDuration: const Duration(milliseconds: 0),
      );
    } else if (hasValidBase && _looksLikeFile(baseUrl)) {
      imageChild = FutureBuilder<Widget>(
        future: _loadFileImageWidget(baseUrl!),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return _buildLoadingPlaceholder();
          return snapshot.data!;
        },
      );
    } else {
      imageChild = _buildErrorWidget();
    }

    return Container(
      clipBehavior: Clip.antiAlias,
      width: isCircle ? size : width,
      height: isCircle ? size : height,
      decoration: isCircle
          ? const BoxDecoration(shape: BoxShape.circle)
          : BoxDecoration(
        color: bgColor ?? AppColors.kWhiteColor,
        borderRadius: oneSideRadius
            ? BorderRadius.only(
          bottomLeft: Radius.circular(radius),
          topLeft: Radius.circular(radius),
        )
            : BorderRadius.circular(radius),
      ),
      child: imageChild,
    );
  }
}
