const express = require('express');
const helmet = require('helmet');
const escapeHtml = require('escape-html');

const app = express();
const port = process.env.PORT || 3000;

app.use(helmet());
app.use(express.json());

app.get('/', (req, res) => {
  res.json({
    service: 'DevSecOps Mini Pipeline',
    status: 'ok',
    message: 'Security checks are part of the delivery pipeline.'
  });
});

app.get('/health', (req, res) => {
  res.status(200).json({ status: 'healthy' });
});

app.get('/search', (req, res) => {
  const query = escapeHtml(req.query.q || '');
  res.send(`<h1>Search results for ${query}</h1>`);
});

if (require.main === module) {
  app.listen(port, () => {
    console.log(`App listening on port ${port}`);
  });
}

module.exports = app;
