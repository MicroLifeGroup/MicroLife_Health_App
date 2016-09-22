//
//  WeightTableViewCell.h
//  Microlife
//
//  Created by 曾偉亮 on 2016/9/17.
//  Copyright © 2016年 Rex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OverWeightTableViewCell : UITableViewCell

@property (strong, nonatomic) UIImageView *weightCellImgView;

@property (strong, nonatomic) UIView *weightCellSperator;

@property (strong, nonatomic) UILabel *weightCellDateLabel;

@property (strong, nonatomic) UILabel *weightCellTimeLabel;


-(id)initWithWeightCellFrame:(CGRect)frame;

@end
