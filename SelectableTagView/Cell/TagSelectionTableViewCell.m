//
//  TagSelectionTableViewCell.m
//  SelectableTagView
//
//  Created by 董志玮 on 2019/9/29.
//  Copyright © 2019 董志玮. All rights reserved.
//

#import "TagSelectionTableViewCell.h"

@interface TagSelectionTableViewCell ()

@property (nonatomic, strong) UIButton *addButton;

@end

@implementation TagSelectionTableViewCell

- (void)dealloc {
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setupCellWithTitle:(NSString *)title isAdd:(BOOL)isAdd {
    self.textLabel.text = title;
    self.addButton.layer.borderWidth = 1.f;
    [self refreshButtonWithAdd:isAdd];
    [self.addButton addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.addButton];
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@50);
        make.height.equalTo(@20);
        make.trailing.equalTo(self.mas_trailing).offset(-15);
        make.centerY.equalTo(self.mas_centerY);
    }];
}

- (void)refreshButtonWithAdd:(BOOL)isAdd {
    [self.addButton setTitle:isAdd ? @"添加" : @"已添加" forState:UIControlStateNormal];
    self.addButton.enabled = isAdd ? YES : NO;
    [self.addButton setTitleColor:(isAdd ? [UIColor blueColor] : [UIColor lightGrayColor]) forState:UIControlStateNormal];
    self.addButton.layer.borderColor = isAdd ? [UIColor blueColor].CGColor : [UIColor lightGrayColor].CGColor;
}

- (UIButton *)addButton {
    if (_addButton == nil) {
        _addButton = [UIButton buttonWithType:UIButtonTypeSystem];
    }
    return _addButton;
}

- (void)buttonClicked {
    if (self.addTagBlock) {
        self.addTagBlock(self);
    }
}


@end
