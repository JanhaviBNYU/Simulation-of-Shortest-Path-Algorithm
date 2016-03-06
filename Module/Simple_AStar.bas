Attribute VB_Name = "Simple_AStar"
Option Explicit

'For Uni Directional
Global OpenNodeListUD(1 To 2100) As Node ' Main Open List
Global ClosedNodeListUD(1 To 2100) As Node 'Main Closed List
Public Temp_HoldCloseNodeDetailsUD As Node 'Temporary holds the details of the node that is going to be closed
Public OpenNodeList_IncreMentUD As Long 'Counter
Public ClosedNodeList_IncreMentUD As Long 'Counter
Public AlreadyInOpenListUD(1 To 8) As Long

Public StartPointUD As Long
Public DestinationPointUD As Long
Public CurrentParentUD As Long
Public NUD(1 To 8) As Long
Public PathFoundUD As Boolean

'For Bi Directional
Global OpenNodeListBD(1 To 2100) As Node
Global ClosedNodeListBD(1 To 2100) As Node
Public Temp_HoldCloseNodeDetailsBD As Node
Public OpenNodeList_IncreMentBD As Long
Public ClosedNodeList_IncrementBD As Long
Public AlreadyInOpenListBD(1 To 8) As Long

Public StartPointBD As Long
Public DestinationPointBD As Long
Public CurrentParentBD As Long
Public NBD(1 To 8) As Long
Public PathFoundBD As Boolean

Public bln_StartPointBlockedUD As Boolean
Public bln_StartPointBlockedBD As Boolean

Public bln_BreakIfNewG_LessthanPreG As Boolean
''Public check As Boolean
Public bln_arrayoutofbound As Boolean



Public Sub GetNeighboursUD(CurrentParentUD As Long)
    
If CurrentParentUD = 0 Then
    MsgBox "Path Not Reachable"
    bln_arrayoutofbound = True
    Exit Sub
End If
Dim SourcePoint_IndexUD As Long
Dim SourcePoint_RowUD As Long
Dim SourcePoint_ColUD As Long
Dim Immediate_UPUD As Long
Dim Immediate_DOWNUD As Long
Dim Immediate_RIGHTUD As Long
Dim Immediate_LEFTUD As Long
Dim Immediate_UP_LEFTUD As Long
Dim Immediate_UP_RIGHTUD As Long
Dim Immediate_DOWN_LEFTUD As Long
Dim Immediate_DOWN_RIGHTUD As Long

SourcePoint_IndexUD = CurrentParentUD
SourcePoint_RowUD = XYAllocation(CurrentParentUD).X
SourcePoint_ColUD = XYAllocation(CurrentParentUD).Y

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        Immediate_UPUD = GetIndexUD(SourcePoint_RowUD - 1, SourcePoint_ColUD)
            If frmMain.pic(Immediate_UPUD).BackColor = vbMagenta Or frmMain.pic(Immediate_UPUD).BackColor = vbRed Or frmMain.pic(Immediate_UPUD).BackColor = vbYellow Then
                NUD(1) = 0
                AlreadyInOpenListUD(1) = 0
                    
            Else
                If frmMain.pic(Immediate_UPUD).BackColor = vbBlue Then
                    AlreadyInOpenListUD(1) = Immediate_UPUD
                    NUD(1) = 0
                        
                Else
                    AlreadyInOpenListUD(1) = 0
                    
                    If frmMain.pic(Immediate_UPUD).BackColor = vbGreen Then
                        NUD(1) = Immediate_UPUD
                    Else
                        frmMain.pic(Immediate_UPUD).BackColor = vbBlue
                        NUD(1) = Immediate_UPUD
                    End If
                    
                End If
            End If
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        Immediate_DOWNUD = GetIndexUD(SourcePoint_RowUD + 1, SourcePoint_ColUD)
            If frmMain.pic(Immediate_DOWNUD).BackColor = vbMagenta Or frmMain.pic(Immediate_DOWNUD).BackColor = vbRed Or frmMain.pic(Immediate_DOWNUD).BackColor = vbYellow Then
                NUD(2) = 0
                AlreadyInOpenListUD(2) = 0
            Else
                If frmMain.pic(Immediate_DOWNUD).BackColor = vbBlue Then
                    AlreadyInOpenListUD(2) = Immediate_DOWNUD
                    NUD(2) = 0
                Else
                    AlreadyInOpenListUD(2) = 0
                    
                    If frmMain.pic(Immediate_DOWNUD).BackColor = vbGreen Then
                        NUD(2) = Immediate_DOWNUD
                    Else
                        frmMain.pic(Immediate_DOWNUD).BackColor = vbBlue
                        NUD(2) = Immediate_DOWNUD
                    End If
                End If
            End If
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        Immediate_RIGHTUD = GetIndexUD(SourcePoint_RowUD, SourcePoint_ColUD + 1)
            If frmMain.pic(Immediate_RIGHTUD).BackColor = vbMagenta Or frmMain.pic(Immediate_RIGHTUD).BackColor = vbRed Or frmMain.pic(Immediate_RIGHTUD).BackColor = vbYellow Then
                NUD(3) = 0
                AlreadyInOpenListUD(3) = 0
            Else
                If frmMain.pic(Immediate_RIGHTUD).BackColor = vbBlue Then
                   AlreadyInOpenListUD(3) = Immediate_RIGHTUD
                   NUD(3) = 0
                Else
                    AlreadyInOpenListUD(3) = 0
                    If frmMain.pic(Immediate_RIGHTUD).BackColor = vbGreen Then
                        NUD(3) = Immediate_RIGHTUD
                    Else
                        frmMain.pic(Immediate_RIGHTUD).BackColor = vbBlue
                        NUD(3) = Immediate_RIGHTUD
                    End If
                End If
            End If
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        Immediate_LEFTUD = GetIndexUD(SourcePoint_RowUD, SourcePoint_ColUD - 1)
            If frmMain.pic(Immediate_LEFTUD).BackColor = vbMagenta Or frmMain.pic(Immediate_LEFTUD).BackColor = vbRed Or frmMain.pic(Immediate_LEFTUD).BackColor = vbYellow Then
                NUD(4) = 0
                AlreadyInOpenListUD(4) = 0
            Else
                If frmMain.pic(Immediate_LEFTUD).BackColor = vbBlue Then
                     AlreadyInOpenListUD(4) = Immediate_LEFTUD
                     NUD(4) = 0
                Else
                    AlreadyInOpenListUD(4) = 0
                    If frmMain.pic(Immediate_LEFTUD).BackColor = vbGreen Then
                        
                        NUD(4) = Immediate_LEFTUD
                    Else
                        frmMain.pic(Immediate_LEFTUD).BackColor = vbBlue
                        NUD(4) = Immediate_LEFTUD
                    End If
                End If
            End If
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        Immediate_UP_LEFTUD = GetIndexUD(SourcePoint_RowUD - 1, SourcePoint_ColUD - 1)
            If frmMain.pic(Immediate_UP_LEFTUD).BackColor = vbMagenta Or frmMain.pic(Immediate_UP_LEFTUD).BackColor = vbRed Or frmMain.pic(Immediate_UP_LEFTUD).BackColor = vbYellow Then
                NUD(5) = 0
                 AlreadyInOpenListUD(5) = 0
            Else
                If frmMain.pic(Immediate_UP_LEFTUD).BackColor = vbBlue Then
                     AlreadyInOpenListUD(5) = Immediate_UP_LEFTUD
                     NUD(5) = 0
                Else
                    AlreadyInOpenListUD(5) = 0
                    
                    If frmMain.pic(Immediate_UP_LEFTUD).BackColor = vbGreen Then
                        NUD(5) = Immediate_UP_LEFTUD
                    Else
                        frmMain.pic(Immediate_UP_LEFTUD).BackColor = vbBlue
                        NUD(5) = Immediate_UP_LEFTUD
                    End If
                End If
             End If
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        Immediate_UP_RIGHTUD = GetIndexUD(SourcePoint_RowUD - 1, SourcePoint_ColUD + 1)
            If frmMain.pic(Immediate_UP_RIGHTUD).BackColor = vbMagenta Or frmMain.pic(Immediate_UP_RIGHTUD).BackColor = vbRed Or frmMain.pic(Immediate_UP_RIGHTUD).BackColor = vbYellow Then
                NUD(6) = 0
                AlreadyInOpenListUD(6) = 0
            Else
                If frmMain.pic(Immediate_UP_RIGHTUD).BackColor = vbBlue Then
                    AlreadyInOpenListUD(6) = Immediate_UP_RIGHTUD
                    NUD(6) = 0
                Else
                    AlreadyInOpenListUD(6) = 0
                    
                    If frmMain.pic(Immediate_UP_RIGHTUD).BackColor = vbGreen Then
                        
                        NUD(6) = Immediate_UP_RIGHTUD
                    Else
                        frmMain.pic(Immediate_UP_RIGHTUD).BackColor = vbBlue
                        NUD(6) = Immediate_UP_RIGHTUD
                    End If
                End If
            End If
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        Immediate_DOWN_LEFTUD = GetIndexUD(SourcePoint_RowUD + 1, SourcePoint_ColUD - 1)
            If frmMain.pic(Immediate_DOWN_LEFTUD).BackColor = vbMagenta Or frmMain.pic(Immediate_DOWN_LEFTUD).BackColor = vbRed Or frmMain.pic(Immediate_DOWN_LEFTUD).BackColor = vbYellow Then
                NUD(7) = 0
                AlreadyInOpenListUD(7) = 0
            Else
                If frmMain.pic(Immediate_DOWN_LEFTUD).BackColor = vbBlue Then
                    AlreadyInOpenListUD(7) = Immediate_DOWN_LEFTUD
                    NUD(7) = 0
                Else
                    AlreadyInOpenListUD(7) = 0
                    If frmMain.pic(Immediate_DOWN_LEFTUD).BackColor = vbGreen Then
                        
                        NUD(7) = Immediate_DOWN_LEFTUD
                    Else
                        frmMain.pic(Immediate_DOWN_LEFTUD).BackColor = vbBlue
                        NUD(7) = Immediate_DOWN_LEFTUD
                    End If
                End If
            End If
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        Immediate_DOWN_RIGHTUD = GetIndexUD(SourcePoint_RowUD + 1, SourcePoint_ColUD + 1)
            If frmMain.pic(Immediate_DOWN_RIGHTUD).BackColor = vbMagenta Or frmMain.pic(Immediate_DOWN_RIGHTUD).BackColor = vbRed Or frmMain.pic(Immediate_DOWN_RIGHTUD).BackColor = vbYellow Then
                NUD(8) = 0
                AlreadyInOpenListUD(8) = 0
            Else
                If frmMain.pic(Immediate_DOWN_RIGHTUD).BackColor = vbBlue Then
                    AlreadyInOpenListUD(8) = Immediate_DOWN_RIGHTUD
                    NUD(8) = 0
                Else
                    AlreadyInOpenListUD(8) = 0
                    
                    If frmMain.pic(Immediate_DOWN_RIGHTUD).BackColor = vbGreen Then
                        NUD(8) = Immediate_DOWN_RIGHTUD
                    Else
                        frmMain.pic(Immediate_DOWN_RIGHTUD).BackColor = vbBlue
                        NUD(8) = Immediate_DOWN_RIGHTUD
                    End If
                End If
            End If
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
End Sub


