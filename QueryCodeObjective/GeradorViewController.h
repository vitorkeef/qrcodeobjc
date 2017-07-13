//
//  GeradorViewController.h
//  QueryCodeObjective
//
//  Created by MakroTest on 06/07/17.
//  Copyright © 2017 Vitor Leone Prado. All rights reserved.
//

#import "ViewController.h"

@interface GeradorViewController : ViewController 

@property (weak, nonatomic) IBOutlet UITextField *txtNome;
@property (weak, nonatomic) IBOutlet UITextField *txtIdade;
@property (weak, nonatomic) IBOutlet UITextField *txtSenha;
@property (weak, nonatomic) IBOutlet UITextField *txtCpf;

- (IBAction)gerarQRCode:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imageQRCOde;
@property (weak, nonatomic) IBOutlet UITextField *textCPF;



@end
