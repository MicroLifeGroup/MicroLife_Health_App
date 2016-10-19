//
//  BMRPickerView.m
//  Microlife
//
//  Created by 曾偉亮 on 2016/10/13.
//  Copyright © 2016年 Rex. All rights reserved.
//

#import "BMRPickerView.h"

@implementation BMRPickerView {
    
    NSMutableArray *ary_BMRData;
    
}

-(id)initWithBMRPickerView:(CGRect)frame {
    
    self = [super init];
    
    if (!self) return nil;
    
    self.backgroundColor = [UIColor whiteColor];
    
    
    
    //ary_BMR
    NSMutableArray *ary_BMR = [[NSMutableArray alloc] init];
    for (int i = 500; i <= 4500; i++) {
        
        [ary_BMRData addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    //ary_unit
    NSArray *ary_unit = [NSArray arrayWithObjects:@"kcal", nil];
    
    
    //ary_BMRData
    ary_BMRData = [NSMutableArray arrayWithObjects:
                   [NSArray arrayWithObjects:@" ", nil],
                   ary_BMR,
                   ary_unit,nil];
    
    return self;
}

#pragma mark - UIPickerViewDataSource & UIPickerViewDelegate
//----------------------------------------------------------
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return ary_BMRData.count;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    NSArray *ary = [[NSArray alloc] initWithArray:ary_BMRData[component]];
    NSInteger count = ary.count;
    
    return count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    NSArray *ary = [[NSArray alloc] initWithArray:ary_BMRData[component]];
    NSString *title = [NSString stringWithFormat:@"%@",ary[row]];
    
    return title;
}


@end
