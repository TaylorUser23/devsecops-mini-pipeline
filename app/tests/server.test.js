const request = require('supertest');
const app = require('../src/server');

describe('DevSecOps Mini App', () => {
  test('GET / returns service status', async () => {
    const res = await request(app).get('/');
    expect(res.statusCode).toBe(200);
    expect(res.body.status).toBe('ok');
  });

  test('GET /health returns healthy status', async () => {
    const res = await request(app).get('/health');
    expect(res.statusCode).toBe(200);
    expect(res.body.status).toBe('healthy');
  });

  test('GET /search encodes HTML input', async () => {
    const res = await request(app).get('/search?q=<script>alert(1)</script>');
    expect(res.statusCode).toBe(200);
    expect(res.text).toContain('&lt;script&gt;alert(1)&lt;/script&gt;');
    expect(res.text).not.toContain('<script>alert(1)</script>');
  });
});
