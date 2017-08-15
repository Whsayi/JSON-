//
//  ViewController.m
//  用自带的json解析
//
//  Created by 张浩宁 on 2017/8/15.
//  Copyright © 2017年 bawei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSArray *_arr;
    NSDictionary *_dic;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化表格
    _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    // 设置代理
    _tableView.delegate = self;
    _tableView.dataSource = self;
    // 添加到视图上
    [self.view addSubview:_tableView];

    // 设置标题
    self.title = @"电影列表";
    // 开始解析
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"movie" ofType:@"json"];
    NSString *jsonString = [NSString stringWithContentsOfFile:jsonPath encoding:NSUTF8StringEncoding error:nil];
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    //json解析
    _dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
    NSLog(@"--------%@",_dic);
    
    
}
// 分区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dic.allKeys.count;
}
// 行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    _arr = [_dic objectForKey:[_dic.allKeys objectAtIndex:section]];
    return _arr.count;
}
// 单元格内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"1"];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"1"];
    }
    _arr = [_dic objectForKey:[_dic.allKeys objectAtIndex:indexPath.section]];
    cell.textLabel.text = [NSString stringWithFormat:@"电影名:%@",[_arr[indexPath.row]objectForKey:@"MovieName"]];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"演员:%@,内容:%@",[_arr[indexPath.row]objectForKey:@"MovieAuthor"],[_arr[indexPath.row]objectForKey:@"MovieContent"]];
    return cell;
}
// 页眉内容
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [_dic.allKeys objectAtIndex:section];
}

@end
