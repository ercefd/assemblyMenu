##############################################################
#Array
##############################################################
#   4 Bytes - Address of the Data
#   4 Bytes - Size of array
#   4 Bytes - Size of elements
##############################################################

##############################################################
#Linked List
##############################################################
#   4 Bytes - Address of the First Node
#   4 Bytes - Size of linked list
##############################################################

##############################################################
#Linked List Node
##############################################################
#   4 Bytes - Address of the Data
#   4 Bytes - Address of the Next Node
##############################################################

##############################################################
#Recipe
##############################################################
#   4 Bytes - Name (address of the name)
#	4 Bytes - Ingredients (address of the ingredients array)
#   4 Bytes - Cooking Time
#	4 Bytes - Difficulty
#	4 Bytes - Rating
##############################################################


.data
space: .asciiz " "
newLine: .asciiz "\n"
tab: .asciiz "\t"
lines: .asciiz "------------------------------------------------------------------\n"

listStr: .asciiz "List: \n"
recipeName: .asciiz "Recipe name: "
ingredients: .asciiz "Ingredients: "
cookingTime: .asciiz "Cooking time: "
difficulty: .asciiz "Difficulty: "
rating: .asciiz "Rating: "
listSize: .asciiz "List Size: "
emptyListWarning: .asciiz "List is empty!\n"
indexBoundWarning: .asciiz "Index out of bounds!\n"
recipeNotMatch: .asciiz "Recipe not matched!\n"
recipeMatch: .asciiz "Recipe matched!\n"
recipeAdded: .asciiz "Recipe added.\n"
recipeRemoved: .asciiz "Recipe removed.\n"
noRecipeWarning: .asciiz "No recipe to print!\n"

addressOfRecipeList: .word 0 #the address of the array of recipe list stored here!


# Recipe 1: Pancakes
r1: .asciiz "Pancakes"
r1i1: .asciiz "Flour"
r1i2: .asciiz "Milk"
r1i3: .asciiz "Eggs"
r1i4: .asciiz "Sugar"
r1i5: .asciiz "Baking powder"
r1c: .word 15							# Cooking time in minutes
r1d: .word 2							# Difficulty (scale 1-5)
r1r: .word 4							# Rating (scale 1-5)

# Recipe 2: Spaghetti Bolognese
r2: .asciiz "Spaghetti Bolognese"
r2i1: .asciiz "Spaghetti"
r2i2: .asciiz "Ground beef"
r2i3: .asciiz "Tomato sauce"
r2i4: .asciiz "Garlic"
r2i5: .asciiz "Onion"
r2c: .word 30
r2d: .word 3
r2r: .word 5

# Recipe 3: Chicken Stir-Fry
r3: .asciiz "Chicken Stir-Fry"
r3i1: .asciiz "Chicken breast"
r3i2: .asciiz "Soy sauce"
r3i3: .asciiz "Bell peppers"
r3i4: .asciiz "Broccoli"
r3i5: .asciiz "Garlic"
r3c: .word 20
r3d: .word 3
r3r: .word 4

# Recipe 4: Caesar Salad
r4: .asciiz "Caesar Salad"
r4i1: .asciiz "Romaine lettuce"
r4i2: .asciiz "Caesar dressing"
r4i3: .asciiz "Parmesan cheese"
r4i4: .asciiz "Croutons"
r4i5: .asciiz "Chicken breast (optional)"
r4c: .word 10
r4d: .word 1
r4r: .word 4

# Recipe 5: Chocolate Chip Cookies
r5: .asciiz "Chocolate Chip Cookies"
r5i1: .asciiz "Butter"
r5i2: .asciiz "Sugar"
r5i3: .asciiz "Flour"
r5i4: .asciiz "Eggs"
r5i5: .asciiz "Chocolate chips"
r5c: .word 25
r5d: .word 2
r5r: .word 5


search1: .asciiz "Caesar Salad"
search2: .asciiz "Shepherd's Pie"

