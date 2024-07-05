import 'package:shop_online/controllers/payment_provider.dart';
import 'package:shop_online/payments/failed.dart';
import 'package:shop_online/payments/successful.dart';
import 'package:shop_online/views/shared/export_packages.dart';

class PaymentsWebView extends StatefulWidget {
  const PaymentsWebView({super.key});

  @override
  State<PaymentsWebView> createState() => _PaymentsWebViewState();
}

class _PaymentsWebViewState extends State<PaymentsWebView> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    var paymentNotifier = Provider.of<PaymentNotifier>(context, listen: false);

    // #docregion platform_features
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);
    // #enddocregion platform_features

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            // debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            // debugPrint('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint("""
            Page resource error:
            code: ${error.errorCode}
            description: ${error.description}
            errorType: ${error.errorType}
            isForMainFrame: ${error.isForMainFrame}
            """);
          },
          onNavigationRequest: (NavigationRequest request) {
            debugPrint('allowing navigation to ${request.url}');
            return NavigationDecision.navigate;
          },
          onUrlChange: (UrlChange change) {
            if (change.url!.contains('checkout-success')) {
              paymentNotifier.setPaymentUrl = '';
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Successful()));
            } else if (change.url!.contains('cancel')) {
              paymentNotifier.setPaymentUrl = '';
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PaymentFailed()));
            }
          },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      )
      ..loadRequest(Uri.parse(paymentNotifier.paymentUrl));

    // #docregion platform_features
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    // #enddocregion platform_features

    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 50,
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
