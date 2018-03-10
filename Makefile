.PHONY: build prepare run test seed down reset setup

PROJECT=workbench

DCEXE=docker-compose
DCFLAGS=-p $(PROJECT)
DC=$(DCEXE) $(DCFLAGS)

DOCKER=docker

%:
	$(DC) $@

start:
	docker-compose up peatio barong

test: prepare
	docker-compose run --rm peatio_specs

reset: purge
	docker-compose run --rm peatio "rake db:create db:migrate"
	docker-compose run --rm barong "rake db:create db:migrate"

seed:
	docker-compose run --rm peatio "rake db:seed"

run-rm:
	$(DC) peatio "rake db:create db:migrate"
	$(DC) barong "rake db:create db:migrate"

reset-db:
	$(DOCKER) volume rm $(PROJECT)_db_data

down:
	$(DC) down

purge: down reset-db

