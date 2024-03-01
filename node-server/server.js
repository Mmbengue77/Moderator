const express = require('express');
const bodyParser = require('body-parser');
const axios = require('axios');

const app = express();
const port = 3000;

app.use(bodyParser.json());

// Utiliser des routes spécifiques pour la modération depuis le fichier moderationRoutes
const moderationRoutes = require('./routes/moderationRoutes');
app.use('/api/moderation', moderationRoutes);

// Exemple de route dans Node.js pour la modération
app.post('/moderate', async (req, res) => {
  const { text } = req.body;
  try {
    const response = await axios.post('https://moderation.logora.fr/predict', {
      text: text,
    });
    res.json(response.data);
  } catch (error) {
    res.status(500).json({ error: 'Erreur lors de la modération' });
  }
});

app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
