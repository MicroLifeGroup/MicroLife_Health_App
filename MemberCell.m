//
//  MemberCell.m
//  Microlife
//
//  Created by Ideabus on 2016/10/4.
//  Copyright © 2016年 Rex. All rights reserved.
//

#import "MemberCell.h"

@implementation MemberCell
- (IBAction)checkboxSelected:(id)sender {
    
    _checkboxBtn.selected = !_checkboxBtn.selected;
    //每次點擊都會改變按鈕的狀態
    
    if ( _checkboxBtn.selected) {
        //在此實現打勾時的方法
        [ _checkboxBtn setImage:[UIImage imageNamed:@"all_select_a_1"] forState:UIControlStateSelected];
        
        
    }else{
        //在此實現不打勾時的方法
        [ _checkboxBtn setImage:[UIImage imageNamed:@"all_select_a_0"] forState:UIControlStateNormal];
        
    }

    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}






@end
