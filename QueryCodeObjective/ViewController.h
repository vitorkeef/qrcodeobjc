///Users/imacteammobile2/Desktop/qrcodeobjc/QueryCodeObjective/Base.lproj/Main.storyboard
//  ViewController.h
//  QueryCodeObjective
//
//  Created by Vitor Leone Prado on 07/07/17.
//  Copyright (c) 2014 Vitor Leone Prado. All rights reserve
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController <AVCaptureMetadataOutputObjectsDelegate>

@property (weak, nonatomic) IBOutlet UIView *CapturaDela;
@property (weak, nonatomic) IBOutlet UILabel *status;
@property (weak, nonatomic) IBOutlet UIButton *botaoLerCodigo;
@property (weak, nonatomic) IBOutlet UIView *statusView;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property(strong, nonatomic) NSArray *data;


- (IBAction)lerCodigo:(UIButton *)sender;
@end

