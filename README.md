# Blocipedia [![Code Climate](https://codeclimate.com/github/silvio-galli/blocipedia/badges/gpa.svg)](https://codeclimate.com/github/silvio-galli/blocipedia)

SaaS Wiki Collaboration Tool made with the help of my mentor [Charlie Gaines](https://github.com/beaugaines) at [Bloc](http://www.bloc.io).

[Demo available here](https://floating-ocean-14149.herokuapp.com/) on Heroku platform.

The source code is on [GitHub](https://github.com) at: [https://github.com/silvio-galli/bloccit](https://github.com/silvio-galli/blocipedia)


## Tech specs
The project is based on **Ruby on Rails**, uses **Bootstrap** for the layout and other elements on the page.

**Database seeding** is obtained using the [Faker](https://github.com/stympy/faker) gem.

The project makes also use of a little **javascript** and **jQuery** through the [showdown](https://github.com/showdownjs/showdown) javascript library to allow live Markdown to HTML preview with the help of the [Redcarpet](https://github.com/vmg/redcarpet) gem.

**Environment variables and keys** are managed with the help of [Figaro](https://github.com/laserlemon/figaro) gem.

**Authentication** is managed through the [Devise](https://github.com/plataformatec/devise) gem.
Every new user is required to confirm his/her subscription via email confirmation notification that is sent using `ActionMailer` through a Google account, in [development](https://github.com/silvio-galli/blocipedia/blob/master/config/environments/development.rb) and [production](https://github.com/silvio-galli/blocipedia/blob/master/config/environments/production.rb) environment.
Google keys are managed using [Figaro](https://github.com/laserlemon/figaro) gem.

**Authorization** is handled through the [Pundit](https://github.com/elabs/pundit) gem.

The app makes use of the [Stripe](https://github.com/stripe/stripe-ruby) gem and API to create Premium Users (read *paying users*). Stripe keys are managed using [Figaro](https://github.com/laserlemon/figaro) gem.

**URLs** are human friendly strings created using [FriendlyId](https://github.com/norman/friendly_id) gem.


## Features

- Everybody is allowed to take a look at the list of wikis, but only signed in users can fully read wikis or write a new one.
- The app features two plans: free plan (*member user*) and premium plan (*premium user*).
- Member users can create only public wikis. Premium users can create public and private wikis.
- Every new user is registered as *member user*.
- Every member user can upgrade to premium plan through a subscription of 10 $ via Stripe.
- Every premium user can downgrade to free plan with one click.
- Every premium user can add collaborators for private wikis even if they are not premium users.



---

###### mentioned gems
![](https://img.shields.io/badge/rails-4.2.5-green.svg?style=flat)
![](https://img.shields.io/badge/bootstrap_sass-3.3.5.1-green.svg?style=flat)
![](https://img.shields.io/badge/faker-1.6.3-green.svg?style=flat)
![](https://img.shields.io/badge/jquery_rails-4.0.5-green.svg?style=flat)
![](https://img.shields.io/badge/redcarpet-3.3.4-green.svg?style=flat)
![](https://img.shields.io/badge/figaro-1.1.1-green.svg?style=flat)
![](https://img.shields.io/badge/devise-3.5.6-green.svg?style=flat)
![](https://img.shields.io/badge/pundit-1.1.0-green.svg?style=flat)
![](https://img.shields.io/badge/stripe-1.37.0-green.svg?style=flat)
![](https://img.shields.io/badge/friendly_id-5.1.0-green.svg?style=flat)