.text 
main:
    # Initialize the Recipe List (Linked List)
    jal createLinkedList        # Create the linked list (queue)
    #move $t0, $v0               # Store the address of the linked list in $t0
	sw $v0, addressOfRecipeList

    # Create and Add Pancakes Recipe
    # Create array for Pancakes ingredients
    li $a0, 5                   # Maximum 5 ingredients
    li $a1, 4                   # Each ingredient address is 4 bytes
    jal createArray             # Create the array
    move $a0, $v0               # Store the address of the ingredients array in $t1

	la $a1, r1i1                # Ingredient 1: Flour
    li $a2, 0                   # Index 0
    jal putElementToArray
	la $a1, r1i2                # Ingredient 2: Milk
    li $a2, 1                   # Index 1
    jal putElementToArray
    la $a1, r1i3                # Ingredient 3: Eggs
    li $a2, 2                   # Index 2
    jal putElementToArray
    la $a1, r1i4                # Ingredient 4: Sugar
    li $a2, 3                   # Index 3
    jal putElementToArray
    la $a1, r1i5                # Ingredient 5: Baking Powder
    li $a2, 4                   # Index 4
    jal putElementToArray

    # Create Pancakes recipe
    move $a1, $a0               # Ingredients array address

	 #Print $t0
	#move $a0, $a1               # Move $t0 to $a0 (syscall uses $a0 for input)
	#li $v0, 1                   # Syscall code for printing an integer
	#syscall                     # Print $t0

	
    la $a0, r1                  # Recipe name: Pancakes
    la $a2, r1c                 # Cooking time
    la $a3, r1d                 # Difficulty
    la $t2, r1r                 # Rating
    sw $t2, 0($sp)              # Store rating on stack
    jal createRecipe            # Create recipe
    move $t2, $v0               # Store the address of the recipe in $t2

	# Print $t0
	#move $a0, $t2               # Move $t0 to $a0 (syscall uses $a0 for input)
	#li $v0, 1                   # Syscall code for printing an integer
	#syscall                     # Print $t0

    # Enqueue Pancakes recipe
    lw $a0, addressOfRecipeList
	
    move $a1, $t2               # Recipe address


    jal enqueue
    la $a0, recipeAdded         # Print recipe added message
    li $v0, 4                   # Print string syscall
    syscall


	# Create and Add Spaghetti Bolognese Recipe
    # Create array for Spaghetti ingredients
    li $a0, 5                   # Maximum 5 ingredients
    li $a1, 4                   # Each ingredient address is 4 bytes
    jal createArray             # Create the array
    move $a0, $v0               # Store the address of the ingredients array in $t1

    # Add ingredients to array
    la $a1, r2i1                # Ingredient 1: Spaghetti
    li $a2, 0                   # Index 0
    jal putElementToArray
    la $a1, r2i2                # Ingredient 2: Ground Beef
    li $a2, 1                   # Index 1
    jal putElementToArray
    la $a1, r2i3                # Ingredient 3: Tomato Sauce
    li $a2, 2                   # Index 2
    jal putElementToArray
    la $a1, r2i4                # Ingredient 4: Garlic
    li $a2, 3                   # Index 3
    jal putElementToArray
    la $a1, r2i5                # Ingredient 5: Onion
    li $a2, 4                   # Index 4
    jal putElementToArray

    # Create Spaghetti Bolognese recipe
    move $a1, $a0               # Ingredients array address
	la $a0, r2                  # Recipe name: Spaghetti Bolognese
    la $a2, r2c                 # Cooking time
    la $a3, r2d                 # Difficulty
    la $t2, r2r                 # Rating
    sw $t2, 0($sp)              # Store rating on stack
    jal createRecipe            # Create recipe
    move $t2, $v0               # Store the address of the recipe in $t2

    # Enqueue Spaghetti Bolognese recipe
    lw $a0, addressOfRecipeList               # Linked list address
    move $a1, $t2               # Recipe address
    jal enqueue
    la $a0, recipeAdded         # Print recipe added message
    li $v0, 4                   # Print string syscall
    syscall
    

    # Print newline
	li $v0, 4          # Load syscall for printing string
    la $a0, newLine    # Load the address of the newline string
    syscall            # Print the newline

    #Print Queue Size
    lw $a0, addressOfRecipeList
    jal queueSize               # Get the size of the queue
    move $a0, $v0               # Queue size
    li $v0, 1                   # Print integer syscall
    syscall

    # Print newline
	li $v0, 4          # Load syscall for printing string
    la $a0, newLine    # Load the address of the newline string
    syscall            # Print the newline

    # Print "List: "
    li $v0, 4                    # Load syscall for printing string
    la $a0, listStr              # Load the address of the "List: " label
    syscall                      # Print the "List: " label

    # Print separator line
    li $v0, 4                    # Load syscall for printing string
    la $a0, lines                # Load the address of the separator line string
    syscall                      # Print the separator line

    # Print current recipes in the list
    lw $a0, addressOfRecipeList
	la $a1, printRecipe
	li $a2, 0
	jal traverseLinkedList

    #Print newline
    li $v0, 4          # Load syscall for printing string
    la $a0, newLine    # Load the address of the newline string
    syscall            # Print the newline

    # Print separator line
    li $v0, 4                    # Load syscall for printing string
    la $a0, lines                # Load the address of the separator line string
    syscall                      # Print the separator line

    #Print newline
	li $v0, 4          # Load syscall for printing string
    la $a0, newLine    # Load the address of the newline string
    syscall            # Print the newline

    # Dequeue and print the first recipe
    lw $a0, addressOfRecipeList
	jal dequeue
    move $a0, $t0
	jal printRecipe

    # Print newline
	li $v0, 4          # Load syscall for printing string
    la $a0, newLine    # Load the address of the newline string
    syscall            # Print the newline
    

    #Print Queue Size
    lw $a0, addressOfRecipeList
    jal queueSize               # Get the size of the queue
    move $a0, $v0               # Queue size
    li $v0, 1                   # Print integer syscall
    syscall
    
    #Print newline
    li $v0, 4          # Load syscall for printing string
    la $a0, newLine    # Load the address of the newline string
    syscall            # Print the newline

    # Print "List: "
    li $v0, 4                    # Load syscall for printing string
    la $a0, listStr              # Load the address of the "List: " label
    syscall                      # Print the "List: " label

    # Print separator line
    li $v0, 4                    # Load syscall for printing string
    la $a0, lines                # Load the address of the separator line string
    syscall                      # Print the separator line
    
    #print remainig recipes in the list
    lw $a0, addressOfRecipeList
	la $a1, printRecipe
	li $a2, 0
	jal traverseLinkedList

    #Print newline
    li $v0, 4          # Load syscall for printing string
    la $a0, newLine    # Load the address of the newline string
    syscall            # Print the newline

    # Print separator line
    li $v0, 4                    # Load syscall for printing string
    la $a0, lines                # Load the address of the separator line string
    syscall                      # Print the separator line

    #Print newline
    li $v0, 4          # Load syscall for printing string
    la $a0, newLine    # Load the address of the newline string
    syscall            # Print the newline

    # dequeue and print the next recipe
    lw $a0, addressOfRecipeList
	jal dequeue
    move $a0, $t0
	jal printRecipe

    #Print newline
    li $v0, 4          # Load syscall for printing string
    la $a0, newLine    # Load the address of the newline string
    syscall            # Print the newline

    
    # dequeue and print the next recipe 
    lw $a0, addressOfRecipeList
	jal dequeue
    move $a0, $t0
    jal printRecipe
    

    #Print newline
    li $v0, 4          # Load syscall for printing string
    la $a0, newLine    # Load the address of the newline string
    syscall            # Print the newline

    # Print Queue Size
    lw $a0, addressOfRecipeList
    jal queueSize               # Get the size of the queue
    move $a0, $v0               # Queue size
    li $v0, 1                   # Print integer syscall
    syscall

    #Print newline
    li $v0, 4          # Load syscall for printing string
    la $a0, newLine    # Load the address of the newline string
    syscall            # Print the newline
    
    # Print "List: "
    li $v0, 4                    # Load syscall for printing string
    la $a0, listStr              # Load the address of the "List: " label
    syscall                      # Print the "List: " label

    # Print separator line
    li $v0, 4                    # Load syscall for printing string
    la $a0, lines                # Load the address of the separator line string
    syscall                      # Print the separator line
    

    #print remaining recipes in the list (empty yazcak)
    lw $a0, addressOfRecipeList
	la $a1, printRecipe
	li $a2, 0
	jal traverseLinkedList

    # Print separator line
    li $v0, 4                    # Load syscall for printing string
    la $a0, lines                # Load the address of the separator line string
    syscall                      # Print the separator line

    #Print newline
    li $v0, 4          # Load syscall for printing string
    la $a0, newLine    # Load the address of the newline string
    syscall            # Print the newline

    # 4. Create and Add Chicken Stir-Fry Recipe
    # Create array for Chicken Stir-Fry ingredients
    li $a0, 5                   # Maximum 5 ingredients
    li $a1, 4                   # Each ingredient address is 4 bytes
    jal createArray             # Create the array
    move $a0, $v0               # Store the address of the ingredients array in $t1

    # Add ingredients to array
    la $a1, r3i1                # Ingredient 1: Chicken breast
    li $a2, 0                   # Index 0
    jal putElementToArray
    la $a1, r3i2                # Ingredient 2: Soy sauce
    li $a2, 1                   # Index 1
    jal putElementToArray
    la $a1, r3i3                # Ingredient 3: Bell peppers
    li $a2, 2                   # Index 2
    jal putElementToArray
    la $a1, r3i4                # Ingredient 4: Broccoli
    li $a2, 3                   # Index 3
    jal putElementToArray
    la $a1, r3i5                # Ingredient 5: Garlic
    li $a2, 4                   # Index 4
    jal putElementToArray

    # Create Chicken Stir-Fry recipe
    move $a1, $a0               # Ingredients array address
    la $a0, r3                  # Recipe name: Chicken Stir-Fry
    la $a2, r3c                 # Cooking time
    la $a3, r3d                 # Difficulty
    la $t2, r3r                 # Rating
    sw $t2, 0($sp)              # Store rating on stack
    jal createRecipe            # Create recipe
    move $t2, $v0               # Store the address of the recipe in $t2

    # Enqueue Chicken Stir-Fry recipe
    lw $a0, addressOfRecipeList               # Linked list address
    move $a1, $t2               # Recipe address
    jal enqueue
    la $a0, recipeAdded         # Print recipe added message
    li $v0, 4                   # Print string syscall
    syscall


    # Print newline
	li $v0, 4          # Load syscall for printing string
    la $a0, newLine    # Load the address of the newline string
    syscall            # Print the newline

    #Print Queue Size
    lw $a0, addressOfRecipeList
    jal queueSize               # Get the size of the queue
    move $a0, $v0               # Queue size
    li $v0, 1                   # Print integer syscall
    syscall

    # Print newline
	li $v0, 4          # Load syscall for printing string
    la $a0, newLine    # Load the address of the newline string
    syscall            # Print the newline

    # Print "List: "
    li $v0, 4                    # Load syscall for printing string
    la $a0, listStr              # Load the address of the "List: " label
    syscall                      # Print the "List: " label

    # Print separator line
    li $v0, 4                    # Load syscall for printing string
    la $a0, lines                # Load the address of the separator line string
    syscall                      # Print the separator line

    #print current recipes in the list
    lw $a0, addressOfRecipeList
	la $a1, printRecipe
	li $a2, 0
	jal traverseLinkedList

    # Print separator line
    li $v0, 4                    # Load syscall for printing string
    la $a0, lines                # Load the address of the separator line string
    syscall                      # Print the separator line

    # Create and Add Caesar Salad Recipe
    # Create array for Caesar Salad ingredients
    li $a0, 4                  # Maximum 5 ingredients
    li $a1, 4                   # Each ingredient address is 4 bytes
    jal createArray             # Create the array
    move $a0, $v0               # Store the address of the ingredients array in $t1

    # Add ingredients to array
    la $a1, r4i1                # Ingredient 1: Romaine lettuce
    li $a2, 0                   # Index 0
    jal putElementToArray
    la $a1, r4i2                # Ingredient 2: Caesar dressing
    li $a2, 1                   # Index 1
    jal putElementToArray
    la $a1, r4i3                # Ingredient 3: Parmesan cheese
    li $a2, 2                   # Index 2
    jal putElementToArray
    la $a1, r4i4                # Ingredient 4: Croutons
    li $a2, 3                   # Index 3
    jal putElementToArray
    la $a1, r4i5                # Ingredient 5: Chicken breast (optional)
    li $a2, 4                   # Index 4
    jal putElementToArray

    # Create Caesar Salad recipe
    move $a1, $a0               # Ingredients array address
    la $a0, r4                  # Recipe name: Caesar Salad
    la $a2, r4c                 # Cooking time
    la $a3, r4d                 # Difficulty
    la $t2, r4r                 # Rating
    sw $t2, 0($sp)              # Store rating on stack
    jal createRecipe            # Create recipe
    move $t2, $v0               # Store the address of the recipe in $t2

    # Enqueue Caesar Salad recipe
    lw $a0, addressOfRecipeList               # Linked list address
    move $a1, $t2               # Recipe address
    jal enqueue
    la $a0, recipeAdded         # Print recipe added message
    li $v0, 4                   # Print string syscall
    syscall

    # Print newline
	li $v0, 4          # Load syscall for printing string
    la $a0, newLine    # Load the address of the newline string
    syscall            # Print the newline

    #Print Queue Size
    lw $a0, addressOfRecipeList
    jal queueSize               # Get the size of the queue
    move $a0, $v0               # Queue size
    li $v0, 1                   # Print integer syscall
    syscall
    
    # Print newline
	li $v0, 4          # Load syscall for printing string
    la $a0, newLine    # Load the address of the newline string
    syscall            # Print the newline

    # Print "List: "
    li $v0, 4                    # Load syscall for printing string
    la $a0, listStr              # Load the address of the "List: " label
    syscall                      # Print the "List: " label

    # Print separator line
    li $v0, 4                    # Load syscall for printing string
    la $a0, lines                # Load the address of the separator line string
    syscall                      # Print the separator line

    #print current recipes in the list
    lw $a0, addressOfRecipeList
	la $a1, printRecipe
	li $a2, 0
	jal traverseLinkedList


    # Create array for Chocolate Chip Cookies ingredients
    li $a0, 5                   # Maximum 5 ingredients
    li $a1, 4                   # Each ingredient address is 4 bytes
    jal createArray             # Create the array
    move $a0, $v0               # Store the address of the ingredients array in $t1

    # Add ingredients to array
    la $a1, r5i1                # Ingredient 1: Butter
    li $a2, 0                   # Index 0
    jal putElementToArray
    la $a1, r5i2                # Ingredient 2: Sugar
    li $a2, 1                   # Index 1
    jal putElementToArray
    la $a1, r5i3                # Ingredient 3: Flour
    li $a2, 2                   # Index 2
    jal putElementToArray
    la $a1, r5i4                # Ingredient 4: Eggs
    li $a2, 3                   # Index 3
    jal putElementToArray
    la $a1, r5i5                # Ingredient 5: Chocolate chips
    li $a2, 4                   # Index 4
    jal putElementToArray

    # Create Chocolate Chip Cookies recipe
    move $a1, $a0               # Ingredients array address
    la $a0, r5                  # Recipe name: Chocolate Chip Cookies
    la $a2, r5c                 # Cooking time
    la $a3, r5d                 # Difficulty
    la $t2, r5r                 # Rating
    sw $t2, 0($sp)              # Store rating on stack
    jal createRecipe            # Create recipe
    move $t2, $v0               # Store the address of the recipe in $t2


    # Print newline
	li $v0, 4          # Load syscall for printing string
    la $a0, newLine    # Load the address of the newline string
    syscall            # Print the newline

    # Print separator line
    li $v0, 4                    # Load syscall for printing string
    la $a0, lines                # Load the address of the separator line string
    syscall                      # Print the separator line


    # Enqueue Chocolate Chip Cookies recipe
    lw $a0, addressOfRecipeList               # Linked list address
    move $a1, $t2               # Recipe address
    jal enqueue
    la $a0, recipeAdded         # Print recipe added message
    li $v0, 4                   # Print string syscall
    syscall

    # Print newline
	li $v0, 4          # Load syscall for printing string
    la $a0, newLine    # Load the address of the newline string
    syscall            # Print the newline

    #Print Queue Size
    lw $a0, addressOfRecipeList
    jal queueSize               # Get the size of the queue
    move $a0, $v0               # Queue size
    li $v0, 1                   # Print integer syscall
    syscall
    
    # Print newline
	li $v0, 4          # Load syscall for printing string
    la $a0, newLine    # Load the address of the newline string
    syscall            # Print the newline

    # Print "List: "
    li $v0, 4                    # Load syscall for printing string
    la $a0, listStr              # Load the address of the "List: " label
    syscall                      # Print the "List: " label

    # Print separator line
    li $v0, 4                    # Load syscall for printing string
    la $a0, lines                # Load the address of the separator line string
    syscall                      # Print the separator line

    #print current recipes in the list
    lw $a0, addressOfRecipeList
	la $a1, printRecipe
	li $a2, 0
	jal traverseLinkedList

    # Print newline
	li $v0, 4          # Load syscall for printing string
    la $a0, newLine    # Load the address of the newline string
    syscall            # Print the newline

    # Print separator line
    li $v0, 4                    # Load syscall for printing string
    la $a0, lines                # Load the address of the separator line string
    syscall                      # Print the separator line

    # Print newline
	li $v0, 4          # Load syscall for printing string
    la $a0, newLine    # Load the address of the newline string
    syscall            # Print the newline

    # Search for first recipe 
    lw $a0, addressOfRecipeList
	la $a1, findRecipe
	la $a2, search1
	jal traverseLinkedList

    # Search for second recipe 
	lw $a0, addressOfRecipeList
	la $a1, findRecipe
	la $a2, search2
	jal traverseLinkedList






