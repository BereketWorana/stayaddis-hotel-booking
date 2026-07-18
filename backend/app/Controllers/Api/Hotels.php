<?php

namespace App\Controllers\Api;

use App\Controllers\BaseController;
use App\Models\HotelModel;
use App\Models\RoomModel;

class Hotels extends BaseController
{
    // GET /api/hotels
    public function index()
    {
        $hotelModel = new HotelModel();
        $hotels = $hotelModel->findAll();

        return $this->response->setJSON([
            'status' => 'success',
            'data'   => $hotels,
        ]);
    }

    // GET /api/hotels/{id}
    public function show($id = null)
    {
        $hotelModel = new HotelModel();
        $roomModel = new RoomModel();

        $hotel = $hotelModel->find($id);

        if (!$hotel) {
            return $this->response->setStatusCode(404)->setJSON([
                'status'  => 'error',
                'message' => 'Hotel not found',
            ]);
        }

        $rooms = $roomModel->getByHotel($id);
        $images = $hotelModel->getWithImages($id);

        // Extract unique images
        $gallery = [];
        foreach ($images as $img) {
            $gallery[] = [
                'image_path' => $img['image_path'],
                'caption'    => $img['caption'],
            ];
        }

        return $this->response->setJSON([
            'status' => 'success',
            'data'   => [
                'hotel'   => $hotel,
                'rooms'   => $rooms,
                'gallery' => $gallery,
            ],
        ]);
    }
}