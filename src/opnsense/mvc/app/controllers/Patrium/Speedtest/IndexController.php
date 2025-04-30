<?php
namespace Patrium\Speedtest;

use OPNsense\Base\IndexControllerBase;

class IndexController extends IndexControllerBase
{
    public function indexAction()
    {
        $this->view->pick('Patrium/Speedtest/index');
    }
}