mainTerminate:
    li $v0, 10                  # Exit syscall
    syscall                     # Terminate the program




createArray:
    # Create an array
    # Inputs: $a0 - max number of elements (size), $a1 - size of elements
    # Outputs: $v0 - address of array

    # Step 0: Save $a0 to another register (e.g., $t2)
    move $t2, $a0            # $t2'de $a0'ın orijinal değerini sakla

    # Step 1: Calculate the total memory required (elements + metadata)
    mul $t0, $a0, $a1        # $t0 = max number of elements * size of each element
    addi $t0, $t0, 12        # Add 12 bytes for metadata (address, size of array, size of element)

    # Step 2: Allocate memory for the array using sbrk syscall
    li $v0, 9                # System call for sbrk (memory allocation)
    move $a0, $t0            # Request the calculated memory size
    syscall                  # Allocate memory
    move $t1, $v0            # Store the address of the allocated memory in $t1

    # Step 3: Check if memory allocation succeeded
    li $t0, 0                # Load 0 into $t0 (comparison value)
    bne $v0, $t0, allocation_success  # If $v0 != 0, memory allocation succeeded

    # If memory allocation failed (address is NULL), jump to error handling
allocation_error:
    la $a0, indexBoundWarning  # Load error message
    li $v0, 4                  # Print string syscall
    syscall                    # Print the error message
    li $v0, 10                 # Exit syscall
    syscall                    # Exit program

