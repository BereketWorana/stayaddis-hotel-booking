<?php

namespace App\Controllers\Api;

use App\Controllers\BaseController;
use App\Models\BookingModel;
use App\Models\UserModel;
use App\Models\RoomModel;

class Bookings extends BaseController
{
    public function create()
    {
        $rules = [
            'room_id'    => 'required|integer',
            'check_in'   => 'required|valid_date',
            'check_out'  => 'required|valid_date',
            'guests'     => 'required|integer|greater_than[0]',
            'full_name'  => 'required|min_length[3]',
            'email'      => 'required|valid_email',
            'phone'      => 'required|min_length[10]',
        ];

        if (!$this->validate($rules)) {
            return $this->response->setStatusCode(400)->setJSON([
                'status'  => 'error',
                'message' => 'Validation failed',
                'errors'  => $this->validator->getErrors(),
            ]);
        }

        $data = $this->request->getPost();

        // Find or create user
        $userModel = new UserModel();
        $user = $userModel->where('email', $data['email'])->first();

        if (!$user) {
            $userId = $userModel->insert([
                'full_name' => $data['full_name'],
                'email'     => $data['email'],
                'phone'     => $data['phone'],
                'is_guest'  => true,
            ], true);
        } else {
            $userId = $user['id'];
        }

        // Calculate total price
        $roomModel = new RoomModel();
        $room = $roomModel->find($data['room_id']);

        $checkIn  = new \DateTime($data['check_in']);
        $checkOut = new \DateTime($data['check_out']);
        $nights   = $checkIn->diff($checkOut)->days;
        $totalPrice = $room['price_per_night'] * $nights;

        // Create booking
        $bookingModel = new BookingModel();
        $bookingId = $bookingModel->insert([
            'user_id'            => $userId,
            'room_id'            => $data['room_id'],
            'booking_reference'  => $bookingModel->generateReference(),
            'check_in'           => $data['check_in'],
            'check_out'          => $data['check_out'],
            'guests'             => $data['guests'],
            'total_price'        => $totalPrice,
            'status'             => 'confirmed',
	    'payment_method'     => $data['payment_method'] ?? 'Cash on Arrival',
        ]);


        $booking = $bookingModel->find($bookingId);

        return $this->response->setJSON([
            'status'  => 'success',
            'message' => 'Booking confirmed',
            'data'    => $booking,
        ]);
    }
}