Public Function GetIndexUD(ByVal X As Long, ByVal Y As Long) As Long

Dim i As Long
    For i = 1 To 2100
            If X = XYAllocation(i).X And Y = XYAllocation(i).Y Then
                GetIndexUD = i
                Exit Function
            End If
  Next i
End Function

Public Function GetIndexBD(ByVal X As Long, ByVal Y As Long) As Long

Dim i As Long
    For i = 1 To 2100
            If X = XYAllocation(i).X And Y = XYAllocation(i).Y Then
                GetIndexBD = i
                Exit Function
            End If
  Next i
End Function

Public Function AddToOpenListUD(ByVal Parent As Long, ByVal PX As Long, ByVal PY As Long, ByVal Child As Long, ByVal CX As Long, ByVal CY As Long, ByVal G As Double, ByVal H As Double, ByVal F As Double, ByVal bln_Check As Boolean)
    
    OpenNodeList_IncreMentUD = OpenNodeList_IncreMentUD + 1
    If OpenNodeList_IncreMentUD > 2100 Then
        MsgBox "Array is going Out of Bound" & vbCrLf & "Reset the application", vbOKOnly, "Pathfingind"
        bln_arrayoutofbound = True
        Exit Function
    End If
    OpenNodeListUD(OpenNodeList_IncreMentUD).Parent = Parent
    OpenNodeListUD(OpenNodeList_IncreMentUD).PX = PX
    OpenNodeListUD(OpenNodeList_IncreMentUD).PY = PY
    OpenNodeListUD(OpenNodeList_IncreMentUD).Child = Child
    OpenNodeListUD(OpenNodeList_IncreMentUD).CX = CX
    OpenNodeListUD(OpenNodeList_IncreMentUD).CY = CY
    OpenNodeListUD(OpenNodeList_IncreMentUD).G = G
    OpenNodeListUD(OpenNodeList_IncreMentUD).H = H
    OpenNodeListUD(OpenNodeList_IncreMentUD).F = F
    OpenNodeListUD(OpenNodeList_IncreMentUD).itsUsed = bln_Check
End Function



Public Function AddToOpenListBD(ByVal Parent As Long, ByVal PX As Long, ByVal PY As Long, ByVal Child As Long, ByVal CX As Long, ByVal CY As Long, ByVal G As Double, ByVal H As Double, ByVal F As Double, ByVal bln_Check As Boolean)
    OpenNodeList_IncreMentBD = OpenNodeList_IncreMentBD + 1
    OpenNodeListBD(OpenNodeList_IncreMentBD).Parent = Parent
    OpenNodeListBD(OpenNodeList_IncreMentBD).PX = PX
    OpenNodeListBD(OpenNodeList_IncreMentBD).PY = PY
    OpenNodeListBD(OpenNodeList_IncreMentBD).Child = Child
    OpenNodeListBD(OpenNodeList_IncreMentBD).CX = CX
    OpenNodeListBD(OpenNodeList_IncreMentBD).CY = CY
    OpenNodeListBD(OpenNodeList_IncreMentBD).G = G
    OpenNodeListBD(OpenNodeList_IncreMentBD).H = H
    OpenNodeListBD(OpenNodeList_IncreMentBD).F = F
    OpenNodeListBD(OpenNodeList_IncreMentBD).itsUsed = bln_Check
End Function


Public Function AddToClosedListUD(CloseNode As Node)
    
    ClosedNodeList_IncreMentUD = ClosedNodeList_IncreMentUD + 1
    If ClosedNodeList_IncreMentUD > 2100 Then
        bln_arrayoutofbound = True
        Exit Function
    End If
    ClosedNodeListUD(ClosedNodeList_IncreMentUD).Parent = CloseNode.Parent
    ClosedNodeListUD(ClosedNodeList_IncreMentUD).PX = CloseNode.PX
    ClosedNodeListUD(ClosedNodeList_IncreMentUD).PY = CloseNode.PY
    
    ClosedNodeListUD(ClosedNodeList_IncreMentUD).Child = CloseNode.Child
    ClosedNodeListUD(ClosedNodeList_IncreMentUD).CX = CloseNode.CX
    ClosedNodeListUD(ClosedNodeList_IncreMentUD).CY = CloseNode.CY
    ClosedNodeListUD(ClosedNodeList_IncreMentUD).F = CloseNode.F
    ClosedNodeListUD(ClosedNodeList_IncreMentUD).G = CloseNode.G
    ClosedNodeListUD(ClosedNodeList_IncreMentUD).H = CloseNode.H
    ClosedNodeListUD(ClosedNodeList_IncreMentUD).itsUsed = True
    
    Dim i As Long

    For i = 1 To 2100
        If OpenNodeListUD(i).Parent = CloseNode.Parent And OpenNodeListUD(i).Child = CloseNode.Child And OpenNodeListUD(i).CX = CloseNode.CX And OpenNodeListUD(i).CY = CloseNode.CY Then
            OpenNodeListUD(i).itsUsed = True
            Exit Function
        End If
    Next i
End Function


Public Function AddToClosedListBD(CloseNode As Node)
    ClosedNodeList_IncrementBD = ClosedNodeList_IncrementBD + 1
    ClosedNodeListBD(ClosedNodeList_IncrementBD).Parent = CloseNode.Parent
    ClosedNodeListBD(ClosedNodeList_IncrementBD).PX = CloseNode.PX
    ClosedNodeListBD(ClosedNodeList_IncrementBD).PY = CloseNode.PY
    
    ClosedNodeListBD(ClosedNodeList_IncrementBD).Child = CloseNode.Child
    ClosedNodeListBD(ClosedNodeList_IncrementBD).CX = CloseNode.CX
    ClosedNodeListBD(ClosedNodeList_IncrementBD).CY = CloseNode.CY
    ClosedNodeListBD(ClosedNodeList_IncrementBD).F = CloseNode.F
    ClosedNodeListBD(ClosedNodeList_IncrementBD).G = CloseNode.G
    ClosedNodeListBD(ClosedNodeList_IncrementBD).H = CloseNode.H
    ClosedNodeListBD(ClosedNodeList_IncrementBD).itsUsed = True
    
    Dim i As Long

    For i = 1 To 2100
        If OpenNodeListBD(i).CX = CloseNode.CX And OpenNodeListBD(i).CY = CloseNode.CY Then
            OpenNodeListBD(i).itsUsed = True
            Exit Function
        End If
    Next i
End Function


Public Sub AddToCloseUD(CurrentParent As Long)
If CurrentParent = 0 Then
    MsgBox "Path Not Reachable"
    Exit Sub
