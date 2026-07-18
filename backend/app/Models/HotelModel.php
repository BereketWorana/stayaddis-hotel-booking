<?php

namespace App\Models;

use CodeIgniter\Model;

class HotelModel extends Model
{
    protected $table      = 'hotels';
    protected $primaryKey = 'id';
    protected $allowedFields = [
        'name', 'description', 'star_rating', 'address', 'city', 'cover_image'
    ];

    // Get hotel with its gallery images
    public function getWithImages($id)
    {
        return $this->select('hotels.*, hotel_images.image_path, hotel_images.caption')
                    ->join('hotel_images', 'hotel_images.hotel_id = hotels.id', 'left')
                    ->where('hotels.id', $id)
                    ->orderBy('hotel_images.sort_order', 'ASC')
                    ->findAll();
    }

    // Get all hotels with room count
    public function getAllWithRoomCount()
    {
        return $this->select('hotels.*, COUNT(rooms.id) as room_count')
                    ->join('rooms', 'rooms.hotel_id = hotels.id', 'left')
                    ->groupBy('hotels.id')
                    ->findAll();
    }
}