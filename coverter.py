def hex_to_decimal(hex_value):
    """
    Convert a 32-bit hexadecimal fixed-point number to decimal
    
    Args:
    - hex_value: Hexadecimal representation of 32-bit fixed-point number
    
    Returns:
    - Floating-point decimal representation
    """
    # Convert hex to signed 32-bit integer
    value = int(hex_value, 16)
    
    # Handle two's complement for negative numbers
    if value & (1 << 31):
        # If negative, convert from two's complement
        value = -(((~value) & 0xFFFFFFFF) + 1)
    
    # Convert to float by dividing by 2^16
    return value / (2 ** 16)

# Example usage
def main():
    # Test cases
    test_hexes = [
        '0x00009000',  # 0.5
        '0x003C0000',  # 1.0
        '0x0000AE51',  # -0.5
        '0x00011AA3',  # Max positive value
        '0x80000000'   # Min negative value
    ]
    
    print("Hex to Decimal Conversion:")
    print("-" * 40)
    for hex_val in test_hexes:
        decimal = hex_to_decimal(hex_val)
        print(f"{hex_val} → {decimal*57.2958}")

if __name__ == "__main__":
    main()