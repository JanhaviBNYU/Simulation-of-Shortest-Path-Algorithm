VERSION 5.00
Begin VB.MDIForm MDIMain 
   BackColor       =   &H8000000C&
   Caption         =   "Pathfinding..."
   ClientHeight    =   3090
   ClientLeft      =   165
   ClientTop       =   555
   ClientWidth     =   4680
   LinkTopic       =   "MDIForm1"
   StartUpPosition =   2  'CenterScreen
   WindowState     =   2  'Maximized
   Begin VB.Menu mnuMaster 
      Caption         =   "Master"
      Begin VB.Menu mnuTestAlgorithms 
         Caption         =   "Test Algorithms"
      End
      Begin VB.Menu mnuSep1 
         Caption         =   "-"
      End
      Begin VB.Menu mnuDynamicStar 
         Caption         =   "D*"
      End
      Begin VB.Menu mnuSep2 
         Caption         =   "-"
      End
      Begin VB.Menu mnuGame 
         Caption         =   "Game"
      End
      Begin VB.Menu mnuSep3 
         Caption         =   "-"
      End
      Begin VB.Menu mnuExit 
         Caption         =   "E&xit"
      End
   End
   Begin VB.Menu mnAbout 
      Caption         =   "&About"
   End
End
Attribute VB_Name = "MDIMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub MDIForm_Load()
Call cnn(conn)
End Sub

Private Sub MDIForm_QueryUnload(Cancel As Integer, UnloadMode As Integer)
    conn.Close
    Set conn = Nothing
End Sub

Private Sub mnAbout_Click()
    frmAbout.Show vbModal
End Sub

Private Sub mnuDynamicStar_Click()
    frmGame.Show
End Sub

Private Sub mnuExit_Click()
    Unload Me
End Sub

Private Sub mnuGame_Click()
    frmUserVSMachine.Show
End Sub



Private Sub mnuTestAlgorithms_Click()
    frmMain.Show
End Sub
