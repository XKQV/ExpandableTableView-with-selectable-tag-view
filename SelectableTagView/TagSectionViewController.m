//
//  ViewController.m
//  SelectableTagView
//
//  Created by 董志玮 on 2019/9/29.
//  Copyright © 2019 董志玮. All rights reserved.
//

#import "TagSectionViewController.h"
#import "TagSelectionTableView.h"
#import "TagView.h"
#import "TagInfoModel.h"

@interface TagSectionViewController ()
@property (nonatomic, strong) TagView *tagView;
@property (nonatomic, strong) TagSelectionTableView *tagSelectiontableView;
@property (nonatomic, strong) NSArray <TagInfoModel *> *selectedArray;

@end

@implementation TagSectionViewController

- (void)dealloc {
    
}

- (instancetype)initWithSelectedModelArray:(NSArray <TagInfoModel *> *)modelArray {
    self = [super init];
    if (self) {
        self.selectedArray = modelArray;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.translucent = NO;
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveSelectedTag)];
    self.navigationItem.rightBarButtonItem = rightItem;
    [self setupTagView];
    [self setupTableView];
}

- (void)saveSelectedTag {
    [SelectedTagModel sharedInstance].selectedTagArray = self.tagView.selectedTagArray;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setupTagView {
    WEAKSELF;
    TagView *tagView = [TagView new];
    tagView.selectedTagArray = self.selectedArray;
    [self.view addSubview:tagView];
    tagView.layer.borderColor = [UIColor blueColor].CGColor;
    tagView.layer.borderWidth = 1.f;
    CGFloat tagViewHeight = [TagView heightForTagViewWithTagArray:tagView.selectedTagArray tagFont:[UIFont systemFontOfSize:15]];
    [tagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(self.view);
        make.height.equalTo(@(tagViewHeight));
    }];
    tagView.selectedTag = ^(NSString * tag) {
        NSLog(@"selected tag is %@", tag);
    };
    tagView.deletedTag = ^(NSString * tag) {
        NSLog(@"deleted tag is %@", tag);
        
        NSMutableArray *selectedArray = weakSelf.selectedArray.mutableCopy;
        for (TagInfoModel *model in selectedArray) {
            if ([model.title isEqualToString:tag]) {
                [selectedArray removeObject:model];
                break;
            }
        }
        weakSelf.selectedArray = selectedArray.copy;
        weakSelf.tagView.selectedTagArray = weakSelf.selectedArray;
        weakSelf.tagSelectiontableView.allTagArray = [weakSelf allModelArray];
        [weakSelf.tagSelectiontableView reloadData];
        
        CGFloat tagViewHeight = [TagView heightForTagViewWithTagArray:weakSelf.selectedArray tagFont:[UIFont systemFontOfSize:15]];
        [weakSelf.tagView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(tagViewHeight));
        }];
    };
    self.tagView = tagView;
}

- (void)setupTableView {
    WEAKSELF;
    self.tagSelectiontableView = [[TagSelectionTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tagSelectiontableView.allTagArray = [self allModelArray];
    [self.view addSubview:self.tagSelectiontableView];
    self.tagSelectiontableView.layer.borderColor = [UIColor blueColor].CGColor;
    self.tagSelectiontableView.layer.borderWidth = 1.f;
    [self.tagSelectiontableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tagView.mas_bottom).offset(30);
        make.leading.bottom.trailing.equalTo(@0);
    }];
    self.tagSelectiontableView.addTagBlock = ^(TagInfoModel * modelToBeAdded) {
        NSMutableArray *addedArray = [NSMutableArray arrayWithArray:weakSelf.tagView.selectedTagArray];
        [addedArray addObject:modelToBeAdded];
        weakSelf.tagView.selectedTagArray = addedArray.copy;
        weakSelf.selectedArray = addedArray.copy;
        
        CGFloat tagViewHeight = [TagView heightForTagViewWithTagArray:addedArray.copy tagFont:[UIFont systemFontOfSize:15]];
        [weakSelf.tagView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(tagViewHeight));
        }];
    };
}

- (NSArray *)allModelArray {
    NSMutableArray *modelArray = @[].mutableCopy;
    NSArray *allModelArray;
    
    if (self.selectedArray.count == 0) {
        [[self tagArray] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            TagInfoModel *model = [TagInfoModel yy_modelWithDictionary:obj];
            [modelArray addObject:model];
        }];
        allModelArray = modelArray.copy;
        [SelectedTagModel sharedInstance].allTagArray = allModelArray;
    } else {
        allModelArray = [SelectedTagModel sharedInstance].allTagArray;
#warning double loop
        NSUInteger match = 0;
        NSMutableArray *temSelectedArray = self.selectedArray.mutableCopy;
        for (TagInfoModel *allModel in allModelArray) {
            allModel.add = YES;
            if (match < self.selectedArray.count) {
                for (TagInfoModel *selectedModel in temSelectedArray) {
                    if ([allModel.title isEqualToString:selectedModel.title]) {
                        allModel.add = selectedModel.add;
                        [temSelectedArray removeObject:selectedModel];
                        match ++;
                        break;
                    }
                }
            }
        }
    }
    return allModelArray;
}

- (NSArray *)tagArray {
    return @[
             @{@"title" : @"安装", @"add" : @"1"},
             @{@"title" : @"保险", @"add" : @"1"},
             @{@"title" : @"报警设备，器材", @"add" : @"1"},
             @{@"title" : @"不锈钢材料加工销售", @"add" : @"1"},
             @{@"title" : @"安装安装", @"add" : @"1"},
             @{@"title" : @"保险保险", @"add" : @"1"},
             @{@"title" : @"报警设备，器材，器材", @"add" : @"1"},
             @{@"title" : @"不锈钢材料加工销售，售后", @"add" : @"1"},
             @{@"title" : @"安装，维护", @"add" : @"1"},
             @{@"title" : @"保险，保障", @"add" : @"1"},
             @{@"title" : @"报警设备，器材，材料", @"add" : @"1"},
             @{@"title" : @"不锈钢材料加工销售，回收", @"add" : @"1"},
             @{@"title" : @"1安装", @"add" : @"1"},
             @{@"title" : @"2保险", @"add" : @"1"},
             @{@"title" : @"3报警设备，器材", @"add" : @"1"},
             @{@"title" : @"4不锈钢材料加工销售", @"add" : @"1"},
             @{@"title" : @"5安装安装", @"add" : @"1"},
             @{@"title" : @"6保险保险", @"add" : @"1"},
             @{@"title" : @"7报警设备，器材，器材", @"add" : @"1"},
             @{@"title" : @"8不锈钢材料加工销售，售后", @"add" : @"1"},
             @{@"title" : @"9安装，维护", @"add" : @"1"},
             @{@"title" : @"10保险，保障", @"add" : @"1"},
             @{@"title" : @"11报警设备，器材，材料", @"add" : @"1"},
             @{@"title" : @"12不锈钢材料加工销售，回收", @"add" : @"1"},
             ];
}


@end
