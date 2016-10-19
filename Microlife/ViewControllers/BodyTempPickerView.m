//
//  BodyTempPickerView.m
//  Microlife
//
//  Created by 曾偉亮 on 2016/10/12.
//  Copyright © 2016年 Rex. All rights reserved.
//

#import "BodyTempPickerView.h"

@implementation BodyTempPickerView {
    
    NSMutableArray *ary_bodyTempData;
}

@synthesize m_pickerView;

-(id)initWithBodyTempPickerView:(CGRect)frame {
    
    self = [super init];
    
    if (!self) return nil;
    
    self.backgroundColor = [UIColor whiteColor];
    
    //m_pickerView
    m_pickerView = [[UIPickerView alloc] initWithFrame:frame];
    
    m_pickerView.backgroundColor = [UIColor whiteColor];
    
    m_pickerView.delegate = self;
    
    m_pickerView.dataSource = self;
    
    m_pickerView.showsSelectionIndicator = YES;

    
    //ary_temp
    NSMutableArray *ary_temp = [[NSMutableArray alloc] init];
    float tempPlus = 0.1;
    for (float tempFloat = 32.0; tempFloat <= 42.2; tempPlus++) {
        
        [ary_temp addObject:[NSString stringWithFormat:@"%.1f",tempFloat]];
        
        tempFloat += 0.1;
    }
    
    //ary_unit
    NSArray *ary_unit = [NSArray arrayWithObjects:@"℃",@"℉", nil];
    
    //ary_bodyTempData
    ary_bodyTempData = [NSMutableArray arrayWithObjects:
                        [NSArray arrayWithObjects:@" ", nil],
                        ary_temp,
                        ary_unit ,nil];
    
    
    return self;
}

#pragma mark - UIPickerViewDataSource & UIPickerViewDelegate
//----------------------------------------------------------
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return ary_bodyTempData.count;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    NSArray *ary = [[NSArray alloc] initWithArray:ary_bodyTempData[component]];
    NSInteger count = ary.count;
    
    return count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    NSArray *ary = [[NSArray alloc] initWithArray:ary_bodyTempData[component]];
    NSString *title = [NSString stringWithFormat:@"%@",ary[row]];
    
    return title;
}



@end
