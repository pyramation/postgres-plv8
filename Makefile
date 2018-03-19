
def:
	docker build -t "pyramation/postgres-plv8" .

ssh:
	docker run -it pyramation/postgres-plv8 /bin/bash

run:
	docker run -p 5432:5432 --name plv8 pyramation/postgres-plv8

daemon:
	docker run -p 5432:5432 --name plv8 -d pyramation/postgres-plv8

push:
	docker push pyramation/postgres-plv8
