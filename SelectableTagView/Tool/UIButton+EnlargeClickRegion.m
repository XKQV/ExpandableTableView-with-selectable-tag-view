//
//  UIButton+EnlargeClickRegion.m
//  SelectableTagView
//
//  Created by XKQ on 2019/9/30.
//  Copyright © 2019 董志玮. All rights reserved.
//

#import "UIButton+EnlargeClickRegion.h"

@implementation UIButton (EnlargeClickRegion)

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent*)event
{
    CGRect bounds = self.bounds;
    //若原热区小于44x44，则放大热区，否则保持原大小不变
    CGFloat widthDelta = MAX(44.0 - bounds.size.width, 0);
    CGFloat heightDelta = MAX(44.0 - bounds.size.height, 0);
    bounds = CGRectInset(bounds, -0.5 * widthDelta, -0.5 * heightDelta);
    return CGRectContainsPoint(bounds, point);
}

@end
