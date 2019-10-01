//
//  TagView.h
//  SelectableTagView
//
//  Created by 董志玮 on 2019/9/29.
//  Copyright © 2019 董志玮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TagInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^tagViewBlock)(NSString *);
typedef void(^tagViewDeleteBlock)(NSString *);

@interface TagView : UIView

+ (CGFloat)heightForTagViewWithTagArray:(NSArray<TagInfoModel *> *)array tagFont:(UIFont *)font;

@property (nonatomic, copy) tagViewBlock selectedTag;
@property (nonatomic, copy) tagViewDeleteBlock deletedTag;
@property (nonatomic, strong) NSArray<TagInfoModel *> *selectedTagArray;

@end

NS_ASSUME_NONNULL_END
