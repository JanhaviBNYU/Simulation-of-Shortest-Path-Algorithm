Attribute VB_Name = "Dijkstra"
Option Explicit

'For Uni Directional
Global OpenNodeListDJ(1 To 2500) As Node ' Main Open List
Global ClosedNodeListDJ(1 To 2500) As Node 'Main Closed List
Public Temp_HoldCloseNodeDetailsDJ As Node 'Temporary holds the details of the node that is going to be closed
Public OpenNodeList_IncreMentDJ As Long 'Counter
Public ClosedNodeList_IncreMentDJ As Long 'Counter
Public AlreadyInOpenListDJ(1 To 8) As Long

Public StartPointDJ As Long
Public DestinationPointDJ As Long
Public CurrentParentDJ As Long
Public NDJ(1 To 8) As Long
Public PathFoundDJ As Boolean


Public bln_StartPointBlockedDJ As Boolean
Public bln_StartPointBlockedBD As Boolean

Public bln_BreakIfNewG_LessthanPreG As Boolean
Public bln_destnotreach As Boolean


Public Sub GetNeighboursDJ(CurrentParentDJ As Long)
If CurrentParentDJ = 0 Then
    MsgBox "Destination not Reachable", vbOKOnly, "Pathfinding"
    bln_destnotreach = True
    Exit Sub
End If

Dim SourcePoint_IndexDJ As Long
Dim SourcePoint_RowDJ As Long
Dim SourcePoint_ColDJ As Long
Dim Immediate_UPDJ As Long
Dim Immediate_DOWNDJ As Long
Dim Immediate_RIGHTDJ As Long
Dim Immediate_LEFTDJ As Long
Dim Immediate_UP_LEFTDJ As Long
Dim Immediate_UP_RIGHTDJ As Long
Dim Immediate_DOWN_LEFTDJ As Long
Dim Immediate_DOWN_RIGHTDJ As Long

