//
//  TagViewTableViewCell.m
//  SelectableTagView
//
//  Created by 董志玮 on 2019/9/29.
//  Copyright © 2019 董志玮. All rights reserved.
//

#import "TagViewTableViewCell.h"
#import "TagView.h"

@interface TagViewTableViewCell ()

@property (nonatomic, strong) TagView *tagView;

@end

@implementation TagViewTableViewCell

- (void)dealloc {
    
}

//TagView
- (TagView *)tagView {
    if (!_tagView) {
        _tagView = [TagView new];
        [self addSubview:_tagView];
        _tagView.layer.borderColor = [UIColor blueColor].CGColor;
        _tagView.layer.borderWidth = 1.f;
        [_tagView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.leading.bottom.trailing.equalTo(self);
        }];
    }
    return _tagView;
}

- (void)configCellWithTagArray:(NSArray<TagInfoModel *> *)tagArray {
    if (tagArray) {
        self.tagView.selectedTagArray = tagArray;
    }
}



@end
