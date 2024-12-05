import math

class CORDICArccosine:
    def __init__(self, num_iterations=16):
        """
        Initialize CORDIC Arccosine calculator
        
        Args:
        - num_iterations: Number of CORDIC iterations (default 16)
        """
        self.num_iterations = num_iterations
        self.atan_table = self._generate_atan_lookup_table()
        self.gain = self._calculate_cordic_gain()

    def float_to_fixed(self, float_val):
        """
        Convert float to 32-bit fixed-point (16.16) representation
        
        Args:
        - float_val: Input floating-point value
        
        Returns:
        - Fixed-point representation as a signed 32-bit integer
        """
        # Check for overflow
        max_val = 2 ** 15 - 1 / (2 ** 16)
        min_val = -(2 ** 15)
        
        if float_val > max_val or float_val < min_val:
            raise ValueError(f"Value {float_val} out of representable range")
        
        # Multiply by 2^16 and round to nearest integer
        return int(round(float_val * (2 ** 16)))

    def fixed_to_float(self, fixed_val):
        """
        Convert 32-bit fixed-point (16.16) back to float
        
        Args:
        - fixed_val: Fixed-point integer
        
        Returns:
        - Floating-point value
        """
        # Handle signed representation
        if fixed_val & (1 << 31):  # Check if negative
            fixed_val = -(((~fixed_val) & 0xFFFFFFFF) + 1)
        
        return fixed_val / (2 ** 16)

    def _generate_atan_lookup_table(self):
        """
        Generate CORDIC arctangent lookup table
        
        Returns:
        - List of fixed-point arctangent values
        """
        atan_table = []
        for k in range(self.num_iterations):
            atan_value = math.atan(2 ** -k)
            atan_table.append(self.float_to_fixed(atan_value))
        return atan_table

    def _calculate_cordic_gain(self):
        """
        Calculate CORDIC cumulative gain
        
        Returns:
        - Fixed-point gain value
        """
        gain = 1.0
        for k in range(self.num_iterations):
            gain *= math.sqrt(1 + 2 ** (-2 * k))
        return self.float_to_fixed(gain)

    def arccosine(self, x_input):
        """
        Calculate arccosine using CORDIC algorithm
        
        Args:
        - x_input: Input cosine value (in fixed-point)
        
        Returns:
        - Arccosine angle in fixed-point representation
        """
        # Input validation
        x = self.fixed_to_float(x_input)
        if abs(x) > 1:
            raise ValueError("Input must be between -1 and 1")
        
        # Initial conditions
        x_reg = x_input
        y_reg = self.float_to_fixed(math.sqrt(1 - x * x))
        z_reg = self.float_to_fixed(math.pi / 2)  # Start at pi/2
        
        # CORDIC iterations
        for k in range(self.num_iterations):
            # Determine rotation direction
            d = 1 if x_reg > 0 else -1
            
            # Temporary variables for rotation
            x_temp = x_reg - d * (y_reg >> k)
            y_temp = y_reg + d * (x_reg >> k)
            z_temp = z_reg - d * self.atan_table[k]
            
            # Update registers
            x_reg = x_temp
            y_reg = y_temp
            z_reg = z_temp
        
        return z_reg

    def test_arccosine(self):
        """
        Test the arccosine implementation with various inputs
        """
        test_values = [0.5, 0.777, 0.42, 0.45]
        
        print("CORDIC Arccosine Test Results:")
        print("Input (cos)    | Arccosine (radians)  | Arccosine (degrees) | Hex Result")
        print("-" * 80)
        
        for val in test_values:
            # Convert input to fixed-point
            x_fixed = self.float_to_fixed(val)
            
            try:
                # Calculate arccosine
                result_fixed = self.arccosine(x_fixed)
                result_float = self.fixed_to_float(result_fixed)
                
                print(f"{val:12.4f} | {result_float:18.4f} | {math.degrees(result_float):18.4f} | 0x{result_fixed & 0xFFFFFFFF:08X}")
            except ValueError as e:
                print(f"{val:12.4f} | Error: {str(e)}")

# Run the test
cordic_acos = CORDICArccosine()
cordic_acos.test_arccosine()