End If

    Dim i As Long
    Dim temp As Long
    For i = 1 To OpenNodeList_IncreMentUD
        If OpenNodeListUD(i).Child = CurrentParent And OpenNodeListUD(i).CX = XYAllocation(CurrentParent).X And OpenNodeListUD(i).CY = XYAllocation(CurrentParent).Y Then
            temp = i
            Exit For
        End If
    Next i
    If temp = 0 Then
        MsgBox "Reset the Application"
        bln_arrayoutofbound = True
        Exit Sub
    End If
    Temp_HoldCloseNodeDetailsUD.Parent = OpenNodeListUD(temp).Parent
    Temp_HoldCloseNodeDetailsUD.PX = OpenNodeListUD(temp).PX
    Temp_HoldCloseNodeDetailsUD.PY = OpenNodeListUD(temp).PY
    Temp_HoldCloseNodeDetailsUD.Child = OpenNodeListUD(temp).Child
    Temp_HoldCloseNodeDetailsUD.CX = OpenNodeListUD(temp).CX
    Temp_HoldCloseNodeDetailsUD.CY = OpenNodeListUD(temp).CY
    Temp_HoldCloseNodeDetailsUD.F = OpenNodeListUD(temp).F
    Temp_HoldCloseNodeDetailsUD.G = OpenNodeListUD(temp).G
    Temp_HoldCloseNodeDetailsUD.H = OpenNodeListUD(temp).H
    Call AddToClosedListUD(Temp_HoldCloseNodeDetailsUD)
End Sub


Public Sub AddToCloseBD(CurrentParent As Long)
    If CurrentParent = 0 Then
        MsgBox "Path Cannot Be Reached", vbOKOnly, "Pathfinding"
        bln_arrayoutofbound = True
        Exit Sub
    End If
    Dim i As Long
    Dim temp As Long
    For i = 1 To OpenNodeList_IncreMentBD
        If OpenNodeListBD(i).Child = CurrentParent And OpenNodeListBD(i).CX = XYAllocation(CurrentParent).X And OpenNodeListBD(i).CY = XYAllocation(CurrentParent).Y Then
            temp = i
            Exit For
        End If
    Next i
    Temp_HoldCloseNodeDetailsBD.Parent = OpenNodeListBD(temp).Parent
    Temp_HoldCloseNodeDetailsBD.PX = OpenNodeListBD(temp).PX
    Temp_HoldCloseNodeDetailsBD.PY = OpenNodeListBD(temp).PY
    Temp_HoldCloseNodeDetailsBD.Child = OpenNodeListBD(temp).Child
    Temp_HoldCloseNodeDetailsBD.CX = OpenNodeListBD(temp).CX
    Temp_HoldCloseNodeDetailsBD.CY = OpenNodeListBD(temp).CY
    Temp_HoldCloseNodeDetailsBD.F = OpenNodeListBD(temp).F
    Temp_HoldCloseNodeDetailsBD.G = OpenNodeListBD(temp).G
    Temp_HoldCloseNodeDetailsBD.H = OpenNodeListBD(temp).H
    Call AddToClosedListBD(Temp_HoldCloseNodeDetailsBD)
End Sub


Public Function CalculateGUD(Parent As Long, PX As Long, PY As Long, Child As Long, CX As Long, CY As Long, Pos As Long) As Double
Dim Cost As Double
    If Pos = 0 Then
        CalculateGUD = 0
    ElseIf Pos = 1 Or Pos = 2 Or Pos = 3 Or Pos = 4 Then
        Cost = GetParentG_CostUD(Parent, PX, PY)
        Cost = Cost + 10
       ' Cost = 10
    ElseIf Pos = 5 Or Pos = 6 Or Pos = 7 Or Pos = 8 Then
        Cost = GetParentG_CostUD(Parent, PX, PY)
        Cost = Cost + 14
        'Cost = 14
    End If
    CalculateGUD = Cost
End Function

Public Function GetParentG_CostUD(Parent As Long, PX As Long, PY As Long) As Double
    Dim i As Long
    Dim temp_g As Double
    
    For i = 1 To 2100
        If OpenNodeListUD(i).Child = Parent And OpenNodeListUD(i).CX = PX And OpenNodeListUD(i).CY = PY Then
            If OpenNodeListUD(i).Parent = Parent And OpenNodeListUD(i).PX = PX And OpenNodeListUD(i).PY = PY Then
                temp_g = OpenNodeListUD(i).G
                Exit For
            Else
                'temp_g = GetParentG_Cost(OpenList(i).Parent, OpenList(i).PX, OpenList(i).PY) + OpenList(i).G
                temp_g = OpenNodeListUD(i).G
                Exit For
            End If
        End If
    Next i
    GetParentG_CostUD = temp_g
End Function


Public Function CalculateGBD(Parent As Long, PX As Long, PY As Long, Child As Long, CX As Long, CY As Long, Pos As Long) As Double
Dim Cost As Double
    If Pos = 0 Then
        CalculateGBD = 0
    ElseIf Pos = 1 Or Pos = 2 Or Pos = 3 Or Pos = 4 Then
        Cost = GetParentG_CostBD(Parent, PX, PY)
        Cost = Cost + 10
       ' Cost = 10
    ElseIf Pos = 5 Or Pos = 6 Or Pos = 7 Or Pos = 8 Then
        Cost = GetParentG_CostBD(Parent, PX, PY)
        Cost = Cost + 14
        'Cost = 14
    End If
    CalculateGBD = Cost
End Function

Public Function GetParentG_CostBD(Parent As Long, PX As Long, PY As Long) As Double
    Dim i As Long
    Dim temp_g As Double
    
    For i = 1 To 2100
        If OpenNodeListBD(i).Child = Parent And OpenNodeListBD(i).CX = PX And OpenNodeListBD(i).CY = PY Then
            If OpenNodeListBD(i).Parent = Parent And OpenNodeListBD(i).PX = PX And OpenNodeListBD(i).PY = PY Then
                temp_g = OpenNodeListBD(i).G
                Exit For
            Else
                'temp_g = GetParentG_Cost(OpenList(i).Parent, OpenList(i).PX, OpenList(i).PY) + OpenList(i).G
                temp_g = OpenNodeListBD(i).G
                Exit For
            End If
        End If
    Next i
    GetParentG_CostBD = temp_g
End Function


Public Function SelectLowestFUD(Current_Parent As Long) As Double
    Dim i As Long
    Dim temp_f As Double
    Dim temp_i As Long
    Dim temp_node As Long
    Dim incre As Long
    
    temp_f = 0
    temp_i = 0
    
    incre = 1
    For i = 1 To OpenNodeList_IncreMentUD
        If OpenNodeList_IncreMentUD > 2100 Then
            bln_arrayoutofbound = True
            Exit Function
        End If
        If OpenNodeListUD(i).Parent = Current_Parent And OpenNodeListUD(i).itsUsed <> True Then
        
             If incre = 1 Then
                temp_f = OpenNodeListUD(i).F
                temp_i = i
                temp_node = OpenNodeListUD(i).Child
                incre = incre + 1
             Else
                If temp_f >= OpenNodeListUD(i).F Then
                    temp_f = OpenNodeListUD(i).F
                    temp_i = i
                    temp_node = OpenNodeListUD(i).Child
                End If
             End If
        End If
    Next i
    If temp_node = DestinationPointUD Then
        MsgBox "Path Found"
        PathFoundUD = True
        Call BackTrack
        Call SavePath
        
        SelectLowestFUD = temp_node
        Exit Function
    Else
        frmMain.pic(temp_node).BackColor = vbYellow
        SelectLowestFUD = temp_node
        
    End If
End Function


Public Function SelectLowestFBD(Current_Parent As Long) As Double
    Dim i As Long
    Dim temp_f As Double
    Dim temp_i As Long
    Dim temp_node As Long
    Dim incre As Long
    
    temp_f = 0
    temp_i = 0
    
    incre = 1
    For i = 1 To OpenNodeList_IncreMentBD
        If OpenNodeListBD(i).Parent = Current_Parent And OpenNodeListBD(i).itsUsed <> True Then
        
             If incre = 1 Then
                temp_f = OpenNodeListBD(i).F
                temp_i = i
                temp_node = OpenNodeListBD(i).Child
                incre = incre + 1
             Else
                If temp_f >= OpenNodeListBD(i).F Then
                    temp_f = OpenNodeListBD(i).F
                    temp_i = i
                    temp_node = OpenNodeListBD(i).Child
                End If
             End If
        End If
    Next i
    If temp_node = DestinationPointBD Then
        MsgBox "Path Found"
        PathFoundBD = True
        Call BackTrackBD
        SelectLowestFBD = temp_node
        Exit Function
    Else
        frmMain.pic(temp_node).BackColor = &HC0C0FF
        SelectLowestFBD = temp_node
        
    End If
End Function

Public Sub AddToOpenUD()

Dim A_Parent As Long
Dim A_PX As Long
Dim A_PY As Long

Dim A_Child As Long
Dim A_CX As Long
Dim A_CY As Long

Dim A_F As Double
Dim A_G As Double
Dim A_H As Double

Dim PreParent As Long
Dim PrePX As Long
Dim PrePY As Long
Dim PreChild As Long
Dim PreCX As Long
Dim PreCY As Long
Dim PreF As Long
Dim PreG As Long
Dim PreH As Long

