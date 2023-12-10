<?php

namespace App\Response;

use Core\Http\Respond;

class BadgeResponse extends Respond
{
    public function __construct(string $content)
    {
        parent::__construct($content, header: [
            'Content-Type' => 'image/svg+xml',
            'Cache-Control' => 'max-age=0, no-cache, no-store, must-revalidate'
        ]);
    }
}
