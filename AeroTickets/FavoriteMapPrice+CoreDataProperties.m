//
//  FavoriteMapPrice+CoreDataProperties.m
//  AeroTickets
//
//  Created by Pavel Khlebnikov on 09.07.2021.
//
//

#import "FavoriteMapPrice+CoreDataProperties.h"

@implementation FavoriteMapPrice (CoreDataProperties)

+ (NSFetchRequest<FavoriteMapPrice *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"FavoriteMapPrice"];
}

@dynamic actual;
@dynamic departure;
@dynamic distance;
@dynamic from;
@dynamic numberOfChanges;
@dynamic returnDate;
@dynamic to;
@dynamic price;

@end
