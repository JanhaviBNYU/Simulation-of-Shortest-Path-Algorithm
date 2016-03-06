Attribute VB_Name = "General"
Option Explicit
Public conn As ADODB.Connection
Public rs As ADODB.Recordset
Public strm As ADODB.Stream

Public starttime As String
Public EndTime As String

Private bSingleStep As Boolean
Private bDoSingleStep As Boolean
Private Declare Function GetAsyncKeyState Lib "user32" (ByVal vKey As Long) As Integer
Private Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)


Global XYAllocation(1 To 2100) As General.XYPosition

Public bln_stepbystep As Boolean
Public Algorithm As String
Public HeuristicToImpl As String
Public bln_UltimateExit As Boolean

Public Type XYPosition
    Index As Long 'Node(Pic)
    X As Long 'X-Pos
    Y As Long 'Y-Pos
End Type


Public Type Node
    Parent As Long 'Which node created it
    PX As Long 'X co-ordinate for parent
    PY As Long 'Y co-ordinate for parent
    Child As Long 'Node for which f g h is calculated and x y co-ordinates are stored
    CX As Long 'X value :)
    CY As Long 'Y value :)
    F As Double 'The total result of H + F
    G As Double 'Its score value e.g. 10 = straight and 14 = diagonal
    H As Double 'Its heurstic value
    itsUsed As Boolean 'if the node is in open list value is false and if the node is in closed list value is true
End Type

Public Sub GridInitialization()

    Dim i As Long
    Dim k As Long
    Dim j As Long
    Dim m As Long
    
    m = 1
    k = 1
    For i = 1 To 42
        If i = 0 Then
            'Do Nothing
        End If
    
        For j = 1 To 50
            If m = 2101 Then
                Exit For
            End If
            XYAllocation(m).Index = m
            XYAllocation(m).X = i
            XYAllocation(m).Y = k
            k = k + 1
            m = m + 1
        Next j
        k = 1
    Next i
    
End Sub


Public Function HeuristicSearch(CurrentPoint As Long, DestinationPoint As Long, HeuristicToImpl As String) As Long
Dim CurrentX As Long
Dim targetX As Long

Dim CurrentY As Long
Dim targetY As Long

Dim xDistance As Long
Dim yDistance As Long

Dim H As Long

CurrentX = XYAllocation(CurrentPoint).X
CurrentY = XYAllocation(CurrentPoint).Y

targetX = XYAllocation(DestinationPoint).X
targetY = XYAllocation(DestinationPoint).Y

    Select Case HeuristicToImpl
    Case "Manhattan"
        H = 10 * (Abs(CurrentX - targetX) + Abs(CurrentY - targetY))
    Case "Diagonal"
        xDistance = Abs(CurrentX - targetX)
        yDistance = Abs(CurrentY - targetY)
    
        If xDistance > yDistance Then
            H = 14 * yDistance + 10 * (xDistance - yDistance)
        Else
            H = 14 * xDistance + 10 * (yDistance - xDistance)
        End If
    Case "Euclidean"
        H = (((Abs(CurrentX - targetX) ^ 2) + (Abs(CurrentY - targetY) ^ 2)) ^ 0.5)
        'h(n) = D * sqrt((n.x-goal.x)^2 + (n.y-goal.y)^2)
    Case "Squared Euclidean"
        H = ((Abs(CurrentX - targetX) ^ 2) + (Abs(CurrentY - targetY) ^ 2))
    'h(n) = D * ((n.x-goal.x)^2 + (n.y-goal.y)^2)
    End Select
    HeuristicSearch = H
End Function


Public Sub WaitForKey(ByVal Key As KeyCodeConstants)
    'Get status of key
    'First wait to be pressed
    Do While Not CBool(GetAsyncKeyState(Key) And &H8000) And Not bDoSingleStep
        Sleep 50
        DoEvents
    Loop
    'Then to be released
    Do While CBool(GetAsyncKeyState(Key) And &H8000) And Not bDoSingleStep
        Sleep 50
        DoEvents
    Loop
End Sub


Public Sub WaitForSingleStep()
    bSingleStep = True
    WaitForKey vbKeyF8
    bSingleStep = False
    bDoSingleStep = False
End Sub


Public Sub CenterChildForm(frmChild As Form)

Dim F As Form
Dim frmParent As Form

On Error GoTo NonMDIForm

Set frmParent = Nothing

For Each F In Forms
If F.AutoShowChildren Then 'Only MDI forms have this property
Set frmParent = F
Exit For
End If

NonMDIForm:

Next

On Error GoTo 0

If Not frmParent Is Nothing Then
frmChild.Top = (frmParent.ScaleHeight - frmChild.Height) / 2
frmChild.LEFT = (frmParent.ScaleWidth - frmChild.Width) / 2
End If

End Sub

Public Sub Main()
    'MDIMain.Show
    frmSplash.Show
End Sub

Public Sub cnn(conn As ADODB.Connection)
    Set conn = New ADODB.Connection
    Set rs = New ADODB.Recordset
    Set strm = New ADODB.Stream
    conn.Open "pathfinding"
End Sub
