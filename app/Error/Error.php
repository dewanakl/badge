<?php

namespace App\Error;

use App\Response\BadgeResponse;
use App\Services\BadgeService;
use Core\Support\Error as BaseError;

class Error extends BaseError
{
    /**
     * Tampilkan errornya.
     *
     * @return mixed
     */
    public function render(): mixed
    {
        $th = $this->getThrowable();

        return new BadgeResponse((new BadgeService)->renderBadgeWithError(
            $th::class,
            $th->getMessage()
        ));
    }
}