Dim i As Long
Dim j As Long
Dim temp As Long

            For i = 1 To 8
                If NUD(i) = 0 And AlreadyInOpenListUD(i) <> 0 Then
                    For j = 1 To 2100
                       ' If (OpenNodeListUD(j).Child = AlreadyInOpenListUD(i) Or OpenNodeListUD(j).Parent = AlreadyInOpenListUD(i)) And OpenNodeListUD(j).itsUsed = False Then
                       ' If OpenNodeListUD(j).Child = AlreadyInOpenListUD(i) And OpenNodeListUD(j).itsUsed = False Then
                           ' MsgBox "got"
                        If OpenNodeListUD(j).itsUsed = False Then
                            If OpenNodeListUD(j).Child = AlreadyInOpenListUD(i) Or OpenNodeListUD(j).Parent = AlreadyInOpenListUD(i) Then
                                temp = j
                                Exit For
                            End If
                        End If
                    Next j
                            'Calculate New F G H values
                            If CurrentParentUD = 0 Then
                                Exit Sub
                            End If
                            A_Parent = CurrentParentUD
                            A_PX = XYAllocation(CurrentParentUD).X
                            A_PY = XYAllocation(CurrentParentUD).Y
                            A_Child = AlreadyInOpenListUD(i)
                            A_CX = XYAllocation(AlreadyInOpenListUD(i)).X
                            A_CY = XYAllocation(AlreadyInOpenListUD(i)).Y

                            A_G = CalculateGUD(A_Parent, A_PX, A_PY, A_Child, A_CX, A_CY, i)
                            A_H = HeuristicSearch(A_Child, DestinationPointUD, HeuristicToImpl)
                            A_F = A_G + A_H

                            If temp <> 0 Then
                                PreParent = OpenNodeListUD(temp).Parent
                                PrePX = OpenNodeListUD(temp).PX
                                PrePY = OpenNodeListUD(temp).PY
                                PreChild = OpenNodeListUD(temp).Child
                                PreCX = OpenNodeListUD(temp).CX
                                PreCY = OpenNodeListUD(temp).CY
                                PreF = OpenNodeListUD(temp).F
                                PreG = OpenNodeListUD(temp).G
                                PreH = OpenNodeListUD(temp).H
    
                                If A_G < PreG Then
                                    OpenNodeListUD(temp).Parent = A_Parent
                                    OpenNodeListUD(temp).PX = A_PX
                                    OpenNodeListUD(temp).PY = A_PY
                                    OpenNodeListUD(temp).Child = A_Child
                                    OpenNodeListUD(temp).CX = A_CX
                                    OpenNodeListUD(temp).CY = A_CY
                                    OpenNodeListUD(temp).F = A_F
                                    OpenNodeListUD(temp).G = A_G
                                    OpenNodeListUD(temp).H = A_H
    
                                    CurrentParentUD = A_Child
                                    frmMain.pic(CurrentParentUD).BackColor = vbYellow
                                    AddToCloseUD (CurrentParentUD)
                                    bln_BreakIfNewG_LessthanPreG = True
                                    Exit Sub
                                End If
                            End If
                ElseIf NUD(i) <> 0 Then
                    A_Parent = CurrentParentUD
                    A_PX = XYAllocation(CurrentParentUD).X
                    A_PY = XYAllocation(CurrentParentUD).Y
                    A_Child = NUD(i)
                    A_CX = XYAllocation(NUD(i)).X
                    A_CY = XYAllocation(NUD(i)).Y

                    A_G = CalculateGUD(A_Parent, A_PX, A_PY, A_Child, A_CX, A_CY, i)
                    A_H = HeuristicSearch(A_Child, DestinationPointUD, HeuristicToImpl)
                    A_F = A_G + A_H
                    Call AddToOpenListUD(A_Parent, A_PX, A_PY, A_Child, A_CX, A_CY, A_G, A_H, A_F, False)
                End If
            Next i

End Sub

Public Sub AddToOpenBD()

Dim A_Parent As Long
Dim A_PX As Long
Dim A_PY As Long

Dim A_Child As Long
Dim A_CX As Long
Dim A_CY As Long

Dim A_F As Double
Dim A_G As Double
Dim A_H As Double

Dim A_bln As Long

Dim i As Long


      
            For i = 1 To 8
                If NBD(i) <> 0 Then
                    A_Parent = CurrentParentBD
                    A_PX = XYAllocation(CurrentParentBD).X
                    A_PY = XYAllocation(CurrentParentBD).Y
                    A_Child = NBD(i)
                    A_CX = XYAllocation(NBD(i)).X
                    A_CY = XYAllocation(NBD(i)).Y
                    
                    A_G = CalculateGBD(A_Parent, A_PX, A_PY, A_Child, A_CX, A_CY, i)
                    A_H = HeuristicSearch(A_Child, DestinationPointBD, HeuristicToImpl)
                    A_F = A_G + A_H
                    Call AddToOpenListBD(A_Parent, A_PX, A_PY, A_Child, A_CX, A_CY, A_G, A_H, A_F, False)
                End If
            Next i
     
End Sub


Public Sub DisplayTreeViewData()
            
            frmMain.Path.Nodes.Clear
            frmMain.OpenList.Nodes.Clear
            frmMain.ClosedList.Nodes.Clear
            Dim i As Long
            For i = 1 To OpenNodeList_IncreMentUD
                frmMain.Path.Nodes.Add.Text = "P:- " & OpenNodeListUD(i).Parent & "C:- " & OpenNodeListUD(i).Child & "(" & OpenNodeListUD(i).CX & "," & OpenNodeListUD(i).CY & ")" & "F:- " & OpenNodeListUD(i).F & "G:- " & OpenNodeListUD(i).G & "H:- " & OpenNodeListUD(i).H
                If OpenNodeListUD(i).itsUsed = True Then
                    frmMain.ClosedList.Nodes.Add.Text = "P:- " & OpenNodeListUD(i).Parent & "C:- " & OpenNodeListUD(i).Child & "(" & OpenNodeListUD(i).CX & "," & OpenNodeListUD(i).CY & ")" & "F:- " & OpenNodeListUD(i).F & "G:- " & OpenNodeListUD(i).G & "H:- " & OpenNodeListUD(i).H
                Else
                    frmMain.OpenList.Nodes.Add.Text = "P:- " & OpenNodeListUD(i).Parent & "C:- " & OpenNodeListUD(i).Child & "(" & OpenNodeListUD(i).CX & "," & OpenNodeListUD(i).CY & ")" & "F:- " & OpenNodeListUD(i).F & "G:- " & OpenNodeListUD(i).G & "H:- " & OpenNodeListUD(i).H
                End If
            Next i
End Sub


Public Sub AStar_UD(Heuristic As String, Direction As String)
PathFoundUD = False
Dim A_Parent As Long
Dim A_PX As Long
Dim A_PY As Long

Dim A_Child As Long
Dim A_CX As Long
Dim A_CY As Long

Dim A_F As Double
Dim A_G As Double
Dim A_H As Double

Dim A_bln As Long
bln_StartPointBlockedUD = False
bln_BreakIfNewG_LessthanPreG = False
''check = False

    StartPointUD = FindStartPointUD("Red")
    DestinationPointUD = FindEndPointUD
    
    HeuristicToImpl = Heuristic
    CurrentParentUD = StartPointUD
    
    Call CheckStartSource(StartPointUD)
    If bln_StartPointBlockedUD = True Then
        Exit Sub
    End If
    
    
'1.> Begin At Starting Point A add it to Open List
          
        A_Parent = CurrentParentUD
        A_PX = XYAllocation(CurrentParentUD).X
        A_PY = XYAllocation(CurrentParentUD).Y
        
        A_Child = A_Parent
        A_CX = A_PX
        A_CY = A_PY
        
        A_G = CalculateGUD(A_Parent, A_PX, A_PY, A_Child, A_CX, A_CY, 0)
        A_H = HeuristicSearch(CurrentParentUD, DestinationPointUD, HeuristicToImpl)
        A_F = A_G + A_H
        Call AddToOpenListUD(A_Parent, A_PX, A_PY, A_Child, A_CX, A_CY, A_G, A_H, A_F, False)
        
        'Call DisplayTreeViewData
'2.> Look Reachable Squares add them to open list and save Current_Parent as Ther Parent
        Call GetNeighboursUD(CurrentParentUD)
        If bln_stepbystep = True Then
            Call WaitForSingleStep
        End If
        Call AddToOpenUD
        'Call DisplayTreeViewData
'3.> Drop The Starting Square From the open list and add it to closed list
        Call AddToCloseUD(CurrentParentUD)
        'Call DisplayTreeViewData
        'To continue we simply choose the F square with lowest F value
        CurrentParentUD = SelectLowestFUD(CurrentParentUD)
'4.> Drop the Lowest F from Open List to Closed List
        Call AddToCloseUD(CurrentParentUD)
        If PathFoundUD = True Then
            Exit Sub
        End If
'5.> Check all the adjacent square ignoring that are in the closed list,add squares if ther are not in open list make this selected parent
        While (1)
Start:
            Call GetNeighboursUD(CurrentParentUD)
            If bln_stepbystep = True Then
                Call WaitForSingleStep
            End If
            Call AddToOpenUD
            