allocation_success:
    # Step 4: Initialize the metadata of the array
    # Restore original $a0 from $t2
    move $a0, $t2             # $a0'ın ilk değerini geri yükle

    # Calculate ingredient array start address
    addi $t3, $t1, 12         # $t3 = Ingredient'lerin başladığı adres (t1 + 12)

    # Store the data pointer (ingredient array start address) in the first 4 bytes
    sw $t3, 0($t1)            # $t1'in 0 offset'ine ingredient'lerin başlangıç adresini yaz

    # Store the size of the array (max number of elements) in the next 4 bytes
    sw $a0, 4($t1)            # $t1'in 4 offset'ine array boyutunu yaz

    # Store the size of the elements in the last 4 bytes of the metadata
    sw $a1, 8($t1)            # $t1'in 8 offset'ine eleman boyutunu yaz


		# Print the metadata (values stored at $t1)
	# Print max number of elements
	#lw $a0, 0($t1)            # Load max number of elements
	#li $v0, 1                 # Print integer syscall
	#syscall                   # Print the value

	# Print size of elements
	#lw $a0, 4($t1)            # Load element size
	#li $v0, 1                 # Print integer syscall
	#syscall                   # Print the value

	# Print current size
	#lw $a0, 8($t1)            # Load current size
	#li $v0, 1                 # Print integer syscall
	#syscall                   # Print the value

    # Step 5: Return the address of the array (start of the allocated memory)
    move $v0, $t1             # Set $v0 to the address of the array (start of metadata)
    jr $ra                    # Return to the caller


