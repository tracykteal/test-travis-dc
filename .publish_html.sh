#!/bin/bash


if [[ "${TRAVIS_PULL_REQUEST}" != 'false' ]]; then
    echo "we don't publish PR"
    exit 0
elif [[ "${TRAVIS_BRANCH}" != 'master' ]]; then
    echo "we only publish master"
    exit 0
else
    echo ${FULL_REPO}
    mkdir -p ${APP_DIR}
    git clone ${FULL_REPO} ${APP_DIR}
    cd ${APP_DIR}
    git config user.name "${USER_NAME}"
    git config user.email "${USER_EMAIL}"
    git checkout gh-pages
    cp /home/travis/build/${USER_NAME}/${NAME_REPO}/*.html ${APP_DIR}
    cp /home/travis/build/${USER_NAME}/${NAME_REPO}/handout-script.R ${APP_DIR}
    git add *.html
    git add handout-script.R
    git commit -m "[travis] update html pages + handout"
    git push ${FULL_REPO} HEAD:gh-pages
fi
