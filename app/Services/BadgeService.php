<?php

namespace App\Services;

use PUGX\Poser\Badge;
use PUGX\Poser\Poser;
use PUGX\Poser\Render\SvgFlatRender;
use PUGX\Poser\Render\SvgFlatSquareRender;
use PUGX\Poser\Render\SvgForTheBadgeRenderer;
use PUGX\Poser\Render\SvgPlasticRender;

class BadgeService
{
    private $poser;

    public function __construct()
    {
        $this->poser = new Poser([
            new SvgPlasticRender,
            new SvgFlatRender,
            new SvgFlatSquareRender,
            new SvgForTheBadgeRenderer,
        ]);
    }

    public function renderBadge(string $label, string $message, string|null $color = null, string|null $style = null): string
    {
        if (!in_array($style, ['flat', 'flat-square', 'plastic', 'for-the-badge'], true)) {
            $style = 'flat';
        }

        return $this->poser->generate(
            $label,
            $message,
            ($color ?? 'blue'),
            $style,
            Badge::DEFAULT_FORMAT
        )->__toString();
    }

    public function renderBadgeWithError(string $label, string $message): string
    {
        return $this->renderBadge(
            $label,
            $message,
            'red'
        );
    }
}