SourcePoint_IndexDJ = CurrentParentDJ
SourcePoint_RowDJ = XYAllocation(CurrentParentDJ).X
SourcePoint_ColDJ = XYAllocation(CurrentParentDJ).Y

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        Immediate_UPDJ = GetIndexDJ(SourcePoint_RowDJ - 1, SourcePoint_ColDJ)
            If frmMain.pic(Immediate_UPDJ).BackColor = vbMagenta Or frmMain.pic(Immediate_UPDJ).BackColor = vbRed Or frmMain.pic(Immediate_UPDJ).BackColor = vbYellow Then
                NDJ(1) = 0
                AlreadyInOpenListDJ(1) = 0
                    
            Else
                If frmMain.pic(Immediate_UPDJ).BackColor = vbBlue Then
                    AlreadyInOpenListDJ(1) = Immediate_UPDJ
                    NDJ(1) = 0
                        
                Else
                    AlreadyInOpenListDJ(1) = 0
                    
                    If frmMain.pic(Immediate_UPDJ).BackColor = vbGreen Then
                        NDJ(1) = Immediate_UPDJ
                    Else
                        frmMain.pic(Immediate_UPDJ).BackColor = vbBlue
                        NDJ(1) = Immediate_UPDJ
                    End If
                    
                End If
            End If
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        Immediate_DOWNDJ = GetIndexDJ(SourcePoint_RowDJ + 1, SourcePoint_ColDJ)
            If frmMain.pic(Immediate_DOWNDJ).BackColor = vbMagenta Or frmMain.pic(Immediate_DOWNDJ).BackColor = vbRed Or frmMain.pic(Immediate_DOWNDJ).BackColor = vbYellow Then
                NDJ(2) = 0
                AlreadyInOpenListDJ(2) = 0
            Else
                If frmMain.pic(Immediate_DOWNDJ).BackColor = vbBlue Then
                    AlreadyInOpenListDJ(2) = Immediate_DOWNDJ
                    NDJ(2) = 0
                Else
                    AlreadyInOpenListDJ(2) = 0
                    
                    If frmMain.pic(Immediate_DOWNDJ).BackColor = vbGreen Then
                        NDJ(2) = Immediate_DOWNDJ
                    Else
                        frmMain.pic(Immediate_DOWNDJ).BackColor = vbBlue
                        NDJ(2) = Immediate_DOWNDJ
                    End If
                End If
            End If
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        Immediate_RIGHTDJ = GetIndexDJ(SourcePoint_RowDJ, SourcePoint_ColDJ + 1)
            If frmMain.pic(Immediate_RIGHTDJ).BackColor = vbMagenta Or frmMain.pic(Immediate_RIGHTDJ).BackColor = vbRed Or frmMain.pic(Immediate_RIGHTDJ).BackColor = vbYellow Then
                NDJ(3) = 0
                AlreadyInOpenListDJ(3) = 0
            Else
                If frmMain.pic(Immediate_RIGHTDJ).BackColor = vbBlue Then
                   AlreadyInOpenListDJ(3) = Immediate_RIGHTDJ
                   NDJ(3) = 0
                Else
                    AlreadyInOpenListDJ(3) = 0
                    If frmMain.pic(Immediate_RIGHTDJ).BackColor = vbGreen Then
                        NDJ(3) = Immediate_RIGHTDJ
                    Else
                        frmMain.pic(Immediate_RIGHTDJ).BackColor = vbBlue
                        NDJ(3) = Immediate_RIGHTDJ
                    End If
                End If
            End If
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        Immediate_LEFTDJ = GetIndexDJ(SourcePoint_RowDJ, SourcePoint_ColDJ - 1)
            If frmMain.pic(Immediate_LEFTDJ).BackColor = vbMagenta Or frmMain.pic(Immediate_LEFTDJ).BackColor = vbRed Or frmMain.pic(Immediate_LEFTDJ).BackColor = vbYellow Then
                NDJ(4) = 0
                AlreadyInOpenListDJ(4) = 0
            Else
                If frmMain.pic(Immediate_LEFTDJ).BackColor = vbBlue Then
                     AlreadyInOpenListDJ(4) = Immediate_LEFTDJ
                     NDJ(4) = 0
                Else
                    AlreadyInOpenListDJ(4) = 0
                    If frmMain.pic(Immediate_LEFTDJ).BackColor = vbGreen Then
                        
                        NDJ(4) = Immediate_LEFTDJ
                    Else
                        frmMain.pic(Immediate_LEFTDJ).BackColor = vbBlue
                        NDJ(4) = Immediate_LEFTDJ
                    End If
                End If
            End If
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        Immediate_UP_LEFTDJ = GetIndexDJ(SourcePoint_RowDJ - 1, SourcePoint_ColDJ - 1)
            If frmMain.pic(Immediate_UP_LEFTDJ).BackColor = vbMagenta Or frmMain.pic(Immediate_UP_LEFTDJ).BackColor = vbRed Or frmMain.pic(Immediate_UP_LEFTDJ).BackColor = vbYellow Then
                NDJ(5) = 0
                 AlreadyInOpenListDJ(5) = 0
            Else
                If frmMain.pic(Immediate_UP_LEFTDJ).BackColor = vbBlue Then
                     AlreadyInOpenListDJ(5) = Immediate_UP_LEFTDJ
                     NDJ(5) = 0
                Else
                    AlreadyInOpenListDJ(5) = 0
                    
                    If frmMain.pic(Immediate_UP_LEFTDJ).BackColor = vbGreen Then
                        NDJ(5) = Immediate_UP_LEFTDJ
                    Else
                        frmMain.pic(Immediate_UP_LEFTDJ).BackColor = vbBlue
                        NDJ(5) = Immediate_UP_LEFTDJ
                    End If
                End If
             End If
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        Immediate_UP_RIGHTDJ = GetIndexDJ(SourcePoint_RowDJ - 1, SourcePoint_ColDJ + 1)
            If frmMain.pic(Immediate_UP_RIGHTDJ).BackColor = vbMagenta Or frmMain.pic(Immediate_UP_RIGHTDJ).BackColor = vbRed Or frmMain.pic(Immediate_UP_RIGHTDJ).BackColor = vbYellow Then
                NDJ(6) = 0
                AlreadyInOpenListDJ(6) = 0
            Else
                If frmMain.pic(Immediate_UP_RIGHTDJ).BackColor = vbBlue Then
                    AlreadyInOpenListDJ(6) = Immediate_UP_RIGHTDJ
                    NDJ(6) = 0
                Else
                    AlreadyInOpenListDJ(6) = 0
                    
                    If frmMain.pic(Immediate_UP_RIGHTDJ).BackColor = vbGreen Then
                        
                        NDJ(6) = Immediate_UP_RIGHTDJ
                    Else
                        frmMain.pic(Immediate_UP_RIGHTDJ).BackColor = vbBlue
                        NDJ(6) = Immediate_UP_RIGHTDJ
                    End If
                End If
            End If
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        Immediate_DOWN_LEFTDJ = GetIndexDJ(SourcePoint_RowDJ + 1, SourcePoint_ColDJ - 1)
            If frmMain.pic(Immediate_DOWN_LEFTDJ).BackColor = vbMagenta Or frmMain.pic(Immediate_DOWN_LEFTDJ).BackColor = vbRed Or frmMain.pic(Immediate_DOWN_LEFTDJ).BackColor = vbYellow Then
                NDJ(7) = 0
                AlreadyInOpenListDJ(7) = 0
            Else
                If frmMain.pic(Immediate_DOWN_LEFTDJ).BackColor = vbBlue Then
                    AlreadyInOpenListDJ(7) = Immediate_DOWN_LEFTDJ
                    NDJ(7) = 0
                Else
                    AlreadyInOpenListDJ(7) = 0
                    If frmMain.pic(Immediate_DOWN_LEFTDJ).BackColor = vbGreen Then
                        
                        NDJ(7) = Immediate_DOWN_LEFTDJ
                    Else
                        frmMain.pic(Immediate_DOWN_LEFTDJ).BackColor = vbBlue
                        NDJ(7) = Immediate_DOWN_LEFTDJ
                    End If
                End If
            End If
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        Immediate_DOWN_RIGHTDJ = GetIndexDJ(SourcePoint_RowDJ + 1, SourcePoint_ColDJ + 1)
            If frmMain.pic(Immediate_DOWN_RIGHTDJ).BackColor = vbMagenta Or frmMain.pic(Immediate_DOWN_RIGHTDJ).BackColor = vbRed Or frmMain.pic(Immediate_DOWN_RIGHTDJ).BackColor = vbYellow Then
                NDJ(8) = 0
                AlreadyInOpenListDJ(8) = 0
            Else
                If frmMain.pic(Immediate_DOWN_RIGHTDJ).BackColor = vbBlue Then
                    AlreadyInOpenListDJ(8) = Immediate_DOWN_RIGHTDJ
                    NDJ(8) = 0
                Else
                    AlreadyInOpenListDJ(8) = 0
                    
                    If frmMain.pic(Immediate_DOWN_RIGHTDJ).BackColor = vbGreen Then
                        NDJ(8) = Immediate_DOWN_RIGHTDJ
                    Else
                        frmMain.pic(Immediate_DOWN_RIGHTDJ).BackColor = vbBlue
                        NDJ(8) = Immediate_DOWN_RIGHTDJ
                    End If
                End If
            End If
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
End Sub


