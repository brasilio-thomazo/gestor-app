<?php

namespace App\Http\Controllers;

use App\Http\Requests\AuthRequest;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\ValidationException;

class AuthController extends Controller
{

    public function login(AuthRequest $request)
    {
        $user = User::where('username', $request->username)->first();
        if (!$user)
            throw ValidationException::withMessages(['username' => ['Nome de usário inválido.']]);

        if (!Hash::check($request->password, $user->password))
            throw ValidationException::withMessages(['password' => ['Senha inválida']]);

        $token = $user->createToken($request->userAgent(), $user->rules);
        return response()->json(['user' => $user, 'token' => $token->plainTextToken], 200, [], JSON_NUMERIC_CHECK);
    }
}
