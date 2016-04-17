//: # Recursive Enums


/*:
This fails because of infinite recursion:

    enum Tree<T> {
        case Leaf(T)
        case Node(Tree, Tree)
    }
*/

enum Tree<T> {
    case Leaf(T)
    indirect case Node(Tree, Tree)
}

let node1 = Tree.Leaf("A")
let node2 = Tree.Leaf("B")
let node3 = Tree.Leaf("C")
let tree1 = Tree.Node(node1, node2)
let tree2 = Tree.Node(tree1, node3)

print(tree2)
