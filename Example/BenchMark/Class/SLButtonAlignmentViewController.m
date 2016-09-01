//
//  SLButtonAlignmentViewController.m
//  HWCoreFramework
//
//  Created by 58 on 9/1/16.
//  Copyright © 2016 ParallelWorld. All rights reserved.
//

#import "SLButtonAlignmentViewController.h"
#import "HWCoreFramework.h"

@interface SLButtonAlignmentViewController ()
@property (weak, nonatomic) IBOutlet UIButton *titleImageButton;
@property (nonatomic, assign) HWButtonAlignmentType buttonAlignmentType;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@end

@implementation SLButtonAlignmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)slideValueChanged:(UISlider *)sender {
    float value = sender.value;
    [self.titleImageButton hw_setContentWithSpace:value forType:self.buttonAlignmentType];
}

- (IBAction)leftTitleRightImage:(id)sender {
    self.buttonAlignmentType = HWButtonRightImageLeftTitle;
    [self slideValueChanged:self.slider];
}
- (IBAction)leftImageRightTitle:(id)sender {
    self.buttonAlignmentType = HWButtonLeftImageRightTitle;
    [self slideValueChanged:self.slider];
}
- (IBAction)topImageBottomTitle:(id)sender {
    self.buttonAlignmentType = HWButtonTopImageBottomTitle;
    [self slideValueChanged:self.slider];
}
- (IBAction)topTitleBottomImage:(id)sender {
    self.buttonAlignmentType = HWButtonBottomImageTopTitle;
    [self slideValueChanged:self.slider];
}
@end
