FROM circleci/node:latest-browsers

WORKDIR /usr/src/app/
USER root
COPY package.json ./
RUN yarn

COPY ./ ./

RUN npm run test:all
RUN npm run build

#CMD ["npm", "run", "build"]
CMD ["npm", "start"]
