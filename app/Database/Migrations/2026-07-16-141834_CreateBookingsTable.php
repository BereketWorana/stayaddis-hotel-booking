<?php

namespace App\Database\Migrations;

use CodeIgniter\Database\Migration;

class CreateBookingsTable extends Migration
{
    public function up()
    {
        $this->forge->addField([
            'id' => [
                'type'           => 'INTEGER',
                'auto_increment' => true,
            ],
            'user_id' => [
                'type'       => 'INTEGER',
                'constraint' => 11,
            ],
            'room_id' => [
                'type'       => 'INTEGER',
                'constraint' => 11,
            ],
            'booking_reference' => [
                'type'       => 'VARCHAR',
                'constraint' => 10,
            ],
            'check_in' => [
                'type' => 'DATE',
            ],
            'check_out' => [
                'type' => 'DATE',
            ],
            'guests' => [
                'type'    => 'INTEGER',
                'default' => 1,
            ],
            'total_price' => [
                'type'    => 'DECIMAL',
                'constraint' => '10,2',
            ],
            'status' => [
                'type'       => 'VARCHAR',
                'constraint' => 20,
                'default'    => 'pending',
            ],
            'created_at' => [
                'type' => 'TIMESTAMP',
                'null' => true,
            ],
        ]);

        $this->forge->addPrimaryKey('id');
        $this->forge->addUniqueKey('booking_reference');
        $this->forge->addForeignKey('user_id', 'users', 'id', 'CASCADE', 'CASCADE');
        $this->forge->addForeignKey('room_id', 'rooms', 'id', 'CASCADE', 'CASCADE');
        $this->forge->createTable('bookings');

        // Forge doesn't support CHECK constraints — raw SQL needed
        $this->db->query("ALTER TABLE bookings ADD CONSTRAINT check_dates CHECK (check_out > check_in)");
        $this->db->query("ALTER TABLE bookings ALTER COLUMN created_at SET DEFAULT CURRENT_TIMESTAMP");
    }

    public function down()
    {
        $this->forge->dropTable('bookings');
    }
}