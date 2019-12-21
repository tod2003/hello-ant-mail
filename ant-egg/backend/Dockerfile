FROM circleci/node

WORKDIR /usr/src/app/
USER root
COPY package.json ./

COPY ./ ./

#CMD ["npm", "run", "build"]
CMD ["npm", "start"]
