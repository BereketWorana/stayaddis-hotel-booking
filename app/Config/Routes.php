<?php

use CodeIgniter\Router\RouteCollection;

/** @var RouteCollection $routes */
$routes->get('/', 'Home::index');
$routes->get('/dbtest', 'DbTest::index');
// Web routes
$routes->get('/', 'Home::index');
$routes->get('/hotel/(:num)', 'Home::hotelDetail/$1');

// API routes
$routes->get('/api/hotels', 'Api\Hotels::index');
$routes->get('/api/hotels/(:num)', 'Api\Hotels::show/$1');
$routes->get('/api/rooms', 'Api\Rooms::index');
$routes->post('/api/bookings', 'Api\Bookings::create');
$routes->post('/api/register', 'Api\Auth::register');
$routes->post('/api/login', 'Api\Auth::login');
