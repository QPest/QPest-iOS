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
    // Begin context with size for image without alpha channel and
    // with the current device scale factor (change for retina to non-retina)
    UIGraphicsBeginImageContextWithOptions(newSize, YES, 0.0f);
    
    CGRect newImageFrame = CGRectMake(0, 0, newSize.width, newSize.height);
    // Draw the image in the frame automatically resizing it
    [image drawInRect: newImageFrame];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
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
        // If already gray scale, do nothing
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
        int width = objects[i].width + objects[i].x;
        int height = objects[i].height + objects[i].y;
        
        CGFloat x = objects[i].x;
        CGFloat y = objects[i].y;
        
        cv::Point topLeftPoint(x, y);
        cv::Size size(width,height);
        cv::Scalar color = cv::Scalar(0, 0, 255);
        cv::rectangle(imageMat, topLeftPoint, size, color, 2);
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
    
    if (objects.size() > 0){
        objectDetected = YES;
    }
    
    return objectDetected;
}


@end
