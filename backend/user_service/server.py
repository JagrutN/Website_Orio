from concurrent import futures
from grpc_reflection.v1alpha import reflection
import grpc
import proto.user_pb2_grpc as user_pb2_grpc
import proto.user_pb2 as user_pb2
from service import UserService


def serve():
    server = grpc.server(futures.ThreadPoolExecutor(max_workers=10))
    user_pb2_grpc.add_UserServiceServicer_to_server(UserService(), server)
    SERVICE_NAMES = (
        user_pb2.DESCRIPTOR.services_by_name['UserService'].full_name,
        reflection.SERVICE_NAME,  # Includes gRPC reflection service
    )
    reflection.enable_server_reflection(SERVICE_NAMES, server)
    server.add_insecure_port('[::]:50051')
    print("gRPC Server started at port 50051")
    server.start()
    server.wait_for_termination()

if __name__ == '__main__':
    serve()
