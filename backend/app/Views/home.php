<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>StayAddis - Hotels in Addis Ababa</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: Arial, sans-serif; background: #f5f5f5; }
        .header { background: #1a1a2e; color: white; padding: 20px; text-align: center; }
        .container { max-width: 1200px; margin: 0 auto; padding: 20px; }
        .hotel-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(350px, 1fr)); gap: 20px; }
        .hotel-card { background: white; border-radius: 10px; overflow: hidden; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .hotel-card img { width: 100%; height: 220px; object-fit: cover; }
        .hotel-info { padding: 15px; }
        .hotel-info h3 { margin-bottom: 5px; color: #1a1a2e; }
        .stars { color: #f4b400; margin-bottom: 8px; }
        .hotel-info p { color: #666; font-size: 14px; margin-bottom: 10px; }
        .btn { display: inline-block; background: #e94560; color: white; padding: 8px 16px; text-decoration: none; border-radius: 5px; }
    </style>
</head>
<body>
    <div class="header">
        <h1>🏨 StayAddis</h1>
        <p>Find the perfect hotel in Addis Ababa</p>
    </div>

    <div class="container">
        <div class="hotel-grid">
            <?php foreach ($hotels as $hotel): ?>
            <div class="hotel-card">
                <img src="/assets/images/<?= $hotel['cover_image'] ?>" alt="<?= $hotel['name'] ?>">
                <div class="hotel-info">
                    <h3><?= $hotel['name'] ?></h3>
                    <div class="stars">
                        <?= str_repeat('⭐', $hotel['star_rating']) ?>
                    </div>
                    <p><?= $hotel['description'] ?></p>
                    <a href="/hotel/<?= $hotel['id'] ?>" class="btn">View Details</a>
                </div>
            </div>
            <?php endforeach; ?>
        </div>
    </div>
</body>
</html>