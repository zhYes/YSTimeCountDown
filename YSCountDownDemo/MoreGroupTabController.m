//
//  MoreGroupTabController.m
//  YSCountDownDemo
//
//  Created by FDC-iOS on 2017/4/21.
//  Copyright © 2017年 meilun. All rights reserved.
//

#import "MoreGroupTabController.h"
#import "moreSectionCell.h"
#import "YSCountDown.h"

@interface MoreGroupTabController ()<UITableViewDataSource>

@property(nonatomic,strong)NSArray *dataListGroup;

@end

@implementation MoreGroupTabController {
    YSCountDown    *countDown;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib * nib = [UINib nibWithNibName:@"moreSectionCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"moreSection"];
    self.tableView.rowHeight = 110;
    
    /// 1.初始化 传入当前视图和数据数组
    countDown = [[YSCountDown alloc] initWith:self.tableView :self.dataListGroup];
}

- (void)dealloc {
    /// 2.销毁
    [countDown destoryTimer];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel * head = [[UILabel alloc] initWithFrame:CGRectZero];
    head.text = [NSString stringWithFormat:@"第%zd组数据",section + 1];
    head.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [head sizeToFit];
    return head;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataListGroup.count;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray * arr = self.dataListGroup[section];
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    moreSectionCell * cell = [tableView dequeueReusableCellWithIdentifier:@"moreSection"];
    cell.subTitleLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    
    
    /// 3.绑定tag
    cell.tag = indexPath.section * 1000 + indexPath.row;
    cell.endTimeLabel.tag = 1314;
    cell.endTimeLabel.text = [countDown countDownWithPER_SEC:indexPath];
    
    
    return cell;
}


// 数据
- (NSArray *)dataListGroup {
    
    NSMutableArray * nmArr;
    if (_dataListGroup == nil) {
        nmArr = [NSMutableArray array];
        _dataListGroup = [NSArray array];
        NSArray *arr = [NSArray array];
        for (int i = 0; i < 50; i ++) {
            arr = @[@"1591881249", @"1496881148",@"1596889947",@"1596881346",@"1596881445",@"1596881524",@"1496881623",@"1486881722",@"1586991027",@"1586994825",@"1586990921",@"1581699702"
                    ];
            
            [nmArr insertObject:arr atIndex:0];
        }
        _dataListGroup = nmArr.copy;
    }
    return _dataListGroup;
}

@end
