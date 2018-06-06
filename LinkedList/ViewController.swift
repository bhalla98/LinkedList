//
//  ViewController.swift
//  LinkedList
//
//  Created by siddharth bhalla on 5/27/18.
//  Copyright © 2018 sb. All rights reserved.
//

import UIKit

public class Node {
    var value: Int
    var next: Node?
    
    init(value: Int) {
        self.value = value
    }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var listLbl: UILabel!
    @IBOutlet weak var bottomLbl: UILabel!
    @IBOutlet weak var elementField: UITextField!
    @IBOutlet weak var positionField: UITextField!
    
    var head = Node(value: 0)
    var sorted = Node(value: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listLbl.text = "[0]"
    }
    
    @IBAction func addElement(_ sender: UIButton) {
        insert(val: Int(elementField.text!)!, position: Int(positionField.text!)!)
    }
    
    @IBAction func removeElement(_ sender: UIButton) {
        remove(position: Int(positionField.text!)!)
    }
    
    @IBAction func searchElement(_ sender: UIButton) {
        searchVal(value: Int(elementField.text!)!)
    }
    
    @IBAction func reverseList(_ sender: UIButton) {
        let myReversedList = reverseList(headref: head)
        
        printList(head: myReversedList) //needs to print out 3,2,1
    }
    
    // TODO Sort list function
    @IBAction func sortList(_ sender: UIButton) {
        insertionSort(headref: head)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    // PRINTING LIST
    func printList(head: Node?) {
        var elementsArray = [Int]()
        print("Printing out list of nodes")
        var currentNode = head
        while currentNode != nil {
            print(currentNode?.value ?? -1)
            elementsArray.append((currentNode?.value)!)
            // TODO print element in Label
            currentNode = currentNode?.next
        }
        listLbl.text = "\(elementsArray)"
    }
    
    
    // INSERTING NEW ELEMENT
    func insert(val: Int, position: Int) {
        // TODO handle usecase when list is empty and head->nil
        
        if head.value == nil {
            head.value = val
            head.next = nil
        } else if position == 1 {
            let newNode = Node(value: val)
            newNode.next = head
            head = newNode
        } else if position == 2 {
            let newNode = Node(value: val)
            newNode.next = head.next
            head.next = newNode
            
        }  else {
            var counter = 1
            var lastNode: Node? = head
            while lastNode != nil && lastNode!.next != nil {
                lastNode = lastNode!.next!
                counter += 1
                if counter == position-1 {
                    break
                }
                
            }
            print("LastNode: \(lastNode!.value)")
            
            let newNode = Node(value: val)
            newNode.value = val
            newNode.next = lastNode?.next
            lastNode?.next = newNode
        }
        
        printList(head: head)
        
    }
    
    
    // REMOVING ELEMENT
    func remove(position: Int) {
        print("Remove Func Called:")
        if position == 1 {
            var currentNode = Node(value: -1)
            currentNode.next = nil
            var lastNode: Node? = head
            
            while lastNode!.next != nil {
                currentNode = lastNode!
                lastNode = lastNode!.next!
                print("CurrentNode: \(currentNode.value), NextNode: \(lastNode!.value)" )
                break
            }
            
            print("RemovedNode: \(lastNode!.value)")
            head = currentNode.next!
            printList(head: head)
        }
            //    if position == 1 {
            //        head = head.next!
            //    }
        else {
            var counter = 1
            var currentNode = Node(value: -1)
            currentNode.next = nil
            var lastNode: Node? = head
            while lastNode!.next != nil {
                currentNode = lastNode!
                lastNode = lastNode!.next!
                counter += 1
                print("CurrentNode: \(currentNode.value), NextNode: \(lastNode!.value)" )
                if counter == position {
                    break
                }
            }
            
            print("RemovedNode: \(lastNode!.value)")
            currentNode.next = lastNode?.next
            lastNode?.next = nil
            
            printList(head: head)
        }
    }



    // REVERSING LIST
    func reverseList(headref: Node?) -> Node? {

        var currentNode = headref
        var prev: Node?
        var next: Node?

        while currentNode != nil {
            next = currentNode?.next
            currentNode?.next = prev

            print("Prev: \(prev?.value ?? -1), Curr: \(currentNode?.value ?? -1), Next: \(next?.value ?? -1)")

            prev = currentNode
            currentNode = next
        }
        head = prev!
        return prev
    }
    
    
    // SEARCHING ELEMENT IN LIST
    func searchVal(value: Int) {
        if head.value == nil {
            print("List is Empty")
        }
        var flag = 0
        var counter: Int = 1
        var currentNode: Node? = head
        
        while currentNode != nil {
            if currentNode!.value == value {
                flag = 1
                print("Value found at position: \(counter)")
                bottomLbl.text = "Value found at position: \(counter)"
                break
            }
            currentNode = currentNode!.next
            counter = counter + 1
        }
        if flag == 0 {
            print("Value not found")
        }
    }
    
    
    // SORTING LIST
    func insertionSort(headref: Node?) {
        
        var currentNode = headref
        while currentNode != nil {
            var nextNode = currentNode?.next
            sortedInsert(newNode: currentNode)
            currentNode = nextNode
        }
    
        head = sorted.next!
        printList(head: sorted.next)
    }
    
    func sortedInsert(newNode: Node?) {
        if sorted.value == nil || sorted.value >= (newNode?.value)! {
            newNode?.next = sorted
            sorted = newNode!;
        } else {
            var currentNode = sorted
            while currentNode.next != nil && (currentNode.next?.value)! < (newNode?.value)! {
                currentNode = currentNode.next!
            }
            newNode?.next = currentNode.next
            currentNode.next = newNode
        }
    }
   

}
