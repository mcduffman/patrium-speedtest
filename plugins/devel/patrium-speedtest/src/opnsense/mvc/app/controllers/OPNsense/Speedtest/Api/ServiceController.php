<?php
namespace OPNsense\OPNsense\Speedtest\Api;

use OPNsense\Base\ApiController;
use Psr\Http\Message\ResponseInterface;
use Psr\Http\Message\ServerRequestInterface;
use OPNsense\OPNsense\Speedtest\Statistic;

class ServiceController extends ApiController
{
    public function testAction(): ResponseInterface
    {
        $this->sessionClose();
        $script = '/usr/local/opnsense/scripts/OPNsense/Speedtest/run_speedtest.sh';
        $cmd = escapeshellcmd($script) . ' --format=json';
        exec($cmd . ' 2>&1', $output, $returnCode);

        $raw = implode("\n", $output);
        $data = json_decode($raw, true);
        if ($returnCode !== 0 || !is_array($data)) {
            return $this->response
                ->withStatus(500)
                ->withJson([
                    'status'  => 'error',
                    'message' => 'Speedtest failed',
                    'output'  => $raw
                ]);
        }

        Statistic::storeResult($data);

        return $this->response->withJson([
            'status' => 'OK',
            'data'   => $data
        ]);
    }
}
