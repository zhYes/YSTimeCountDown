# YSTimeCountDown
倒计时的完整封装上传
只需五步,五行代码就可以使用
第一步:导入我们的工具类
第二步:在viewDidLoad方法创建工具对象
/// 1.初始化 传入当前tableView视图和数据数组
    countDown = [[YSCountDown alloc] initWith:self.tableView :self.dataList];
第三步:在数据源方法里绑定tag
/// 3.绑定tag
    cell.tag = indexPath.row;
    cell.endTimeLabel.tag = 1314;
    cell.endTimeLabel.text = [countDown countDownWithPER_SEC:indexPath];
第四步:销毁我们的定时器
 /// 4.销毁
    [countDown destoryTimer];
第五步:cmd + R 运行

注意点 : 如果是分组数据的cell绑定为:
    /// 3.绑定tag
    cell.tag = indexPath.section * 1000 + indexPath.row; // 区别于不分组数据
    cell.endTimeLabel.tag = 1314;
    cell.endTimeLabel.text = [countDown countDownWithPER_SEC:indexPath];
    
详细介绍博文介绍:http://www.jianshu.com/p/5b4e0286658a
