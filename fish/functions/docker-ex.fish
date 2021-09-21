function docker-ex
    docker exec -it $argv[1] /bin/bash || /bin/sh
end
