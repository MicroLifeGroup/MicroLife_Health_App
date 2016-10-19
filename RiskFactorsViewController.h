//
//  RiskFactorsViewController.h
//  Setting
//
//  Created by Ideabus on 2016/8/12.
//  Copyright © 2016年 Allen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RiskFactorCell.h"

@interface RiskFactorsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    
    UIButton *rfselectBtn;
    NSMutableArray *RFArray;
    UITableView *RFTableView;
    
    
}
@property (nonatomic,retain)UIButton *rfselectBtn;
@property (nonatomic,retain)UITableView *RFTableView;

@end
