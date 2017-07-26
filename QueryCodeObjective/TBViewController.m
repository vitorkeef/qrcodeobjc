//
//  TBViewController.m
//  QueryCodeObjective
//
//  Created by ImacTeamMobile2 on 17/07/17.
//  Copyright © 2017 Vitor Leone Prado. All rights reserved.
//

#import "TBViewController.h"
#import "AFURLSessionManager.h"

@interface TBViewController ()

@end

@implementation TBViewController{

    NSArray *recipes;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self jSonfunction];
    
        recipes = [NSArray arrayWithObjects:@"Egg Benedict", @"Mushroom Risotto", @"Full Breakfast", @"Hamburger", @"Ham and Egg Sandwich", @"Creme Brelee", @"White Chocolate Donut", @"Starbucks Coffee", @"Vegetable Curry", @"Instant Noodle with Egg", @"Noodle with BBQ Pork", @"Japanese Noodle with Pork", @"Green Tea", @"Thai Shrimp Cake", @"Angry Birds Cake", @"Ham and Cheese Panini", nil];

    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:@"https://jsonplaceholder.typicode.com/users"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            //imprimindo o array todo
            //NSLog(@"%@ %@", response, responseObject);
            self.data = responseObject;
            
            //imprimindo o array com a palavra que a gente quiser antes, no caso, data
            //   NSLog(@"%@ %@", @"data", self.data);
            
            //imprimindo o primeiro dicionario
            //            NSString *index0 =[self.data objectAtIndex:0];
            //            NSLog(@"index0: %@", index0);
            
            //imprimindo apenas um dado do dicionario, no caso, o titulo
            // NSString *index0title = [[self.data objectAtIndex:0]objectForKey:@"titulo"];
            //NSLog(@"titulo: %@", index0title);
            
            
            //imprimindo um dado que ta dentro de outro dado, no caso, a cidade
            //https://jsonplaceholder.typicode.com/users
            NSString *index0id = [[[self.data objectAtIndex:0]objectForKey:@"address"]objectForKey:@"city"];
            NSLog(@"index0id: %@", index0id);
            
            // _labelJson.text = index0id;
            
            //            NSString *index0id = [[[[self.data objectAtIndex:0]objectForKey:@"address"]objectForKey:@"geo"]objectForKey:@"lat"];
            //            NSLog(@"index0id: %@", index0id);
        }
    }];
    [dataTask resume];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [recipes count];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    //cell.detailTextLabel.text=[NSString stringWithFormat:@"ID: %@", keyValuePair[@"number"]];
    
    NSString *index0 =[self.data objectAtIndex:0];
   // cell.textLabel.text = [NSString stringWithFormat:@"ID: %@", keyValuePair[@"name"]];
  //  cell.textLabel.text = [[[self.data objectAtIndex:0]objectForKey:@"address"]objectForKey:@"city"];
    
    return cell;
}

-(void) jSonfunction{

    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog( @"clicou %@", indexPath);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
