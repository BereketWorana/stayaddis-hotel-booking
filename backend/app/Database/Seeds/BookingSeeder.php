<?php

namespace App\Database\Seeds;

use CodeIgniter\Database\Seeder;

class BookingSeeder extends Seeder
{
    public function run()
    {
        $data = [
            [
                'user_id'            => 1,
                'room_id'            => 1,
                'booking_reference'  => 'SAD-1001',
                'check_in'           => '2026-07-20',
                'check_out'          => '2026-07-23',
                'guests'             => 2,
                'total_price'        => 10500.00,
                'status'             => 'confirmed',
            ],
            [
                'user_id'            => 2,
                'room_id'            => 4,
                'booking_reference'  => 'SAD-1002',
                'check_in'           => '2026-07-25',
                'check_out'          => '2026-07-27',
                'guests'             => 3,
                'total_price'        => 60000.00,
                'status'             => 'confirmed',
            ],
            [
                'user_id'            => 3,
                'room_id'            => 3,
                'booking_reference'  => 'SAD-1003',
                'check_in'           => '2026-08-01',
                'check_out'          => '2026-08-03',
                'guests'             => 1,
                'total_price'        => 9000.00,
                'status'             => 'pending',
            ],
            [
                'user_id'            => 4,
                'room_id'            => 6,
                'booking_reference'  => 'SAD-1004',
                'check_in'           => '2026-08-10',
                'check_out'          => '2026-08-14',
                'guests'             => 5,
                'total_price'        => 72000.00,
                'status'             => 'pending',
            ],
        ];

        $this->db->table('bookings')->insertBatch($data);
    }
}
