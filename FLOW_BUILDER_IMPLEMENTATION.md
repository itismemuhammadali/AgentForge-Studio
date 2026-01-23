# Flow Builder Canvas Implementation

## Overview
A complete interactive flow builder canvas has been implemented with drag-and-drop nodes, connections, zoom/pan functionality, and template support.

## Files Created

### 1. `lib/models/flow_node_models.dart`
Defines the data models for the flow builder:
- **NodeType enum**: All node types (Start, Stop, Question, Text Message, AI Node, API Call, Logic Switch, Handover, Booking Mode, Lead Capture)
- **FlowNode class**: Represents a node on the canvas with:
  - Unique ID
  - Type and position
  - Label and optional notes
  - Output connections list
  - Helper methods for colors, icons, and labels
- **FlowConnection class**: Represents connections between nodes with optional labels

### 2. `lib/widgets/bot_builder/flow_canvas_painter.dart`
Custom painter for rendering the canvas:
- Grid background for visual reference
- Connection lines with curved bezier paths
- Arrow heads on connections
- Temporary connection preview while dragging
- Support for dark/light themes

### 3. `lib/widgets/bot_builder/flow_node_widget.dart`
Individual node widget with:
- Draggable nodes (long-press to drag)
- Selection highlighting
- Connection points (bottom of node)
- Hover-activated action buttons (Edit, Delete)
- Theme-aware styling
- Node type-specific colors and icons

### 4. `lib/widgets/bot_builder/flow_canvas_interactive.dart`
Main interactive canvas with:
- **Zoom controls**: Zoom in/out (0.5x to 3x), fit to screen
- **Pan functionality**: Click and drag to navigate (via InteractiveViewer)
- **Drag-and-drop**: Drop components from sidebar onto canvas
- **Node management**: Add, delete, update, edit nodes
- **Connection management**: Create connections by clicking connection points
- **Toolbar**: Shows node/connection count and zoom level
- **Edit dialog**: Allows editing node labels and notes

### 5. Updated `lib/widgets/bot_builder/tabs/flow_builder_tab.dart`
Enhanced with:
- **Component palette**: All 10 node types with drag-and-drop support
- **Template system**: 3 pre-built templates (Restaurant, Webshop, Healthcare)
- **Canvas toggle**: Switch between template view and canvas
- **Start from scratch**: Create empty canvas with Start node
- **State management**: Manages nodes and connections

## Features

### Drag-and-Drop
- Drag components from sidebar to canvas
- Drag nodes on canvas to reposition
- Visual feedback during dragging

### Node Management
- **Create**: Drag from sidebar or use templates
- **Edit**: Click edit button to modify label and notes
- **Delete**: Click delete button to remove node
- **Select**: Click to select, shows blue highlight

### Connections
- Click connection point (bottom circle) on first node
- Click connection point on second node to create connection
- Curved bezier paths with arrow heads
- Temporary preview while connecting

### Canvas Navigation
- **Zoom In/Out**: Buttons in toolbar
- **Fit to Screen**: Reset zoom and pan
- **Pan**: Click and drag on canvas background
- **Grid**: Visual reference grid

### Templates
- **Restaurant**: Greeting → Question → Booking → End
- **Webshop**: Product Inquiry → API Call → Lead Capture → End
- **Healthcare**: Symptom Check → AI Diagnosis → Booking → End

### Node Types
1. **Start** (Green) - Entry point
2. **Stop** (Red) - Exit point
3. **Question** (Red) - User question
4. **Text Message** (Gray) - Send message
5. **AI Node** (Yellow) - AI processing
6. **API Call** (Black) - External API
7. **Logic Switch** (Blue) - Conditional logic
8. **Handover** (Red) - Transfer to human
9. **Booking Mode** (Gray) - Booking interface
10. **Lead Capture** (Gray) - Capture user info

## User Workflow

1. **Start**: Click "Start from Scratch" or select a template
2. **Build**: Drag components from sidebar to canvas
3. **Connect**: Click connection points to create flow
4. **Edit**: Click edit button on nodes to add notes
5. **Navigate**: Use zoom/pan for large flows
6. **Save**: Changes are tracked in state

## Technical Details

### State Management
- Uses StatefulWidget with setState for updates
- Nodes and connections stored in lists
- Callbacks for add/update/delete operations

### Positioning
- Nodes use Offset for absolute positioning
- Canvas is 4000x4000 for "nearly infinite" size
- InteractiveViewer handles zoom/pan transformation

### Styling
- Theme-aware colors (dark/light mode)
- Component colors match node types
- Smooth transitions and hover effects

### Performance
- CustomPaint for efficient rendering
- Positioned widgets for node placement
- Lazy rendering of connections

## Future Enhancements
- Undo/Redo functionality
- Save/Load flows
- Export as JSON/image
- Validation (Start/Stop requirements)
- Multiple output connections per node
- Connection labels
- Node grouping/nesting
- Keyboard shortcuts
