//
//  WFBaseController.m
//  WFZhihu
//
//  Created by xiupintech on 16/1/4.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import "WFBaseController.h"

@interface WFBaseController ()<UITableViewDataSource,UITableViewDelegate>
{
    UILabel *_navigationLabel;
    
}
@end

@implementation WFBaseController

- (id)init{

    if (self == [super init]) {
        
        _showFlag = NO;
        _needUpdate = NO;
    }
    return self;
}

#pragma mark - View Load
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.extendedLayoutIncludesOpaqueBars = YES;
    [self configListView];
    [self configNavigationBar];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}


#pragma mark - View
#pragma mark - View factory
- (void)configNavigationBar{

    _navigationBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    _navigationBar.backgroundColor = RGBColor(5, 143, 214, 1.0f);
    [self.view addSubview:_navigationBar];
    
    _navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    _navigationLabel.textAlignment = NSTextAlignmentCenter;
    _navigationLabel.font = [UIFont boldSystemFontOfSize:18];
    _navigationLabel.textColor = [UIColor whiteColor];
    _navigationLabel.backgroundColor = [UIColor clearColor];
    
     [self.view addSubview:_navigationLabel];
}


- (void)configListView{

    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.f, 0.f, kScreenWidth, kScreenHeight)];
    _mainTableView.rowHeight = 80;
    _mainTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, kScreenWidth, 200.f)];
    [self.view addSubview:_mainTableView];
    
    _refreshView = [[WFRefreshView alloc] initWithFrame:CGRectMake(125, 32, 22.f, 22.f)];
    [self.view addSubview:_refreshView];
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([scrollView isEqual:self.mainTableView]){
        CGFloat offSetY = scrollView.contentOffset.y;
        
        if (offSetY <= 0 && offSetY >= -80) {
            if (-offSetY <= 60) {
                if (!_isLoading) {
                    [_refreshView redrawFromProgress:-offSetY/60];
                }else{
                    [_refreshView redrawFromProgress:0];
                }
            }
           
            if(!_isLoading && !scrollView.isDragging && -offSetY>60 && -offSetY<=80){
                
                [_refreshView redrawFromProgress:0];
                [_refreshView startAnimation];
                [self requestNewData];
              
            }
            
            
        }else if(offSetY <- 80){
            
        }else if(offSetY <= 300) {
            
            [_refreshView redrawFromProgress:0];
        }
    }
}

- (void)requestNewData{

    _isLoading = YES;

}

#pragma mark - Setter
- (void)setNavigationTitle:(NSString *)navigationTitle{
    
    NSDictionary *attributesDic = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]};
    CGSize size = [navigationTitle boundingRectWithSize:CGSizeMake(MAXFLOAT, 44) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attributesDic context:nil].size;
    
    _refreshView.frame = CGRectMake(kScreenWidth/2 - size.width/2 - 22 - 5, 32, 22.f, 22.f);
    
    _navigationLabel.text = navigationTitle;

}

@end
