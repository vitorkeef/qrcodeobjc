//
//  ViewController.h
//  QueryCodeObjective
//
//  Created by Humberto Puccinelli on 20/11/14.
//  Copyright (c) 2014 Humberto Puccinelli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController <AVCaptureMetadataOutputObjectsDelegate>

@property (weak, nonatomic) IBOutlet UIView *CapturaDela;
@property (weak, nonatomic) IBOutlet UILabel *status;
@property (weak, nonatomic) IBOutlet UIButton *botaoLerCodigo;

- (IBAction)lerCodigo:(UIButton *)sender;
@end

