//
//  TempTableViewCell.h
//  Microlife
//
//  Created by 曾偉亮 on 2016/9/17.
//  Copyright © 2016年 Rex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OverTempTableViewCell : UITableViewCell

@property (strong, nonatomic) UIImageView *tempCellImgView;

@property (strong, nonatomic) UIView *tempCellSperator;

@property (strong, nonatomic) UILabel *tempCellDateLabel;

@property (strong, nonatomic) UILabel *tempCellTimeLabel;

-(id)initTempTableViewCellWithFrame:(CGRect)frame;

@end
