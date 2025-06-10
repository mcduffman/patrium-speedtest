<?php
namespace OPNsense\OPNsense\Speedtest\Api;

use OPNsense\Base\ApiController;
use Psr\Http\Message\ResponseInterface;
use Psr\Http\Message\ServerRequestInterface;
use OPNsense\OPNsense\Speedtest\Settings;
use OPNsense\Core\Config;

class SettingsController extends ApiController
{
    public function getAction(): ResponseInterface
    {
        $settings = new Settings();
        $data = $settings->getNodes();
        return $this->response->withJson($data);
    }

    public function setAction(ServerRequestInterface $request): ResponseInterface
    {
        $this->sessionClose();
        $settings = new Settings();
        $settings->setNodes($request->getParsedBody());
        $settings->serializeToConfig();
        Config::getInstance()->save();
        return $this->response->withJson(['status' => 'OK']);
    }
}