'''            If check = False Then
'''                CurrentParentUD = SelectLowestFUD_LastOption
'''                GoTo START:
'''            End If
            If bln_BreakIfNewG_LessthanPreG = True Then
                bln_BreakIfNewG_LessthanPreG = False
                GoTo Start:
            End If
            
            CurrentParentUD = SelectLowestFUD(CurrentParentUD)
         
            If PathFoundUD = True Then
                Call DisplayTreeViewData
                Exit Sub
            End If
            'Call DisplayTreeViewData
            
            
            If CurrentParentUD = 0 Then
                If bln_arrayoutofbound = True Then
                    Exit Sub
                End If
                CurrentParentUD = SelectLowestFUD_LastOption
                frmMain.pic(CurrentParentUD).BackColor = vbYellow
                Call AddToCloseUD(CurrentParentUD)
                GoTo Start:
                'MsgBox "Not Getting the Path"
                'Exit Sub
            Else
                Call AddToCloseUD(CurrentParentUD)
                If bln_arrayoutofbound = True Then
                    MsgBox "Cannot Find the Path " & vbCrLf & "Reset the Application", vbOKOnly, "Pathfinding"
                    Exit Sub
                End If
            End If
GoTo Start:
           
        Wend
'6.>
End Sub


Public Function FindStartPointUD(Colour As String) As Long
Dim i As Long

    If Colour = "Red" Then
        For i = 1 To 2100
            If frmMain.pic(i).BackColor = vbRed Then
                FindStartPointUD = i
            End If
        Next i
    End If
End Function

Public Function FindStartPointBD(Colour As String) As Long
Dim i As Long

    If Colour = "Green" Then
        For i = 1 To 2100
            If frmMain.pic(i).BackColor = vbGreen Then
                FindStartPointBD = i
            End If
        Next i
    End If
End Function

Public Function FindEndPointUD()
Dim i As Long

    
        For i = 1 To 2100
            If frmMain.pic(i).BackColor = vbGreen Then
                FindEndPointUD = i
            End If
        Next i
    
End Function

Public Function FindEndPointBD()
Dim i As Long


            For i = 1 To 2100
                If frmMain.pic(i).BackColor = vbRed Then
                    FindEndPointBD = i
                End If
            Next i
            
End Function

Public Sub SimpleAStar(Heuristic As String, Direction As String)
    If Direction = "BiDirectional" Then
        Call AStar_BD(Heuristic, Direction)
    ElseIf Direction = "UniDirectional" Then
        Call AStar_UD(Heuristic, Direction)
    End If
End Sub


Public Sub GetNeighboursBD(CurrentParentBD As Long)
    

Dim SourcePoint_IndexBD As Long
Dim SourcePoint_RowBD As Long
Dim SourcePoint_ColBD As Long
Dim Immediate_UPBD As Long
Dim Immediate_DOWNBD As Long
Dim Immediate_RIGHTBD As Long
Dim Immediate_LEFTBD As Long
Dim Immediate_UP_LEFTBD As Long
Dim Immediate_UP_RIGHTBD As Long
Dim Immediate_DOWN_LEFTBD As Long
Dim Immediate_DOWN_RIGHTBD As Long

SourcePoint_IndexBD = CurrentParentBD
SourcePoint_RowBD = XYAllocation(CurrentParentBD).X
SourcePoint_ColBD = XYAllocation(CurrentParentBD).Y

'BackTrack = &H80FF&
'vbYellow = &HC0C0FF
'vbBlue = &HC0FFC0
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''&HC0C0FF,&HC0FFC0
        Immediate_UPBD = GetIndexBD(SourcePoint_RowBD - 1, SourcePoint_ColBD)
            If frmMain.pic(Immediate_UPBD).BackColor = vbMagenta Or frmMain.pic(Immediate_UPBD).BackColor = vbGreen Or frmMain.pic(Immediate_UPBD).BackColor = &HC0C0FF Then
                NBD(1) = 0
            Else
                If frmMain.pic(Immediate_UPBD).BackColor = &HC0FFC0 Then 'Or frmMain.pic(Immediate_UPBD).BackColor = &HC0C0FF Then
                        If Algorithm = "Simple A*" Or Algorithm = "Dijkstra" Then
                            NBD(1) = Immediate_UPBD
                        Else
                            NBD(1) = 0
                        End If
                Else
                    If frmMain.pic(Immediate_UPBD).BackColor = vbRed Then
                        NBD(1) = Immediate_UPBD
                    Else
                        frmMain.pic(Immediate_UPBD).BackColor = &HC0FFC0
                        NBD(1) = Immediate_UPBD
                    End If
                End If
            End If
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        Immediate_DOWNBD = GetIndexBD(SourcePoint_RowBD + 1, SourcePoint_ColBD)
            If frmMain.pic(Immediate_DOWNBD).BackColor = vbMagenta Or frmMain.pic(Immediate_DOWNBD).BackColor = vbGreen Or frmMain.pic(Immediate_DOWNBD).BackColor = &HC0C0FF Then
                NBD(2) = 0
                'AlreadyInOpenListArray(2) = 0
            Else
                If frmMain.pic(Immediate_DOWNBD).BackColor = &HC0FFC0 Then ' Or frmMain.pic(Immediate_DOWNBD).BackColor = &HC0C0FF Then
                    If Algorithm = "Simple A*" Or Algorithm = "Dijkstra" Then
                        NBD(2) = Immediate_DOWNBD
                    Else
                        'AlreadyInOpenListArray(2) = Immediate_DOWNBD
                        NBD(2) = 0
                    End If
                Else
                    If frmMain.pic(Immediate_DOWNBD).BackColor = vbRed Then
                        'AlreadyInOpenListArray(2) = 0
                        NBD(2) = Immediate_DOWNBD
                    Else
                        frmMain.pic(Immediate_DOWNBD).BackColor = &HC0FFC0
                        NBD(2) = Immediate_DOWNBD
                    End If
                End If
            End If
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        Immediate_RIGHTBD = GetIndexBD(SourcePoint_RowBD, SourcePoint_ColBD + 1)
            If frmMain.pic(Immediate_RIGHTBD).BackColor = vbMagenta Or frmMain.pic(Immediate_RIGHTBD).BackColor = vbGreen Or frmMain.pic(Immediate_RIGHTBD).BackColor = &HC0C0FF Then
                NBD(3) = 0
                'AlreadyInOpenListArray(3) = 0
            Else
                If frmMain.pic(Immediate_RIGHTBD).BackColor = &HC0FFC0 Then ' Or frmMain.pic(Immediate_RIGHTBD).BackColor = &HC0C0FF Then
                   If Algorithm = "Simple A*" Or Algorithm = "Dijkstra" Then
                        NBD(3) = Immediate_RIGHTBD
                    Else
                        'AlreadyInOpenListArray(3) = Immediate_RIGHTBD
                        NBD(3) = 0
                    End If
                Else
                    If frmMain.pic(Immediate_RIGHTBD).BackColor = vbRed Then
                        'AlreadyInOpenListArray(3) = 0
                        NBD(3) = Immediate_RIGHTBD
                    Else
                        frmMain.pic(Immediate_RIGHTBD).BackColor = &HC0FFC0
                        NBD(3) = Immediate_RIGHTBD
                    End If
                End If
            End If
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        Immediate_LEFTBD = GetIndexBD(SourcePoint_RowBD, SourcePoint_ColBD - 1)
            If frmMain.pic(Immediate_LEFTBD).BackColor = vbMagenta Or frmMain.pic(Immediate_LEFTBD).BackColor = vbGreen Or frmMain.pic(Immediate_LEFTBD).BackColor = &HC0C0FF Then
                NBD(4) = 0
                'AlreadyInOpenListArray(4) = 0
            Else
                If frmMain.pic(Immediate_LEFTBD).BackColor = &HC0FFC0 Or frmMain.pic(Immediate_LEFTBD).BackColor = &HC0C0FF Then
                    If Algorithm = "Simple A*" Or Algorithm = "Dijkstra" Then
                        NBD(4) = Immediate_LEFTBD
                    Else
                        'AlreadyInOpenListArray(4) = Immediate_LEFTBD
                        NBD(4) = 0
                    End If
                Else
                    If frmMain.pic(Immediate_LEFTBD).BackColor = vbRed Then
                        'AlreadyInOpenListArray(4) = 0
                        NBD(4) = Immediate_LEFTBD
                    Else
                        frmMain.pic(Immediate_LEFTBD).BackColor = &HC0FFC0
                        NBD(4) = Immediate_LEFTBD
                    End If
                End If
            End If
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        Immediate_UP_LEFTBD = GetIndexBD(SourcePoint_RowBD - 1, SourcePoint_ColBD - 1)
            If frmMain.pic(Immediate_UP_LEFTBD).BackColor = vbMagenta Or frmMain.pic(Immediate_UP_LEFTBD).BackColor = vbGreen Or frmMain.pic(Immediate_UP_LEFTBD).BackColor = &HC0C0FF Then
                NBD(5) = 0
                'AlreadyInOpenListArray(5) = 0
            Else
                If frmMain.pic(Immediate_UP_LEFTBD).BackColor = &HC0FFC0 Then ' Or frmMain.pic(Immediate_UP_LEFTBD).BackColor = &HC0C0FF Then
                   If Algorithm = "Simple A*" Or Algorithm = "Dijkstra" Then
                        NBD(5) = Immediate_UP_LEFTBD
                    Else
                        'AlreadyInOpenListArray(5) = Immediate_UP_LEFTBD
                        NBD(5) = 0
                    End If
                Else
                    If frmMain.pic(Immediate_UP_LEFTBD).BackColor = vbRed Then
                        'AlreadyInOpenListArray(5) = 0
                        NBD(5) = Immediate_UP_LEFTBD
                    Else
                        frmMain.pic(Immediate_UP_LEFTBD).BackColor = &HC0FFC0
                        NBD(5) = Immediate_UP_LEFTBD
                    End If
                End If
             End If
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        Immediate_UP_RIGHTBD = GetIndexBD(SourcePoint_RowBD - 1, SourcePoint_ColBD + 1)
            If frmMain.pic(Immediate_UP_RIGHTBD).BackColor = vbMagenta Or frmMain.pic(Immediate_UP_RIGHTBD).BackColor = vbGreen Or frmMain.pic(Immediate_UP_RIGHTBD).BackColor = &HC0C0FF Then
                NBD(6) = 0
                'AlreadyInOpenListArray(6) = 0
            Else
                If frmMain.pic(Immediate_UP_RIGHTBD).BackColor = &HC0FFC0 Then ' Or frmMain.pic(Immediate_UP_RIGHTBD).BackColor = &HC0C0FF Then
                  If Algorithm = "Simple A*" Or Algorithm = "Dijkstra" Then
                        NBD(6) = Immediate_UP_RIGHTBD
                    Else
                        'AlreadyInOpenListArray(6) = Immediate_UP_RIGHTBD
                        NBD(6) = 0
                    End If
                Else
                    If frmMain.pic(Immediate_UP_RIGHTBD).BackColor = vbRed Then
                        'AlreadyInOpenListArray(6) = 0
                        NBD(6) = Immediate_UP_RIGHTBD
                    Else
                        frmMain.pic(Immediate_UP_RIGHTBD).BackColor = &HC0FFC0
                        NBD(6) = Immediate_UP_RIGHTBD
                    End If
                End If
            End If
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        Immediate_DOWN_LEFTBD = GetIndexBD(SourcePoint_RowBD + 1, SourcePoint_ColBD - 1)
            If frmMain.pic(Immediate_DOWN_LEFTBD).BackColor = vbMagenta Or frmMain.pic(Immediate_DOWN_LEFTBD).BackColor = vbGreen Or frmMain.pic(Immediate_DOWN_LEFTBD).BackColor = &HC0C0FF Then
                NBD(7) = 0
                'AlreadyInOpenListArray(7) = 0
            Else
                If frmMain.pic(Immediate_DOWN_LEFTBD).BackColor = &HC0FFC0 Then ' Or frmMain.pic(Immediate_DOWN_LEFTBD).BackColor = &HC0C0FF Then
                  If Algorithm = "Simple A*" Or Algorithm = "Dijkstra" Then
                        NBD(7) = Immediate_DOWN_LEFTBD
                    Else
                        'AlreadyInOpenListArray(7) = Immediate_DOWN_LEFTBD
                        NBD(7) = 0
                    End If
                Else
                    If frmMain.pic(Immediate_DOWN_LEFTBD).BackColor = vbRed Then
                        'AlreadyInOpenListArray(7) = 0
                        NBD(7) = Immediate_DOWN_LEFTBD
                    Else
                        frmMain.pic(Immediate_DOWN_LEFTBD).BackColor = &HC0FFC0
                        NBD(7) = Immediate_DOWN_LEFTBD
                    End If
                End If
            End If
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        Immediate_DOWN_RIGHTBD = GetIndexBD(SourcePoint_RowBD + 1, SourcePoint_ColBD + 1)
            If frmMain.pic(Immediate_DOWN_RIGHTBD).BackColor = vbMagenta Or frmMain.pic(Immediate_DOWN_RIGHTBD).BackColor = vbGreen Or frmMain.pic(Immediate_DOWN_RIGHTBD).BackColor = &HC0C0FF Then
                NBD(8) = 0
                'AlreadyInOpenListArray(8) = 0
            Else
                If frmMain.pic(Immediate_DOWN_RIGHTBD).BackColor = &HC0FFC0 Then 'Or frmMain.pic(Immediate_DOWN_RIGHTBD).BackColor = &HC0C0FF Then
                  If Algorithm = "Simple A*" Or Algorithm = "Dijkstra" Then
                        NBD(8) = Immediate_DOWN_RIGHTBD
                    Else
                        'AlreadyInOpenListArray(8) = Immediate_DOWN_RIGHTBD
                        NBD(8) = 0
                    End If
                Else
                    If frmMain.pic(Immediate_DOWN_RIGHTBD).BackColor = vbRed Then
                        'AlreadyInOpenListArray(8) = 0
                        NBD(8) = Immediate_DOWN_RIGHTBD
                    Else
                        frmMain.pic(Immediate_DOWN_RIGHTBD).BackColor = &HC0FFC0
                        NBD(8) = Immediate_DOWN_RIGHTBD
                    End If
                End If
            End If
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
End Sub


