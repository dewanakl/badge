<?php

namespace App\Services;

interface BadgeContract
{
    public function renderBadge(string $label, string $message, string|null $color = null, string|null $style = null): string;
    public function renderBadgeWithError(string $label, string $message): string;
}
