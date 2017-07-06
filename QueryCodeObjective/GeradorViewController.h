//
//  GeradorViewController.h
//  QueryCodeObjective
//
//  Created by MakroTest on 06/07/17.
//  Copyright © 2017 Humberto Puccinelli. All rights reserved.
//

#import "ViewController.h"

@interface GeradorViewController : ViewController

@property (weak, nonatomic) IBOutlet UILabel *codigoLabel;
- (IBAction)gerarQRCode:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imageQRCOde;



@end