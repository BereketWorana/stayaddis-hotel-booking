<?php

namespace App\Controllers;

use App\Models\HotelModel;

class Home extends BaseController
{
    public function index()
    {
        $hotelModel = new HotelModel();
        $hotels = $hotelModel->findAll();

        return view('home', ['hotels' => $hotels]);
    }
}