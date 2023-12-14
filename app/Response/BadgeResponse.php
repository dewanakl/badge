<?php

namespace App\Response;

use Core\Http\Respond;
use DateTimeInterface;

class BadgeResponse extends Respond
{
    public function __construct(string $content)
    {
        parent::__construct($content, headers: [
            ...respond()->getHeader()->all(),
            'Content-Type' => 'image/svg+xml',
            'Cache-Control' => 'no-cache, no-store, max-age=0, must-revalidate, proxy-revalidate',
            'Age' => '0',
            'Expires' => gmdate(DateTimeInterface::RFC7231, 0),
            'Last-Modified' => gmdate(DateTimeInterface::RFC7231, 0)
        ]);
    }
}
