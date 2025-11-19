import Foundation

struct D3Demo {
    static let html = """
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://d3js.org/d3.v7.min.js"></script>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
            padding: 20px;
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            min-height: 100vh;
        }
        .container {
            background: white;
            border-radius: 20px;
            padding: 20px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.2);
        }
        h1 {
            color: #333;
            margin-bottom: 20px;
            font-size: 24px;
        }
        #chart {
            width: 100%;
            overflow: visible;
        }
        .node circle {
            fill: #4facfe;
            stroke: #00f2fe;
            stroke-width: 3px;
        }
        .node text {
            font-size: 12px;
            font-weight: bold;
        }
        .link {
            stroke: #999;
            stroke-opacity: 0.6;
            stroke-width: 2px;
        }
        .controls {
            margin-top: 20px;
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 10px;
        }
        button {
            padding: 15px;
            border: none;
            border-radius: 10px;
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            color: white;
            font-weight: bold;
            font-size: 16px;
        }
        button:active {
            transform: scale(0.95);
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Visualização de Rede</h1>
        <div id="chart"></div>
        <div class="controls">
            <button onclick="addNode()">Adicionar Nó</button>
            <button onclick="restart()">Reiniciar</button>
        </div>
    </div>

    <script>
        const width = Math.min(window.innerWidth - 80, 400);
        const height = 400;

        let nodes = [
            { id: 1, name: "Swift" },
            { id: 2, name: "JavaScript" },
            { id: 3, name: "WebKit" },
            { id: 4, name: "Node.js" },
            { id: 5, name: "D3.js" }
        ];

        let links = [
            { source: 1, target: 3 },
            { source: 2, target: 3 },
            { source: 2, target: 4 },
            { source: 2, target: 5 }
        ];

        const svg = d3.select("#chart")
            .append("svg")
            .attr("width", width)
            .attr("height", height);

        let simulation = d3.forceSimulation(nodes)
            .force("link", d3.forceLink(links).id(d => d.id).distance(100))
            .force("charge", d3.forceManyBody().strength(-300))
            .force("center", d3.forceCenter(width / 2, height / 2));

        let link = svg.append("g")
            .selectAll("line")
            .data(links)
            .enter().append("line")
            .attr("class", "link");

        let node = svg.append("g")
            .selectAll("g")
            .data(nodes)
            .enter().append("g")
            .attr("class", "node")
            .call(d3.drag()
                .on("start", dragstarted)
                .on("drag", dragged)
                .on("end", dragended));

        node.append("circle")
            .attr("r", 20);

        node.append("text")
            .text(d => d.name)
            .attr("x", 25)
            .attr("y", 5);

        simulation.on("tick", () => {
            link
                .attr("x1", d => d.source.x)
                .attr("y1", d => d.source.y)
                .attr("x2", d => d.target.x)
                .attr("y2", d => d.target.y);

            node
                .attr("transform", d => `translate(${d.x},${d.y})`);
        });

        function dragstarted(event, d) {
            if (!event.active) simulation.alphaTarget(0.3).restart();
            d.fx = d.x;
            d.fy = d.y;
        }

        function dragged(event, d) {
            d.fx = event.x;
            d.fy = event.y;
        }

        function dragended(event, d) {
            if (!event.active) simulation.alphaTarget(0);
            d.fx = null;
            d.fy = null;
        }

        function addNode() {
            const newId = nodes.length + 1;
            const techNames = ["React", "Vue", "Angular", "TypeScript", "Python", "Go"];
            const randomName = techNames[Math.floor(Math.random() * techNames.length)];
            
            nodes.push({ id: newId, name: randomName });
            
            const randomTarget = Math.floor(Math.random() * (nodes.length - 1)) + 1;
            links.push({ source: newId, target: randomTarget });
            
            updateGraph();
        }

        function restart() {
            nodes = [
                { id: 1, name: "Swift" },
                { id: 2, name: "JavaScript" },
                { id: 3, name: "WebKit" },
                { id: 4, name: "Node.js" },
                { id: 5, name: "D3.js" }
            ];

            links = [
                { source: 1, target: 3 },
                { source: 2, target: 3 },
                { source: 2, target: 4 },
                { source: 2, target: 5 }
            ];
            
            updateGraph();
        }

        function updateGraph() {
            simulation.nodes(nodes);
            simulation.force("link").links(links);

            link = link.data(links);
            link.exit().remove();
            link = link.enter().append("line")
                .attr("class", "link")
                .merge(link);

            node = node.data(nodes, d => d.id);
            node.exit().remove();
            
            const nodeEnter = node.enter().append("g")
                .attr("class", "node")
                .call(d3.drag()
                    .on("start", dragstarted)
                    .on("drag", dragged)
                    .on("end", dragended));

            nodeEnter.append("circle")
                .attr("r", 20);

            nodeEnter.append("text")
                .text(d => d.name)
                .attr("x", 25)
                .attr("y", 5);

            node = nodeEnter.merge(node);

            simulation.alpha(1).restart();
        }
        
        function handleSwiftMessage(message) {
            console.log('📱 Swift → JS:', message);
            
            if (message === 'addNode') {
                addNode();
                if (window.webkit && window.webkit.messageHandlers.swiftHandler) {
                    window.webkit.messageHandlers.swiftHandler.postMessage('Nó adicionado! Total: ' + data.nodes.length);
                }
            } else if (message === 'addRandomLink') {
                if (data.nodes.length > 1) {
                    const source = Math.floor(Math.random() * data.nodes.length);
                    let target = Math.floor(Math.random() * data.nodes.length);
                    while (target === source) {
                        target = Math.floor(Math.random() * data.nodes.length);
                    }
                    data.links.push({ source: data.nodes[source].id, target: data.nodes[target].id });
                    updateGraph();
                    if (window.webkit && window.webkit.messageHandlers.swiftHandler) {
                        window.webkit.messageHandlers.swiftHandler.postMessage('Link criado!');
                    }
                }
            } else if (message === 'reset') {
                data.nodes = [
                    { id: 'Swift', group: 1 },
                    { id: 'JavaScript', group: 2 },
                    { id: 'D3.js', group: 3 },
                    { id: 'WebKit', group: 4 }
                ];
                data.links = [
                    { source: 'Swift', target: 'WebKit' },
                    { source: 'WebKit', target: 'JavaScript' },
                    { source: 'JavaScript', target: 'D3.js' }
                ];
                updateGraph();
                if (window.webkit && window.webkit.messageHandlers.swiftHandler) {
                    window.webkit.messageHandlers.swiftHandler.postMessage('Grafo resetado!');
                }
            }
        }
    </script>
</body>
</html>
"""
}
