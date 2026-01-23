# Flow Builder User Guide

## Getting Started

### Option 1: Use a Template
1. Click on one of the template buttons:
   - **Restaurant Template** - Pre-built restaurant booking flow
   - **Webshop Template** - Pre-built e-commerce flow
   - **Healthcare Template** - Pre-built healthcare appointment flow
2. The canvas will load with pre-configured nodes and connections

### Option 2: Start from Scratch
1. Click **"Start from Scratch"** button
2. A canvas will open with a single "Start" node
3. Begin adding nodes by dragging from the sidebar

## Building Your Flow

### Adding Nodes
1. **Locate** the component in the left sidebar
2. **Drag** the component onto the canvas
3. The node will appear at the drop location
4. Repeat for all nodes needed

### Available Node Types
- **Start** - Entry point (green)
- **Stop** - Exit point (red)
- **Question** - Ask user a question (red)
- **Text Message** - Send a message (gray)
- **AI Node** - Process with AI (yellow)
- **API Call** - Call external API (black)
- **Logic Switch** - Conditional branching (blue)
- **Handover** - Transfer to human agent (red)
- **Booking Mode** - Booking interface (gray)
- **Lead Capture** - Capture user information (gray)

### Connecting Nodes (Creating Arrows)

**How to Create Connections:**
1. Click the **"Connect"** button in the sidebar (arrow icon)
2. The button will highlight in blue and show "Connection Mode - Click two nodes to connect"
3. **Click the connection point** (large circle at the bottom of the first node)
   - The node will stay selected (blue border)
   - A blue dashed line will appear from the first node following your mouse
4. **Move your mouse** to the second node - you'll see the arrow preview in real-time
5. **Click the connection point** (large circle at the bottom of the second node)
   - The connection is created with a solid blue arrow
   - Connection mode automatically turns off
   - Both nodes remain selected

**Visual Feedback:**
- **Blue dashed line**: Shows where the connection will go (while connecting)
- **Blue solid arrow**: Final connection between nodes
- **Blue border on nodes**: Indicates selected nodes

### Moving Nodes
1. **Long-press** on a node
2. **Drag** to the new position
3. **Release** to place the node
4. All connections will update automatically

### Editing Nodes
1. **Hover** over a node to reveal action buttons
2. **Click** the edit button (pencil icon)
3. **Modify** the label and add notes
4. **Click** "Save" to apply changes

### Deleting Nodes
1. **Hover** over a node to reveal action buttons
2. **Click** the delete button (trash icon)
3. The node and all its connections will be removed

## Canvas Navigation

### Zooming
- **Zoom In**: Click the zoom in button (magnifying glass +)
- **Zoom Out**: Click the zoom out button (magnifying glass -)
- **Fit to Screen**: Click the fit button to reset zoom and pan
- Current zoom level is displayed in the toolbar

### Panning
1. **Click and drag** on the canvas background
2. The view will move in the direction you drag
3. Works at any zoom level

### Selecting Nodes
- **Click** on a node to select it (blue highlight)
- **Click** on another node to add it to selection (both stay selected)
- **Click** on empty canvas to deselect all nodes
- Selected nodes can be edited or deleted together

### Fullscreen Mode
- **Click** the fullscreen button (top-right corner) to expand the canvas
- In fullscreen mode, the sidebar remains visible on the left
- **Click** the exit fullscreen button to return to normal view
- All functionality works the same in fullscreen mode

## Tips & Tricks

### Best Practices
- Always start with a "Start" node
- Always end with a "Stop" node
- Use "Question" nodes for user decisions
- Use "Logic Switch" for complex branching
- Add notes to nodes for clarity

### Keyboard Shortcuts
- Delete selected node: Click delete button (hover to reveal)
- Edit selected node: Click edit button (hover to reveal)

### Large Flows
- Use zoom out to see the entire flow
- Use pan to navigate to specific areas
- Use fit to screen to reset view

## Troubleshooting

### Can't drag nodes?
- Make sure you're using long-press (not just click)
- Try dragging from the center of the node

### Connection not appearing?
- Make sure you're in Connection Mode (click "Connect" button first)
- Or use the quick connection method by clicking connection points
- Try clicking the connection points more precisely

### Can't drag nodes after dropping?
- Make sure you're using **long-press** (hold for a moment, don't just click)
- Click and hold on the node, then drag while holding
- Release to drop the node in the new position

### Node disappeared?
- Use zoom out to see if it's off-screen
- Use fit to screen to reset the view

### Want to start over?
- Click "Start from Scratch" again to create a new flow
- Or select a template to load a fresh flow

## Saving Your Flow
Your flow is automatically saved as you make changes. All nodes and connections are preserved in the application state.
