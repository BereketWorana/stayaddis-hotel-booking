<?php

namespace App\Controllers\Api;

use App\Controllers\BaseController;
use App\Models\RoomModel;

class Rooms extends BaseController
{
    // GET /api/rooms?hotel_id=1
    public function index()
    {
        $roomModel = new RoomModel();
        $hotelId = $this->request->getGet('hotel_id');

        if ($hotelId) {
            $rooms = $roomModel->getByHotel($hotelId);
        } else {
            $rooms = $roomModel->findAll();
        }

        return $this->response->setJSON([
            'status' => 'success',
            'data'   => $rooms,
        ]);
    }
}