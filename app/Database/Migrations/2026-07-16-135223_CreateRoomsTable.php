<?php

namespace App\Database\Migrations;

use CodeIgniter\Database\Migration;

class CreateRoomsTable extends Migration
{
    public function up()
    {
        $this->forge->addField([
            'id' => [
                'type'           => 'INTEGER',
                'auto_increment' => true,
            ],
            'hotel_id' => [
                'type'       => 'INTEGER',
                'constraint' => 11,
            ],
            'room_type' => [
                'type'       => 'VARCHAR',
                'constraint' => 100,
            ],
            'description' => [
                'type' => 'TEXT',
                'null' => true,
            ],
            'price_per_night' => [
                'type'    => 'DECIMAL',
                'constraint' => '10,2',
            ],
            'capacity' => [
                'type'    => 'INTEGER',
                'default' => 2,
            ],
            'available_count' => [
                'type'    => 'INTEGER',
                'default' => 1,
            ],
            'image' => [
                'type'       => 'VARCHAR',
                'constraint' => 255,
                'null'       => true,
            ],
            'created_at' => [
                'type' => 'TIMESTAMP',
                'null' => true,
            ],
        ]);

        $this->forge->addPrimaryKey('id');
        $this->forge->addForeignKey('hotel_id', 'hotels', 'id', 'CASCADE', 'CASCADE');
        $this->forge->createTable('rooms');

        $this->db->query("ALTER TABLE rooms ALTER COLUMN created_at SET DEFAULT CURRENT_TIMESTAMP");
    }

    public function down()
    {
        $this->forge->dropTable('rooms');
    }
}