putElementToArray:
    # Store an element (recipe) in an array.
    # Inputs: $a0 - address of array, $a1 - element address, $a2 - index

    # Load metadata from the array
    lw $t0, 0($a0)              # Load data pointer (start of actual data)
    lw $t1, 4($a0)              # Load max number of elements (array size)
    lw $t2, 8($a0)              # Load size of each element

	# Print $t0
	#move $a0, $t0               # Move $t0 to $a0 (syscall uses $a0 for input)
	#li $v0, 1                   # Syscall code for printing an integer
	#syscall                     # Print $t0

	# Print $t1
	#move $a0, $t1               # Move $t1 to $a0
	#li $v0, 1                   # Syscall code for printing an integer
	#syscall                     # Print $t1

	# Print $t2
	#move $a0, $t2               # Move $t2 to $a0
	#li $v0, 1                   # Syscall code for printing an integer
	#syscall                     # Print $t2		

    # Ensure index is within bounds
    slt $t3, $a2, $t1           # t3 = 1 if index < max_elements
    sle $t4, $zero, $a2         # t4 = 1 if index >= 0

    and $t5, $t3, $t4           # t5 = 1 if index is valid (both conditions true)

    # If index is not valid, print the "Index out of bounds!" message
    bnez $t5, valid_index       # If t5 is not zero, index is valid, skip to valid_index
    move $t2, $a0
    la $a0, indexBoundWarning   # Load the "Index out of bounds!" message
    li $v0, 4                   # Print string syscall
    syscall                     # Print the message
    move $a0, $t2
    jr $ra                      # Return to the caller

