<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?= $hotel['name'] ?> - StayAddis</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: Arial, sans-serif; background: #f5f5f5; }
        .header { background: #1a1a2e; color: white; padding: 20px; text-align: center; }
        .header a { color: #e94560; text-decoration: none; }
        .container { max-width: 1000px; margin: 0 auto; padding: 20px; }
        .gallery { display: flex; gap: 10px; overflow-x: auto; padding: 10px 0; }
        .gallery img { height: 200px; border-radius: 10px; }
        .room-card { background: white; padding: 15px; margin: 10px 0; border-radius: 10px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        .room-card h3 { color: #1a1a2e; }
        .price { color: #e94560; font-size: 20px; font-weight: bold; }
        .btn { background: #e94560; color: white; padding: 10px 20px; border: none; border-radius: 5px; cursor: pointer; text-decoration: none; display: inline-block; margin-top: 10px; }
    </style>
</head>
<body>
    <div class="header">
        <h1><?= $hotel['name'] ?></h1>
        <p><?= str_repeat('⭐', $hotel['star_rating']) ?> | <?= $hotel['address'] ?></p>
        <a href="/">← Back to Hotels</a>
    </div>

    <div class="container">
        <h2>Gallery</h2>
        <div class="gallery">
            <?php foreach ($gallery as $img): ?>
            <img src="/assets/images/<?= $img['image_path'] ?>" alt="<?= $img['caption'] ?>">
            <?php endforeach; ?>
        </div>

        <h2>Rooms</h2>
        <?php foreach ($rooms as $room): ?>
        <div class="room-card">
            <h3><?= $room['room_type'] ?></h3>
            <p><?= $room['description'] ?></p>
            <p>Capacity: <?= $room['capacity'] ?> guests | Available: <?= $room['available_count'] ?> rooms</p>
            <p class="price">ETB <?= number_format($room['price_per_night'], 2) ?>/night</p>
            <a href="/book?room_id=<?= $room['id'] ?>" class="btn">Book Now</a>
        </div>
        <?php endforeach; ?>
    </div>
</body>
</html>