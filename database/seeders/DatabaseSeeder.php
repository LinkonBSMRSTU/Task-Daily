<?php

namespace Database\Seeders;

use App\Models\Todo;
use App\Models\TodoCategory;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {
        TodoCategory::factory(10)->create();
        Todo::factory(50)->create();
    }
}
