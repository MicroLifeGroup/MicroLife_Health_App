//
//  EditMailNotificationViewController.h
//  Setting
//
//  Created by Ideabus on 2016/8/18.
//  Copyright © 2016年 Allen. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol postValueDelegate <NSObject>

-(void)postValue:(NSString *) str;

@end


@interface EditMailNotificationViewController : UIViewController<UITextFieldDelegate>{
    UITextField *editNameTextField;
    UITextField *editEmailTextField;

}

@property (nonatomic,retain) UITextField *editNameTextField;
@property (nonatomic,retain) UITextField *editEmailTextField;
@property(strong,nonatomic) UITextField *textInfo;
@property(strong,nonatomic) NSString *str;
@property(strong,nonatomic) id<postValueDelegate> delegate;



@end
