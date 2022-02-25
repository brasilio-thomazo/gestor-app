<?php

namespace Database\Seeders;

use App\Models\Role;
use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {
        $all = ['read', 'update', 'store', 'delete'];
        $r = ['read'];
        $rw = ['read', 'update'];

        $roles = ['Administrador', 'Diretor', 'Gererente', 'Padrão'];
        $rules = [
            ['user' => $all, 'role' => $all],
            ['user' => $all, 'role' => $rw],
            ['user' => $all, 'role' => $r],
            ['user' => $r, 'role' => $r]
        ];

        foreach ($roles as $k => $v) {
            Role::factory()->create([
                'name' => $v,
                'rules' => $rules[$k]
            ]);
        }

        User::factory()->create([
            'name' => 'Administrador',
            'username' => 'admin',
            'password' => Hash::make('admin'),
            'email' => 'postmaster@localhost',
            'level' => 1.0,
            'email_verified_at' => now(),
            'role_id' => 1,
            'rules' => $rules[0],
            'remember_token' => Str::random(10),
        ]);

        User::factory(20)->create();
    }
}
