VERSION 5.00
Begin VB.Form frmMap 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Form1"
   ClientHeight    =   11670
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   14925
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   Picture         =   "frmMap.frx":0000
   ScaleHeight     =   11670
   ScaleWidth      =   14925
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmdSearch 
      Caption         =   "Search"
      Height          =   495
      Left            =   11400
      TabIndex        =   0
      Top             =   10920
      Width           =   1575
   End
   Begin VB.Shape shpDestination 
      BorderColor     =   &H0080FF80&
      BorderWidth     =   4
      Height          =   375
      Left            =   1320
      Top             =   4200
      Width           =   375
   End
   Begin VB.Shape shpSource 
      BorderColor     =   &H000000FF&
      BorderWidth     =   4
      Height          =   375
      Left            =   1440
      Top             =   3360
      Width           =   375
   End
End
Attribute VB_Name = "frmMap"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Type NodePoint
    X As Long
    Y As Long
End Type

Private Type TreeNode
    CurrNode As Long
    NextNode(0 To 3) As Long
    Dist(0 To 3) As Double
    VisitNumber As Long
    Distance As Double
    TmpVar As Double
End Type


Private Const nNodes As Long = 17
Dim NodeList(0 To nNodes - 1) As NodePoint
Dim TreeNodeList(0 To nNodes - 1) As TreeNode

Dim nPathList As Long
Dim PATHLIST() As Long
Dim CurrDestinationNode As Long
Dim CurrSourceNode As Long





Private Sub cmdSearch_Click()
frmMap.Cls
Call Form_Paint
If DijkstraPathFinding(CurrSourceNode, CurrDestinationNode) = True Then
    DrawShortestPath
Else
    MsgBox "Path Not Found", vbOKOnly, "PathFinding"
End If

End Sub

Private Sub Form_Load()
NodeList(0).X = 5565
NodeList(0).Y = 11430
NodeList(1).X = 2565
NodeList(1).Y = 10965
NodeList(2).X = 4200
NodeList(2).Y = 10245
NodeList(3).X = 3660
NodeList(3).Y = 9150
NodeList(4).X = 5415
NodeList(4).Y = 8415
NodeList(5).X = 2955
NodeList(5).Y = 8265
NodeList(6).X = 1545
NodeList(6).Y = 8430
NodeList(7).X = 1020
NodeList(7).Y = 6645
NodeList(8).X = 2820
NodeList(8).Y = 6360
NodeList(9).X = 5760
NodeList(9).Y = 6225
NodeList(10).X = 8655
NodeList(10).Y = 6360
NodeList(11).X = 5505
NodeList(11).Y = 5415
NodeList(12).X = 615
NodeList(12).Y = 3750
NodeList(13).X = 2505
NodeList(13).Y = 3465
NodeList(14).X = 6120
NodeList(14).Y = 4245
NodeList(15).X = 1365
NodeList(15).Y = 2820
NodeList(16).X = 2790
NodeList(16).Y = 570

TreeNodeList(0).CurrNode = 0
    TreeNodeList(0).NextNode(0) = 1
    TreeNodeList(0).NextNode(1) = 2
    TreeNodeList(0).NextNode(2) = 4
    TreeNodeList(0).NextNode(3) = 10
TreeNodeList(1).CurrNode = 1
    TreeNodeList(1).NextNode(0) = 0
    TreeNodeList(1).NextNode(1) = 2
    TreeNodeList(1).NextNode(2) = 6
    TreeNodeList(1).NextNode(3) = -1
TreeNodeList(2).CurrNode = 2
    TreeNodeList(2).NextNode(0) = 0
    TreeNodeList(2).NextNode(1) = 1
    TreeNodeList(2).NextNode(2) = 3
    TreeNodeList(2).NextNode(3) = -1
TreeNodeList(3).CurrNode = 3
    TreeNodeList(3).NextNode(0) = 2
    TreeNodeList(3).NextNode(1) = 4
    TreeNodeList(3).NextNode(2) = 5
    TreeNodeList(3).NextNode(3) = -1
TreeNodeList(4).CurrNode = 4
    TreeNodeList(4).NextNode(0) = 0
    TreeNodeList(4).NextNode(1) = 3
    TreeNodeList(4).NextNode(2) = 9
    TreeNodeList(4).NextNode(3) = -1
TreeNodeList(5).CurrNode = 5
    TreeNodeList(5).NextNode(0) = 3
    TreeNodeList(5).NextNode(1) = 6
    TreeNodeList(5).NextNode(2) = 8
    TreeNodeList(5).NextNode(3) = -1