Public Function GetIndexDJ(ByVal X As Long, ByVal Y As Long) As Long

Dim i As Long
    For i = 1 To 2100
            If X = XYAllocation(i).X And Y = XYAllocation(i).Y Then
                GetIndexDJ = i
                Exit Function
            End If
  Next i
End Function

Public Function AddToOpenListDJ(ByVal Parent As Long, ByVal PX As Long, ByVal PY As Long, ByVal Child As Long, ByVal CX As Long, ByVal CY As Long, ByVal G As Double, ByVal H As Double, ByVal F As Double, ByVal bln_Check As Boolean)
    OpenNodeList_IncreMentDJ = OpenNodeList_IncreMentDJ + 1
    OpenNodeListDJ(OpenNodeList_IncreMentDJ).Parent = Parent
    OpenNodeListDJ(OpenNodeList_IncreMentDJ).PX = PX
    OpenNodeListDJ(OpenNodeList_IncreMentDJ).PY = PY
    OpenNodeListDJ(OpenNodeList_IncreMentDJ).Child = Child
    OpenNodeListDJ(OpenNodeList_IncreMentDJ).CX = CX
    OpenNodeListDJ(OpenNodeList_IncreMentDJ).CY = CY
    OpenNodeListDJ(OpenNodeList_IncreMentDJ).G = G
    OpenNodeListDJ(OpenNodeList_IncreMentDJ).H = 0
    OpenNodeListDJ(OpenNodeList_IncreMentDJ).F = F
    OpenNodeListDJ(OpenNodeList_IncreMentDJ).itsUsed = bln_Check
