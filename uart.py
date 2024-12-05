import serial
import time

# Configure the serial port (adjust COM port and baud rate as needed)
ser = serial.Serial('COM3', 9600)  # Replace 'COM3' with your port, 9600 is the baud rate

# Function to send data to FPGA
def send_data(data):
    # Make sure the data is in bytes, so we encode it
    ser.write(data.encode())
    print(f"Sent: {data}")

# Function to receive data from FPGA
def receive_data():
    # Wait until data is available to read
    if ser.in_waiting > 0:
        data = ser.read(ser.in_waiting)  # Read all available data
        print(f"Received: {data.decode()}")  # Decode and print the received data

# Example usage
if __name__ == "__main__":
    while True:
        send_data("Hello FPGA")  # Send data to FPGA
        time.sleep(1)  # Wait for a second before checking for response

        receive_data()  # Receive any available data from FPGA
        time.sleep(1)  # Wait for a second
