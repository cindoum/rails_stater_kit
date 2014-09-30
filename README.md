[![Build Status](https://travis-ci.org/cindoum/rails_stater_kit.svg?branch=master)](https://travis-ci.org/cindoum/rails_stater_kit) 
#Ruby on rails starter kit

---

> This is a Ruby on rails starter kit. It should contains everything that is needed to start a project.

##Features 
* Angular setup and demo page (using best pratice, such as resolver, service etcc)
* Angular integration with rails (angular-rails-template)
* Slim html template engine (http://slim-lang.com/)
* Websocket integration and demo chat (https://github.com/websocket-rails/websocket-rails)
* Authentication (https://github.com/plataformatec/devise)
* Omniauth google/linked
* Authorization (user/admin) (https://github.com/ryanb/cancan)
* Error management (https://github.com/errbit/errbit)

##Installation

> Need to test if installation setup does not require more step... 

Installation should not be harder than 
    
    git clone git@github.com:cindoum/rails_stater_kit.git 
    
Then set ENV variables used in config/app_config.yml.

* Google client id and client secret (to be use by omniauth)
* Linkedin client id and client secret (to be use by omniauth)
* Errbit API key

Those values are kept in ENV vars to ensure protection of them. They should never appear within a public repository.

##Current version
> 0.1

---
> Feel free to submit PR or open an issue for any bug or enhancement.