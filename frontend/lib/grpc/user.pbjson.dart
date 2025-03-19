//
//  Generated code. Do not modify.
//  source: user.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use registerRequestDescriptor instead')
const RegisterRequest$json = {
  '1': 'RegisterRequest',
  '2': [
    {'1': 'email_or_phone', '3': 1, '4': 1, '5': 9, '10': 'emailOrPhone'},
    {'1': 'otp', '3': 2, '4': 1, '5': 9, '10': 'otp'},
    {'1': 'password', '3': 3, '4': 1, '5': 9, '10': 'password'},
    {'1': 'username', '3': 4, '4': 1, '5': 9, '10': 'username'},
    {'1': 'use_biometric', '3': 5, '4': 1, '5': 8, '10': 'useBiometric'},
  ],
};

/// Descriptor for `RegisterRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List registerRequestDescriptor = $convert.base64Decode(
    'Cg9SZWdpc3RlclJlcXVlc3QSJAoOZW1haWxfb3JfcGhvbmUYASABKAlSDGVtYWlsT3JQaG9uZR'
    'IQCgNvdHAYAiABKAlSA290cBIaCghwYXNzd29yZBgDIAEoCVIIcGFzc3dvcmQSGgoIdXNlcm5h'
    'bWUYBCABKAlSCHVzZXJuYW1lEiMKDXVzZV9iaW9tZXRyaWMYBSABKAhSDHVzZUJpb21ldHJpYw'
    '==');

@$core.Deprecated('Use loginRequestDescriptor instead')
const LoginRequest$json = {
  '1': 'LoginRequest',
  '2': [
    {'1': 'email_or_phone', '3': 1, '4': 1, '5': 9, '10': 'emailOrPhone'},
    {'1': 'password', '3': 2, '4': 1, '5': 9, '10': 'password'},
    {'1': 'use_biometric', '3': 3, '4': 1, '5': 8, '10': 'useBiometric'},
  ],
};

/// Descriptor for `LoginRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List loginRequestDescriptor = $convert.base64Decode(
    'CgxMb2dpblJlcXVlc3QSJAoOZW1haWxfb3JfcGhvbmUYASABKAlSDGVtYWlsT3JQaG9uZRIaCg'
    'hwYXNzd29yZBgCIAEoCVIIcGFzc3dvcmQSIwoNdXNlX2Jpb21ldHJpYxgDIAEoCFIMdXNlQmlv'
    'bWV0cmlj');

@$core.Deprecated('Use authResponseDescriptor instead')
const AuthResponse$json = {
  '1': 'AuthResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'username', '3': 3, '4': 1, '5': 9, '10': 'username'},
  ],
};

/// Descriptor for `AuthResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List authResponseDescriptor = $convert.base64Decode(
    'CgxBdXRoUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIYCgdtZXNzYWdlGAIgAS'
    'gJUgdtZXNzYWdlEhoKCHVzZXJuYW1lGAMgASgJUgh1c2VybmFtZQ==');