TreeNodeList(6).CurrNode = 6
    TreeNodeList(6).NextNode(0) = 1
    TreeNodeList(6).NextNode(1) = 5
    TreeNodeList(6).NextNode(2) = 7
    TreeNodeList(6).NextNode(3) = -1
TreeNodeList(7).CurrNode = 7
    TreeNodeList(7).NextNode(0) = 6
    TreeNodeList(7).NextNode(1) = 8
    TreeNodeList(7).NextNode(2) = 12
    TreeNodeList(7).NextNode(3) = -1
TreeNodeList(8).CurrNode = 8
    TreeNodeList(8).NextNode(0) = 5
    TreeNodeList(8).NextNode(1) = 7
    TreeNodeList(8).NextNode(2) = 9
    TreeNodeList(8).NextNode(3) = 13
TreeNodeList(9).CurrNode = 9
    TreeNodeList(9).NextNode(0) = 4
    TreeNodeList(9).NextNode(1) = 8
    TreeNodeList(9).NextNode(2) = 11
    TreeNodeList(9).NextNode(3) = -1
TreeNodeList(10).CurrNode = 10
    TreeNodeList(10).NextNode(0) = 0
    TreeNodeList(10).NextNode(1) = 11
    TreeNodeList(10).NextNode(2) = 14
    TreeNodeList(10).NextNode(3) = -1
TreeNodeList(11).CurrNode = 11
    TreeNodeList(11).NextNode(0) = 9
    TreeNodeList(11).NextNode(1) = 10
    TreeNodeList(11).NextNode(2) = 14
    TreeNodeList(11).NextNode(3) = -1
TreeNodeList(12).CurrNode = 12
    TreeNodeList(12).NextNode(0) = 7
    TreeNodeList(12).NextNode(1) = 13
    TreeNodeList(12).NextNode(2) = 15
    TreeNodeList(12).NextNode(3) = -1
TreeNodeList(13).CurrNode = 13
    TreeNodeList(13).NextNode(0) = 8
    TreeNodeList(13).NextNode(1) = 12
    TreeNodeList(13).NextNode(2) = 14
    TreeNodeList(13).NextNode(3) = 15
TreeNodeList(14).CurrNode = 14
    TreeNodeList(14).NextNode(0) = 10
    TreeNodeList(14).NextNode(1) = 11
    TreeNodeList(14).NextNode(2) = 13
    TreeNodeList(14).NextNode(3) = 16
TreeNodeList(15).CurrNode = 15
    TreeNodeList(15).NextNode(0) = 12
    TreeNodeList(15).NextNode(1) = 13
    TreeNodeList(15).NextNode(2) = 16
    TreeNodeList(15).NextNode(3) = -1
TreeNodeList(16).CurrNode = 16
    TreeNodeList(16).NextNode(0) = 14
    TreeNodeList(16).NextNode(1) = 15
    TreeNodeList(16).NextNode(2) = -1
    TreeNodeList(16).NextNode(3) = -1
        
            
        
    
        
    
Dim i As Long
For i = 0 To nNodes - 1
        If Not (TreeNodeList(i).NextNode(0) = -1) Then
            TreeNodeList(i).Dist(0) = GetDist2D(NodeList(TreeNodeList(i).CurrNode).X, NodeList(TreeNodeList(i).CurrNode).Y, NodeList(TreeNodeList(i).NextNode(0)).X, NodeList(TreeNodeList(i).NextNode(0)).Y)
        End If
        If Not (TreeNodeList(i).NextNode(1) = -1) Then
            TreeNodeList(i).Dist(1) = GetDist2D(NodeList(TreeNodeList(i).CurrNode).X, NodeList(TreeNodeList(i).CurrNode).Y, NodeList(TreeNodeList(i).NextNode(1)).X, NodeList(TreeNodeList(i).NextNode(1)).Y)
        End If
        If Not (TreeNodeList(i).NextNode(2) = -1) Then
            TreeNodeList(i).Dist(2) = GetDist2D(NodeList(TreeNodeList(i).CurrNode).X, NodeList(TreeNodeList(i).CurrNode).Y, NodeList(TreeNodeList(i).NextNode(2)).X, NodeList(TreeNodeList(i).NextNode(2)).Y)
        End If
        If Not (TreeNodeList(i).NextNode(3) = -1) Then
            TreeNodeList(i).Dist(3) = GetDist2D(NodeList(TreeNodeList(i).CurrNode).X, NodeList(TreeNodeList(i).CurrNode).Y, NodeList(TreeNodeList(i).NextNode(3)).X, NodeList(TreeNodeList(i).NextNode(3)).Y)
        End If
