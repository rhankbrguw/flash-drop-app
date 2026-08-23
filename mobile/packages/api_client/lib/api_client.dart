import 'package:grpc/grpc.dart';
import 'src/gen/location.pbgrpc.dart';
export 'src/gen/location.pb.dart';
export 'src/tracking_repository.dart';

class LocationApiClient {
  late final LocationServiceClient _client;
  late final ClientChannel _channel;
  final String? token;

  LocationApiClient({required String host, required int port, this.token}) {
    _channel = ClientChannel(
      host,
      port: port,
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );
    _client = LocationServiceClient(_channel);
  }

  CallOptions _getOptions() {
    if (token == null || token!.isEmpty) return CallOptions();
    return CallOptions(metadata: {'Authorization': 'Bearer $token'});
  }

  ResponseFuture<StreamLocationResponse> streamLocation(
      Stream<StreamLocationRequest> requests) {
    return _client.streamLocation(requests, options: _getOptions());
  }

  ResponseStream<WatchDriverResponse> watchDriver(WatchDriverRequest request) {
    return _client.watchDriver(request, options: _getOptions());
  }

  ResponseFuture<GetLocationHistoryResponse> getLocationHistory(GetLocationHistoryRequest request) {
    return _client.getLocationHistory(request, options: _getOptions());
  }

  Future<void> close() async {
    await _channel.shutdown();
  }
}
