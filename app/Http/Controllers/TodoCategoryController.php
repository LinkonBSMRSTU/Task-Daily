<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\TodoCategory;

class TodoCategoryController extends Controller
{
    public function index()
    {
        // for paginated response
        if (request()->has('limit')) {
            // get value from limit param
            $limit = request()->get('limit') ?: 10;
            // get todo_categories
            $todo_categories = TodoCategory::latest()->paginate($limit)->appends(request()->query());
        } else {
            // get todo_categories
            $todo_categories = TodoCategory::latest()->get();
        }
        // if no todo_category found
        if (!count($todo_categories)) {
            // error response
            return response()->json([
                'code' => 404,
                'status' => 'error',
                'message' => 'Data not available',
                'data' => null
            ], 200);
        }
        // success response
        return response()->json([
            'code' => 200,
            'status' => 'success',
            'message' => 'Data available',
            'data' => $todo_categories
        ], 200);
    }

    public function store(Request $request)
    {
        // validate request
        $request->validate([
            'title' => 'required'
        ]);
        // create todo_category
        $todo_category = TodoCategory::create($request->all());
        // success response
        return response()->json([
            'code' => 200,
            'status' => 'success',
            'message' => 'Data available',
            'data' => $todo_category
        ], 200);
    }

    public function show(TodoCategory $todo_category)
    {
        // success response
        return response()->json([
            'code' => 200,
            'status' => 'success',
            'message' => 'Data available',
            'data' => $todo_category
        ], 200);
    }

    /*public function update(TodoCategoryUpdateRequest $request, TodoCategory $todo_category)
    {
        // update todo_category
        $todo_category->update($request->all());
        // transform todo_category
        $todo_category = TodoCategoryResource::make($todo_category);
        // success response
        return responder()
            ->status('success')
            ->code(200)
            ->message('TodoCategory updated successfully.')
            ->data($todo_category);
    }

    public function destroy(TodoCategory $todo_category)
    {
        // delete todo_category
        if ($todo_category->delete()) {
            // success response
            return responder()
                ->status('success')
                ->code(200)
                ->message('TodoCategory deleted successfully.');
        } else {
            // error response
            return responder()
                ->status('error')
                ->code(400)
                ->message('TodoCategory cannot be deleted.');
        }
    }*/
}
