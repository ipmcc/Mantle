//
//  MTLCoreDataTestModels.m
//  Mantle
//
//  Created by Justin Spahr-Summers on 2013-04-05.
//  Copyright (c) 2013 GitHub. All rights reserved.
//

#import "MTLCoreDataTestModels.h"

@implementation MTLParentTestModel

@synthesize numberString = _numberString;
@synthesize date = _date;
@synthesize requiredString = _requiredString;
@synthesize orderedChildren = _orderedChildren;
@synthesize unorderedChildren = _unorderedChildren;

+ (NSString *)managedObjectEntityName {
	return @"Parent";
}

+ (NSDictionary *)managedObjectKeysByPropertyKey {
	return @{
		@"numberString": @"number",
		@"requiredString": @"string"
	};
}

+ (NSSet *)propertyKeysForManagedObjectUniquing {
	return [NSSet setWithObject:@"numberString"];
}

+ (NSValueTransformer *)numberStringEntityAttributeTransformer {
	return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
		return [NSDecimalNumber decimalNumberWithString:str];
	} reverseBlock:^(NSNumber *num) {
		return num.stringValue;
	}];
}

+ (NSDictionary *)relationshipModelClassesByPropertyKey {
	return @{
		@"orderedChildren": MTLChildTestModel.class,
		@"unorderedChildren": MTLChildTestModel.class,
	};
}

@end

@implementation MTLChildTestModel

@synthesize childID = _childID;
@synthesize parent1 = _parent1;
@synthesize parent2 = _parent2;

+ (NSString *)managedObjectEntityName {
	return @"Child";
}

+ (NSDictionary *)managedObjectKeysByPropertyKey {
	return @{};
}

+ (NSSet *)propertyKeysForManagedObjectUniquing
{
	return [NSSet setWithObjects:@"childID", nil];
}

+ (NSDictionary *)relationshipModelClassesByPropertyKey {
	return @{
		@"parent1": MTLParentTestModel.class,
		@"parent2": MTLParentTestModel.class,
	};
}

@end

@implementation MTLFailureModel

@synthesize notSupported = _notSupported;

+ (NSDictionary *)managedObjectKeysByPropertyKey {
	return @{};
}

+ (NSString *)managedObjectEntityName {
	return @"Empty";
}

@end
