<?php

namespace App\Controllers\Api;

use App\Controllers\BaseController;
use App\Models\BookingModel;

class Lookup extends BaseController
{
    public function booking()
    {
        $ref = $this->request->getGet('ref');
        $email = $this->request->getGet('email');

        if (!$ref || !$email) {
            return $this->response->setStatusCode(400)->setJSON([
                'status' => 'error',
                'message' => 'Reference and email are required',
            ]);
        }

        $bookingModel = new BookingModel();
        $booking = $bookingModel
            ->select('bookings.*, users.full_name, users.email, hotels.name as hotel_name, rooms.room_type')
            ->join('users', 'users.id = bookings.user_id')
            ->join('rooms', 'rooms.id = bookings.room_id')
            ->join('hotels', 'hotels.id = rooms.hotel_id')
            ->where('booking_reference', strtoupper($ref))
            ->where('users.email', $email)
            ->first();

        if (!$booking) {
            return $this->response->setStatusCode(404)->setJSON([
                'status' => 'error',
                'message' => 'Booking not found. Check your reference and email.',
            ]);
        }

        return $this->response->setJSON([
            'status' => 'success',
            'data' => $booking,
        ]);
    }
}
