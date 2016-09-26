//
//  BPTableViewCell.h
//  Microlife
//
//  Created by 曾偉亮 on 2016/9/17.
//  Copyright © 2016年 Rex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OverBPTableViewCell : UITableViewCell

@property (strong, nonatomic) UIImageView *bpCellImgView;

@property (strong, nonatomic) UIView *bpCellSperator;

@property (strong, nonatomic) UILabel *bpCellDateLabel;

@property (strong, nonatomic) UILabel *bpCellTimeLabel;


-(id)initBPTableiewCellWithFrame:(CGRect)frame;

@end
