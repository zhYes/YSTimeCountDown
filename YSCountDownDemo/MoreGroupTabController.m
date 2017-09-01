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
    countDown.isPlusTime = self.isPlusTime;
    
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
    if (_isPlusTime) {
        cell.endTimeLabel.textColor = [UIColor whiteColor];
        cell.subTitleLabel.textColor = [UIColor whiteColor];
        cell.contentView.backgroundColor = [UIColor blackColor];
    }
    
    return cell;
}


// 数据
- (NSArray *)dataListGroup {
    
    NSMutableArray * nmArr;
    if (_dataListGroup == nil) {
        _dataListGroup = [NSArray array];
        
        nmArr = [NSMutableArray array];
        NSArray *arr = [NSArray array];
        NSDate * datenow = [NSDate date];
        NSString*timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
        NSInteger nowInteger = [timeSp integerValue];
        NSMutableArray * groupArr = [NSMutableArray array];
        for (int i = 0; i<30; i ++) {
            NSString *str2;
            if (_isPlusTime) {
            str2 = [NSString stringWithFormat:@"%zd",nowInteger - arc4random()%50 ];
                self.tableView.backgroundColor = [UIColor blackColor];
            }else {
                str2 = [NSString stringWithFormat:@"%zd",nowInteger + arc4random()%500 ];
            }
            
            arr = @[str2];
            [nmArr addObjectsFromArray:arr];
            [groupArr insertObject:nmArr atIndex:0];
        }
        _dataListGroup = groupArr.copy;
    }
    
    return _dataListGroup;
}

@end
