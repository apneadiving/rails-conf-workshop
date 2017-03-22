# CommandsWorkshop
This is the repository for the [rails conf workshop](http://railsconf.com/program/workshops#session-115)

## Overall explanations
It contains an example of fairly innocent code at first sight in the [invitations_controller](https://github.com/apneadiving/rails-conf-workshop/blob/master/app/controllers/invitations_controller.rb).

Its a basic example of what we face most of the time when code is shipped quickly.
Even though it works and its tested, most of the logic is actually hidden in callbacks (who would expect a payment to be made just by reading the controller's code?).
And as I've seen very often:
- models are crying to get context (most of the time relying on additionnal instance variables).
- and only happy path is taken into account which means data would be in a bad state if error happens somewhere

The refactoring we'll do is expected to fix this.

## Setup
The app simpy uses sqlite3 as a db. I tried to keep minimum dependencies.
Just install required gems
```bash
bundle
```

and then ensure everything is ok by running the specs:
```bash
rake
```

## Course of action
- read together [invitations_controller_spec](https://github.com/apneadiving/rails-conf-workshop/blob/master/spec/controllers/invitations_controller_spec.rb), particularly the commented one
- implement [user/signup](https://github.com/apneadiving/rails-conf-workshop/blob/master/app/services/services/user/signup.rb)
- implement [invitation/create](https://github.com/apneadiving/rails-conf-workshop/blob/master/app/services/services/invitation/create.rb)
- notice invitation accept is actually a relevant piece of logic and move code from controller to [invitation/accept](https://github.com/apneadiving/rails-conf-workshop/blob/master/app/services/services/invitation/accept.rb)
- split code to relevant services: [user/create_from_invitation](https://github.com/apneadiving/rails-conf-workshop/blob/master/app/services/services/user/create_from_invitation.rb), [user/credit](https://github.com/apneadiving/rails-conf-workshop/blob/master/app/services/services/user/credit.rb)
- change user/create_from_invitation, user/credit to boolean services so we can call them from invitation/accept
- change to waterfall implementation
