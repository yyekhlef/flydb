#!/bin/sh

log() {
    echo -e "\033[34m\033[1m$1\033[0m"
}
notice() {
    echo -e "\033[34m$1\033[0m"
}

FLYWAY_VERSION=3.2.1

test -d flyway-${FLYWAY_VERSION} || {
    notice "Download and extract flyway-commandline ${FLYWAY_VERSION}"
    wget http://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/${FLYWAY_VERSION}/flyway-commandline-${FLYWAY_VERSION}.tar.gz
    tar xzf flyway-commandline-${FLYWAY_VERSION}.tar.gz
}

test -f ./flyway || {
    ln -s flyway-${FLYWAY_VERSION}/flyway .
}

log "Flyway ${FLYWAY_VERSION}.. done"

docker images | grep mysql || {
    notice "Downloading Mysql docker image (mysql:5.6)"
    docker pull mysql:5.6
}

docker ps | grep mysqlcd || {
    notice "Running a Mysql docker image with ROOT_PASSWORD=root o/"
    docker run --name mysqlcd -e MYSQL_ROOT_PASSWORD=root -v ${PWD}/data:/var/lib/mysql/ -p 3306:3306 -d mysql:5.6
}

log "MySQL.. done and running"
notice "... wait a few seconds to let MySQL start ..."
sleep 5

test -e ./mysql-shell || {
    notice "Create a mysql-shell script"
    cat >mysql-shell <<EOF
#!/bin/sh
docker run -it --link mysqlcd:mysql --rm mysql:5.6 sh -c 'exec mysql -h"\$MYSQL_PORT_3306_TCP_ADDR" -P"\$MYSQL_PORT_3306_TCP_PORT" -uroot -p"\$MYSQL_ENV_MYSQL_ROOT_PASSWORD"'
EOF
    chmod +x mysql-shell
}

log "Create default schema if not exists"
docker run -it --link mysqlcd:mysql --rm mysql:5.6 sh -c 'exec mysql -h"$MYSQL_PORT_3306_TCP_ADDR" -P"$MYSQL_PORT_3306_TCP_PORT" -uroot -p"$MYSQL_ENV_MYSQL_ROOT_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS todos;"'
