//
//  ExpandableTableViewCell.m
//  DoubleExpandTableViewDemo
//
//  Created by 董志玮 on 2019/9/26.
//  Copyright © 2019 董志玮. All rights reserved.
//

#import "ExpandableTableViewCell.h"

@interface ExpandableTableViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *experienceLabel;
@property (nonatomic, strong) UIButton *expandButton;
@property (nonatomic, assign) BOOL isExpand;

@end

@implementation ExpandableTableViewCell

- (void)dealloc {
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)configureCellWithModel:(ExperienceModel *)model isExpand:(BOOL)expand {
    self.titleLabel.text = model.title;
    self.experienceLabel.text = model.experience;
    if ([self showExpandWithModel:model]) {
        [self.expandButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@20);
        }];
        self.isExpand = expand;
    } else {
        [self.expandButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0);
        }];
    }
}

- (void)expandButtonClicked {
    self.isExpand = !self.isExpand;
    self.expandBlock(self);
}

- (void)setIsExpand:(BOOL)isExpand {
    if (isExpand) {
        self.experienceLabel.numberOfLines = 0;
        [self.expandButton setTitle:@"收起" forState:UIControlStateNormal];
    } else {
        self.experienceLabel.numberOfLines = 2;
        [self.expandButton setTitle:@"展开" forState:UIControlStateNormal];
    }
}

- (BOOL)showExpandWithModel:(ExperienceModel *)model {
    CGSize sizeToFit = [ExpandableTableViewCell sizeToFitText:model.experience];
    if (sizeToFit.height > 20 * 2) {
        self.expandButton.hidden = NO;
        self.isExpand = YES;
        return YES;
    } else {
        self.expandButton.hidden = YES;
        self.isExpand = NO;
        return NO;
    }
}

+ (CGSize)sizeToFitText:(NSString *)text {
    CGSize sizeToFit = [text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16]} context:nil].size;
    return sizeToFit;
}

+ (CGFloat)cellHeightWithModel:(ExperienceModel *)model isExpand:(BOOL)expand {
    CGFloat height = 30; //top and bottom space
    height += 5; //vertical space
    height += 20; //title label
    CGFloat heightToFit = [ExpandableTableViewCell sizeToFitText:model.experience].height;
    if (heightToFit > 20 * 2) {
        if (expand) {
            height += ceil(heightToFit) + 1;
        } else {
            height += 20 * 2;
        }
        height += 20; //expand button
        height += 5; //vertical space
    } else {
        height += heightToFit;
    } //experience label
    return height;
}


- (void)setupSubviews {
    UILabel *titleLabel = [UILabel new];
    [self.contentView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.equalTo(@15);
        make.height.equalTo(@20);
        make.trailing.equalTo(@-15);
    }];
    self.titleLabel = titleLabel;
    
    UILabel *experienceLabel = [UILabel new];
    experienceLabel.numberOfLines = 2;
    experienceLabel.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:experienceLabel];
    [experienceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(5);
        make.leading.equalTo(@15);
        make.trailing.equalTo(@-15);
    }];
    self.experienceLabel = experienceLabel;
    
    UIButton *expandButton = [UIButton new];
    expandButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [expandButton setTitle:@"展开" forState:UIControlStateNormal];
    expandButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [expandButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [expandButton addTarget:self action:@selector(expandButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:expandButton];
    [expandButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(experienceLabel.mas_bottom).offset(5);
        make.leading.equalTo(experienceLabel.mas_leading);
        make.width.equalTo(@50);
        make.height.equalTo(@20);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-15);
    }];
    self.expandButton = expandButton;
    
}

@end
