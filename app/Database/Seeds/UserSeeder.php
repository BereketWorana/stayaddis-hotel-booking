<?php

namespace App\Database\Seeds;

use CodeIgniter\Database\Seeder;

class UserSeeder extends Seeder
{
    public function run()
    {
        $data = [
            [
                'full_name'     => 'Abebe Kebede',
                'email'         => 'abebe@example.com',
                'phone'         => '+251911234567',
                'password_hash' => password_hash('password123', PASSWORD_DEFAULT),
                'is_guest'      => false,
            ],
            [
                'full_name'     => 'Sara Tadesse',
                'email'         => 'sara@example.com',
                'phone'         => '+251922345678',
                'password_hash' => password_hash('password123', PASSWORD_DEFAULT),
                'is_guest'      => false,
            ],
            [
                'full_name'     => 'Guest User One',
                'email'         => 'guest1@example.com',
                'phone'         => '+251933456789',
                'password_hash' => null,
                'is_guest'      => true,
            ],
            [
                'full_name'     => 'Guest User Two',
                'email'         => 'guest2@example.com',
                'phone'         => '+251944567890',
                'password_hash' => null,
                'is_guest'      => true,
            ],
        ];

        $this->db->table('users')->insertBatch($data);
    }
}
