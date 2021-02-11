<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Todo extends Model
{
    use HasFactory;

    protected $table = 'todos';

    protected $fillable = [
        'title',
		'description',
		'todo_category_id',
		'category',
		'start_time',
		'end_time',
    ];

    protected $hidden = [
        'todo_category_id',
        'created_at',
        'updated_at',
    ];

    protected $casts = [
        'title' => 'string',
		'description' => 'string',
		'todo_category_id' => 'integer',
    ];

    
}
