<?php

namespace App\Controllers;

use App\Models\HotelModel;
use App\Models\RoomModel;

class Home extends BaseController
{
    public function index()
    {
        $hotelModel = new HotelModel();
        $hotels = $hotelModel->findAll();

        return view('home', ['hotels' => $hotels]);
    }

    public function hotelDetail($id = null)
    {
        $hotelModel = new HotelModel();
        $roomModel = new RoomModel();

        $hotel = $hotelModel->find($id);

        if (!$hotel) {
            throw \CodeIgniter\Exceptions\PageNotFoundException::forPageNotFound();
        }

        $rooms = $roomModel->getByHotel($id);
        $images = $hotelModel->getWithImages($id);

        $gallery = [];
        foreach ($images as $img) {
            if ($img['image_path']) {
                $gallery[] = [
                    'image_path' => $img['image_path'],
                    'caption'    => $img['caption'],
                ];
            }
        }

        return view('hotel_detail', [
            'hotel'   => $hotel,
            'rooms'   => $rooms,
            'gallery' => $gallery,
        ]);
    }
}