<?php

namespace App\Controllers;

use Codeigniter\Controller;

class DbTest extends BaseController
{
    public function index()
    {
        $db = \Config\Database::connect();

        if($db->connect())
        {
            echo"✅ Database connected successfullt!";
        

        //test query
        $query = $db->query("SELECT * FROM hotels");
        $hotels = $query->getResult();

        echo"<pre>";
        print_r($hotels);
        echo"<prev>";
        } else {
            echo"❌ Database connection failed!";
        }

    }
}