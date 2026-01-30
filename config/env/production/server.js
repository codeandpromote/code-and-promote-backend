module.exports = ({ env }) => ({
  host: '0.0.0.0', // <--- This allows Render to "see" your app
  port: env.int('PORT', 1337),
  app: {
    keys: env.array('APP_KEYS'),
  },
  webhooks: {
    populateRelations: env.bool('WEBHOOKS_POPULATE_RELATIONS', false),
  },
});