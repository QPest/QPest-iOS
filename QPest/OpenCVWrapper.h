//
//  OpenCVWrapper.h
//  QPest
//
//  Created by Danilo Mendes on 10/15/16.
//  Copyright © 2016 Henrique Dutra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface OpenCVWrapper : NSObject

// Convert image to grayscale
+ (UIImage *) rgbToGrayScaleFromImage: (UIImage *) image;

// Convert image to HSV
+ (UIImage *) rgbToHSVFromImage: (UIImage *) image;

// Detect object, returning image with rect
+ (UIImage *) detectCascade: (UIImage *) image withCascade: (NSString *) path;

// Detect object, returning boolean
+ (BOOL) cascadeDetected: (UIImage *) image withCascade: (NSString *) path;

@end
