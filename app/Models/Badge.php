<?php

namespace App\Models;

use Core\Model\Model;

final class Badge extends Model
{
    protected $table = 'badges';

    protected $primaryKey = 'id';

    protected $typeKey = 'int';

    protected $fillable = [
        'username',
        'amount'
    ];

    protected $dates = [
        'created_at',
        'updated_at',
    ];
}
