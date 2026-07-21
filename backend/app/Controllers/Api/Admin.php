<?php

namespace App\Controllers\Api;

use App\Controllers\BaseController;
use App\Models\HotelModel;
use App\Models\RoomModel;
use App\Models\BookingModel;

class Admin extends BaseController
{
    // Dashboard stats
    public function dashboard()
    {
        $hotelModel = new HotelModel();
        $roomModel = new RoomModel();
        $bookingModel = new BookingModel();

        return $this->response->setJSON([
            'status' => 'success',
            'data'   => [
                'total_hotels'   => $hotelModel->countAll(),
                'total_rooms'    => $roomModel->countAll(),
                'total_bookings' => $bookingModel->countAll(),
                'recent_bookings' => $bookingModel->orderBy('created_at', 'DESC')->findAll(5),
            ],
        ]);
    }

    // List all hotels
    public function hotels()
    {
        $hotelModel = new HotelModel();
        return $this->response->setJSON([
            'status' => 'success',
            'data'   => $hotelModel->findAll(),
        ]);
    }

    // Add hotel
    public function addHotel()
    {
        $hotelModel = new HotelModel();
        $data = $this->request->getPost();        
        $id = $hotelModel->insert($data);
        return $this->response->setJSON([
            'status' => 'success',
            'data'   => $hotelModel->find($id),
        ]);
    }

    // Update hotel
    public function updateHotel($id)
    {
        $hotelModel = new HotelModel();
        $data = $this->request->getRawInput();
        $hotelModel->update($id, $data);
        return $this->response->setJSON([
            'status' => 'success',
            'data'   => $hotelModel->find($id),
        ]);
    }

    // Delete hotel
    public function deleteHotel($id)
    {
        $hotelModel = new HotelModel();
        $hotelModel->delete($id);
        return $this->response->setJSON([
            'status'  => 'success',
            'message' => 'Hotel deleted',
        ]);
    }

    // List all bookings
    public function bookings()
    {
        $bookingModel = new BookingModel();
        $bookings = $bookingModel
            ->select('bookings.*, users.full_name, users.email, hotels.name as hotel_name, rooms.room_type')
            ->join('users', 'users.id = bookings.user_id')
            ->join('rooms', 'rooms.id = bookings.room_id')
            ->join('hotels', 'hotels.id = rooms.hotel_id')
            ->orderBy('bookings.created_at', 'DESC')
            ->findAll(20);

        return $this->response->setJSON([
            'status' => 'success',
            'data'   => $bookings,
        ]);
    }

    // Update booking status
        public function updateBookingStatus($id)
    {
        $bookingModel = new BookingModel();
        $data = $this->request->getRawInput();
        $status = $data['status'] ?? null;
        $bookingModel->update($id, ['status' => $status]);
        return $this->response->setJSON([
            'status'  => 'success',
            'message' => 'Booking status updated',
        ]);
    }
}
