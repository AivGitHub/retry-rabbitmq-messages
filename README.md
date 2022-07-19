## About The Project

![Alt text](docs/img/rabbitmq_expiration_not_working.png?raw=true "RabbitMq expiration not working")

If you have ever used [RabbitMQ](https://www.rabbitmq.com/) you googled this.

Pure [RabbitMQ](https://www.rabbitmq.com/ttl.html#per-message-ttl-caveats) does not support working flexible different
expiration time of messages and as we know not always possible to install plugins or whatever on servers.

This project shows how we can set exponential backoff in RabbitMQ without plugins. Only python code.

Also, this project can be used as an
[example/skeleton](https://en.wikipedia.org/wiki/Skeleton_(computer_programming)) ~~**without dummy word**~~ of
[Django](https://www.djangoproject.com/) + [UWSGI](https://uwsgi-docs.readthedocs.io/) for production,
there are not many examples of that.

Moreover, this project is using [mules](https://uwsgi-docs.readthedocs.io/en/latest/Mules.html) for messaging,
which are served by [UWSGI](https://uwsgi-docs.readthedocs.io/), there are even fewer examples (good examples).

### Lies:
1. Everyone says run it with `./manage.py runserver` and that's all
2. To run some function only once on
[Django](https://docs.djangoproject.com/en/4.0/ref/applications/#django.apps.AppConfig.ready) start
add method to `def ready(self)` to a `class ApplicationConfig` and
run `./manage.py runserver --noreload`

**This is a LIE, don't trust these resources, or you will get a lot of problems on production.**

#### On production problems will be like:
1. Why this function called twice?
2. Why this process is duplicated?
3. Why my styles/media files are not working?

#### Why this happens:
1. `./manage.py runserver` runs two processes,
one of those managing child process to reload
[Django](https://docs.djangoproject.com/en/4.0/ref/django-admin/#runserver) on code change
2. [UWSGI](https://uwsgi-docs.readthedocs.io/) runs two processes, one of those managing child process to
reload server if something goes wrong.
We can run only one process, but don't do that or your application/mules won't be reloaded if something goes wrong
3. [Django](https://docs.djangoproject.com/en/4.0/howto/static-files/) does not serve static/media files.
It should be served by Nginx,
if we are talking about clean code without dirty hacks like whitenoise or adding something to `urls.py`

### Problem:
1. Hidden in [RabbitMQ caveats](https://www.rabbitmq.com/ttl.html#per-message-ttl-caveats)
2. If you put messages in temporary queue with different expiration time messages will be blocked by message on top

### Solution:
1. Create temporary queues with expiration time, for example tmp.routing.key-N, where N is an expiration time
2. This allows to use exponential expiration time of messages

### Caveats:
1. This method will create r*n temporary queues in the worst case, where r is an amount of queues (or routing keys),
and n is an amount of retries

<p align="right">(<a href="#top">back to top</a>)</p>

## Getting Started

### Prerequisites

1. [Python](https://www.python.org/) >= 3.8.10
2. You have [RabbitMQ](https://www.rabbitmq.com/download.html) running,
if not run it with
[`bash`](https://www.gnu.org/software/bash/) [`run_rabbitmq.sh`](run_rabbitmq.sh) in separate console
3. Create [`.env`](https://docs.docker.com/compose/env-file/) file or
add path to file in `CORE_ENV_FILE` [environ](https://wiki.archlinux.org/title/environment_variables)
with the next variables:
   - `CORE_SECRET_KEY='some_secret_value'`,
   it is a [Django](https://docs.djangoproject.com/en/4.0/ref/settings/#secret-key) SECRET_KEY
   - `CORE_DEBUG=False`, it is a [Django](https://docs.djangoproject.com/en/4.0/ref/settings/#debug) DEBUG.
   False to production
   - `CORE_ALLOWED_HOSTS='localhost,192.168.1.0'`,
   it is a [Django](https://docs.djangoproject.com/en/4.0/ref/settings/#allowed-hosts) ALLOWED_HOSTS
   - `CORE_AMQP_URL='localhost:5432'`,
   it is a host of RabbitMQ server

### Installation

1. `python -m venv .venv`
2. `source .venv/bin/activate`
3. `pip install -r requirements.txt`

<p align="right">(<a href="#top">back to top</a>)</p>

## Usage

1. To run in dev mod
(caution: without [mules](https://uwsgi-docs.readthedocs.io/en/latest/Mules.html)) run `./manage.py runserver`
2. To run in production with
[mules](https://uwsgi-docs.readthedocs.io/en/latest/Mules.html) run `bash wsgi-entrypoint.sh`
3. To run in
[docker](https://docs.docker.com/engine/reference/commandline/compose_up/) container run `docker-compose up`.\
Runs Django application, Nginx in Docker

## Roadmap

* [x] Run [Django](https://docs.djangoproject.com/en/4.0/howto/deployment/wsgi/uwsgi/) application in production mod
* [] Add [RabbitMQ](https://www.rabbitmq.com/) with exponential time retries
* [x] Add [Nginx](https://www.nginx.com//) to serve static/media files
* [x] Add [Docker](https://www.docker.com/) container.
To be honest I'm not the fan of dockers,
I prefer full isolation like [dedicated server](https://en.wikipedia.org/wiki/Dedicated_hosting_service) or
[VirtualBox](https://www.virtualbox.org/) at least

## Contributing

1. Fork the Project
2. Open a Pull Request
3. Or just read
[here: contributing to projects](https://docs.github.com/en/get-started/quickstart/contributing-to-projects)

<p align="right">(<a href="#top">back to top</a>)</p>

# License

Distributed under the MIT License. See [LICENSE.txt](LICENSE.txt) for more information.

<p align="right">(<a href="#top">back to top</a>)</p>

## Contact

Hi all,

How are you? Hope You've enjoyed the project.

There are my contacts:

- [@linkedin](https://linkedin.com/in/aiv)
- [Send an Email](mailto:coldie322@gmail.com?subject=[GitHub]-retry-rabbitmq-messages)

Project Link:
[https://github.com/AivGitHub/retry-rabbitmq-messages](https://github.com/AivGitHub/retry-rabbitmq-messages)

Best regards,\
Ivan Koldakov

<p align="right">(<a href="#top">back to top</a>)</p>
