//
//  TableViewCellCenterTextLabel.m
//  SelectableTagView
//
//  Created by XKQ on 2019/10/1.
//  Copyright © 2019 董志玮. All rights reserved.
//

#import "TableViewCellCenterTextLabel.h"

@implementation TableViewCellCenterTextLabel

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    self.textLabel.frame = CGRectMake(0, self.textLabel.frame.origin.y, self.frame.size.width, self.textLabel.frame.size.height);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