End Function


Public Function AddToClosedListDJ(CloseNode As Node)
    ClosedNodeList_IncreMentDJ = ClosedNodeList_IncreMentDJ + 1
    ClosedNodeListDJ(ClosedNodeList_IncreMentDJ).Parent = CloseNode.Parent
    ClosedNodeListDJ(ClosedNodeList_IncreMentDJ).PX = CloseNode.PX
    ClosedNodeListDJ(ClosedNodeList_IncreMentDJ).PY = CloseNode.PY
    
    ClosedNodeListDJ(ClosedNodeList_IncreMentDJ).Child = CloseNode.Child
    ClosedNodeListDJ(ClosedNodeList_IncreMentDJ).CX = CloseNode.CX
    ClosedNodeListDJ(ClosedNodeList_IncreMentDJ).CY = CloseNode.CY
    ClosedNodeListDJ(ClosedNodeList_IncreMentDJ).F = CloseNode.F
    ClosedNodeListDJ(ClosedNodeList_IncreMentDJ).G = CloseNode.G
    ClosedNodeListDJ(ClosedNodeList_IncreMentDJ).H = 0
    ClosedNodeListDJ(ClosedNodeList_IncreMentDJ).itsUsed = True
    
    Dim i As Long

    For i = 1 To 2100
        If OpenNodeListDJ(i).Parent = CloseNode.Parent And OpenNodeListDJ(i).Child = CloseNode.Child And OpenNodeListDJ(i).CX = CloseNode.CX And OpenNodeListDJ(i).CY = CloseNode.CY Then
            OpenNodeListDJ(i).itsUsed = True
            Exit Function
        End If
    Next i
End Function

Public Sub AddToCloseDJ(CurrentParent As Long)
If CurrentParent = 0 Then
    MsgBox "Destination Not Reachable"
    Exit Sub
End If
    Dim i As Long
    Dim temp As Long
    For i = 1 To OpenNodeList_IncreMentDJ
        If OpenNodeListDJ(i).Child = CurrentParent And OpenNodeListDJ(i).CX = XYAllocation(CurrentParent).X And OpenNodeListDJ(i).CY = XYAllocation(CurrentParent).Y Then
            temp = i
            Exit For
        End If
    Next i
    Temp_HoldCloseNodeDetailsDJ.Parent = OpenNodeListDJ(temp).Parent
    Temp_HoldCloseNodeDetailsDJ.PX = OpenNodeListDJ(temp).PX
    Temp_HoldCloseNodeDetailsDJ.PY = OpenNodeListDJ(temp).PY
    Temp_HoldCloseNodeDetailsDJ.Child = OpenNodeListDJ(temp).Child
    Temp_HoldCloseNodeDetailsDJ.CX = OpenNodeListDJ(temp).CX
    Temp_HoldCloseNodeDetailsDJ.CY = OpenNodeListDJ(temp).CY
    Temp_HoldCloseNodeDetailsDJ.F = OpenNodeListDJ(temp).F
    Temp_HoldCloseNodeDetailsDJ.G = OpenNodeListDJ(temp).G
    Temp_HoldCloseNodeDetailsDJ.H = OpenNodeListDJ(temp).H
    Call AddToClosedListDJ(Temp_HoldCloseNodeDetailsDJ)
End Sub


Public Function CalculateGDJ(Parent As Long, PX As Long, PY As Long, Child As Long, CX As Long, CY As Long, Pos As Long) As Double
Dim Cost As Double
    If Pos = 0 Then
        CalculateGDJ = 0
    ElseIf Pos = 1 Or Pos = 2 Or Pos = 3 Or Pos = 4 Then
        Cost = GetParentG_CostDJ(Parent, PX, PY)
        Cost = Cost + 10
       ' Cost = 10
    ElseIf Pos = 5 Or Pos = 6 Or Pos = 7 Or Pos = 8 Then
        Cost = GetParentG_CostDJ(Parent, PX, PY)
        Cost = Cost + 14
        'Cost = 14
    End If
    CalculateGDJ = Cost
End Function

