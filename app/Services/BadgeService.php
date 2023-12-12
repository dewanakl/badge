<?php

namespace App\Services;

use PUGX\Poser\Badge;
use PUGX\Poser\Poser;
use PUGX\Poser\Render\SvgFlatRender;
use PUGX\Poser\Render\SvgFlatSquareRender;
use PUGX\Poser\Render\SvgForTheBadgeRenderer;
use PUGX\Poser\Render\SvgPlasticRender;

class BadgeService implements BadgeContract
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
        if (!in_array($style, ['flat', 'flat-square', 'plastic', 'for-the-badge', 'none'], true)) {
            $style = 'flat';
        }

        if ($style === 'none') {
            return <<<EOD
            <?xml version="1.0" encoding="UTF-8" standalone="no"?>
            <svg xmlns="http://www.w3.org/2000/svg" width="0" height="0" version="1.1">
            <rect width="0%" height="0%" fill="none" />
            </svg>
            EOD;
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
