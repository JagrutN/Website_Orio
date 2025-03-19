import grpc
import hashlib
import proto.user_pb2 as user_pb2
import proto.user_pb2_grpc as user_pb2_grpc

SERVER_ADDRESS = "localhost:50051"  # Change to 50051 if not using gRPC-Web Proxy

def hash_password(password):
    salt = b'somesalt'  # Use a random salt in production
    return hashlib.pbkdf2_hmac('sha256', password.encode(), salt, 100000)

def register_user(email_or_phone, password, username, use_biometric):
    with grpc.insecure_channel(SERVER_ADDRESS) as channel:
        stub = user_pb2_grpc.UserServiceStub(channel)
        hashed_password = hash_password(password)
        
        request = user_pb2.RegisterRequest(
            email_or_phone=email_or_phone,
            password=hashed_password.hex(),
            username=username,
            use_biometric=use_biometric
        )

        try:
            response = stub.Register(request)
            print(f"Registration Response: {response.message}")
        except grpc.RpcError as e:
            print(f"Registration Failed: {e.details()}")

def login_user(email_or_phone, password):
    with grpc.insecure_channel(SERVER_ADDRESS) as channel:
        stub = user_pb2_grpc.UserServiceStub(channel)
        hashed_password = hash_password(password)

        request = user_pb2.LoginRequest(
            email_or_phone=email_or_phone,
            password=hashed_password.hex(),
            use_biometric=False  # Change this based on user preference
        )

        try:
            response = stub.Login(request)
            if response.success:
                print(f"Login Successful! Welcome, {response.username}")
            else:
                print(f"Login Failed: {response.message}")
        except grpc.RpcError as e:
            print(f"Login Failed: {e.details()}")

# ✅ Interactive CLI for Testing
if __name__ == "__main__":
    print("\nConnecting to gRPC Server...\n")
    while True:
        print("\n1-Register\n2-Login\n3-Exit")
        choice = input("Select an option: ")

        if choice == "1":
            email_or_phone = input("Enter Email or Phone: ")
            password = input("Enter Password: ")
            username = input("Enter Username: ")
            use_biometric = input("Use Biometric Login? (yes/no): ").strip().lower() == "yes"
            register_user(email_or_phone, password, username, use_biometric)

        elif choice == "2":
            email_or_phone = input("Enter Email or Phone: ")
            password = input("Enter Password: ")
            login_user(email_or_phone, password)

        elif choice == "3":
            print("Exiting...")
            break

        else:
            print("Invalid choice! Try again.")
