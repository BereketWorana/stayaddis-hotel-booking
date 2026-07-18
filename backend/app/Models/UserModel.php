<?php

namespace App\Models;

use CodeIgniter\Model;

class UserModel extends Model
{
    protected $table      = 'users';
    protected $primaryKey = 'id';
    protected $allowedFields = [
        'full_name', 'email', 'phone', 'password_hash', 'is_guest', 'role'
    ];
}
