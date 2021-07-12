//
//  FavoriteTiket+CoreDataProperties.m
//  AeroTickets
//
//  Created by Pavel Khlebnikov on 09.07.2021.
//
//

#import "FavoriteTiket+CoreDataProperties.h"

@implementation FavoriteTiket (CoreDataProperties)

+ (NSFetchRequest<FavoriteTiket *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"FavoriteTiket"];
}

@dynamic airline;
@dynamic created;
@dynamic departure;
@dynamic expires;
@dynamic flightNumber;
@dynamic from;
@dynamic price;
@dynamic returnDate;
@dynamic to;

@end