Public Sub AStar_BD(Heuristic As String, Direction As String)

PathFoundUD = False
PathFoundBD = False

Dim PathUD As Boolean
Dim PathBD As Boolean

PathUD = False
PathBD = False

Dim A_ParentUD As Long
Dim A_PXUD As Long
Dim A_PYUD As Long

Dim A_ParentBD As Long
Dim A_PXBD As Long
Dim A_PYBD As Long

Dim A_ChildUD As Long
Dim A_CXUD As Long
Dim A_CYUD As Long

Dim A_ChildBD As Long
Dim A_CXBD As Long
Dim A_CYBD As Long

Dim A_FUD As Double
Dim A_GUD As Double
Dim A_HUD As Double

Dim A_FBD As Double
Dim A_GBD As Double
Dim A_HBD As Double


    '''StartPointUD = FindStartPointUD("Red")
    StartPointBD = FindStartPointBD("Green")
    
    '''DestinationPointUD = FindEndPointUD
    DestinationPointBD = FindEndPointBD
    
    HeuristicToImpl = Heuristic
    
    '''CurrentParentUD = StartPointUD
    CurrentParentBD = StartPointBD
    
    
    
'1.> Begin At Starting Point A add it to Open List
        'For UD
'''        A_ParentUD = CurrentParentUD
'''        A_PXUD = XYAllocation(CurrentParentUD).X
'''        A_PYUD = XYAllocation(CurrentParentUD).Y
'''
'''        A_ChildUD = A_ParentUD
'''        A_CXUD = A_PXUD
'''        A_CYUD = A_PYUD
'''
'''        A_GUD = CalculateGUD(A_ParentUD, A_PXUD, A_PYUD, A_ChildUD, A_CXUD, A_CYUD, 0)
'''        A_HUD = HeuristicSearch(CurrentParentUD, DestinationPointUD, HeuristicToImpl)
'''        A_FUD = A_GUD + A_HUD
'''        Call AddToOpenListUD(A_ParentUD, A_PXUD, A_PYUD, A_ChildUD, A_CXUD, A_CYUD, A_GUD, A_HUD, A_FUD, False)
'''
        'Fo BD
        A_ParentBD = CurrentParentBD
        A_PXBD = XYAllocation(CurrentParentBD).X
        A_PYBD = XYAllocation(CurrentParentBD).Y
        
        A_ChildBD = A_ParentBD
        A_CXBD = A_PXBD
        A_CYBD = A_PYBD
        
        A_GBD = CalculateGBD(A_ParentBD, A_PXBD, A_PYBD, A_ChildBD, A_CXBD, A_CYBD, 0)
        A_HBD = HeuristicSearch(CurrentParentBD, DestinationPointBD, HeuristicToImpl)
        A_FBD = A_GBD + A_HBD
        Call AddToOpenListBD(CurrentParentBD, A_PXBD, A_PYBD, A_ChildBD, A_CXBD, A_CYBD, A_GBD, A_HBD, A_FBD, False)
        'Call DisplayTreeViewData
'2.> Look Reachable Squares add them to open list and save Current_Parent as Ther Parent
'''        Call GetNeighboursUD(CurrentParentUD)
        Call GetNeighboursBD(CurrentParentBD)
        
        If bln_stepbystep = True Then
            Call WaitForSingleStep
        End If
        
'''        Call AddToOpenUD
        Call AddToOpenBD
        'Call DisplayTreeViewData
'3.> Drop The Starting Square From the open list and add it to closed list
'''        Call AddToCloseUD(CurrentParentUD)
        Call AddToCloseBD(CurrentParentBD)
        
        'Call DisplayTreeViewData
        'To continue we simply choose the F square with lowest F value
''        CurrentParentUD = SelectLowestFUD(CurrentParentUD)
        CurrentParentBD = SelectLowestFBD(CurrentParentBD)
'4.> Drop the Lowest F from Open List to Closed List
'''        Call AddToCloseUD(CurrentParentUD)
        Call AddToCloseBD(CurrentParentBD)
        
''        If PathFoundUD = True Then
''            PathUD = True
''        End If
        
        If PathFoundBD = True Then
            PathBD = True
        End If
'5.> Check all the adjacent square ignoring that are in the closed list,add squares if ther are not in open list make this selected parent
        While (1)
Start:
''''            If PathUD = True Then
''''                'Do Nothing
''''            Else
''''                Call GetNeighboursUD(CurrentParentUD)
'''            End If
            
'''            If PathBD = True Then
'''                'Do Nothing
'''            Else
                If bln_arrayoutofbound = True Then
                    Exit Sub
                End If
                Call GetNeighboursBD(CurrentParentBD)
