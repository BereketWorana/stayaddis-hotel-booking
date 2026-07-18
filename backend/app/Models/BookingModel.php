<?php

namespace App\Models;

use CodeIgniter\Model;

class BookingModel extends Model
{
    protected $table      = 'bookings';
    protected $primaryKey = 'id';
   protected $allowedFields = [
    'user_id', 'room_id', 'booking_reference', 'check_in', 'check_out',
    'guests', 'total_price', 'status', 'payment_method'
   ];

    // Generate unique booking reference
    public function generateReference()
    {
        do {
            $ref = 'SAD-' . strtoupper(substr(uniqid(), -4));
        } while ($this->where('booking_reference', $ref)->first());

        return $ref;
    }
}