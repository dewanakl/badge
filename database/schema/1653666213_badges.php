<?php

use Core\Database\Migration;
use Core\Database\Schema;
use Core\Database\Table;

return new class implements Migration
{
    /**
     * Jalankan migrasi.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('badges', function (Table $table) {
            $table->id();

            $table->string('username', 50)->unique();
            $table->integer('amount')->default(0);

            $table->timeStamp();
        });
    }

    /**
     * Kembalikan seperti semula.
     *
     * @return void
     */
    public function down()
    {
        Schema::drop('badges');
    }
};
