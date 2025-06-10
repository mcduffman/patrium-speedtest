<?php
namespace OPNsense\OPNsense\Speedtest;

use OPNsense\Base\IndexController;
use OPNsense\Core\Config;

class IndexController extends IndexController
{
    public function indexAction()
    {
        $settings = new \OPNsense\OPNsense\Speedtest\Settings();
        $this->view->settings = $settings;

        $stats = new \OPNsense\OPNsense\Speedtest\Statistic();
        $this->view->latestResult = $stats->getLatest();
        $this->view->averages = [
            'week'  => $stats->getAverage('week'),
            'month' => $stats->getAverage('month'),
            'year'  => $stats->getAverage('year')
        ];

        $this->view->title = gettext("Diagnostics: Speedtest");
        $this->view->pick('OPNsense/Speedtest/index');
    }
}