valid_index:
    # Calculate the address of the element at the given index
    mul $t6, $a2, $t2           # Byte offset = index * size_of_element
    add $t7, $t0, $t6           # Address = data_pointer + offset

	# Print $t2
	#move $a0, $t7               # Move $t2 to $a0
	#li $v0, 1                   # Syscall code for printing an integer
	#syscall                     # Print $t2		

    # Store the element (address of recipe) in the array
    sw $a1, 0($t7)              # Store the element at the calculated address

    jr $ra                      # Return to caller

createLinkedList:
	# Create a linked list.
	# Outputs: $v0 - address of linked List
	
	li $v0, 9                # System call for memory allocation (sbrk)
    li $a0, 8                # Request 8 bytes for the linked list structure
    syscall                  # Allocate memory
    move $t0, $v0            # Store the address of the allocated memory in $t0


    # Initialize the linked list structure (head = NULL, size = 0)
    sw $zero, 0($t0)         # Set the head of the list to NULL
    sw $zero, 4($t0)         # Set the size of the list to 0

    move $v0, $t0            # Return the address of the linked list
    jr $ra                   # Return to the caller


enqueue:
	# Inputs: $a0 - address of the linked list structure, $a1 - address of data to add
	
    # 1. Allocate memory for the new node
	move $t7, $a0            # $a0'ı yedekle
    li $v0, 9                # System call for memory allocation
    li $a0, 8                # Request 8 bytes (4 bytes for data, 4 bytes for next pointer)
    syscall                  # Perform the memory allocation
    move $t2, $v0            # Store the address of the new node
	move $a0, $t7            # $a0'ı geri yükle

    # 2. Initialize the new node
    sw $a1, 0($t2)           # Store the data (recipe address) in the new node
    sw $zero, 4($t2)         # Set the next pointer to NULL

    # 3. Check if the list is empty
    lw $t0, 0($a0)           # Load the head of the linked list
    beqz $t0, set_head       # If the list is empty, set the new node as the head

    # 4. Traverse to the end of the list
    move $t3, $t0            # Start at the head of the list
	
traverse_end:
    lw $t4, 4($t3)           # Load the next pointer of the current node
	
    beqz $t4, set_next       # If the next pointer is NULL, we're at the last node
    move $t3, $t4            # Move to the next node
    j traverse_end           # Continue traversing

set_next:
    sw $t2, 4($t3)           # Set the new node as the next node of the current last node
    j update_size            # Jump to size update

set_head:
    sw $v0, 0($a0)           # Set the new node as the head of the linked list
	
	

update_size:
    # 5. Update the size of the list
    lw $t5, 4($a0)           # Load the current size of the list
		# Print $t2
	#move $a0, $t7               # Move $t2 to $a0
	#li $v0, 1                   # Syscall code for printing an integer
	#syscall                     # Print $t2	
    addi $t5, $t5, 1         # Increment the size by 1
    sw $t5, 4($a0)           # Store the updated size back to the list metadata
	jr $ra                   # Return to the caller


dequeue:
	# Inputs: $a0 - address of the linked list structure
	# Outputs: $v0 - removed head node, 0 if empty
	
    lw $t0, 0($a0)           # Load the address of the head node
    beqz $t0, empty_list_dequeue # If list is empty, return 0

    lw $v0, 0($t0)           # Load the data of the head node into $v0
    lw $t2, 4($t0)           # Load the address of the next node

    sw $t2, 0($a0)           # Set the head to the next node
    lw $t3, 4($a0)           # Load current size
    addi $t3, $t3, -1        # Decrement size using addi
    sw $t3, 4($a0)           # Update size in the list metadata

    # Print success message
    la $a0, recipeRemoved    # Load "Recipe removed." message
    li $v0, 4                # Print string syscall
    syscall                  # Print the message
    jr $ra                   # Return to caller

