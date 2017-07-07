//
//  ViewController.h
//  QueryCodeObjective
//
//  Created by Vitor Leone Prado on 20/11/14.
//  Copyright (c) 2014 Vitor Leone Prado. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController <AVCaptureMetadataOutputObjectsDelegate>

@property (weak, nonatomic) IBOutlet UIView *CapturaDela;
@property (weak, nonatomic) IBOutlet UILabel *status;
@property (weak, nonatomic) IBOutlet UIButton *botaoLerCodigo;
- (IBAction)testarweb:(id)sender;


- (IBAction)lerCodigo:(UIButton *)sender;
@end

