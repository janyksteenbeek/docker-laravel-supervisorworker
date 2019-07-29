# Laravel Queue Worker

A Docker image for running your Laravel queue workers inside Supervisord. The Docker image runs on PHP 7.3.

## Environment Configuration

The following environment variables are available:

| Variable         | Name                  | Description                                                            | Default |
|------------------|-----------------------|------------------------------------------------------------------------|---------|
| PHP_MEMORY_LIMIT | PHP memory limit      | The memory (RAM) limit per worker                                      | 512     |
| RETRIES          | Worker retries        | The amount of times a worker should retry a job before failing         | 5       |
| QUEUE_CONNECTION | Queue connection name | The name of the Laravel queue connection the workers should use        | redis   |
| QUEUE_NAME       | Queue name            | The name of the queue on the connection the workers should use         | default |
| WORKER_AMOUNT    | Amount of workers     | The number of workers that should be spawned on starting the container | 5       |
| TIMEOUT          | Timeout in seconds    | The number of how long a job may be running before failing             | 60      |


## Docker Images

The Docker image is hosted on Docker Hub under [janyksteenbeek/docker-laravel-supervisorworker](https://hub.docker.com/r/janyksteenbeek/docker-laravel-supervisorworker).

## Thanks

This repository is based on the [ipunkt/docker-laravel-queue-worker](https://github.com/ipunkt/docker-laravel-queue-worker) repository. Thanks to ipunkt for their amazing work.