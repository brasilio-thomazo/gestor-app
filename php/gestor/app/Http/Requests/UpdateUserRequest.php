<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class UpdateUserRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            'name' => 'required|string|max:75',
            'username' => [
                'required',
                'string',
                'regex:/^[a-zA-Z0-9._-]+$/',
                'max:25',
                'min:2',
                Rule::unique('users')->ignore($this->id)
            ],
            'email' => [
                'required',
                'email',
                Rule::unique('users')->ignore($this->id)
            ],
            'role_id' => 'numeric|exists:roles,id',
            'level' => 'numeric|min:0|max:1',
        ];
    }
}
