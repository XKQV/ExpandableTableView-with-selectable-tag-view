//
//  TagInfoModel.m
//  SelectableTagView
//
//  Created by 董志玮 on 2019/9/29.
//  Copyright © 2019 董志玮. All rights reserved.
//

#import "TagInfoModel.h"

@implementation TagInfoModel

- (id)copyWithZone:(NSZone *)zone {
    id json = [self yy_modelToJSONObject];
    TagInfoModel *model = [TagInfoModel yy_modelWithJSON:json];
    return model;
}



@end
