//
//  ViewController.m
//  DoubleExpandTableViewDemo
//
//  Created by 董志玮 on 2019/9/25.
//  Copyright © 2019 董志玮. All rights reserved.
//

#import "MainViewController.h"
#import "MainTableView.h"
#import "ExperienceModel.h"


@interface MainViewController ()

@property (nonatomic, strong) UITableView *tableview;
@end

@implementation MainViewController

- (void)dealloc {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    WEAKSELF;
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.translucent = NO;
    
    MainTableView *tableview = [[MainTableView alloc] initWithExperienceModel:[self modelArray]];
    tableview.cellClickBlock = ^{
        MainViewController *vc = [MainViewController new];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    [self.view addSubview:tableview];
    [tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.tableview = tableview;
}

- (void)viewWillAppear:(BOOL)animated {
    [self.tableview reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (NSArray<NSDictionary<NSString *, NSArray<ExperienceModel *>*>*> *)modelArray {
    ExperienceModel *smallModel = [ExperienceModel new];
    smallModel.title = @"1";
    smallModel.experience = @"抽象工厂";
    
    ExperienceModel *mediumModel = [ExperienceModel new];
    mediumModel.title = @"2";
    mediumModel.experience = @"抽象工厂模式提供一个固定的接口,用于创建一系列有关联或相依存的对象,而不必指定其具体类或其创建的细节.";
    
    ExperienceModel *largeModel = [ExperienceModel new];
    largeModel.title = @"3";
    largeModel.experience = @"通过上面类图所示, Client只知道Abstract Factory和Abstract Product.每个工厂类中,结构与实际操作的细节按黑箱对待.甚至产品也不知道谁将负责创建它们.只有具体的工厂知道为客户端创建什么,如何创建.这个模式有一个有趣点是,很多时候它都是用,甚至产品也不知道谁将负责创建它们.甚至产品也不知道谁将负责创建它们作的细节按黑箱对待.甚至产品也不知道谁将负责创建它们.只有具体的工厂知道为客户端创建什么,如何创建.这个模式有一个有趣点是,很多时候它都是用,甚至产品也不知道谁将负责创建它们.";
    
    ExperienceModel *largeModel4 = [ExperienceModel new];
    largeModel4.title = @"4";
    largeModel4.experience = @"通过上面类图所示, Client只知道Abstract Factory和Abstract Product.每个工厂类中,结构与实际操作的细节按黑箱对待.甚至产品也不知道谁将负责创建它们.只有具体的工厂知道为客户端创建什么,如何创建.这个模式有一个有趣点是,很多时候它都是用,甚至产品也不知道谁将负责创建它们.甚至产品也不知道谁将负责创建它们.";
    
    ExperienceModel *largeModel5 = [ExperienceModel new];
    largeModel5.title = @"5";
    largeModel5.experience = @"通过上面类图所示, Client只知道Abstract Factory和Abstract Product.每个工厂类中,结构与实际操作的细节按黑箱对待.甚至产品也不知道谁将负责创建它们.只有具体的工厂知道为客户端创建什么,如何创建.这个模式有一个有趣点是,很多时候它都是用,甚至产品也不知道谁将负责创建它们.甚至产品也不知道谁将负责创建它们.";
    
    NSArray *modelArray = @[
        @{
            @"可展开Table" : @[smallModel, mediumModel, largeModel, smallModel, largeModel4, largeModel5]
        },
        //                        @{
        //                            @"Section 2" : @[smallModel, mediumModel, largeModel, smallModel, largeModel4, largeModel5]
        //                            },
        //                        @{
        //                            @"Section 3" : @[smallModel, mediumModel, largeModel, smallModel, largeModel4, largeModel5]
        //                            },
    ];
    
    return modelArray;
}

@end
