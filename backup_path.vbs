' VBScript to select a default backup folder
Set objShell = CreateObject("Shell.Application")
Set selectedFolder = objShell.BrowseForFolder(0, WScript.Arguments(0), 0, 17)
If Not selectedFolder Is Nothing Then
    WScript.Echo selectedFolder.Self.Path
End If