Public Function GetParentG_CostDJ(Parent As Long, PX As Long, PY As Long) As Double
    Dim i As Long
    Dim temp_g As Double
    
    For i = 1 To 2100
        If OpenNodeListDJ(i).Child = Parent And OpenNodeListDJ(i).CX = PX And OpenNodeListDJ(i).CY = PY Then
            If OpenNodeListDJ(i).Parent = Parent And OpenNodeListDJ(i).PX = PX And OpenNodeListDJ(i).PY = PY Then
                temp_g = OpenNodeListDJ(i).G
                Exit For
            Else
                'temp_g = GetParentG_Cost(OpenList(i).Parent, OpenList(i).PX, OpenList(i).PY) + OpenList(i).G
                temp_g = OpenNodeListDJ(i).G
                Exit For
            End If
        End If
    Next i
    GetParentG_CostDJ = temp_g
End Function


Public Function SelectLowestFDJ(Current_Parent As Long) As Double
    Dim i As Long
    Dim temp_f As Double
    Dim temp_i As Long
    Dim temp_node As Long
    Dim incre As Long
    
    temp_f = 0
    temp_i = 0
    
    incre = 1
    For i = 1 To OpenNodeList_IncreMentDJ
        If OpenNodeListDJ(i).Parent = Current_Parent And OpenNodeListDJ(i).itsUsed <> True Then
        
             If incre = 1 Then
                temp_f = OpenNodeListDJ(i).F
                temp_i = i
                temp_node = OpenNodeListDJ(i).Child
                incre = incre + 1
             Else
                If temp_f >= OpenNodeListDJ(i).F Then
                    temp_f = OpenNodeListDJ(i).F
                    temp_i = i
                    temp_node = OpenNodeListDJ(i).Child
                End If
             End If
        End If
    Next i
    If temp_node = DestinationPointDJ Then
        MsgBox "Path Found"
        PathFoundDJ = True
        Call BackTrackDJ
        Call SavePath
        SelectLowestFDJ = temp_node
        Exit Function
    Else
        frmMain.pic(temp_node).BackColor = vbYellow
        SelectLowestFDJ = temp_node
        
    End If
End Function


Public Sub AddToOpenDJ()

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
                If NDJ(i) = 0 And AlreadyInOpenListDJ(i) <> 0 Then
                    For j = 1 To 2100
                       ' If (OpenNodeListDJ(j).Child = AlreadyInOpenListDJ(i) Or OpenNodeListDJ(j).Parent = AlreadyInOpenListDJ(i)) And OpenNodeListDJ(j).itsUsed = False Then
                       ' If OpenNodeListDJ(j).Child = AlreadyInOpenListDJ(i) And OpenNodeListDJ(j).itsUsed = False Then
                           ' MsgBox "got"
                        If OpenNodeListDJ(j).itsUsed = False Then
                            If OpenNodeListDJ(j).Child = AlreadyInOpenListDJ(i) Or OpenNodeListDJ(j).Parent = AlreadyInOpenListDJ(i) Then
                                temp = j
                                Exit For
                            End If
                        End If
                    Next j
                            'Calculate New F G H values
                            A_Parent = CurrentParentDJ
                            A_PX = XYAllocation(CurrentParentDJ).X
                            A_PY = XYAllocation(CurrentParentDJ).Y
                            A_Child = AlreadyInOpenListDJ(i)
                            A_CX = XYAllocation(AlreadyInOpenListDJ(i)).X
                            A_CY = XYAllocation(AlreadyInOpenListDJ(i)).Y

                            A_G = CalculateGDJ(A_Parent, A_PX, A_PY, A_Child, A_CX, A_CY, i)
                            A_H = 0
                            A_F = A_G + A_H

                            If temp <> 0 Then
                                PreParent = OpenNodeListDJ(temp).Parent
                                PrePX = OpenNodeListDJ(temp).PX
                                PrePY = OpenNodeListDJ(temp).PY
                                PreChild = OpenNodeListDJ(temp).Child
                                PreCX = OpenNodeListDJ(temp).CX
                                PreCY = OpenNodeListDJ(temp).CY
                                PreF = OpenNodeListDJ(temp).F
                                PreG = OpenNodeListDJ(temp).G
                                PreH = OpenNodeListDJ(temp).H
    
                                If A_G < PreG Then
                                    OpenNodeListDJ(temp).Parent = A_Parent
                                    OpenNodeListDJ(temp).PX = A_PX
                                    OpenNodeListDJ(temp).PY = A_PY
                                    OpenNodeListDJ(temp).Child = A_Child
                                    OpenNodeListDJ(temp).CX = A_CX
                                    OpenNodeListDJ(temp).CY = A_CY
                                    OpenNodeListDJ(temp).F = A_F
                                    OpenNodeListDJ(temp).G = A_G
                                    OpenNodeListDJ(temp).H = 0
    
                                    CurrentParentDJ = A_Child
                                    frmMain.pic(CurrentParentDJ).BackColor = vbYellow
                                    AddToCloseDJ (CurrentParentDJ)
                                    bln_BreakIfNewG_LessthanPreG = True
                                    Exit Sub
                                End If
                            End If
                ElseIf NDJ(i) <> 0 Then
                    A_Parent = CurrentParentDJ
                    A_PX = XYAllocation(CurrentParentDJ).X
                    A_PY = XYAllocation(CurrentParentDJ).Y
                    A_Child = NDJ(i)
                    A_CX = XYAllocation(NDJ(i)).X
                    A_CY = XYAllocation(NDJ(i)).Y

                    A_G = CalculateGDJ(A_Parent, A_PX, A_PY, A_Child, A_CX, A_CY, i)
                    A_H = 0
                    A_F = A_G + A_H
                    Call AddToOpenListDJ(A_Parent, A_PX, A_PY, A_Child, A_CX, A_CY, A_G, A_H, A_F, False)
                End If
            Next i