Next i

                  
frmMap.Cls
Call Form_Paint
        
End Sub

Private Sub Form_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
'MsgBox X & "," & Y
Dim ClosestNode As Long
ClosestNode = SearchNearestNode(CLng(X), CLng(Y))

If Button = 1 Then
    
    CurrSourceNode = ClosestNode
    shpSource.Left = NodeList(ClosestNode).X - 160
    shpSource.Top = NodeList(ClosestNode).Y - 160
ElseIf Button = 2 Then
    CurrDestinationNode = ClosestNode
    shpDestination.Left = NodeList(ClosestNode).X - 160
    shpDestination.Top = NodeList(ClosestNode).Y - 160
End If
End Sub

Private Sub Form_Paint()
Call DrawNode
Call DrawLineBetweenNodes
End Sub


Public Sub DrawNode()
Dim i As Long

frmMap.DrawWidth = 14

For i = 0 To nNodes - 1
    frmMap.PSet (NodeList(i).X, NodeList(i).Y), RGB(0, 0, 0)
Next i
End Sub

Public Sub DrawLineBetweenNodes()


Dim i As Long

frmMap.DrawWidth = 1

For i = 0 To nNodes - 1
    If Not (TreeNodeList(i).NextNode(0) = -1) Then
        frmMap.Line (NodeList(TreeNodeList(i).CurrNode).X, NodeList(TreeNodeList(i).CurrNode).Y)-(NodeList(TreeNodeList(i).NextNode(0)).X, NodeList(TreeNodeList(i).NextNode(0)).Y), RGB(0, 0, 255)
    End If
    
    If Not (TreeNodeList(i).NextNode(1) = -1) Then
        frmMap.Line (NodeList(TreeNodeList(i).CurrNode).X, NodeList(TreeNodeList(i).CurrNode).Y)-(NodeList(TreeNodeList(i).NextNode(1)).X, NodeList(TreeNodeList(i).NextNode(1)).Y), RGB(0, 0, 255)
    End If
    
    If Not (TreeNodeList(i).NextNode(2) = -1) Then
        frmMap.Line (NodeList(TreeNodeList(i).CurrNode).X, NodeList(TreeNodeList(i).CurrNode).Y)-(NodeList(TreeNodeList(i).NextNode(2)).X, NodeList(TreeNodeList(i).NextNode(2)).Y), RGB(0, 0, 255)
    End If
    If Not (TreeNodeList(i).NextNode(3) = -1) Then
        frmMap.Line (NodeList(TreeNodeList(i).CurrNode).X, NodeList(TreeNodeList(i).CurrNode).Y)-(NodeList(TreeNodeList(i).NextNode(3)).X, NodeList(TreeNodeList(i).NextNode(3)).Y), RGB(0, 0, 255)
    End If
Next i

End Sub

Private Function SearchNearestNode(X As Long, Y As Long) As Long
    Dim i As Long
    Dim CurrClosestIndex As Long '//Which node is currently closest
    Dim CurrClosestDist As Long '//How far away the current closest is...
    CurrClosestDist = 99999 '//Give it a number it'll beat...
    
For i = 0 To nNodes - 1
    If GetDist2D(NodeList(i).X, NodeList(i).Y, X, Y) < CurrClosestDist Then
        CurrClosestDist = GetDist2D(NodeList(i).X, NodeList(i).Y, X, Y)
        CurrClosestIndex = i
    End If
Next i

SearchNearestNode = CurrClosestIndex
End Function

Private Function GetDist2D(X As Long, Y As Long, X1 As Long, Y1 As Long) As Long
    GetDist2D = Sqr(((X - X1) ^ 2) + ((Y - Y1) ^ 2))
End Function



Private Sub DrawShortestPath()
    '//This function draws a big red line for our path...
    Dim i As Long
    frmMap.DrawWidth = 4
    
    For i = 1 To (nPathList - 1) '//Cycle through each one...
        frmMap.Line (NodeList(TreeNodeList(PATHLIST(i)).CurrNode).X, NodeList(TreeNodeList(PATHLIST(i)).CurrNode).Y)-(NodeList(TreeNodeList(PATHLIST(i + 1)).CurrNode).X, NodeList(TreeNodeList(PATHLIST(i + 1)).CurrNode).Y), RGB(255, 0, 0)
    Next i
End Sub

