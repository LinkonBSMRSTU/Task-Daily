<?php

namespace Database\Factories;

use App\Models\Todo;
use Illuminate\Database\Eloquent\Factories\Factory;

class TodoFactory extends Factory
{
    /**
     * The name of the factory's corresponding model.
     *
     * @var string
     */
    protected $model = Todo::class;

    /**
     * Define the model's default state.
     *
     * @return array
     */
    public function definition()
    {
        return [
            'title' => $this->faker->word,
            'description' => $this->faker->sentence,
            'todo_category_id' => $this->faker->numberBetween(1, 10),
            'category' => $this->faker->word,
            'start_time' => $this->faker->time('H:i'),
            'end_time' => $this->faker->time('H:i')
        ];
    }
}
