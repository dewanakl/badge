<?php

namespace App\Error;

use App\Response\BadgeResponse;
use App\Services\BadgeService;
use Core\Support\Error as BaseError;
use Throwable;

class Error extends BaseError
{
    /**
     * Tampilkan errornya.
     *
     * @param Throwable $th
     * @return mixed
     */
    public function render(Throwable $th): mixed
    {
        return new BadgeResponse((new BadgeService)->renderBadgeWithError(
            $th::class,
            $th->getMessage()
        ));
    }
}
