from pyvis.network import Network

net = Network()

net.add_node(1, label="Node 1") # node id = 1 and label = Node 1
net.add_node(2) # node id and label = 2

nodes = ["a", "b", "c", "d"]
net.add_nodes(nodes) # node ids and labels = ["a", "b", "c", "d"]
net.add_nodes("hello") # node ids and labels = ["h", "e", "l", "o"]

net.add_nodes(["a", "b", "c"])
net.get_node("c")
{'id': 'c', 'label': 'c', 'shape': 'dot'}

net.show('nx.html')

git remote set-url origin https://github.com/aadishchopra/repository.git

ssh-add ~/.ssh/id_rsa

ssh-keygen -t ed25519 -C "aadishchopra@rediffmail.com"
