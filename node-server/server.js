const express = require('express');
const bodyParser = require('body-parser');
const moderationRoutes = require('./routes/moderationRoutes');

const app = express();
const port = 3000;

app.use(bodyParser.json());

app.use('/api/moderation', moderationRoutes);

app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
