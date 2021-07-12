//
//  FavoriteTiket+CoreDataProperties.h
//  AeroTickets
//
//  Created by Pavel Khlebnikov on 09.07.2021.
//
//

#import "FavoriteTiket+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface FavoriteTiket (CoreDataProperties)

+ (NSFetchRequest<FavoriteTiket *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *airline;
@property (nullable, nonatomic, copy) NSDate *created;
@property (nullable, nonatomic, copy) NSDate *departure;
@property (nullable, nonatomic, copy) NSDate *expires;
@property (nonatomic) int16_t flightNumber;
@property (nullable, nonatomic, copy) NSString *from;
@property (nonatomic) int64_t price;
@property (nullable, nonatomic, copy) NSDate *returnDate;
@property (nullable, nonatomic, copy) NSString *to;

@end

NS_ASSUME_NONNULL_END
