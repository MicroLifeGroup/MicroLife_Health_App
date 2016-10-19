//
//  RiskFactorCell.m
//  Microlife
//
//  Created by Idea on 2016/10/5.
//  Copyright © 2016年 Rex. All rights reserved.
//

#import "RiskFactorCell.h"

@implementation RiskFactorCell
- (IBAction)RFcheckbox:(id)sender {
    
    _RFcheckbox.selected = !_RFcheckbox.selected;
    //每次點擊都會改變按鈕的狀態
    
    if ( _RFcheckbox.selected) {
        //在此實現打勾時的方法
        [ _RFcheckbox setImage:[UIImage imageNamed:@"all_select_a_1"] forState:UIControlStateSelected];
        
        
    }else{
        //在此實現不打勾時的方法
        [ _RFcheckbox setImage:[UIImage imageNamed:@"all_select_a_0"] forState:UIControlStateNormal];
        
    }

    
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