'''            End If
            
            If bln_stepbystep = True Then
                Call WaitForSingleStep
            End If
            
'''            If PathUD = True Then
'''                'Do Nothing
'''            Else
'''                Call AddToOpenUD
'''            End If
            
'''            If PathBD = True Then
'''                'Do Nothing
'''            Else
                Call AddToOpenBD
'''            End If
            
''''            If PathUD = True Then
''''            Else
''''                CurrentParentUD = SelectLowestFUD(CurrentParentUD)
''''            End If
'''
'''            If PathBD = True Then
'''            Else
                CurrentParentBD = SelectLowestFBD(CurrentParentBD)
''''            End If
            
           If PathFoundBD = True Then
            '    Call DisplayTreeViewData
              Exit Sub
            End If
            'Call DisplayTreeViewData
            
               ''' If CurrentParentUD = 0 And CurrentParentBD = 0 Then
                'Current_Parent = SelectLowestF_LastOption
                 If CurrentParentBD = 0 Then
                    CurrentParentBD = SelectLowestFBD_LastOption
                frmMain.pic(CurrentParentBD).BackColor = &HC0C0FF
                Call AddToCloseUD(CurrentParentBD)
                GoTo Start:
                    'MsgBox "Not Getting the Path"
                    If bln_arrayoutofbound = True Then
                        Exit Sub
                    End If
                    'Exit Sub
                Else
                    '''Call AddToCloseUD(CurrentParentUD)
                    Call AddToCloseBD(CurrentParentBD)
                End If
            
GoTo Start:
           
        Wend
'6.>
End Sub

Public Sub CheckStartSource(StartPoint As Long)
    Dim StartPointX As Long
    Dim StartPointY As Long
    StartPointX = XYAllocation(StartPoint).X
    StartPointY = XYAllocation(StartPoint).Y
    
    Dim Immediate_UPUD As Long
    Dim Immediate_DOWNUD As Long
    Dim Immediate_RIGHTUD As Long
    Dim Immediate_LEFTUD As Long
    Dim Immediate_UP_LEFTUD As Long
    Dim Immediate_UP_RIGHTUD As Long
    Dim Immediate_DOWN_LEFTUD As Long
    Dim Immediate_DOWN_RIGHTUD As Long
    
    Immediate_UPUD = GetIndexUD(StartPointX - 1, StartPointY)
    Immediate_DOWNUD = GetIndexUD(StartPointX + 1, StartPointY)
    Immediate_RIGHTUD = GetIndexUD(StartPointX, StartPointY + 1)
    Immediate_LEFTUD = GetIndexUD(StartPointX, StartPointY - 1)
    Immediate_UP_LEFTUD = GetIndexUD(StartPointX - 1, StartPointY - 1)
    Immediate_UP_RIGHTUD = GetIndexUD(StartPointX - 1, StartPointY + 1)
    Immediate_DOWN_LEFTUD = GetIndexUD(StartPointX + 1, StartPointY - 1)
    Immediate_DOWN_RIGHTUD = GetIndexUD(StartPointX + 1, StartPointY + 1)
    
    
    
    If frmMain.pic(Immediate_UPUD).BackColor = vbMagenta And frmMain.pic(Immediate_DOWNUD).BackColor = vbMagenta And frmMain.pic(Immediate_RIGHTUD).BackColor = vbMagenta And frmMain.pic(Immediate_LEFTUD).BackColor = vbMagenta And frmMain.pic(Immediate_UP_LEFTUD).BackColor = vbMagenta And frmMain.pic(Immediate_UP_RIGHTUD).BackColor = vbMagenta And frmMain.pic(Immediate_DOWN_LEFTUD).BackColor = vbMagenta And frmMain.pic(Immediate_DOWN_RIGHTUD).BackColor = vbMagenta Then
        bln_StartPointBlockedUD = True
    Else
        bln_StartPointBlockedUD = False
    End If
End Sub


Public Function SelectLowestFUD_LastOption() As Double
    Dim i As Long
    Dim temp_f As Double
    Dim temp_i As Long
    Dim temp_node As Long
    Dim incre As Long
    
    temp_f = 0
    temp_i = 0
    
    incre = 1
    For i = 1 To OpenNodeList_IncreMentUD
        If OpenNodeList_IncreMentUD > 2100 Then
            Exit Function
        End If
        If OpenNodeListUD(i).itsUsed <> True Then
        
             If incre = 1 Then
                temp_f = OpenNodeListUD(i).F
                temp_i = i
                temp_node = OpenNodeListUD(i).Child
                incre = incre + 1
             Else
                If temp_f > OpenNodeListUD(i).F Then
                    temp_f = OpenNodeListUD(i).F
                    temp_i = i
                    temp_node = OpenNodeListUD(i).Child
                End If
             End If
        End If
    Next i
    If temp_node = DestinationPointUD Then
        MsgBox "Path Found"
        PathFoundUD = True
        Call BackTrack
        Call SavePath
        SelectLowestFUD_LastOption = temp_node
        Exit Function
    Else
        frmMain.pic(temp_node).BackColor = vbYellow
        SelectLowestFUD_LastOption = temp_node
        
    End If
End Function


Public Function SelectLowestFBD_LastOption() As Double
    Dim i As Long
    Dim temp_f As Double
    Dim temp_i As Long
    Dim temp_node As Long
    Dim incre As Long
    
    temp_f = 0
    temp_i = 0
    
    incre = 1
    For i = 1 To OpenNodeList_IncreMentBD
        If OpenNodeListBD(i).itsUsed <> True Then
        
             If incre = 1 Then
                temp_f = OpenNodeListBD(i).F
                temp_i = i
                temp_node = OpenNodeListBD(i).Child
                incre = incre + 1
             Else
                If temp_f > OpenNodeListBD(i).F Then
                    temp_f = OpenNodeListBD(i).F
                    temp_i = i
                    temp_node = OpenNodeListBD(i).Child
                End If
             End If
        End If
    Next i
    If temp_node = DestinationPointUD Then
        MsgBox "Path Found"
        PathFoundBD = True
        Call BackTrackBD
        SelectLowestFBD_LastOption = temp_node
        Exit Function
    Else
        frmMain.pic(temp_node).BackColor = &HC0C0FF
        SelectLowestFBD_LastOption = temp_node
        
    End If
End Function
Public Sub BackTrack()
    Dim EndNode As Long
    Dim EndNodeX As Long
    Dim EndNodeY As Long
    
    EndNode = FindEndPointUD
    EndNodeX = XYAllocation(EndNode).X
    EndNodeY = XYAllocation(EndNode).Y
    
    Dim StartNode As Long
    StartNode = FindStartPointUD("Red")
    
    Dim bln_backtrack As Boolean
    bln_backtrack = False
    Dim Immediate_UPUD As Long
    Dim Immediate_DOWNUD As Long
    Dim Immediate_RIGHTUD As Long
    Dim Immediate_LEFTUD As Long
    Dim Immediate_UP_LEFTUD As Long
    Dim Immediate_UP_RIGHTUD  As Long
    Dim Immediate_DOWN_LEFTUD As Long
    Dim Immediate_DOWN_RIGHTUD As Long
    
    Immediate_UPUD = GetIndexUD(EndNodeX - 1, EndNodeY)
    Immediate_DOWNUD = GetIndexUD(EndNodeX + 1, EndNodeY)
    Immediate_RIGHTUD = GetIndexUD(EndNodeX, EndNodeY + 1)
    Immediate_LEFTUD = GetIndexUD(EndNodeX, EndNodeY - 1)
    Immediate_UP_LEFTUD = GetIndexUD(EndNodeX - 1, EndNodeY - 1)
    Immediate_UP_RIGHTUD = GetIndexUD(EndNodeX - 1, EndNodeY + 1)
    Immediate_DOWN_LEFTUD = GetIndexUD(EndNodeX + 1, EndNodeY - 1)
    Immediate_DOWN_RIGHTUD = GetIndexUD(EndNodeX + 1, EndNodeY + 1)
    
    Dim temp As Long
    
    If Immediate_UPUD = 0 Then
        'Do Nothing
    ElseIf frmMain.pic(Immediate_UPUD).BackColor = vbYellow Then
        temp = Immediate_UPUD
    End If
    
    If Immediate_DOWNUD = 0 Then
        'Do Nothing
    ElseIf frmMain.pic(Immediate_DOWNUD).BackColor = vbYellow Then
        temp = Immediate_DOWNUD
    End If
    
    If Immediate_RIGHTUD = 0 Then
    
    ElseIf frmMain.pic(Immediate_RIGHTUD).BackColor = vbYellow Then
        temp = Immediate_RIGHTUD
    End If
    
    If Immediate_LEFTUD = 0 Then
    
    ElseIf frmMain.pic(Immediate_LEFTUD).BackColor = vbYellow Then
        temp = Immediate_LEFTUD
    End If
    
    If Immediate_UP_LEFTUD = 0 Then
    
    ElseIf frmMain.pic(Immediate_UP_LEFTUD).BackColor = vbYellow Then
        temp = Immediate_UP_LEFTUD
    End If
    
    If Immediate_UP_RIGHTUD = 0 Then
    ElseIf frmMain.pic(Immediate_UP_RIGHTUD).BackColor = vbYellow Then
        temp = Immediate_UP_RIGHTUD
    End If
    
    If Immediate_DOWN_LEFTUD = 0 Then
    ElseIf frmMain.pic(Immediate_DOWN_LEFTUD).BackColor = vbYellow Then
        temp = Immediate_DOWN_LEFTUD
    End If
    
    If Immediate_DOWN_RIGHTUD = 0 Then
    ElseIf frmMain.pic(Immediate_DOWN_RIGHTUD).BackColor = vbYellow Then
        temp = Immediate_DOWN_RIGHTUD
    End If
    
    Dim i As Long
    Dim nexttemp As Long
