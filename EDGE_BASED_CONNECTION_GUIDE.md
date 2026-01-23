# Edge-Based Connection System - User Guide

## Overview
The Flow Builder now uses an intuitive edge-based connection system. Each node has 4 connection points (edges) on its sides: top, right, bottom, and left. This allows for flexible and organized flow diagrams.

## How to Create Connections

### Step 1: Select a Node
Click on any node to select it. The node will show a blue border and 4 colored connection points will appear on its edges:
- **Top edge** (↑) - for connections from above
- **Right edge** (→) - for connections from the right
- **Bottom edge** (↓) - for connections from below
- **Left edge** (←) - for connections from the left

### Step 2: Click an Edge Point
Click on one of the 4 edge points on the selected node. This starts the connection:
- A dashed blue line appears from the clicked edge
- The line follows your mouse as you move it around the canvas
- This is the "tail" of the arrow

### Step 3: Select the Target Node
Click on the target node where you want to connect. The target node will show its 4 edge points.

### Step 4: Click the Target Edge
Click on one of the 4 edge points on the target node. This completes the connection:
- A solid blue arrow appears connecting the two nodes
- The arrow starts from the first edge you clicked
- The arrow ends at the second edge you clicked
- The connection is now permanent

## Connection Examples

### Vertical Flow (Top to Bottom)
1. Select first node
2. Click its **bottom edge** (↓)
3. Select second node below it
4. Click its **top edge** (↑)
5. Arrow connects vertically downward

### Horizontal Flow (Left to Right)
1. Select first node
2. Click its **right edge** (→)
3. Select second node to the right
4. Click its **left edge** (←)
5. Arrow connects horizontally rightward

### Complex Branching
1. Select a node
2. Click its **right edge** (→)
3. Select a node to the right
4. Click its **left edge** (←)
5. Now select the same first node again
6. Click its **bottom edge** (↓)
7. Select a node below
8. Click its **top edge** (↑)
9. Multiple arrows now branch from the same node

## Managing Connections

### Viewing Connections
- Arrows are shown as solid blue curved lines
- Arrow heads point to the destination node
- Hover over arrows to see which nodes they connect

### Deleting Connections
1. Select the source node (where the arrow starts)
2. Click the delete icon (trash) on the node
3. All connections from that node are deleted

Alternatively:
1. Delete the entire node by clicking its delete icon
2. All connections to/from that node are automatically removed

### Editing Connection Endpoints
Currently, connections cannot be edited after creation. To change a connection:
1. Delete the node or connection
2. Create a new connection with the desired endpoints

## Tips & Best Practices

### Organizing Your Flow
- Use **bottom → top** connections for vertical flows (most common)
- Use **right → left** connections for horizontal branches
- Use **left → right** for feedback loops
- Use **top → bottom** for reverse flows

### Avoiding Overlapping Arrows
- Plan your node layout before creating connections
- Use different edges to route arrows around obstacles
- For example, if nodes are side-by-side, use left/right edges instead of top/bottom

### Creating Complex Flows
- Start with a Start node at the top
- Use bottom edges to connect downward
- Branch using right/left edges
- End with a Stop node at the bottom

### Visual Clarity
- Keep related nodes close together
- Use consistent edge directions (e.g., always use bottom→top for main flow)
- Leave space between nodes for arrow routing
- Use the zoom controls to see the full flow

## Connection Workflow Summary

```
1. Click node → Shows 4 edge points
2. Click edge point → Dashed line appears (connection starting)
3. Click target node → Shows 4 edge points
4. Click target edge → Solid arrow created (connection complete)
```

## Keyboard Shortcuts
- Coming soon!

## Troubleshooting

### Arrow Not Appearing
- Make sure you clicked on an edge point (the colored circles)
- Verify the target node is different from the source node
- Check that both nodes are visible on the canvas

### Can't Select Edge Points
- First click the node to select it
- Edge points only appear when a node is selected
- Edge points are the colored circles on the node's edges

### Arrow Disappeared
- Arrows are permanent until you delete the node
- If a node is deleted, all its connections are removed
- Try zooming out to see if the arrow is off-screen

### Multiple Arrows from Same Node
- This is normal and expected
- You can connect one node to multiple other nodes
- Each connection uses a different edge point

## Advanced Features (Coming Soon)
- Connection labels
- Conditional branching
- Loop detection
- Flow validation
- Connection editing
