//
//  SegundaClasse.m
//  QueryCodeObjective
//
//  Created by ImacTeamMobile2 on 14/07/17.
//  Copyright © 2017 Vitor Leone Prado. All rights reserved.
//

#import "SegundaClasse.h"

@interface SegundaClasse ()

@end

@implementation SegundaClasse

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollview.minimumZoomScale=0.5;
    self.scrollview.maximumZoomScale=6.0;
    self.scrollview.contentSize=CGSizeMake(1280, 960);
    self.scrollview.delegate=self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.labelinsidescroll;
}

- (IBAction)loopFor:(id)sender {
    for (int i = 0; i <= 10; i++){
        _labelText.text = [NSString stringWithFormat:@"%i", i];
        NSLog(@"%d", i);
    }
    
}
@end