BACK:
    For i = ClosedNodeList_IncreMentUD To 1 Step -1
        If ClosedNodeListUD(i).Child = StartNode Then
            bln_backtrack = True
            Exit For
        Else
            If ClosedNodeListUD(i).Child = temp Then
                frmMain.pic(temp).BackColor = vbCyan
                nexttemp = ClosedNodeListUD(i).Parent
                Exit For
            End If
        End If
    Next i
    If bln_backtrack = False Then
        temp = nexttemp
        GoTo BACK:
    Else
        MsgBox "Back Tracked"
        frmMain.endTime_Timer.Enabled = True
        frmMain.endTime_Timer_Timer
        frmMain.endTime_Timer.Enabled = False
        'frmMain.finaltime.Caption = Format$(frmMain.endtimecap.Caption - frmMain.cttime.Caption, "hh:mm:ss")
        frmMain.finaltime.Caption = Format$(frmMain.end_timedb - frmMain.start_timedb, "hh:mm:ss")
        Exit Sub
    End If
End Sub

Public Sub BackTrackBD()
    Dim EndNode As Long
    Dim EndNodeX As Long
    Dim EndNodeY As Long
    
    EndNode = FindEndPointBD
    EndNodeX = XYAllocation(EndNode).X
    EndNodeY = XYAllocation(EndNode).Y
    
    Dim StartNode As Long
    StartNode = FindStartPointBD("Green")
    
    Dim bln_backtrack As Boolean
    bln_backtrack = False
    Dim Immediate_UPBD As Long
    Dim Immediate_DOWNBD As Long
    Dim Immediate_RIGHTBD As Long
    Dim Immediate_LEFTBD As Long
    Dim Immediate_UP_LEFTBD As Long
    Dim Immediate_UP_RIGHTBD  As Long
    Dim Immediate_DOWN_LEFTBD As Long
    Dim Immediate_DOWN_RIGHTBD As Long
    
    Immediate_UPBD = GetIndexBD(EndNodeX - 1, EndNodeY)
    Immediate_DOWNBD = GetIndexBD(EndNodeX + 1, EndNodeY)
    Immediate_RIGHTBD = GetIndexBD(EndNodeX, EndNodeY + 1)
    Immediate_LEFTBD = GetIndexBD(EndNodeX, EndNodeY - 1)
    Immediate_UP_LEFTBD = GetIndexBD(EndNodeX - 1, EndNodeY - 1)
    Immediate_UP_RIGHTBD = GetIndexBD(EndNodeX - 1, EndNodeY + 1)
    Immediate_DOWN_LEFTBD = GetIndexBD(EndNodeX + 1, EndNodeY - 1)
    Immediate_DOWN_RIGHTBD = GetIndexBD(EndNodeX + 1, EndNodeY + 1)
    
    Dim temp As Long
    If Immediate_UPBD = 0 Then
    ElseIf frmMain.pic(Immediate_UPBD).BackColor = &HC0C0FF Then
        temp = Immediate_UPBD
    End If
    
    If Immediate_DOWNBD = 0 Then
    ElseIf frmMain.pic(Immediate_DOWNBD).BackColor = &HC0C0FF Then
        temp = Immediate_DOWNBD
    End If
    
    If Immediate_RIGHTBD = 0 Then
    ElseIf frmMain.pic(Immediate_RIGHTBD).BackColor = &HC0C0FF Then
        temp = Immediate_RIGHTBD
    End If
    
    If Immediate_LEFTBD = 0 Then
    ElseIf frmMain.pic(Immediate_LEFTBD).BackColor = &HC0C0FF Then
        temp = Immediate_LEFTBD
    End If
    
    If Immediate_UP_LEFTBD = 0 Then
    ElseIf frmMain.pic(Immediate_UP_LEFTBD).BackColor = &HC0C0FF Then
        temp = Immediate_UP_LEFTBD
    End If
    
    If Immediate_UP_RIGHTBD = 0 Then
    ElseIf frmMain.pic(Immediate_UP_RIGHTBD).BackColor = &HC0C0FF Then
        temp = Immediate_UP_RIGHTBD
    End If
    
    If Immediate_DOWN_LEFTBD = 0 Then
    ElseIf frmMain.pic(Immediate_DOWN_LEFTBD).BackColor = &HC0C0FF Then
        temp = Immediate_DOWN_LEFTBD
    End If
    
    If Immediate_DOWN_RIGHTBD = 0 Then
    ElseIf frmMain.pic(Immediate_DOWN_RIGHTBD).BackColor = &HC0C0FF Then
        temp = Immediate_DOWN_RIGHTBD
    End If
    
    Dim i As Long
    Dim nexttemp As Long
BACK:
    For i = ClosedNodeList_IncrementBD To 1 Step -1
        If ClosedNodeListBD(i).Child = StartNode Then
            bln_backtrack = True
            Exit For
        Else
            If ClosedNodeListBD(i).Child = temp Then
                frmMain.pic(temp).BackColor = &H80FF&
                nexttemp = ClosedNodeListBD(i).Parent
                Exit For
            End If
        End If
    Next i
    If bln_backtrack = False Then
        temp = nexttemp
        GoTo BACK:
    Else
        MsgBox "Back Tracked"
        frmMain.endTime_Timer.Enabled = True
        frmMain.endTime_Timer_Timer
        frmMain.endTime_Timer.Enabled = False
        'frmMain.finaltime.Caption = Format$(frmMain.endtimecap.Caption - frmMain.cttime.Caption, "hh:mm:ss")
        frmMain.finaltime.Caption = Format$(frmMain.end_timedb - frmMain.start_timedb, "hh:mm:ss")
        Exit Sub
    End If
End Sub

Public Sub SavePath()
    Dim i As Long
    Dim blue_counter As Integer
    Dim cyan_counter As Integer
    Dim magenta_counter As Integer
    Dim blue_str As String
    Dim cyan_str As String
    Dim magenta_str As String
    Dim SQL_SavePath_Neighbour As String, RS_SavePath_Neighbour As ADODB.Recordset
    Dim SQL_Max As String, RS_Max As ADODB.Recordset
        
        blue_counter = 0
        cyan_counter = 0
        magenta_counter = 0
        
        blue_str = ""
        cyan_str = ""
        magenta_str = ""
    
    i = 1
    
    If frmMain.bln_Save = True Then
        For i = 1 To 2100
            
            If frmMain.pic(i).BackColor = vbBlue Then
                If blue_counter = 0 Then
                    blue_str = i
                    blue_counter = blue_counter + 1
                Else
                    blue_str = blue_str & "," & i
                    blue_counter = blue_counter + 1
                End If
            ElseIf frmMain.pic(i).BackColor = vbCyan Then
                If cyan_counter = 0 Then
                    cyan_str = i
                    cyan_counter = cyan_counter + 1
                Else
                    cyan_str = cyan_str & "," & i
                    cyan_counter = cyan_counter + 1
                End If
            ElseIf frmMain.pic(i).BackColor = vbMagenta Then
                If magenta_counter = 0 Then
                    magenta_str = i
                    magenta_counter = magenta_counter + 1
                Else
                    magenta_str = magenta_str & "," & i
                    magenta_counter = magenta_counter + 1
                End If
            End If
        Next i
    '    MsgBox blue_str
    '    MsgBox cyan_str
        SQL_Max = "Select Max(MID_NO) as MAXIMUM from MachineLearning "
        Set RS_Max = conn.Execute(SQL_Max)
        
        SQL_SavePath_Neighbour = "Update MachineLearning set PathNode ='" & cyan_str & "' ,PathLength= " & cyan_counter & ", NeighbourNode = '" & blue_str & "',ObstaclesNode = '" & magenta_str & "', TotalBlocks = " & magenta_counter & ", TimeByAlgorithm = '" & frmMain.finaltime.Caption & "' where MID_NO = " & RS_Max("MAXIMUM") & ""
        Set RS_SavePath_Neighbour = conn.Execute(SQL_SavePath_Neighbour)
        Dim sql_temp As String, rs_temp As ADODB.Recordset
        sql_temp = "Update Temp set PathNode ='" & cyan_str & "' ,PathLength= " & cyan_counter & ", NeighbourNode = '" & blue_str & "',ObstaclesNode = '" & magenta_str & "', TotalBlocks = " & magenta_counter & ", TimeByAlgorithm = '" & frmMain.finaltime.Caption & "' where MID_NO = " & frmMain.glb_current_midno & ""
        Set rs_temp = conn.Execute(sql_temp)
        MsgBox "Path Learned"
        frmMain.bln_Save = False
    End If


End Sub

