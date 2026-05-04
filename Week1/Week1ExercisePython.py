def task1():
    int_var = 3
    float_var = 95.15
    string_var = "hello world"
    bool_var = True
    
    print(f'The value of the integer variable (int_var) is {int_var}')
    print("The type of the integer is: ", str(type(int_var)) + "\n")
    print(f'The value of the float variable (float_var) is {float_var}')
    print("The type of the float variable is: ", str(type(float_var)) + "\n")
    print(f'The value of the string variable (string_var) is {string_var}')
    print("the type of the string variable is: ", str(type(string_var)) + "\n")
    print(f'the value of the boolean variable (bool_var) is {bool_var}')
    print("the type of the boolean string is: ", type(bool_var))
    
task1()

def task2():
    test_stringvariable = "HeLlO wOrLd"
    print(test_stringvariable.upper())        # Example of modifying information
    print(test_stringvariable.isnumeric())    # Example of retrieving information
    print(test_stringvariable.count("HeLlO")) # Example of retrieving information
    
task2()

def task3():
    num_a = 3
    num_b = 3.50
    
    print(num_a + num_b, num_a - num_b, num_a * num_b, num_a / num_b, num_a % num_b, num_a ** num_b)
    print(num_a > num_b, num_a < num_b, num_a == num_b, num_a != num_b, num_a >= num_b, num_a <= num_b)
    print(num_a > 10 and num_b <= 3.50, num_a < 50 or num_b < 2, not (num_a == 200))
    
task3()
 
def task4():
    list_example = ["John", "Jane", "Firebolt"]
    dictionary_example = {"Name": "Joey", "Age": 36}
    tuple_example = ("no", "this", "can't", "be")
    
    print(list_example[0])
    print(dictionary_example["Age"])
    print(tuple_example[3])
    
task4()

def task5():
    expr1 = 25
    expr2 = []
    expr3 = "no"
    expr4 = 33
    
    combined_expression = (expr1 * len(expr3)) / expr4
    expr2.append(combined_expression)
    print(combined_expression)
    print(expr2)

task5()