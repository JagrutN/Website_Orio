import grpc
import proto.user_pb2 as user_pb2
import proto.user_pb2_grpc as user_pb2_grpc
import hashlib
import os

# Temporary in-memory user storage
user_db = {}

class UserService(user_pb2_grpc.UserServiceServicer):
    def Register(self, request, context):
        if request.email_or_phone in user_db:
            return user_pb2.AuthResponse(success=False, message="User already exists", username="")

        # Hash the password
        salt = os.urandom(16)
        hashed_password = hashlib.pbkdf2_hmac('sha256', request.password.encode(), salt, 100000)
        
        user_db[request.email_or_phone] = {
            "username": request.username,
            "password": hashed_password,
            "salt": salt,
            "use_biometric": request.use_biometric
        }

        return user_pb2.AuthResponse(success=True, message="Registration successful", username=request.username)

    def Login(self, request, context):
        user = user_db.get(request.email_or_phone)
        if not user:
            return user_pb2.AuthResponse(success=False, message="User not found", username="")

        # Verify password
        hashed_password = hashlib.pbkdf2_hmac('sha256', request.password.encode(), user["salt"], 100000)
        if hashed_password != user["password"]:
            return user_pb2.AuthResponse(success=False, message="Incorrect password", username="")

        return user_pb2.AuthResponse(success=True, message="Login successful", username=user["username"])