End Sub


Public Sub Dijkstra_DJ()
PathFoundDJ = False
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
bln_StartPointBlockedDJ = False
bln_BreakIfNewG_LessthanPreG = False
bln_destnotreach = False
''check = False

    StartPointDJ = FindStartPointDJ("Red")
    DestinationPointDJ = FindEndPointDJ
    
    'HeuristicToImpl = Heuristic
    CurrentParentDJ = StartPointDJ
    
    Call CheckStartSourceDJ(StartPointDJ)
    If bln_StartPointBlockedDJ = True Then
        Exit Sub
    End If
    
    
'1.> Begin At Starting Point A add it to Open List
          
        A_Parent = CurrentParentDJ
        A_PX = XYAllocation(CurrentParentDJ).X
        A_PY = XYAllocation(CurrentParentDJ).Y
        
        A_Child = A_Parent
        A_CX = A_PX
        A_CY = A_PY
        
        A_G = CalculateGDJ(A_Parent, A_PX, A_PY, A_Child, A_CX, A_CY, 0)
        A_H = 0
        A_F = A_G + A_H
        Call AddToOpenListDJ(A_Parent, A_PX, A_PY, A_Child, A_CX, A_CY, A_G, A_H, A_F, False)
        
        'Call DisplayTreeViewData
'2.> Look Reachable Squares add them to open list and save Current_Parent as Ther Parent
        Call GetNeighboursDJ(CurrentParentDJ)
        If bln_stepbystep = True Then
            Call WaitForSingleStep
        End If
        Call AddToOpenDJ
        'Call DisplayTreeViewData
'3.> Drop The Starting Square From the open list and add it to closed list
        Call AddToCloseDJ(CurrentParentDJ)
        'Call DisplayTreeViewData
        'To continue we simply choose the F square with lowest F value
        CurrentParentDJ = SelectLowestFDJ(CurrentParentDJ)
'4.> Drop the Lowest F from Open List to Closed List
        Call AddToCloseDJ(CurrentParentDJ)
        If PathFoundDJ = True Then
            Exit Sub
        End If
'5.> Check all the adjacent square ignoring that are in the closed list,add squares if ther are not in open list make this selected parent
        While (1)
Start:
            Call GetNeighboursDJ(CurrentParentDJ)
            If bln_destnotreach = True Then
                Exit Sub
            End If
            If bln_stepbystep = True Then
                Call WaitForSingleStep
            End If
            Call AddToOpenDJ
            
'''            If check = False Then
'''                CurrentParentDJ = SelectLowestFDJ_LastOption
'''                GoTo START:
'''            End If
            If bln_BreakIfNewG_LessthanPreG = True Then
                bln_BreakIfNewG_LessthanPreG = False
                GoTo Start:
            End If
            
            CurrentParentDJ = SelectLowestFDJ(CurrentParentDJ)
         
            If PathFoundDJ = True Then
                Call DisplayTreeViewData
                Exit Sub
            End If
            'Call DisplayTreeViewData
            
            
            If CurrentParentDJ = 0 Then
                CurrentParentDJ = SelectLowestFDJ_LastOption
                frmMain.pic(CurrentParentDJ).BackColor = vbYellow
                Call AddToCloseDJ(CurrentParentDJ)
                GoTo Start:
                'MsgBox "Not Getting the Path"
                'Exit Sub
            Else
                Call AddToCloseDJ(CurrentParentDJ)
            End If
