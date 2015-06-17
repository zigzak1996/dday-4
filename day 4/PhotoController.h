//
//  PhotoController.h
//  day 4
//
//  Created by Student on 17.06.15.
//  Copyright (c) 2015 Student. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PhotoController : NSObject
+(void)imageForPhoto: (NSDictionary *)photo size: (NSString *)size completion: (void(^) (UIImage *image))completion;

@end
