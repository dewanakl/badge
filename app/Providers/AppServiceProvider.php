<?php

namespace App\Providers;

use App\Services\BadgeContract;
use App\Services\BadgeService;
use Core\Facades\Provider;

class AppServiceProvider extends Provider
{
    /**
     * Registrasi apa aja disini.
     *
     * @return void
     */
    public function registrasi()
    {
        $this->app->bind(BadgeContract::class, BadgeService::class);
    }

    /**
     * Jalankan sewaktu aplikasi dinyalakan.
     *
     * @return void
     */
    public function booting()
    {
        //
    }
}
