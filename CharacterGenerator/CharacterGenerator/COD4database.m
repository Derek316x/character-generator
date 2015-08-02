//
//  COD4database.m
//  CharacterGenerator
//
//  Created by Xiulan Shi on 8/2/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "COD4database.h"

@implementation COD4database

- (void)setupDB {
    NSDictionary *perks = @{
                            @"TIER1" : @[@"C4 x2", @"RPG-7 x2", @"Special Grenades x3", @"Bomb Squad", @"Claymore x2", @"Bandolier", @"Frag x3"],
                            
                            @"TIER2" : @[@"Juggernaut", @"Sleight of Hand", @"Sonic Boom", @"Stopping Power", @"Double Tap", @"UAV Jammer", @"Overkill"],
                            
                            @"TIER3" : @[@"Deep Impact", @"Extreme Conditioning", @"Steady Aim", @"Last Stand", @"Martyrdom", @"Iron Lungs", @"Eavesdrop", @"Dead Silence"]
                            
                            };
}

@end
