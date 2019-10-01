//
//  TagSelectionTableView.m
//  SelectableTagView
//
//  Created by 董志玮 on 2019/9/29.
//  Copyright © 2019 董志玮. All rights reserved.
//

#import "TagSelectionTableView.h"
#import "TagSelectionTableViewCell.h"


@interface TagSelectionTableView ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation TagSelectionTableView

- (void)dealloc {
    
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allTagArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WEAKSELF;
    static NSString *const identifier = @"cell";
    TagSelectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[TagSelectionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    TagInfoModel *model = self.allTagArray[indexPath.row];
    [cell setupCellWithTitle:model.title isAdd:model.add];
    cell.addTagBlock = ^(TagSelectionTableViewCell * sender) {
#warning send self in a block
        NSIndexPath *indexPath = [weakSelf indexPathForCell:sender];
        NSMutableArray *mutableTagArray = weakSelf.allTagArray.mutableCopy;
        TagInfoModel *model = [(TagInfoModel *)mutableTagArray[indexPath.row] copy] ;
        model.add = !model.add;
        [sender refreshButtonWithAdd:model.add];
        weakSelf.addTagBlock(model.copy);
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
