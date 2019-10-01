//
//  ExpandableTableViewCell.h
//  DoubleExpandTableViewDemo
//
//  Created by 董志玮 on 2019/9/26.
//  Copyright © 2019 董志玮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExperienceModel.h"
@class ExpandableTableViewCell;

typedef void(^expandButtonBlock)(ExpandableTableViewCell *);

@interface ExpandableTableViewCell : UITableViewCell

+ (CGFloat)cellHeightWithModel:(ExperienceModel *)model isExpand:(BOOL)expand;

- (void)configureCellWithModel:(ExperienceModel *)model isExpand:(BOOL)expand;

@property (nonatomic, copy) expandButtonBlock expandBlock;

@end
