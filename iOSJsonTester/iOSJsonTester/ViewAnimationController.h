//
//  ViewAnimationController.h
//  Swag
//
//  Created by Adam Chin on 12/16/15.
//  Copyright © 2015 HushBox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewAnimationController : NSObject <UIViewControllerAnimatedTransitioning>
@property (nonatomic, assign, getter = isAppearing) BOOL appearing;

@end