empty_list_dequeue:
    #Print messages
    la $a0, emptyListWarning # Load "List is empty!" message
    li $v0, 4                # Print string syscall
    syscall                  # Print the message
    la $a0, recipeRemoved    # Load "Recipe removed." message
    li $v0, 4                # Print string syscall
    syscall                  # Print the message
    
    li $v0, 0                # Set $v0 to 0 if the list is empty
    jr $ra                   # Return to caller


queueSize:
	# Inputs: $a0 - address of the linked list structure

	move $t7, $a0
	la $a0, listSize         # Load "List Size: " string address
    li $v0, 4                # Syscall code for printing a string
    syscall                  # Print the "List Size: " string

	move $a0, $t7
	lw $v0, 4($a0)           # Load the size of the list
    jr $ra

traverseArray:
	# Traverse and process elements in the array.
	# Inputs: $a0 - address of array, $a1 - function to call for each element.

	lw $t0, 0($a0)           # Load array length into $t0
	lw $t1, 4($a0)           # Load element size into $t1
	li $t2, 0                # Initialize counter ($t2 = 0)
	move $s0, $ra            # Save return address

traverse_loop:
	move $a0, $t0            # $a0 points to the current element address
	jalr $a1                 # Call the provided function

	addi $t0, $t0, 4         # Move to the next element address
	addi $t2, $t2, 1         # Increment counter
	blt $t2, $t1, traverse_loop # Continue loop if counter < array length

end_traversal:
	move $ra, $s0            # Restore return address
	jr $ra                   # Return to caller





traverseLinkedList:
    # Traverse the linked list.
    # Inputs: $a0 - head node of the linked list, $a1 - called function, $a2 - extra arguments

    lw $s6, 4($a0)           # Load the size of the list into $s6
    move $s7, $ra            # Save the return address into $s7
    beqz $s6, empty_list_traversal  # If the list is empty (size is zero), jump to empty list handling
    lw $t9, 0($a0)           # Load the address of the first node into $t9
    move $s1, $a1            # Store the address of the called function into $s1
    move $a1, $a2            # Move the extra arguments into $a1

    la $a0, newLine          # Load the address of the newLine string
    li $v0, 4                # Load the print string syscall code into $v0
    syscall                  # Execute the syscall to print the new line

traversal_node_loop:
    beqz $s6, end_traversal_node  # If the size ($s6) is zero, end the traversal
    move $a0, $t9            # Pass the current node data to the function (store in $a0)
    jalr $s1                 # Call the function in $s1

    lw $t9, 4($t9)           # Move to the next node (load the next node address into $t9)
    addi $s6, $s6, -1        # Decrement the size counter ($s6)
    j traversal_node_loop    # Repeat the loop

end_traversal_node:
    move $ra, $s7            # Restore the return address and return to the caller
    jr $ra                   # Return to the caller

empty_list_traversal:
    la $a0, emptyListWarning # Load the message "List is empty" and print it
    li $v0, 4                # Load the print string syscall code into $v0
    syscall                  # Execute the syscall to print the message
    move $ra, $s7            # Restore the return address and return to the caller
    jr $ra                   # Return to the caller



compareString:
	# Compare two strings.
	# Inputs: $a0 - string 1 address, $a1 - string 2 address
	# Outputs: $v0 - 0 found, 1 not found
    move $t5, $a0
    move $t6, $a1

    lb $t2, 0($t5)         # Load first byte of string 1

    lb $t3, 0($t6)         # Load first byte of string 2

compare_loop:
    bne $t2, $t3, strings_not_equal # If characters are different, strings are not equal
    beqz $t2, strings_equal         # If end of string 1 is $zero, strings are equal
    addi $t5, $t5, 1                # Move to next byte of string 1
    addi $t6, $t6, 1                # Move to next byte of string 2
    lb $t2, 0($t5)                  # Load next byte of string 1
    lb $t3, 0($t6)                  # Load next byte of string 2
    j compare_loop                  # Continue comparing

strings_equal:
    li $v0, 0                       # Strings are equal, return 0
    jr $ra                          # Return to caller

strings_not_equal:
    li $v0, 1                       # Strings are not equal, return 1
    jr $ra                          # Return to caller


createRecipe:
	# Create a recipe and store in the recipe struct.
	# Inputs: $a0 - recipe name, $a1 - address of ingredients array,
	#         $a2 - cooking time, $a3 - difficulty, 0($sp) - rating
	# Outputs: $v0 - recipe address
	
    # Step 1: Allocate memory for the recipe structure (20 bytes)
    
	move $t2, $a0            # Save the recipe name address to $t2
    li $v0, 9                # System call for memory allocation (sbrk)
    li $a0, 20               # Request 20 bytes for the recipe structure
    syscall                  # Allocate memory
    move $t0, $v0            # Store the address of the allocated memory in $t0

    # Step 2: Initialize the recipe structure
    sw $t2, 0($t0)           # Store the recipe name (address) in the recipe structure
    sw $a1, 4($t0)           # Store the ingredients array address in the recipe structure
    sw $a2, 8($t0)           # Store the cooking time in the recipe structure
    sw $a3, 12($t0)          # Store the difficulty in the recipe structure
    lw $t1, 0($sp)           # Load rating from stack
    sw $t1, 16($t0)          # Store the rating in the recipe structure

    # Step 3: Return the address of the recipe
    move $v0, $t0            # Return the address of the recipe
    jr $ra                   # Return to the caller

