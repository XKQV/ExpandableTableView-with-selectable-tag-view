//
//  ExpandableTableView.h
//  DoubleExpandTableViewDemo
//
//  Created by XKQ on 2019/9/28.
//  Copyright © 2019 董志玮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExperienceModel.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^ExpandableTableViewBlock)(void);

@interface MainTableView : UITableView

- (instancetype)initWithExperienceModel:(NSArray<NSDictionary<NSString *, NSArray<ExperienceModel *>*>*> *)modelArray;

@property (nonatomic, copy) ExpandableTableViewBlock cellClickBlock;

@end

NS_ASSUME_NONNULL_END
