/*
 * iSGL3D: http://isgl3d.com
 *
 * Copyright (c) 2010-2011 Stuart Caunt
 * 
 * This class is inspired from equivalent functionality provided by cocos2d :
 * cocos2d for iPhone: http://www.cocos2d-iphone.org
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 */

#import "Isgl3dActionMove.h"
#import "Isgl3dNode.h"

#pragma mark Isgl3dActionMoveTo

@implementation Isgl3dActionMoveTo


+ (id) actionWithDuration:(float)duration position:(Isgl3dVector3)position {
	return [[[self alloc] initWithDuration:duration position:position] autorelease];
}

- (id) initWithDuration:(float)duration position:(Isgl3dVector3)position {
	if ((self = [super initWithDuration:duration])) {
		_finalPosition = position;
	}
	
	return self;
}

- (void) dealloc {
	[super dealloc];
}

- (id) copyWithZone:(NSZone*)zone {
	Isgl3dActionMoveTo * copy = [[[self class] allocWithZone:zone] initWithDuration:_duration position:_finalPosition];

	return copy;
}

-(void) startWithTarget:(id)target {
	[super startWithTarget:target];
	_initialPosition = ((Isgl3dNode *)target).position;
	_vector = _finalPosition;
	iv3Sub(&_vector, &_initialPosition);
}

- (void) update:(float)progress {
	[_target setPosition:iv3(_initialPosition.x + progress * _vector.x, _initialPosition.y + progress * _vector.y, _initialPosition.z + progress * _vector.z)];
}

@end

#pragma mark Isgl3dActionMoveBy

@implementation Isgl3dActionMoveBy


+ (id) actionWithDuration:(float)duration vector:(Isgl3dVector3)vector {
	return [[[self alloc] initWithDuration:duration vector:vector] autorelease];
}

- (id) initWithDuration:(float)duration vector:(Isgl3dVector3)vector {
	if ((self = [super initWithDuration:duration])) {
		_vector = vector;
	}
	
	return self;
}

- (void) dealloc {
	[super dealloc];
}

- (id) copyWithZone:(NSZone*)zone {
	Isgl3dActionMoveBy * copy = [[[self class] allocWithZone:zone] initWithDuration:_duration vector:_vector];

	return copy;
}

-(void) startWithTarget:(id)target {
	[super startWithTarget:target];
	_initialPosition = ((Isgl3dNode *)target).position;
}

- (void) update:(float)progress {
	[_target setPosition:iv3(_initialPosition.x + progress * _vector.x, _initialPosition.y + progress * _vector.y, _initialPosition.z + progress * _vector.z)];
}

@end

#pragma mark Isgl3dActionSetPosition

@implementation Isgl3dActionSetPosition


+ (id) actionWithPosition:(Isgl3dVector3)position {
	return [[[self alloc] initWithPosition:position] autorelease];
}

- (id) initWithPosition:(Isgl3dVector3)position {
	if ((self = [super init])) {
		_finalPosition = position;
	}
	
	return self;
}

- (void) dealloc {
	[super dealloc];
}

- (id) copyWithZone:(NSZone*)zone {
	Isgl3dActionSetPosition * copy = [[[self class] allocWithZone:zone] initWithPosition:_finalPosition];

	return copy;
}

- (void) update:(float)progress {
	[_target setPosition:_finalPosition];
}

@end
