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
[See presentation](https://slides.com/apneadiving/rails-conf-intro)
