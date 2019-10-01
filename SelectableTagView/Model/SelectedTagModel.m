//
//  SelectedTagModel.m
//  SelectableTagView
//
//  Created by XKQ on 2019/9/29.
//  Copyright © 2019 董志玮. All rights reserved.
//

#import "SelectedTagModel.h"

@interface SelectedTagModel ()

@end

@implementation SelectedTagModel

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static id instance;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}


@end
