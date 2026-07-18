<?php

namespace App\Controllers\Api;

use App\Controllers\BaseController;
use App\Models\BookingModel;

class MyBookings extends BaseController
{
    public function index()
    {
        $userId = $this->request->getGet('user_id');
        
        if (!$userId) {
            return $this->response->setStatusCode(400)->setJSON([
                'status' => 'error',
                'message' => 'user_id is required',
            ]);
        }

        $bookingModel = new BookingModel();
        $bookings = $bookingModel
            ->select('bookings.*, hotels.name as hotel_name, rooms.room_type')
            ->join('rooms', 'rooms.id = bookings.room_id')
            ->join('hotels', 'hotels.id = rooms.hotel_id')
            ->where('bookings.user_id', $userId)
            ->orderBy('bookings.created_at', 'DESC')
            ->findAll();

        return $this->response->setJSON([
            'status' => 'success',
            'data'   => $bookings,
        ]);
    }
}
