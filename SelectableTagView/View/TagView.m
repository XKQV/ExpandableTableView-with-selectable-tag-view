//
//  TagView.m
//  SelectableTagView
//
//  Created by 董志玮 on 2019/9/29.
//  Copyright © 2019 董志玮. All rights reserved.
//

#import "TagView.h"
#import "UIButton+EnlargeClickRegion.h"
#define maxWidth kScreenWidth - 30
#define verticalSpace 10
#define horizontalSpace 10

@interface TagView ()

@end

@implementation TagView

- (void)dealloc {
    
}

- (void)setupViewWithTagArray:(NSArray<TagInfoModel *> *)tagArray Font:(UIFont *)font {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    UIView *containerView = [UIView new];
    [self addSubview:containerView];
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(verticalSpace));
        make.bottom.equalTo(@0);
        make.leading.equalTo(self).offset(15);
        make.trailing.equalTo(self).offset(-15);
    }];
    
    __block CGFloat originX = 0;
    __block CGFloat originY = 0;
    [tagArray enumerateObjectsUsingBlock:^(TagInfoModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat width = [TagView sizeForOneLabelWithTag:obj.title tagFont:font].width;
        CGFloat height = [TagView sizeForOneLabelWithTag:obj.title tagFont:font].height;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(originX, originY, width, height)];
        originX += width + horizontalSpace;
        if (originX > maxWidth) {
            originX = 0;
            originY += height + verticalSpace; // next line
            label.frame = CGRectMake(originX, originY, width, height);
            originX += width + horizontalSpace;
        }
        label.text = obj.title;
        label.font = font;
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.8];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didSelectTag:)];
        [label addGestureRecognizer:tapGesture];
        label.userInteractionEnabled = YES;
        [containerView addSubview:label];
        
        //delete button
        UIButton *deleteBtton = [UIButton buttonWithType:UIButtonTypeInfoDark];
        [deleteBtton addTarget:self action:@selector(deleteSelectedTag:) forControlEvents:UIControlEventTouchUpInside];
        [label addSubview:deleteBtton];
        [deleteBtton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.equalTo(@10);
            make.top.equalTo(@-5);
            make.trailing.equalTo(@5);
        }];
        [label bringSubviewToFront:deleteBtton];
        
        
    }];
}

+ (CGFloat)heightForTagViewWithTagArray:(NSArray<TagInfoModel *> *)array tagFont:(UIFont *)font {
    if (array.count == 0) {
        return 50;
    }
    __block CGFloat oneLineTotalWidth;
    
    __block NSUInteger numberOfLines = 1;
       [array enumerateObjectsUsingBlock:^(TagInfoModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           CGFloat width = [TagView sizeForOneLabelWithTag:obj.title tagFont:font].width;
           oneLineTotalWidth += width + horizontalSpace;
           if (oneLineTotalWidth > maxWidth) {
               oneLineTotalWidth = width + horizontalSpace;
               numberOfLines += 1;
           }
       }];
    TagInfoModel *model = (TagInfoModel *)array[0];
    CGFloat oneLineHeight = [TagView sizeForOneLabelWithTag:model.title tagFont:font].height;
    return (oneLineHeight + verticalSpace) * numberOfLines + verticalSpace;
}

+ (CGSize)sizeForOneLabelWithTag:(NSString *)string tagFont:(UIFont *)font {
    CGSize size = [string boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil].size;
    size = CGSizeMake(size.width + horizontalSpace * 2, size.height + verticalSpace);
    return size;
}

- (void)setSelectedTagArray:(NSArray<TagInfoModel *> *)tagArray {
    _selectedTagArray = tagArray;
    [self setupViewWithTagArray:tagArray Font:[UIFont systemFontOfSize:15]];
}

- (void)didSelectTag:(UIGestureRecognizer *)sender {
    if (self.selectedTag) {
        UIView *view = sender.view;
        if ([view isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *)view;
            self.selectedTag(label.text);
        }
    }
}

- (void)deleteSelectedTag:(UIGestureRecognizer *)sender {
    if (self.deletedTag) {
        UIButton *button = (UIButton *)sender;
        UIView *view = button.superview;
        if ([view isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *)view;
            self.deletedTag(label.text);
        }
    }
}


@end

