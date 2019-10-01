//
//  TagSelectionTableView.h
//  SelectableTagView
//
//  Created by 董志玮 on 2019/9/29.
//  Copyright © 2019 董志玮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TagInfoModel.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^TagSelectionTableSelectedTagBlock)(TagInfoModel *);
@interface TagSelectionTableView : UITableView

@property (nonatomic, strong) NSArray *allTagArray;
@property (nonatomic, copy) TagSelectionTableSelectedTagBlock addTagBlock;

@end

NS_ASSUME_NONNULL_END