GoTo Start:
           
        Wend
'6.>
End Sub


Public Function FindStartPointDJ(Colour As String) As Long
Dim i As Long

    If Colour = "Red" Then
        For i = 1 To 2100
            If frmMain.pic(i).BackColor = vbRed Then
                FindStartPointDJ = i
            End If
        Next i
    End If
End Function

Public Function FindEndPointDJ()
Dim i As Long

    
        For i = 1 To 2100
            If frmMain.pic(i).BackColor = vbGreen Then
                FindEndPointDJ = i
            End If
        Next i
    
End Function


Public Function SelectLowestFDJ_LastOption() As Double
    Dim i As Long
    Dim temp_f As Double
    Dim temp_i As Long
    Dim temp_node As Long
    Dim incre As Long
    
    temp_f = 0
    temp_i = 0
    
    incre = 1
    For i = 1 To OpenNodeList_IncreMentDJ
        If OpenNodeListDJ(i).itsUsed <> True Then
        
             If incre = 1 Then
                temp_f = OpenNodeListDJ(i).F
                temp_i = i
                temp_node = OpenNodeListDJ(i).Child
                incre = incre + 1
             Else
                If temp_f > OpenNodeListDJ(i).F Then
                    temp_f = OpenNodeListDJ(i).F
                    temp_i = i
                    temp_node = OpenNodeListDJ(i).Child
                End If
             End If
        End If
    Next i
    If temp_node = DestinationPointDJ Then
        MsgBox "Path Found"
        PathFoundDJ = True
        Call BackTrackDJ
        Call SavePath
        SelectLowestFDJ_LastOption = temp_node
        Exit Function
    Else
        frmMain.pic(temp_node).BackColor = vbYellow
        SelectLowestFDJ_LastOption = temp_node
        
    End If
End Function


Public Sub BackTrackDJ()
    Dim EndNode As Long
    Dim EndNodeX As Long
    Dim EndNodeY As Long
    
    EndNode = FindEndPointDJ
    EndNodeX = XYAllocation(EndNode).X
    EndNodeY = XYAllocation(EndNode).Y
    
    Dim StartNode As Long
    StartNode = FindStartPointDJ("Red")
    
    Dim bln_backtrack As Boolean
    bln_backtrack = False
    Dim Immediate_UPDJ As Long
    Dim Immediate_DOWNDJ As Long
    Dim Immediate_RIGHTDJ As Long
    Dim Immediate_LEFTDJ As Long
    Dim Immediate_UP_LEFTDJ As Long
    Dim Immediate_UP_RIGHTDJ  As Long
    Dim Immediate_DOWN_LEFTDJ As Long
    Dim Immediate_DOWN_RIGHTDJ As Long
    
    Immediate_UPDJ = GetIndexDJ(EndNodeX - 1, EndNodeY)
    Immediate_DOWNDJ = GetIndexDJ(EndNodeX + 1, EndNodeY)
    Immediate_RIGHTDJ = GetIndexDJ(EndNodeX, EndNodeY + 1)
    Immediate_LEFTDJ = GetIndexDJ(EndNodeX, EndNodeY - 1)
    Immediate_UP_LEFTDJ = GetIndexDJ(EndNodeX - 1, EndNodeY - 1)
    Immediate_UP_RIGHTDJ = GetIndexDJ(EndNodeX - 1, EndNodeY + 1)
    Immediate_DOWN_LEFTDJ = GetIndexDJ(EndNodeX + 1, EndNodeY - 1)
    Immediate_DOWN_RIGHTDJ = GetIndexDJ(EndNodeX + 1, EndNodeY + 1)
    
    Dim temp As Long
    
    If Immediate_UPDJ = 0 Then
    ElseIf frmMain.pic(Immediate_UPDJ).BackColor = vbYellow Then
        temp = Immediate_UPDJ
    End If
    
    If Immediate_DOWNDJ = 0 Then
    ElseIf frmMain.pic(Immediate_DOWNDJ).BackColor = vbYellow Then
        temp = Immediate_DOWNDJ
    End If
    
    If Immediate_RIGHTDJ = 0 Then
    ElseIf frmMain.pic(Immediate_RIGHTDJ).BackColor = vbYellow Then
        temp = Immediate_RIGHTDJ
    End If
    
    If Immediate_LEFTDJ = 0 Then
    ElseIf frmMain.pic(Immediate_LEFTDJ).BackColor = vbYellow Then
        temp = Immediate_LEFTDJ
    End If
    
    If Immediate_UP_LEFTDJ = 0 Then
    ElseIf frmMain.pic(Immediate_UP_LEFTDJ).BackColor = vbYellow Then
        temp = Immediate_UP_LEFTDJ
    End If
    
    If Immediate_UP_RIGHTDJ = 0 Then
    ElseIf frmMain.pic(Immediate_UP_RIGHTDJ).BackColor = vbYellow Then
        temp = Immediate_UP_RIGHTDJ
    End If
    
    If Immediate_DOWN_LEFTDJ = 0 Then
    ElseIf frmMain.pic(Immediate_DOWN_LEFTDJ).BackColor = vbYellow Then
        temp = Immediate_DOWN_LEFTDJ
    End If
    
    If Immediate_DOWN_RIGHTDJ = 0 Then
    ElseIf frmMain.pic(Immediate_DOWN_RIGHTDJ).BackColor = vbYellow Then
        temp = Immediate_DOWN_RIGHTDJ
    End If
    
    Dim i As Long
    Dim nexttemp As Long
