//
//  EditEntryWireframe.m
//  bam
//
//  Created by François Benaiteau on 30/07/14.
//  Copyright (c) 2014 François Benaiteau. All rights reserved.
//

#import "EditEntryWireframe.h"

#import "EditEntryInteractor.h"
#import "EditEntryPresenter.h"

@implementation EditEntryWireframe

-(id)initWithDataManager:(EntryDataStore*)dataStore
{
    self = [super init];
    if (self) {
        _interactor = [[EditEntryInteractor alloc] initWithDataManager:dataStore];
        _presenter = [[EditEntryPresenter alloc] init];
        _presenter.interactor = _interactor;
        
        
    }
    return self;
}

-(void)presentEditViewForEntryWithKey:(NSString*)key
{

}

@end
