<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TodoCategory extends Model
{
    use HasFactory;

    protected $table = 'todo_categories';

    protected $fillable = [
        'title',
		'description',
    ];

    protected $hidden = [
        
    ];

    protected $casts = [
        'title' => 'string',
		'description' => 'string',
    ];

    
}
