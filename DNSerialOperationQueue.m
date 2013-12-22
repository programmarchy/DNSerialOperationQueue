#import "DNSerialOperationQueue.h"

@interface DNSerialOperationQueue ()

@property (strong, nonatomic) NSOperationQueue *queue;
@property (strong, nonatomic) NSValue *key;
@property (strong, nonatomic) NSOperation *currentOperation;

@end

@implementation DNSerialOperationQueue

- (id)init
{
    return [self initWithOperationQueue:[[NSOperationQueue alloc] init]];
}

- (id)initWithOperationQueue:(NSOperationQueue *)queue
{
    self = [super init];
    if (self) {
        self.queue = queue;
        self.key = [self keyForOperationQueue:queue];
    }
    return self;
}

- (NSValue *)keyForOperationQueue:(NSOperationQueue *)queue
{
    return [NSValue valueWithNonretainedObject:queue];
}

- (void)addOperation:(NSOperation *)operation
{
    if (self.currentOperation) {
        [operation addDependency:self.currentOperation];
    }
    [self.queue
        addOperation:(self.currentOperation = operation)];
}

- (void)addOperationWithBlock:(void (^)(void))block
{
    NSBlockOperation *blockOperation = [[NSBlockOperation alloc] init];
    [blockOperation addExecutionBlock:block];
    [self addOperation:blockOperation];
}

@end
