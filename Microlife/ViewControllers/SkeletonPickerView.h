//
//  SkeletonPickerView.h
//  Microlife
//
//  Created by 曾偉亮 on 2016/10/13.
//  Copyright © 2016年 Rex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SkeletonPickerView : UIView <UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong, nonatomic) UIPickerView *m_pickerView;

-(id)initWithSkeletonPickerView:(CGRect)frame;


@end