Private Function DijkstraPathFinding(NodeSrc As Long, NodeDest As Long) As Boolean
'//0. Any variables required
    
    Dim i As Long
    Dim bRunning As Boolean
    Dim CurrentVisitNumber As Long '//Which visit the current node will be
    Dim CurrNode As Long '//Which node we are scanning...
    Dim LowestNodeFound As Long '//For when we are searching for the lowest temporary value
    Dim LowestValFound As Double '//For above variable
    
    If NodeSrc = NodeDest Then
        'we're already there...
        nPathList = 2
        ReDim PATHLIST(2) As Long
        PATHLIST(1) = NodeSrc
        PATHLIST(2) = NodeDest
        DijkstraPathFinding = True
        Exit Function
    End If

'//1. Setup all the data we need
    For i = 0 To nNodes - 1
        TreeNodeList(i).VisitNumber = -1 '//-1 indicates not visited
        TreeNodeList(i).Distance = -1 '//Unknown distance
        TreeNodeList(i).TmpVar = 99999 '//A high number that can easily be beaten
    Next i
    
    '//Set the first variable
    TreeNodeList(NodeSrc).VisitNumber = 1
        CurrentVisitNumber = 1 '//Initialise
        CurrNode = NodeSrc
    TreeNodeList(NodeSrc).Distance = 0
    TreeNodeList(NodeSrc).TmpVar = 0

'//2. Start scanning
    'We're going to keep looping till we find the destination
    Do While bRunning = False
        '//2a. Go to each node that the current one touches
                'and make it's temporary variable = source distance + weight of the arc
                If Not (TreeNodeList(CurrNode).NextNode(0) = -1) Then TreeNodeList(TreeNodeList(CurrNode).NextNode(0)).TmpVar = MIN(TreeNodeList(CurrNode).Dist(0) + TreeNodeList(CurrNode).Distance, TreeNodeList(TreeNodeList(CurrNode).NextNode(0)).TmpVar)
                If Not (TreeNodeList(CurrNode).NextNode(1) = -1) Then TreeNodeList(TreeNodeList(CurrNode).NextNode(1)).TmpVar = MIN(TreeNodeList(CurrNode).Dist(1) + TreeNodeList(CurrNode).Distance, TreeNodeList(TreeNodeList(CurrNode).NextNode(1)).TmpVar)
                If Not (TreeNodeList(CurrNode).NextNode(2) = -1) Then TreeNodeList(TreeNodeList(CurrNode).NextNode(2)).TmpVar = MIN(TreeNodeList(CurrNode).Dist(2) + TreeNodeList(CurrNode).Distance, TreeNodeList(TreeNodeList(CurrNode).NextNode(2)).TmpVar)
                If Not (TreeNodeList(CurrNode).NextNode(3) = -1) Then TreeNodeList(TreeNodeList(CurrNode).NextNode(3)).TmpVar = MIN(TreeNodeList(CurrNode).Dist(3) + TreeNodeList(CurrNode).Distance, TreeNodeList(TreeNodeList(CurrNode).NextNode(3)).TmpVar)
                
        '//2b. Decide which node has the lowest temporary variable (Free choice if multiple)
                LowestValFound = 100999 'Hopefully the graph isn't this big :)
                For i = 0 To nNodes - 1 '//If we have more than 1000-2000 nodes this part will be horribly slow...
                    If (TreeNodeList(i).TmpVar <= LowestValFound) And (TreeNodeList(i).TmpVar >= 0) And (TreeNodeList(i).VisitNumber < 0) Then 'make sure we ignore the -1's and visited nodes
                        'We have a new lowest value
                        LowestValFound = TreeNodeList(i).TmpVar
                        LowestNodeFound = i
                    End If
                Next i
                '**NB: If there are multiple lowest values then this method will choose the last one found...
        
        '//2c. Mark this node with the next visit number and copy the tmpvar -> distance
                CurrentVisitNumber = CurrentVisitNumber + 1
                TreeNodeList(LowestNodeFound).VisitNumber = CurrentVisitNumber
                TreeNodeList(LowestNodeFound).Distance = TreeNodeList(LowestNodeFound).TmpVar
                CurrNode = LowestNodeFound '//Copy the variable for next time...
        
        '//2d. If this node IS NOT the destination then go onto the next iteration...
                If CurrNode = NodeDest Then
                    bRunning = True '//We've gotten to the destination
                Else
                    bRunning = False '//Still not there yet
                End If
    Loop
    
