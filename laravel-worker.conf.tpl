[supervisord]
nodaemon=true

[program:laravel-worker]
process_name=%(program_name)s_%(process_num)02d
command=php /var/www/app/artisan queue:listen %%QUEUE_CONNECTION%% --queue=%%QUEUE_NAME%% --memory=%%MEMORY_LIMIT%% --tries=%%RETRIES%% --timeout=%%TIMEOUT%%
autostart=true
autorestart=true
numprocs=%%WORKER_AMOUNT%%
startretries=10
stdout_events_enabled=1
stdout_logfile=/dev/stdout
stdout_logfile_maxbytes=0