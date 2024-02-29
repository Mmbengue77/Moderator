const express = require('express');
const router = express.Router();
const { predict, score } = require('../controllers/moderationController');

router.post('/predict', predict);
router.post('/score', score);

module.exports = router;