'//3. Work out the route that was taken...
    bRunning = False
    CurrNode = NodeDest '//Start at the end, and work backwards...
    
    nPathList = 1
    ReDim PATHLIST(nPathList) As Long
    PATHLIST(1) = NodeDest '//Put the first node in...
    
        Do While bRunning = False
            '//First we check that the current node isn't actually the start
                'because if it is then we've found the path already
                If CurrNode = NodeSrc Then
                    bRunning = True
                    GoTo SkipToEnd:
                    'Break out if we haven't found a solution in under 1 second
                    bRunning = True
                    DijkstraPathFinding = False
                    Exit Function
                    
                End If
        
            '//Scan through each node that we visited
            If (TreeNodeList(CurrNode).NextNode(0) >= 0) Then '//Only if there is a node in this direction
                If (TreeNodeList(TreeNodeList(CurrNode).NextNode(0)).VisitNumber >= 0) Then '//Only if we visited this node...
                    If TreeNodeList(CurrNode).Distance - TreeNodeList(TreeNodeList(CurrNode).NextNode(0)).Distance = TreeNodeList(CurrNode).Dist(0) Then
                        'NextNode(0) is part of the route home
                            nPathList = nPathList + 1
                            ReDim Preserve PATHLIST(nPathList) As Long
                            PATHLIST(nPathList) = TreeNodeList(CurrNode).NextNode(0)
                            CurrNode = TreeNodeList(CurrNode).NextNode(0)
                            GoTo SkipToEnd:
                    End If
                End If
            End If
            
            If (TreeNodeList(CurrNode).NextNode(1) >= 0) Then  '//Only if there is a node in this direction
                If (TreeNodeList(TreeNodeList(CurrNode).NextNode(1)).VisitNumber >= 0) Then  '//Only if we visited this node...
                    If TreeNodeList(CurrNode).Distance - TreeNodeList(TreeNodeList(CurrNode).NextNode(1)).Distance = TreeNodeList(CurrNode).Dist(1) Then
                        'NextNode(1) is part of the route home
                            nPathList = nPathList + 1
                            ReDim Preserve PATHLIST(nPathList) As Long
                            PATHLIST(nPathList) = TreeNodeList(CurrNode).NextNode(1)
                            CurrNode = TreeNodeList(CurrNode).NextNode(1)
                            GoTo SkipToEnd:
                    End If
                End If
            End If
            
            If (TreeNodeList(CurrNode).NextNode(2) >= 0) Then  '//Only if there is a node in this direction
                If (TreeNodeList(TreeNodeList(CurrNode).NextNode(2)).VisitNumber >= 0) Then  '//Only if we visited this node...
                    If TreeNodeList(CurrNode).Distance - TreeNodeList(TreeNodeList(CurrNode).NextNode(2)).Distance = TreeNodeList(CurrNode).Dist(2) Then
                        'NextNode(2) is part of the route home
                            nPathList = nPathList + 1
                            ReDim Preserve PATHLIST(nPathList) As Long
                            PATHLIST(nPathList) = TreeNodeList(CurrNode).NextNode(2)
                            CurrNode = TreeNodeList(CurrNode).NextNode(2)
                            GoTo SkipToEnd:
                    End If
                End If
            End If
            
            If (TreeNodeList(CurrNode).NextNode(3) >= 0) Then  '//Only if there is a node in this direction
                If (TreeNodeList(TreeNodeList(CurrNode).NextNode(3)).VisitNumber >= 0) Then  '//Only if we visited this node...
                    If TreeNodeList(CurrNode).Distance - TreeNodeList(TreeNodeList(CurrNode).NextNode(3)).Distance = TreeNodeList(CurrNode).Dist(3) Then
                        'NextNode(3) is part of the route home
                            nPathList = nPathList + 1
                            ReDim Preserve PATHLIST(nPathList) As Long
                            PATHLIST(nPathList) = TreeNodeList(CurrNode).NextNode(3)
                            CurrNode = TreeNodeList(CurrNode).NextNode(3)
                            GoTo SkipToEnd:
                    End If
                End If
            End If
            
SkipToEnd:
            
        Loop
        
'//For ease of use we're going to invert the array.
    'currently we go Dest-Source, Source-Dest is more useful/easier
    Dim TmpArray() As Long
    ReDim TmpArray(nPathList) As Long
    For i = nPathList To 1 Step -1
        TmpArray(i) = PATHLIST(((nPathList - i) + 1))
    Next i
    For i = 1 To nPathList
        PATHLIST(i) = TmpArray(i)
    Next i
    
DijkstraPathFinding = True
End Function

Public Function MIN(A As Double, B As Double) As Double
    '//Return the minimum of the two...
    If A < B Then MIN = A
    If A > B Then MIN = B
    If A = B Then MIN = A
End Function

