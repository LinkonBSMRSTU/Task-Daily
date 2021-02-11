<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Todo;

class TodoController extends Controller
{
    public function index()
    {
        // for paginated response
        if (request()->has('limit')) {
            // get value from limit param
            $limit = request()->get('limit') ?: 10;
            // get todos
            $todos = Todo::latest()->paginate($limit)->appends(request()->query());
        } else {
            // get todos
            $todos = Todo::latest()->get();
        }
        // if no todo found
        if (!count($todos)) {
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
            'data' => $todos
        ], 200);
    }

    public function store(Request $request)
    {
        // validate request
        $request->validate([
            'title' => 'required',
            'category' => 'required',
            'start_time' => 'required',
            'end_time' => 'required',
        ]);
        // create todo
        $todo = Todo::create($request->all());
        // success response
        return response()->json([
            'code' => 200,
            'status' => 'success',
            'message' => 'Data available',
            'data' => $todo
        ], 200);
    }

    public function show(Todo $todo)
    {
        // success response
        return response()->json([
            'code' => 200,
            'status' => 'success',
            'message' => 'Data available',
            'data' => $todo
        ], 200);
    }

    public function destroy(Todo $todo)
    {
        // delete todo_category
        if ($todo->delete()) {
            return response()->json([
                'code' => 200,
                'status' => 'success',
                'message' => 'Data deleted',
                'data' => null
            ], 200);
        } else {
            return response()->json([
                'code' => 400,
                'status' => 'success',
                'message' => 'Data cannot be deleted',
                'data' => null
            ], 400);
        }
    }
}
