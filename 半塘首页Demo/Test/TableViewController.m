//
//  TableViewController.m
//  Test
//
//  Created by 常迪 on 15/11/9.
//  Copyright (c) 2015年 常迪. All rights reserved.
//

#import "TableViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "UIImageView+WebCache.h"
#import "Model.h"
#import "HWAdView.h"
#import "Header.h"
@interface TableViewController ()<UIScrollViewDelegate,ZWAdViewDelagate>

@property (nonatomic, strong) HWAdView *aView;//顶部轮播图
@property (nonatomic,strong) NSMutableArray *titileArr;
@property (nonatomic,strong) NSMutableArray *imageArr;
@property (nonatomic, strong) NSMutableArray *contentArray;//单元格上轮播图内容的网址数组
@property (nonatomic,strong) NSMutableArray *dataArr;   //数据源

@end

@implementation TableViewController


#pragma mark -轮播图数据源-

-(NSMutableArray *)titileArr{
    if (!_titileArr) {
        self.titileArr = [NSMutableArray array];
    }
    return _titileArr;
}

-(NSMutableArray *)imageArr{
    if (!_imageArr) {
        self.imageArr = [NSMutableArray array];
    }
    return _imageArr;
}


- (NSMutableArray *)contentArray{
    if (!_contentArray) {
        self.contentArray = [NSMutableArray array];
    }
    return _contentArray;
}

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        self.dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self connectData];
    [self addTopScrollView];
    [self.tableView registerClass:[TableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.tableHeaderView = self.aView;
}


- (void)connectData{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url = [NSString stringWithFormat:@"http://open4.bantangapp.com/topic/list?track_user_id=&client_id=bt_app_android&client_secret=ffcda7a1c4ff338e05c42e7972ba7b8d&app_versions=3.3.1&os_versions=4.4.4&channel_name=xiaomi&v=1&oauth_token=&screensize=720&na"];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation * operation, id responseObject) {
        NSDictionary *data = [responseObject objectForKey:@"data"];
        NSArray *banner = [data objectForKey:@"banner"];
        NSArray *topic = [data objectForKey:@"topic"];
        for (NSDictionary *dic in banner) {
            BanndrModel *model = [[BanndrModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.titileArr addObject:model.title1];
            [self.imageArr addObject:model.pic1];
        }
        for (NSDictionary *dic in topic) {
            Model *model = [[Model alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArr addObject:model];
        }
        [self addTopScrollView];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark -----实现轮播图方法
- (void)addTopScrollView{
    self.aView = [[HWAdView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 180)];
    self.aView.delegate = self;
    NSArray *titleArray = self.titileArr;
    NSArray *imageArray = self.imageArr;
    self.aView.adDataArray = [NSMutableArray arrayWithArray:imageArray];
    self.aView.adTitleArray = [NSMutableArray arrayWithArray:titleArray];
    self.aView.pageControlPosition = ZWPageControlPosition_BottomRight;//pageConrol显示的地方(枚举)
    self.aView.hidePageControl = NO;
    self.aView.adAutoplay = YES;
    self.aView.adPeriodTime = 2.0;
    self.aView.placeImageSource = @"banner1";
    [self.aView loadAdDataThenStart];
    [self.view addSubview:self.aView];
    
}

#pragma mark - 广告栏点击
-(void)adView:(HWAdView *)adView didDeselectAdAtNum:(NSInteger)num{

    NSLog(@"%lu",num);
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    Model *model  = self.dataArr[indexPath.row];
    [cell configureCellWithModel:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 170;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