BACK:
    For i = ClosedNodeList_IncreMentDJ To 1 Step -1
        If ClosedNodeListDJ(i).Child = StartNode Then
            bln_backtrack = True
            Exit For
        Else
            If ClosedNodeListDJ(i).Child = temp Then
                frmMain.pic(temp).BackColor = vbCyan
                nexttemp = ClosedNodeListDJ(i).Parent
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


Public Sub CheckStartSourceDJ(StartPoint As Long)
    Dim StartPointX As Long
    Dim StartPointY As Long
    StartPointX = XYAllocation(StartPoint).X
    StartPointY = XYAllocation(StartPoint).Y
    
    Dim Immediate_UPDJ As Long
    Dim Immediate_DOWNDJ As Long
    Dim Immediate_RIGHTDJ As Long
    Dim Immediate_LEFTDJ As Long
    Dim Immediate_UP_LEFTDJ As Long
    Dim Immediate_UP_RIGHTDJ As Long
    Dim Immediate_DOWN_LEFTDJ As Long
    Dim Immediate_DOWN_RIGHTDJ As Long
    
    Immediate_UPDJ = GetIndexDJ(StartPointX - 1, StartPointY)
    Immediate_DOWNDJ = GetIndexDJ(StartPointX + 1, StartPointY)
    Immediate_RIGHTDJ = GetIndexDJ(StartPointX, StartPointY + 1)
    Immediate_LEFTDJ = GetIndexDJ(StartPointX, StartPointY - 1)
    Immediate_UP_LEFTDJ = GetIndexDJ(StartPointX - 1, StartPointY - 1)
    Immediate_UP_RIGHTDJ = GetIndexDJ(StartPointX - 1, StartPointY + 1)
    Immediate_DOWN_LEFTDJ = GetIndexDJ(StartPointX + 1, StartPointY - 1)
    Immediate_DOWN_RIGHTDJ = GetIndexDJ(StartPointX + 1, StartPointY + 1)
    
    
    
    If frmMain.pic(Immediate_UPDJ).BackColor = vbMagenta And frmMain.pic(Immediate_DOWNDJ).BackColor = vbMagenta And frmMain.pic(Immediate_RIGHTDJ).BackColor = vbMagenta And frmMain.pic(Immediate_LEFTDJ).BackColor = vbMagenta And frmMain.pic(Immediate_UP_LEFTDJ).BackColor = vbMagenta And frmMain.pic(Immediate_UP_RIGHTDJ).BackColor = vbMagenta And frmMain.pic(Immediate_DOWN_LEFTDJ).BackColor = vbMagenta And frmMain.pic(Immediate_DOWN_RIGHTDJ).BackColor = vbMagenta Then
        bln_StartPointBlockedDJ = True
    Else
        bln_StartPointBlockedDJ = False
    End If
End Sub

