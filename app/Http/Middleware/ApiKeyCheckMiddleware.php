<?php

namespace App\Http\Middleware;

use App\Constants\ApiDefaults;
use Closure;
use Illuminate\Http\Request;

class ApiKeyCheckMiddleware
{
    /**
     * Handle an incoming request.
     * @param Request $request
     * @param Closure $next
     * @return mixed
     * @throws \Exception
     */
    public function handle(Request $request, Closure $next)
    {
        if (!$request->hasHeader('X-API-KEY')) {
            throw new \Exception('X-API-KEY is not available on the request header.');
        }
        if (!in_array($request->header('X-API-KEY'), ApiDefaults::API_KEYS)) {
            throw new \Exception('The value of X-API-KEY is invalid or unauthorized.');
        }
        return $next($request);
    }
}
