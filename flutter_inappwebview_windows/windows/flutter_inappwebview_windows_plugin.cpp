#include "flutter_inappwebview_windows_plugin.h"

#include <flutter/plugin_registrar_windows.h>

#include "cookie_manager.h"
#include "headless_in_app_webview/headless_in_app_webview_manager.h"
#include "in_app_browser/in_app_browser_manager.h"
#include "in_app_webview/in_app_webview_manager.h"
#include "webview_environment/webview_environment_manager.h"

#pragma comment(lib, "Shlwapi.lib")
#pragma comment(lib, "dxgi.lib")
#pragma comment(lib, "d3d11.lib")

namespace flutter_inappwebview_plugin
{
  // static
  void FlutterInappwebviewWindowsPlugin::RegisterWithRegistrar(
    flutter::PluginRegistrarWindows* registrar)
  {
    auto plugin = std::make_unique<FlutterInappwebviewWindowsPlugin>(registrar);
    registrar->AddPlugin(std::move(plugin));
  }

  FlutterInappwebviewWindowsPlugin::FlutterInappwebviewWindowsPlugin(flutter::PluginRegistrarWindows* registrar)
    : registrar(registrar)
  {
    webViewEnvironmentManager = std::make_unique<WebViewEnvironmentManager>(this);
    inAppWebViewManager = std::make_unique<InAppWebViewManager>(this);
    inAppBrowserManager = std::make_unique<InAppBrowserManager>(this);
    headlessInAppWebViewManager = std::make_unique<HeadlessInAppWebViewManager>(this);
    cookieManager = std::make_unique<CookieManager>(this);

    channel_ = std::make_unique<flutter::MethodChannel<flutter::EncodableValue>>(
      registrar->messenger(),
      "sbipc/inappwebview_channel",
      &flutter::StandardMethodCodec::GetInstance());

    channel_->SetMethodCallHandler(
        [this](const flutter::MethodCall<flutter::EncodableValue>& call,
              std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result) {
          if (call.method_name().compare("disposePlugin") == 0) {
            Dispose();
            result->Success();
          } else {
            result->NotImplemented();
          }
        }
    );

  }

  void FlutterInappwebviewWindowsPlugin::Dispose()
  {
    webViewEnvironmentManager = nullptr;
    inAppWebViewManager = nullptr;
    inAppBrowserManager = nullptr;
    headlessInAppWebViewManager = nullptr;
    cookieManager = nullptr;
  }

  FlutterInappwebviewWindowsPlugin::~FlutterInappwebviewWindowsPlugin()
  {
    Dispose();
  }
}
