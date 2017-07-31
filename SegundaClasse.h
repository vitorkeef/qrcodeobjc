//
//  SegundaClasse.h
//  QueryCodeObjective
//
//  Created by ImacTeamMobile2 on 14/07/17.
//  Copyright © 2017 Vitor Leone Prado. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SegundaClasse : UIViewController <UIScrollViewDelegate>
- (IBAction)loopFor:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *labelText;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
- (IBAction)btnHora:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *labelinsidescroll;



@end
