//
//  OneSectionTabController.m
//  YSCountDownDemo
//
//  Created by FDC-iOS on 2017/4/21.
//  Copyright © 2017年 meilun. All rights reserved.
//

#import "OneSectionTabController.h"
#import "OneSectionCell.h"
#import "YSCountDown.h"

@interface OneSectionTabController () <UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSArray *dataList;

@end

@implementation OneSectionTabController {
    YSCountDown * countDown;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    UINib*nib = [UINib nibWithNibName:@"OneSectionCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"one"];
    self.tableView.rowHeight = 110;
    
    /// 1.初始化 传入当前视图和数据数组
    countDown = [[YSCountDown alloc] initWith:self.tableView :self.dataList];
    
}

- (void)dealloc {
    /// 2.销毁
    [countDown destoryTimer];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OneSectionCell * cell = [tableView dequeueReusableCellWithIdentifier:@"one"];
    
    /// 3.绑定tag
    cell.tag = indexPath.row;
    cell.endTimeLabel.tag = 1314;
    cell.endTimeLabel.text = [countDown countDownWithPER_SEC:indexPath];
    
    
    cell.subTitleLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    return cell;
}






///  懒加载假数据
- (NSArray *)dataList {
    
    NSMutableArray * nmArr;
    if (_dataList == nil) {
        _dataList = [NSArray array];
        
        nmArr = [NSMutableArray array];
        NSArray *arr = [NSArray array];
        
        for (int i = 0; i < 50; i ++) {
            arr = @[@"1591881249", @"1496881149",@"1596889949",@"1596881349",@"1596881449",@"1596881529",
                    @"1496881629",@"1486881729",@"1586991029",@"1586994829",@"1586990929",@"1581699702"
                    ];
            [nmArr addObjectsFromArray:arr];
        }
        _dataList = nmArr.copy;
    }
    return _dataList;
}


@end
