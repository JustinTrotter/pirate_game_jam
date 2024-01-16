extends Node2D

var MAX_QUEUE_SIZE = 100

# Add an item to the queue if it has not reached its maximum capacity
func add_to_queue(queue, item):
	if len(queue) < MAX_QUEUE_SIZE:
		queue.push_back(item)

# Removes the front item from the queue and returns whether or not the queue was empty
func finish_queue_front(queue):
	return bool(queue.pop_front())
