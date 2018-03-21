//
//  MGMainVC.m
//  Math Game Test
//
//  Created by Kostya on 16.03.2018.
//  Copyright © 2018 Stolyarenko Konstantin. All rights reserved.
//

#import "MGMainVC.h"
#import "MGTableViewCell.h"
#import "MGBipBopModel.h"

@interface MGMainVC () <UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *bipTxtField;
@property (weak, nonatomic) IBOutlet UITextField *bopTextField;
@property (strong, nonatomic) NSMutableArray *resultArray;
@property (strong, nonatomic) NSString *firstNumber;
@property (strong, nonatomic) NSString *lastNumber;
@end

@implementation MGMainVC

#pragma mark - UIView

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.resultArray = [NSMutableArray new];
    [self initViewDesign];
    [self.bipTxtField addTarget:self action:@selector(editingChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.bopTextField addTarget:self action:@selector(editingChanged:) forControlEvents:UIControlEventEditingChanged];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - IBActions

- (IBAction)refreshScreen:(id)sender
{
    [self.resultArray removeAllObjects];
    [self.tableView reloadData];
}

#pragma mark - UIView Design

-(void)initViewDesign
{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.bipTxtField.delegate = self;
    self.bipTxtField.tag = 1;
    self.bipTxtField.layer.borderWidth = 2.0f;
    self.bipTxtField.layer.borderColor = [UIColor blueColor].CGColor;
    self.bipTxtField.layer.cornerRadius = 20;
    self.bipTxtField.clipsToBounds = YES;
    
    self.bopTextField.delegate = self;
    self.bopTextField.tag = 2;
    self.bopTextField.layer.borderWidth = 2.0f;
    self.bopTextField.layer.borderColor = [UIColor blueColor].CGColor;
    self.bopTextField.layer.cornerRadius = 20;
    self.bopTextField.clipsToBounds = YES;
    
}

-(void)editingChanged:(id)sender
{
   // [self generateSequence:[self.bipTxtField.text integerValue] and:[self.bopTextField.text integerValue]];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([textField canResignFirstResponder]) {
        [textField resignFirstResponder];
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if(textField.tag == 1)
    {
        self.firstNumber = textField.text;
        [self.resultArray removeAllObjects];
    }
    else
    {
        self.lastNumber = textField.text;
        [self.resultArray removeAllObjects];
    }
    [self generateSequence:self.firstNumber and:self.lastNumber];
}

-(void)generateSequence:(NSString *)firstNumberStr and:(NSString *)lastNumberStr
{
    NSInteger firstNumber = [firstNumberStr integerValue];
    NSInteger lastNumber = [lastNumberStr integerValue];
    
    if((lastNumber>firstNumber) && (lastNumber>0) && (firstNumber>0))
    {
        for (NSInteger i = firstNumber; i<=lastNumber; i++)
        {
            MGBipBopModel *bipBopModel = [MGBipBopModel new];
            if((i % firstNumber) == 0 && (i % lastNumber) == 0)
            {
                bipBopModel.modelTitle = [NSString stringWithFormat:@"%ld Bip Bop",(long)i];
                bipBopModel.modelPosition = [NSNumber numberWithInt:1];
                [self.resultArray addObject:bipBopModel];
            }
            else if((i % firstNumber) == 0)
            {
                bipBopModel.modelTitle = [NSString stringWithFormat:@"%ld Bip",(long)i];
                bipBopModel.modelPosition = [NSNumber numberWithInt:0];
                [self.resultArray addObject:bipBopModel];
            }
            else if((i % lastNumber) == 0)
            {
                bipBopModel.modelTitle = [NSString stringWithFormat:@"%ld Bop",(long)i];
                bipBopModel.modelPosition = [NSNumber numberWithInt:2];
                [self.resultArray addObject:bipBopModel];
            }
            else
            {
                bipBopModel.modelTitle = [NSString stringWithFormat:@"%ld",(long)i];
                bipBopModel.modelPosition = [NSNumber numberWithInt:1];
                [self.resultArray addObject:bipBopModel];
            }
        }
        [self.tableView reloadData];
    }
    else
    {
        [self.resultArray removeAllObjects];
    }
}

#pragma mark - TableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.resultArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *resulTableIdentifier = @"ResultCellID";
    MGTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:resulTableIdentifier];
    if (cell == nil)
    {
        cell = [[MGTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:resulTableIdentifier];
    }
    MGBipBopModel *bipBopModel = [self.resultArray objectAtIndex:indexPath.row];
    cell.customLabel.text = bipBopModel.modelTitle;
    cell.customLabel.textAlignment = [bipBopModel.modelPosition integerValue];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

@end
