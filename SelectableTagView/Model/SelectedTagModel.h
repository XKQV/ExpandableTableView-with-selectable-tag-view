//
//  SelectedTagModel.h
//  SelectableTagView
//
//  Created by XKQ on 2019/9/29.
//  Copyright © 2019 董志玮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TagInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SelectedTagModel : NSObject

+ (instancetype)sharedInstance;
@property (nonatomic, strong) NSArray<TagInfoModel *> *selectedTagArray;
@property (nonatomic, strong) NSArray<TagInfoModel *> *allTagArray;

@end

NS_ASSUME_NONNULL_END
