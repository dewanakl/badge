<?php

namespace App\Controllers;

use App\Middleware\UsernameMiddleware;
use App\Models\Badge;
use App\Response\BadgeResponse;
use App\Services\BadgeContract;
use Core\Routing\Controller;
use Core\Http\Request;

class BadgeController extends Controller
{
    #[UsernameMiddleware]
    public function __invoke(string $username, Request $request, BadgeContract $badgeService): BadgeResponse
    {
        $valid = $this->validate($request, [
            'label' => ['nullable', 'str', 'trim', 'max:25'],
            'color' => ['nullable', 'str', 'trim', 'max:15'],
            'style' => ['nullable', 'str', 'trim', 'max:15'],
        ]);

        if ($valid->fails()) {
            return new BadgeResponse($badgeService->renderBadgeWithError(
                join(', ', array_keys($valid->failed())),
                join(', ', array_values($valid->failed()))
            ));
        }

        $badge = Badge::find($username, 'username');

        if (!$badge->exist()) {
            $badge = Badge::create([
                'username' => $username
            ]);
        }

        $badge->amount = $badge->amount + 1;
        $badge->save();

        return new BadgeResponse($badgeService->renderBadge(
            ($valid->label ?? 'Profile views'),
            number_format($badge->amount),
            $valid->color,
            $valid->style,
        ));
    }
}
