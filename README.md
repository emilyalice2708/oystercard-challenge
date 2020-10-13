# Oystercard Challenge

Week 2 pair programming challenge.

## Goals:
- Break one class into two classes without compromising test coverage.
- Unit test classes in isolation using mocking.
- Use basic OO principles.

## How to run

Using irb:
```
irb
require './lib/oystercard.rb'
```
Running tests:
- Tests written with rspec, run from root directory:
```
rspec
```

## Approach
- Analyse user stories to create basic plan.
- Test drive the development of each class.
- Extract classes to improve readability.

### User Stories

In order to use public transport
As a customer
I want money on my card

|Objects|Messages|
|----------|-----------|
|Customer||
|Card|balance|

In order to keep using public transport
As a customer
I want to add money to my card

|Objects|Messages|
|----------|-----------|
|Customer||
|Card|top_up(payment)|

In order to protect my money
As a customer
I don't want to put too much money on my card

Required:
- Maximum balance constant.
- Private method checking whether balance will be exceeded during top_up (guard required).

In order to pay for my journey
As a customer
I need my fare deducted from my card

|Objects|Messages|
|----------|-----------|
|Customer||
|Card|deduct(fare)|
|Journey||

In order to get through the barriers
As a customer
I need to touch in and out

|Objects|Messages|
|----------|-----------|
|Customer||
|Card|touch_in, touch_out|

In order to pay for my journey
As a customer
I need to have the minimum amount for a single journey

Required:
- Minimum balance constant.
- Balance check guard for touch_in method.

In order to pay for my journey
As a customer
I need to pay for my journey when it's complete

|Objects|Messages|
|----------|-----------|
|Customer||
|Journey|complete?|

In order to pay for my journey
As a customer
I need to know where I've travelled from

|Objects|Messages|
|----------|-----------|
|Customer||
|Journey|entry_station|

In order to know where I have been
As a customer
I want to see to all my previous trips

|Objects|Messages|
|----------|-----------|
|Customer||
|Card|journey_log|

In order to know how far I have travelled
As a customer
I want to know what zone a station is in

|Objects|Messages|
|----------|-----------|
|Customer||
|Station|zone|

In order to be charged correctly
As a customer
I need a penalty charge deducted if I fail to touch in or out

Required:
- Penalty constant.

In order to be charged the correct amount
As a customer
I need to have the correct fare calculated

|Objects|Messages|
|----------|-----------|
|Customer||
|Journey|calculate_fare|
