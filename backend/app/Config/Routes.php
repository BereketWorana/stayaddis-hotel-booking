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
$routes->post('/api/admin/login', 'Api\Auth::adminLogin');
// Admin routes
$routes->post('/api/admin/login', 'Api\Auth::adminLogin');
$routes->get('/api/admin/dashboard', 'Api\Admin::dashboard');
$routes->get('/api/admin/hotels', 'Api\Admin::hotels');
$routes->post('/api/admin/hotels', 'Api\Admin::addHotel');
$routes->put('/api/admin/hotels/(:num)', 'Api\Admin::updateHotel/$1');
$routes->delete('/api/admin/hotels/(:num)', 'Api\Admin::deleteHotel/$1');
$routes->get('/api/admin/bookings', 'Api\Admin::bookings');
$routes->put('/api/admin/bookings/(:num)/status', 'Api\Admin::updateBookingStatus/$1');
$routes->get('/api/my-bookings', 'Api\MyBookings::index');
