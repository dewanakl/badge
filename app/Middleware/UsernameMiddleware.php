<?php

namespace App\Middleware;

use App\Response\BadgeResponse;
use App\Services\BadgeService;
use Closure;
use Core\Http\Request;
use Core\Middleware\MiddlewareInterface;
use Core\Valid\Validator;

final class UsernameMiddleware implements MiddlewareInterface
{
    public function handle(Request $request, Closure $next)
    {
        $valid = Validator::make(
            [
                'username' => $request->route('username')
            ],
            [
                'username' => ['required', 'str', 'trim', 'max:50']
            ]
        );

        if ($valid->fails()) {
            return new BadgeResponse((new BadgeService)->renderBadgeWithError(
                join(', ', array_keys($valid->failed())),
                join(', ', array_values($valid->failed()))
            ));
        }

        $request->route('username', strtolower($valid->get('username')));

        return $next($request);
    }
}
