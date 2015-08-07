//
//  CreateSoldierTableViewController.m
//  CharacterGenerator
//
//  Created by Z on 8/2/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "CreateSoldierTableViewController.h"
#import "COD4database.h"

@interface CreateSoldierTableViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@property (nonatomic) COD4database *model;

@end

@implementation CreateSoldierTableViewController

-(void)saveRecruit{
    
    Soldier *recruit = [[Soldier alloc] init];
    recruit.name = self.nameTextField.text;
    
    NSInteger teamRow = [self.teamPicker selectedRowInComponent:0];
    recruit.team = [[self.model.team allKeys] objectAtIndex:teamRow];
    
    NSInteger primaryWeaponTypeRow = [self.primaryWeaponTypePicker selectedRowInComponent:0];
    recruit.primaryWeaponType = [[self.model.primaryWeapons allKeys] objectAtIndex:primaryWeaponTypeRow];
    
    NSInteger primaryWeaponRow = [self.primaryWeaponPicker selectedRowInComponent:0];
    NSArray *primaryWeaponsOfType = [self.model.primaryWeapons objectForKey:recruit.primaryWeaponType];
    recruit.primaryWeapon = [primaryWeaponsOfType objectAtIndex:primaryWeaponRow];
    
    NSInteger secondaryWeaponTypeRow = [self.secondaryWeaponTypePicker selectedRowInComponent:0];
    recruit.secondaryWeaponType = [[self.model.secondaryWeapons allKeys] objectAtIndex:secondaryWeaponTypeRow];
    
    NSInteger secondaryWeaponRow = [self.secondaryWeaponPicker selectedRowInComponent:0];
    NSArray *secondaryWeaponsOfType = [self.model.secondaryWeapons objectForKey:recruit.secondaryWeaponType];
    recruit.secondaryWeapon = [secondaryWeaponsOfType objectAtIndex:secondaryWeaponRow];
    
    Manager *manager = [Manager sharedInstance];
    [manager addRecruit: recruit];
    
}

- (IBAction)dismissModalView:(UIButton *)sender {
    
    [self saveRecruit];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    //setup model
    self.model = [[COD4database alloc] init];
    [self.model setup];
    
    // Connect data
    self.teamPicker.dataSource = self;
    self.teamPicker.delegate = self;
    
    self.primaryWeaponTypePicker.dataSource = self;
    self.primaryWeaponTypePicker.delegate = self;
    
    self.primaryWeaponPicker.dataSource = self;
    self.primaryWeaponPicker.delegate = self;
    
    self.secondaryWeaponTypePicker.dataSource = self;
    self.secondaryWeaponTypePicker.delegate = self;
    
    self.secondaryWeaponPicker.dataSource = self;
    self.secondaryWeaponPicker.delegate = self;
    
}


#pragma mark - Table view data source
//empty because table is static

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSLog(@"preparing");
}

#pragma mark - picker view

// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    if ([pickerView isEqual:self.teamPicker]) {
         NSArray *teams = [self.model.team allKeys];
        return teams.count;
    }
    else if ([pickerView isEqual:self.primaryWeaponTypePicker]){
        NSArray *primaryWeaponTypes = [self.model.primaryWeapons allKeys];
        return primaryWeaponTypes.count;
    }
    else if ([pickerView isEqual:self.primaryWeaponPicker]){
        //get row of selected weapon type
        NSInteger row = [self.primaryWeaponTypePicker selectedRowInComponent:0];
        
        //get array of weapons for selected type
        NSArray *primaryWeaponTypes = [self.model.primaryWeapons allKeys];
        NSString *primaryWeaponType = [primaryWeaponTypes objectAtIndex:row];
        NSArray *weaponsForType = [self.model.primaryWeapons objectForKey:primaryWeaponType];
        return weaponsForType.count;
    }
    else if ([pickerView isEqual:self.secondaryWeaponTypePicker]){
        NSArray *secondaryWeaponTypes = [self.model.secondaryWeapons allKeys];
        return secondaryWeaponTypes.count;
    }
    else if ([pickerView isEqual:self.secondaryWeaponPicker]){
        //get row of selected weapon type
        NSInteger row = [self.secondaryWeaponTypePicker selectedRowInComponent:0];
        
        //get array of weapons for selected type
        NSArray *secondaryWeaponTypes = [self.model.secondaryWeapons allKeys];
        NSString *secondaryWeaponType = [secondaryWeaponTypes objectAtIndex:row];
        NSArray *weaponsForType = [self.model.secondaryWeapons objectForKey:secondaryWeaponType];
        return weaponsForType.count;
    }
    
    return 1;
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    if ([pickerView isEqual:self.teamPicker]) {
        return [[self.model.team allKeys] objectAtIndex:row];
    }
    else if ([pickerView isEqual:self.primaryWeaponTypePicker]){
        return [[self.model.primaryWeapons allKeys] objectAtIndex:row];
    }
    else if ([pickerView isEqual:self.primaryWeaponPicker]){
        NSInteger typeRow = [self.primaryWeaponTypePicker selectedRowInComponent:0];
        NSArray *primaryWeaponTypes = [self.model.primaryWeapons allKeys];
        NSString *primaryWeaponType = [primaryWeaponTypes objectAtIndex:typeRow];
        return [[self.model.primaryWeapons objectForKey:primaryWeaponType] objectAtIndex:row];
    }
    else if ([pickerView isEqual:self.secondaryWeaponTypePicker]){
        return [[self.model.secondaryWeapons allKeys] objectAtIndex:row];
    }
    else if ([pickerView isEqual:self.secondaryWeaponPicker]){
        NSInteger typeRow = [self.secondaryWeaponTypePicker selectedRowInComponent:0];
        NSArray *secondaryWeaponTypes = [self.model.secondaryWeapons allKeys];
        NSString *secondaryWeaponType = [secondaryWeaponTypes objectAtIndex:typeRow];
        return [[self.model.secondaryWeapons objectForKey:secondaryWeaponType] objectAtIndex:row];
    }
    
    return @"1";
}

 //Catpure the picker view selection
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    // This method is triggered whenever the user makes a change to the picker selection.
    // The parameter named row and component represents what was selected.
    
    if ([pickerView isEqual:self.teamPicker]) {
        NSString *selectedTeam = [[self.model.team allKeys] objectAtIndex:row];
        self.teamImageView.image = [UIImage imageNamed:selectedTeam];
    }
    else if ([pickerView isEqual:self.primaryWeaponTypePicker]){
        
        //refresh the weapon picker to display options of selected weapon type
        [self.primaryWeaponPicker reloadAllComponents];
        
        //update imageView
        NSString *selectedWeaponType = [[self.model.primaryWeapons allKeys] objectAtIndex:row];
        NSArray *weaponsForType = [self.model.primaryWeapons objectForKey:selectedWeaponType];
        NSInteger selectedWeaponRow = [self.primaryWeaponPicker selectedRowInComponent:0];
        NSString *selectedWeapon = [weaponsForType objectAtIndex:selectedWeaponRow];
        self.primaryWeaponImageView.image = [UIImage imageNamed:selectedWeapon];
        
    }
    else if ([pickerView isEqual:self.primaryWeaponPicker]){
        
        NSInteger typeRow = [self.primaryWeaponTypePicker selectedRowInComponent:0];
        NSArray *primaryWeaponTypes = [self.model.primaryWeapons allKeys];
        NSString *primaryWeaponType = [primaryWeaponTypes objectAtIndex:typeRow];
        NSString *selectedPrimaryWeapon = [[self.model.primaryWeapons objectForKey:primaryWeaponType] objectAtIndex:row];
        self.primaryWeaponImageView.image = [UIImage imageNamed:selectedPrimaryWeapon];
    }
    else if ([pickerView isEqual:self.secondaryWeaponTypePicker]){
        
        //refresh the weapon picker to display options of selected weapon type
        [self.secondaryWeaponPicker reloadAllComponents];
        
        //update imageView
        NSString *selectedWeaponType = [[self.model.secondaryWeapons allKeys] objectAtIndex:row];
        NSArray *weaponsForType = [self.model.secondaryWeapons objectForKey:selectedWeaponType];
        NSInteger selectedWeaponRow = [self.secondaryWeaponPicker selectedRowInComponent:0];
        NSString *selectedWeapon = [weaponsForType objectAtIndex:selectedWeaponRow];
        self.secondaryWeaponImageView.image = [UIImage imageNamed:selectedWeapon];
        
    }
    else if ([pickerView isEqual:self.secondaryWeaponPicker]){
        
        NSInteger typeRow = [self.secondaryWeaponTypePicker selectedRowInComponent:0];
        NSArray *secondaryWeaponTypes = [self.model.secondaryWeapons allKeys];
        NSString *secondaryWeaponType = [secondaryWeaponTypes objectAtIndex:typeRow];
        NSString *selectedSecondaryWeapon = [[self.model.secondaryWeapons objectForKey:secondaryWeaponType] objectAtIndex:row];
        self.secondaryWeaponImageView.image = [UIImage imageNamed:selectedSecondaryWeapon];
    }
}

@end
