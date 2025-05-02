#!/bin/bash


declare -a Names
declare -a IDs
declare -a Depts
declare -a Batches
Total=0


id_exists() {
  local id=$1
  for ((i = 0; i < Total; i++)); do
    if [ "${IDs[$i]}" == "$id" ]; then
      return 0
    fi
  done
  return 1
}


insert() {
  echo -n "Enter the number of students: "
  read num_of_students
  for ((i = 0; i < num_of_students; i++)); do
    echo "Enter the data of student number $((Total + 1))"
    echo -n "Enter Name: "
    read Names[$Total]
    while true; do
      echo -n "Enter Student ID: "
      read id
      if id_exists "$id"; then
        echo "Student ID already exists. Please enter a unique ID."
      else
        IDs[$Total]=$id
        break
      fi
    done
    echo -n "Enter Department Name: "
    read Depts[$Total]
    echo -n "Enter Batch Number: "
    read Batches[$Total]
    Total=$((Total + 1))
  done
}


display() {
  if [ $Total -eq 0 ]; then
    echo "No data is inserted!"
  else
    for ((i = 0; i < Total; i++)); do
      echo "Data of student number $((i + 1))"
      echo "Name: ${Names[$i]}"
      echo "Student ID: ${IDs[$i]}"
      echo "Department: ${Depts[$i]}"
      echo "Batch: ${Batches[$i]}"
      echo ""
    done
  fi
}


search() {
  if [ $Total -eq 0 ]; then
    echo "No data is inserted!"
  else
    echo -n "Enter Student ID: "
    read identity
    found=0
    for ((i = 0; i < Total; i++)); do
      if [ "${IDs[$i]}" == "$identity" ]; then
        echo "Name: ${Names[$i]}"
        echo "Student ID: ${IDs[$i]}"
        echo "Department: ${Depts[$i]}"
        echo "Batch: ${Batches[$i]}"
        echo ""
        found=1
        break
      fi
    done
    if [ $found -eq 0 ]; then
      echo "No data found for ID $identity."
    fi
  fi
}


update() {
  if [ $Total -eq 0 ]; then
    echo "No data is inserted!"
  else
    echo -n "Enter the student's ID to update: "
    read identity
    found=0
    for ((i = 0; i < Total; i++)); do
      if [ "${IDs[$i]}" == "$identity" ]; then
        echo "Previous Data:"
        echo "Name: ${Names[$i]}"
        echo "Department: ${Depts[$i]}"
        echo "Batch: ${Batches[$i]}"
        echo ""
        echo "Enter new data:"
        echo -n "Enter Name: "
        read Names[$i]
        echo -n "Enter Department Name: "
        read Depts[$i]
        echo -n "Enter Batch Number: "
        read Batches[$i]
        found=1
        break
      fi
    done
    if [ $found -eq 0 ]; then
      echo "No data found for ID $identity."
    fi
  fi
}


delete() {
  if [ $Total -eq 0 ]; then
    echo "No data is inserted!"
  else
    echo -n "Enter the student's ID to delete: "
    read identity
    found=0
    for ((i = 0; i < Total; i++)); do
      if [ "${IDs[$i]}" == "$identity" ]; then
        for ((j = i; j < Total - 1; j++)); do
          Names[$j]=${Names[$((j + 1))]}
          IDs[$j]=${IDs[$((j + 1))]}
          Depts[$j]=${Depts[$((j + 1))]}
          Batches[$j]=${Batches[$((j + 1))]}
        done
        unset Names[$((Total - 1))]
        unset IDs[$((Total - 1))]
        unset Depts[$((Total - 1))]
        unset Batches[$((Total - 1))]
        Total=$((Total - 1))
        echo "Record deleted."
        found=1
        break
      fi
    done
    if [ $found -eq 0 ]; then
      echo "No data found for ID $identity."
    fi
  fi
}


while true; do
  echo ""
  echo "## Green University of Bangladesh"
  echo "## Student Management System"
  echo "1. Insert Student's Data"
  echo "2. Display All Student's Data"
  echo "3. Find Any Student's Data"
  echo "4. Update Data"
  echo "5. Delete Data"
  echo "6. Exit"
  echo -n "Enter your choice: "
  read choice

  case $choice in
  1) insert ;;
  2) display ;;
  3) search ;;
  4) update ;;
  5) delete ;;
  6) echo "Exiting..."; exit ;;
  *) echo "Invalid choice! Try again." ;;
  esac
done

