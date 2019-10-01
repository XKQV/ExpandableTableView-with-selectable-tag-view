//
//  TagViewTableViewCell.h
//  SelectableTagView
//
//  Created by 董志玮 on 2019/9/29.
//  Copyright © 2019 董志玮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TagInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TagViewTableViewCell : UITableViewCell

- (void)configCellWithTagArray:(NSArray<TagInfoModel *> *)tagArray;

@end

NS_ASSUME_NONNULL_END
