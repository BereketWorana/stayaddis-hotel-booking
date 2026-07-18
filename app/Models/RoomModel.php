<?php

namespace App\Models;

use CodeIgniter\Model;

class RoomModel extends Model
{
    protected $table      = 'rooms';
    protected $primaryKey = 'id';
    protected $allowedFields = [
        'hotel_id', 'room_type', 'description', 'price_per_night',
        'capacity', 'available_count', 'image'
    ];

    // Get rooms for a specific hotel
    public function getByHotel($hotelId)
    {
        return $this->where('hotel_id', $hotelId)->findAll();
    }
}