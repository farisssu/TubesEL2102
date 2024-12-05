def decimal_to_fixed_point(decimal_value):
    """
    Convert a decimal value to 32-bit fixed-point (16.16) representation
    
    Args:
    - decimal_value: Input floating-point number
    
    Returns:
    - 32-bit fixed-point representation as a signed integer
    """
    # Check for overflow
    max_val = 2 ** 15 - 1 / (2 ** 16)
    min_val = -(2 ** 15)
    
    if decimal_value > max_val or decimal_value < min_val:
        raise ValueError(f"Value {decimal_value} out of representable range")
    
    # Multiply by 2^16 and round to nearest integer
    fixed_point = int(round(decimal_value * (2 ** 16)))
    
    return fixed_point

def fixed_point_to_hex(fixed_point_value):
    """
    Convert fixed-point integer to 8-digit hexadecimal representation
    
    Args:
    - fixed_point_value: Fixed-point integer
    
    Returns:
    - Hexadecimal string representation
    """
    # Mask to 32 bits to handle negative numbers correctly
    return f'0x{fixed_point_value & 0xFFFFFFFF:08X}'

def main():
    # Test cases
    test_values = [
        60,    # Positive fraction
        1.0,    # Whole number
        -0.5,   # Negative fraction
        3.14,   # Pi
        0       # Zero
    ]
    
    print("Decimal to Fixed-Point Conversion:")
    print("-" * 50)
    for value in test_values:
        try:
            fixed_point = decimal_to_fixed_point(value)
            hex_repr = fixed_point_to_hex(fixed_point)
            print(f"{value:6.2f} → Fixed-Point: {fixed_point} → Hex: {hex_repr}")
        except ValueError as e:
            print(f"{value:6.2f} → {str(e)}")

if __name__ == "__main__":
    main()