<?php

namespace App\Providers;

use Core\Facades\Provider;
use Core\Routing\Route;
use Core\Routing\Router;

class RouteServiceProvider extends Provider
{
    /**
     * Jalankan sewaktu aplikasi dinyalakan.
     *
     * @return void
     */
    public function booting()
    {
        $this->app->singleton(Router::class);
        Route::setRouteFromCacheIfExist();
    }
}
