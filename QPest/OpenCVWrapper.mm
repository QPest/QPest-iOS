//
//  OpenCVWrapper.mm
//  QPest
//
//  Created by Danilo Mendes on 10/15/16.
//  Copyright © 2016 Henrique Dutra. All rights reserved.
//

#import "OpenCVWrapper.h"
#import <opencv2/opencv.hpp>
#import <opencv2/imgcodecs/ios.h>
#import <iostream>

@implementation OpenCVWrapper

+ (UIImage *)resizeImage:(UIImage*)image newSize:(CGSize)newSize {
    CGRect newRect = CGRectIntegral(CGRectMake(0, 0, newSize.width, newSize.height));
    CGImageRef imageRef = image.CGImage;
    
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Set the quality level to use when rescaling
    CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
    CGAffineTransform flipVertical = CGAffineTransformMake(1, 0, 0, -1, 0, newSize.height);
    
    CGContextConcatCTM(context, flipVertical);
    // Draw into the context; this scales the image
    CGContextDrawImage(context, newRect, imageRef);
    
    // Get the resized image from the context and a UIImage
    CGImageRef newImageRef = CGBitmapContextCreateImage(context);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    
    CGImageRelease(newImageRef);
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (UIImage *) rgbToGrayScaleFromImage:(UIImage *)image{
    
    cv::Mat imageMat;
    UIImageToMat(image, imageMat);
    
    if (imageMat.channels() > 1){
        cv::Mat grayscale;
        cv::cvtColor(imageMat, grayscale, CV_BGR2GRAY);
        grayscale.copyTo(imageMat);
        
    } else {
        // do nothing
    }
    
    UIImage *grayScaleImage = MatToUIImage(imageMat);
    
    return grayScaleImage;
    
}

+ (UIImage *) rgbToHSVFromImage:(UIImage *)image{
    
    cv::Mat imageMat;
    UIImageToMat(image, imageMat);
    cv::Mat bgrImageMat;
    
    if (imageMat.channels() > 1){
        cv::cvtColor(imageMat, bgrImageMat, CV_BGR2HSV);
    } else {
        imageMat.copyTo(bgrImageMat);
    }
    
    UIImage *hsvImage = MatToUIImage(bgrImageMat);
    return hsvImage;
}

+ (UIImage *) detectCascade:(UIImage *)image withCascade:(NSString *)path{
    
    // Convert UIImage to CV Mat
    cv::Mat imageMat;
    UIImageToMat(image, imageMat);
    
    // Convert NSString to c_string
    const char *cstringPath = [path UTF8String];
    
    // Start cascade
    cv::CascadeClassifier cascade;
    cascade.load(cstringPath);
    
    std::vector<cv::Rect> objects;
    cascade.detectMultiScale(imageMat, objects, 1.1, 2, 0|CV_HAAR_SCALE_IMAGE, cv::Size(30, 30));
    
    for (int i = 0; i < objects.size(); i++) {
        int width = objects[i].width;// * 0.5;
        int height = objects[i].height;// * 0.5;
        
        CGFloat x = objects[i].x + width;
        CGFloat y = objects[i].y + height;
        
        cv::Point center(x, y);
        cv::Size size(width,height);
        cv::Scalar color = cv::Scalar(0, 50, 0);
        cv::rectangle(imageMat, center, size, color, 2);
        //cv::ellipse(imageMat, center, size, 0, 0, 360, color, 4, 8, 0);
    }
    
    UIImage *resultImage = MatToUIImage(imageMat);
    return resultImage;
}

+ (BOOL) cascadeDetected:(UIImage *)image withCascade:(NSString *)path{
    
    // Convert UIImage to CV Mat
    cv::Mat imageMat;
    UIImageToMat(image, imageMat);
    
    // Convert NSString to c_string
    const char *cstringPath = [path UTF8String];
    
    // Start cascade
    cv::CascadeClassifier cascade;
    cascade.load(cstringPath);
    
    std::vector<cv::Rect> objects;
    cascade.detectMultiScale(imageMat, objects, 1.1, 2, 0|CV_HAAR_SCALE_IMAGE, cv::Size(30, 30));
    
    BOOL objectDetected = NO;
    for (int i = 0; i < objects.size(); i++) {
        objectDetected = YES;
        
        int width = objects[i].width;// * 0.5;
        int height = objects[i].height;// * 0.5;
        
        CGFloat x = objects[i].x + width;
        CGFloat y = objects[i].y + height;
        
        cv::Point center(x, y);
        cv::Size size(width,height);
        cv::Scalar color = cv::Scalar(0, 50, 0);
        cv::rectangle(imageMat, center, size, color, 2);
        //cv::ellipse(imageMat, center, size, 0, 0, 360, color, 4, 8, 0);
    }
    
    return objectDetected;
}


@end