findRecipe:
    # Compare two recipe names.
    # Inputs: $a0 - recipe struct address, $a1 - searched recipe name

    move $t8, $ra
    move $s5, $a0
    lw $t0, 0($s5)            # Load the address of the recipe name from the recipe struct

    lw $a0, 0($t0)             # Move the recipe name to $a0

    jal compareString         # Call compareString to compare the names

    beqz $v0, recipe_matched  # If $v0 == 0 (strings match), jump to recipe_matched

recipe_not_matched:
    la $a0, recipeNotMatch    # Load "Recipe not matched!" message
    li $v0, 4                 # Print string syscall
    syscall                   # Print the message
    move $ra, $t8
    jr $ra                    # Return to the caller

recipe_matched:
    la $a0, recipeMatch       # Load "Recipe matched!" message
    li $v0, 4                 # Print string syscall
    syscall                   # Print the message

    move $a0, $s5             # Move recipe address to $a0 for printRecipe
    jal printRecipe           # Call printRecipe to display matched recipe
    move $ra, $t8
    jr $ra                    # Return to the caller



printRecipe:
    # Print recipe details.
    # Inputs: $a0 - address of recipe struct

    move $s8, $ra         # Save the return address
    # Step 0: Check if recipe exists
    beqz $a0, noRecipe    # If $s5 is 0 (null), jump to noRecipe
    
    
    lw $s5, 0($a0)        # Load the address of the recipe struct
    beqz $s5, noRecipe    # If $s5 is 0 (null), jump to noRecipe



    #move $a0, $s5               
	#li $v0, 1                   
	#syscall                     



    # Step 1: Print Recipe Name
    li $v0, 4   
    la $a0, recipeName    # Load the label for recipe name
    syscall               # Print the label

    lw $t0, 0($s5)        # Load recipe name address
    move $a0, $t0         # Move the address to $a0 for printing
    li $v0, 4             # Print string syscall
    syscall               # Print the recipe name

    # Step 2: Print a newline
    jal printNewLine      # Print newline after recipe name

    # Step 3: Print Ingredients
    li $v0, 4
    la $a0, ingredients   # Load ingredients label
    syscall               # Print ingredients label

    lw $a0, 4($s5)        # Load ingredients array address
    la $a1, printIngredient  # Load printIngredient function address
    jal traverseArray     # Traverse and print ingredients

    # Step 4: Print a newline
    jal printNewLine      # Print newline after ingredients

    # Step 5: Print Cooking Time
    li $v0, 4
    la $a0, cookingTime   # Load cooking time label
    syscall               # Print cooking time label

    lw $t0, 12($s5)        # Load cooking time address
    lw $a0, 0($t0)        # Load the cooking time value
    li $v0, 1             # Print integer syscall
    syscall               # Print the cooking time

    # Step 6: Print a newline
    jal printNewLine      # Print newline after cooking time

    # Step 7: Print Difficulty
    li $v0, 4
    la $a0, difficulty    # Load difficulty label
    syscall               # Print difficulty label

    lw $t0, 16($s5)       # Load difficulty address
    lw $a0, 0($t0)        # Load the difficulty value
    li $v0, 1             # Print integer syscall
    syscall               # Print the difficulty

    # Step 8: Print a newline
    jal printNewLine      # Print newline after difficulty

    # Step 9: Print Rating
    li $v0, 4
    la $a0, rating        # Load rating label
    syscall               # Print rating label

    lw $t0, 20($s5)       # Load rating address
    lw $a0, 0($t0)        # Load the rating value
    li $v0, 1             # Print integer syscall
    syscall               # Print the rating

    # Step 10: Print a newline
    jal printNewLine      # Print newline after rating

    move $ra, $s8         # Restore the return address
    jr $ra                # Return to the caller

noRecipe:
    li $v0, 4            # Print string syscall
    la $a0, noRecipeWarning  # Load the address of noRecipeWarning string
    syscall              # Print the warning
    move $ra, $s8
    jr $ra                # Return to the caller


printNewLine:
    li $v0, 4            # Print string syscall
    la $a0, newLine      # Load the address of newLine string
    syscall              # Print the newline
    jr $ra               # Return to the caller

printIngredient:
	# Print ingredient.
	# Inputs: $a0 - address of ingredient
    move $s5, $a0

    # Step 2: Print a newline for formatting
    la $a0, newLine          # Load the address of the newline string
    li $v0, 4                # Print string syscall
    syscall                  # Print the newline        

    la $a0, tab              # Load the address of the tab string
    li $v0, 4                # Print string syscall for tab
    syscall                  # Print the tab

    move $a0, $s5

    lw $t5, 0($a0)           # Load the ingredient from $s5
    move $a0, $t5            # Move the ingredient address to $a0
    li $v0, 4                # Print string syscall
    syscall                  # Print the ingredient name


    jr $ra                   # Return to the caller