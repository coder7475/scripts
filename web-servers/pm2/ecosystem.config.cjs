module.exports = {
  apps: [
    {
      name: 'app_name',
      script: 'pnpm start', // start script
      env: {
        NODE_ENV: 'production', // mode
        PORT: 5000   // port
      }
    },
  ],
}
