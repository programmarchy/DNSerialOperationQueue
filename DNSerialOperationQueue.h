#import <Foundation/Foundation.h>

@interface DNSerialOperationQueue : NSObject

@property (strong, nonatomic, readonly) NSOperationQueue *queue;
@property (strong, nonatomic, readonly) NSValue *key;

- (id)initWithOperationQueue:(NSOperationQueue *)queue;

- (void)addOperation:(NSOperation *)operation;
- (void)addOperationWithBlock:(void (^)(void))block;

@end
