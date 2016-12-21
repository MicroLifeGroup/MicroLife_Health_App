//
//  OverViewAddEventControllerViewController.h
//  Microlife
//
//  Created by 曾偉亮 on 2016/10/14.
//  Copyright © 2016年 Rex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OverViewAddEventControllerViewController : UIViewController <UIPickerViewDelegate,UIPickerViewDataSource>

@property (strong, nonatomic) NSMutableArray<NSString *> *ary_userDataStr;

@property (strong, nonatomic) UITextField *nameTextField;
@property (strong, nonatomic) UITextField *typeTextField;
@property (strong, nonatomic) UITextField *dateTextField;
@property (nonatomic) BOOL editing;
@property (nonatomic, strong) NSMutableArray *eventArray;

-(id)initWithAddEventViewController:(CGRect)frame;



@end
