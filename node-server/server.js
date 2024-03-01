const express = require('express');
const bodyParser = require('body-parser');
const axios = require('axios');

const app = express();
const port = 3000;

app.use(bodyParser.json());

// Endpoint pour la prédiction
app.get('/api/moderation/predict', async (req, res) => {
  const { text } = req.query;

  try {
    const response = await axios.get('https://moderation.logora.fr/predict', {
      params: {
        text: text,
      },
    });

    res.json(response.data);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Erreur lors de la prédiction' });
  }
});

// Endpoint pour le score
app.get('/api/moderation/score', async (req, res) => {
  const { text } = req.query;

  try {
    const response = await axios.get('https://moderation.logora.fr/score', {
      params: {
        text: text,
      },
    });

    res.json(response.data);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Erreur lors de l\'obtention du score de qualité' });
  }
});

app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
