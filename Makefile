
def:
	docker build -t "pyramation/postgres-plv8" .

ssh:
	docker run -it pyramation/postgres-plv8 /bin/bash

