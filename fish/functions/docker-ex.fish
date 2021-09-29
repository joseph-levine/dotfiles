function docker-ex
    docker exec -it $argv[1] /bin/sh -c 'if [ -x /bin/bash ]; then /bin/bash; else /bin/sh; fi'
end
