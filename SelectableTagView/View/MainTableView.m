//
//  ExpandableTableView.m
//  DoubleExpandTableViewDemo
//
//  Created by XKQ on 2019/9/28.
//  Copyright © 2019 董志玮. All rights reserved.
//
/**
 expandStatusDictionary 只在tableview维护状态，cell内部不记录展开或者收起
 
 */

#import "MainTableView.h"
#import "ExpandableTableViewCell.h"
#import "TagViewTableViewCell.h"
#import "TagView.h"
#import "TagSectionViewController.h"
#import "TableViewCellCenterTextLabel.h"

static NSString *const tagCellIdentifier = @"tagCellIdentifier";
static NSString *const expandCellIdentifier = @"expandCellIdentifier";
static NSString *const cellIdentifier = @"cellIdentifier";


@interface MainTableView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray<NSDictionary<NSString *, NSArray<ExperienceModel *>*>*> *expandableModelArray;
@property (nonatomic, assign) BOOL tableExpand;
@property (nonatomic, strong) NSMutableDictionary *expandStatusDictionary;

@end

@implementation MainTableView

- (void)dealloc {
    
}

- (instancetype)initWithExperienceModel:(NSArray<NSDictionary<NSString *, NSArray<ExperienceModel *>*>*> *)modelArray {
    self = [super initWithFrame:CGRectZero style:UITableViewStylePlain];
    if (self) {
        self.expandableModelArray = modelArray;
        self.expandStatusDictionary = @{}.mutableCopy;
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}

//Tag View
- (NSArray<TagInfoModel *> *)selectedTagArray {
    return [SelectedTagModel sharedInstance].selectedTagArray;
}

//Expandable Table View
- (NSArray<ExperienceModel *> *)singleModelArrayWithIndex:(NSUInteger)index {
    NSDictionary *modelDict = self.expandableModelArray[index];
    NSArray *modelArray = modelDict.allValues[0];
    return modelArray;
}

- (BOOL)isExpandCellAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *modelArray = [self singleModelArrayWithIndex:indexPath.section - 1];
    BOOL isExpandCell;
    if (self.tableExpand) {
        isExpandCell = indexPath.row == modelArray.count;
    } else {
        if (modelArray.count > 3) {
            isExpandCell = indexPath.row == 3;
        } else {
            isExpandCell = NO;
        }
    }
    return isExpandCell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UITableViewHeaderFooterView *header = [self dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    if (!header) {
        header = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"header"];
    }
    if (section == 0) {
        header.textLabel.text = @"标签";
        return header;
    } else {
        NSDictionary *dataDict = self.expandableModelArray[section - 1];
        header.textLabel.text = dataDict.allKeys[0];
        return header;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else {
        NSUInteger count = [self singleModelArrayWithIndex:section - 1].count;
        if (count > 3 && !self.tableExpand) {
            return 4;
        }
        return count + 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WEAKSELF;
    if (indexPath.section == 0) {
        TagViewTableViewCell *tagCell = [tableView dequeueReusableCellWithIdentifier:tagCellIdentifier];
        if (tagCell == nil) {
            tagCell = [[TagViewTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tagCellIdentifier];
        }
        [tagCell configCellWithTagArray:[self selectedTagArray]];
        return tagCell;
    } else {
        
        NSArray *modelArray = [self singleModelArrayWithIndex:indexPath.section - 1];
        NSUInteger count = self.tableExpand ? modelArray.count : 3;
        if (indexPath.row < count) {
            ExpandableTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = [[ExpandableTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            }
            
            [cell configureCellWithModel:modelArray[indexPath.row] isExpand:[[self.expandStatusDictionary objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]] boolValue]];
            
            cell.expandBlock = ^(ExpandableTableViewCell *cell) {
                NSIndexPath *indexPath = [weakSelf indexPathForCell:cell];
                BOOL expand = ![[weakSelf.expandStatusDictionary objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]] boolValue];
                [weakSelf.expandStatusDictionary setObject:@(expand) forKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
                [weakSelf reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                [weakSelf scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
            };
            return cell;
        }
        if (indexPath.row == count && modelArray.count > 3) {
            TableViewCellCenterTextLabel *expandCell = [tableView dequeueReusableCellWithIdentifier:expandCellIdentifier];
            if (expandCell == nil) {
                expandCell = [[TableViewCellCenterTextLabel alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:expandCellIdentifier];
            }
            expandCell.textLabel.textAlignment = NSTextAlignmentCenter;
            expandCell.textLabel.text = self.tableExpand ? @"收起" : @"展开全部 ";
            expandCell.textLabel.textColor = [UIColor blueColor];
            return expandCell;
        }
#warning can we do this?
        return [UITableViewCell new];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        TagSectionViewController *vc = [[TagSectionViewController alloc] initWithSelectedModelArray:[self selectedTagArray]];
        [[self viewController].navigationController pushViewController:vc animated:YES];
    } else {
        if ([self singleModelArrayWithIndex:indexPath.section - 1].count > 3 && [self isExpandCellAtIndexPath:indexPath]) {
            self.tableExpand = !self.tableExpand;
            [self reloadData];
            if ([tableView numberOfSections] > indexPath.section && [tableView numberOfRowsInSection:indexPath.section] > 0) {
                [self scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.section] atScrollPosition:UITableViewScrollPositionTop animated:NO];
            }
            return;
        }
//        self.cellClickBlock();
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [TagView heightForTagViewWithTagArray:[self selectedTagArray] tagFont:[UIFont systemFontOfSize:15]];
    } else {
        if ([self isExpandCellAtIndexPath:indexPath]) {
            return 60;
        }
        if (indexPath.row < [self singleModelArrayWithIndex:indexPath.section - 1].count) {
            return [ExpandableTableViewCell cellHeightWithModel:[self singleModelArrayWithIndex:indexPath.section - 1][indexPath.row] isExpand:[[self.expandStatusDictionary objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]] boolValue]];
        }
        return 0;
    }
}

@end
