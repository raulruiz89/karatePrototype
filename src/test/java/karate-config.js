function fn() {
  // get system property 'karate.env'
  var env = karate.env;
  
  if (!env) {
    env = 'qa';
  }

  karate.log('karate.env system property was:', env);

  // base configuration
  var config = {
    env: env,
    baseUrl: 'https://jsonplaceholder.typicode.com',
    apiVersion: 'v1',
    userAgent: 'Karate/1.0',
    timeout: 5000,
    retry: {
      count: 3,
      interval: 3000
    },
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    },
    // Schema validation settings
    schemaValidation: true,
    schemas: {
      user: 'classpath:schemas/user-schema.json',
      post: 'classpath:schemas/post-schema.json',
      comment: 'classpath:schemas/comment-schema.json',
      album: 'classpath:schemas/album-schema.json'
    }
  }

  if (env == 'dev') {
    // customize
    config.baseUrl = 'https://dev.jsonplaceholder.typicode.com/';
    config.user = 'devUser';
    config.pass = 'devPass';

  } else if (env == 'stg') {
    // customize
    config.baseUrl = 'https://stg.jsonplaceholder.typicode.com/';
    config.user = 'stgUser';
    config.pass = 'stgPass';
  }

  return config;
}