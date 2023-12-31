#!/bin/bash

# Define the name of the HTML file
HTML_FILE="game.html"

# Write the HTML and JavaScript into the HTML file
cat <<EOF > $HTML_FILE
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Game</title>
    <style>
        /* Add your CSS styles here if any */
        body, html {
            height: 100%;
            margin: 0;
            overflow: hidden;
        }
        #mobile-container {
            position: relative;
            width: 100%;
            height: 100%;
        }
    </style>
</head>
<body>
    <div id="mobile-container"></div>
    <script>
      document.addEventListener('DOMContentLoaded', function() {
    const container = document.querySelector('#mobile-container');
    const topBackgroundHeight = '150px'; // Example, adjust as needed

    // Create and style the top background
    const topBackground = document.createElement('div');
    topBackground.style.cssText = `
        width: 100%;
        height: ${topBackgroundHeight};
        background-color: blue;
        position: absolute;
        top: 0;
        left: 0;
        z-index: -1;
    `;
    container.appendChild(topBackground);

    // Create and style the counter
    const counter = document.createElement('div');
    counter.textContent = '00000';
    counter.style.cssText = `
        position: absolute;
        top: 10px;
        left: 50%;
        transform: translateX(-50%);
        color: white;
        font-size: 3em;
        font-family: Arial, sans-serif;
        z-index: 10;
    `;
    document.body.appendChild(counter);

    let projectileCount = 0;
    const opponents = [];
    const projectiles = [];

    // Set up the player (blue circle)
    const circle = document.createElement('div');
    circle.style.cssText = `
        width: 50px;
        height: 50px;
        background-color: blue;
        border-radius: 50%;
        position: absolute;
        bottom: 70px;
        left: 50%;
        transform: translateX(-50%);
        cursor: pointer;
    `;
    container.appendChild(circle);

    // Add a tap prompt element
    const tapDotElement = document.createElement('div');
    tapDotElement.textContent = "TAP THE DOT";
    tapDotElement.style.cssText = `
        position: absolute;
        bottom: 50px;
        left: 50%;
        transform: translateX(-50%);
        font-family: system-ui, sans-serif;
    `;
    container.appendChild(tapDotElement);

    let isDragging = false;
    let startDragY = 0;
    let startCircleBottom = 0;
    const radius = 25;

    // Function to update the counter display
    function updateCounter() {
        projectileCount++;
        counter.textContent = String(projectileCount).padStart(5, '0');
    }

    // Collision and game over logic
    let collisionCount = 0;

    function checkGameOver() {
        collisionCount++;
        if (collisionCount >= 3) {
            showGameOverScreen();
        }
    }

    // Projectile and opponent creation and animation code...

    // Generate opponents in rows
    function generateOpponentsInRows() {
        // Code to generate opponents...
    }

    setInterval(generateOpponentsInRows, 2000);

    // Event listeners for dragging and shooting
    circle.addEventListener('mousedown', function(event) {
        // Dragging logic...
    });

    document.addEventListener('mousemove', function(event) {
        // Mouse movement logic...
    });

    document.addEventListener('mouseup', function() {
        // Shooting logic...
        const projectile = document.createElement('div');
        projectile.style.cssText = `
            width: 25px;
            height: 25px;
            background-color: blue;
            border-radius: 50%;
            position: absolute;
            bottom: ${(parseFloat(circle.style.bottom) + 25)}px;
            left: 50%;
            transform: translateX(-50%);
        `;

        container.appendChild(projectile);
        projectiles.push(projectile);

        requestAnimationFrame(() => animateProjectile(projectile));

        circle.style.transition = 'bottom 0.5s cubic-bezier(.25,.82,.25,1)';
        circle.style.bottom = '70px';
        setTimeout(() => circle.style.transition = '', 500);
    });

    // Projectile animation and collision checking
    function animateProjectile(projectile) {
        // Projectile animation logic...
    }

    // Show the game over screen
    function showGameOverScreen() {
        const gameOverScreen = document.createElement('div');
        gameOverScreen.style.cssText = `
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.8);
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
            color: white;
            font-size: 2em;
            z-index: 1000;
        `;

        const gameOverText = document.createElement('div');
        gameOverText.textContent = 'GAME OVER';

        const playAgainButton = document.createElement('button');
        playAgainButton.textContent = 'Play Again';
        playAgainButton.style.cssText = `
            margin-top: 20px;
            font-size: 1em;
        `;
        playAgainButton.onclick = function() {
            window.location.reload();
        };

        gameOverScreen.appendChild(gameOverText);
        gameOverScreen.appendChild(playAgainButton);
        document.body.appendChild(gameOverScreen);
    }

    // Collision detection
    function checkCollision(projectile) {
        const projectileRect = projectile.getBoundingClientRect();
        opponents.forEach((opponent, opponentIndex) => {
            const opponentRect = opponent.getBoundingClientRect();
            if (projectileRect.left < opponentRect.right &&
                projectileRect.right > opponentRect.left &&
                projectileRect.top < opponentRect.bottom &&
                projectileRect.bottom > opponentRect.top) {
                
                opponent.remove();
                opponents.splice(opponentIndex, 1);
                projectile.remove();
                projectiles.splice(projectiles.indexOf(projectile), 1);

                // Check for game over
                checkGameOver();
            }
        });
    }
});

    </script>
</body>
</html>
EOF

# Open the default web browser and load the game
if command -v xdg-open > /dev/null; then
    # For Linux
    xdg-open $HTML_FILE
elif command -v open > /dev/null; then
    # For MacOS
    open $HTML_FILE
else
    echo "Could not detect the web browser to open the file."
fi
