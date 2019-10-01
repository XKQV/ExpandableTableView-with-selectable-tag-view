//
//  TagSelectionTableViewCell.h
//  SelectableTagView
//
//  Created by 董志玮 on 2019/9/29.
//  Copyright © 2019 董志玮. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TagSelectionTableViewCell;
NS_ASSUME_NONNULL_BEGIN
typedef void(^TagSelectionCellAddBlock)(TagSelectionTableViewCell *);

@interface TagSelectionTableViewCell : UITableViewCell

- (void)setupCellWithTitle:(NSString *)title isAdd:(BOOL)isAdd;
- (void)refreshButtonWithAdd:(BOOL)isAdd;

@property (nonatomic, copy) TagSelectionCellAddBlock addTagBlock;
    
@end

NS_ASSUME_NONNULL_END
