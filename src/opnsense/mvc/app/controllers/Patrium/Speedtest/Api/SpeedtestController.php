<?php
namespace Patrium\Speedtest\Api;

use OPNsense\Base\ApiControllerBase;

class SpeedtestController extends ApiControllerBase
{
    public function runAction()
    {
        exec('/usr/local/opnsense/scripts/speedtest_run.sh');
        return ['status' => 'OK'];
    }

    public function historyAction()
    {
        $data = @file_get_contents("/var/log/speedtest_log.json");
        return json_decode($data, true);
    }
}
