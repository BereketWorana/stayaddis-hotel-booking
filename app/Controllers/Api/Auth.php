<?php

namespace App\Controllers\Api;

use App\Controllers\BaseController;
use App\Models\UserModel;

class Auth extends BaseController
{
    public function register()
    {
        $rules = [
            'full_name' => 'required|min_length[3]',
            'email'     => 'required|valid_email|is_unique[users.email]',
            'phone'     => 'required|min_length[10]',
            'password'  => 'required|min_length[6]',
        ];

        if (!$this->validate($rules)) {
            return $this->response->setStatusCode(400)->setJSON([
                'status'  => 'error',
                'message' => 'Validation failed',
                'errors'  => $this->validator->getErrors(),
            ]);
        }

        $data = $this->request->getPost();
        $userModel = new UserModel();

        $userId = $userModel->insert([
            'full_name'     => $data['full_name'],
            'email'         => $data['email'],
            'phone'         => $data['phone'],
            'password_hash' => password_hash($data['password'], PASSWORD_DEFAULT),
            'is_guest'      => false,
        ]);

        return $this->response->setJSON([
            'status'  => 'success',
            'message' => 'Registration successful',
            'data'    => ['user_id' => $userId],
        ]);
    }

    public function login()
    {
        $rules = [
            'email'    => 'required|valid_email',
            'password' => 'required',
        ];

        if (!$this->validate($rules)) {
            return $this->response->setStatusCode(400)->setJSON([
                'status'  => 'error',
                'message' => 'Validation failed',
                'errors'  => $this->validator->getErrors(),
            ]);
        }

        $data = $this->request->getPost();
        $userModel = new UserModel();
        $user = $userModel->where('email', $data['email'])->first();

        if (!$user || !password_verify($data['password'], $user['password_hash'])) {
            return $this->response->setStatusCode(401)->setJSON([
                'status'  => 'error',
                'message' => 'Invalid email or password',
            ]);
        }

        // Remove password from response
        unset($user['password_hash']);

        return $this->response->setJSON([
            'status'  => 'success',
            'message' => 'Login successful',
            'data'    => $user,
        ]);
    }
}
