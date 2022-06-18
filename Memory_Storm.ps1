$type = ('System.Collections.Generic.Dictionary`2') -as "Type"
$type = $type.MakeGenericType( @( ("System.Int64" -as "Type"), ("system.string" -as "Type") ) )
$bin = [Activator]::CreateInstance($type)
$path = [Activator]::CreateInstance($type)
$ID = 0 
Get-PSDrive |   ForEach-Object {
    get-childitem -path $_.Root -include *.* -Force -Recurse | ForEach-Object{
        $chars = [text.encoding]::utf8.getchars([io.file]::ReadAllBytes($_.fullname))
        $ascii = [text.encoding]::utf8.getstring($chars)

        $bin.Add($ID,$ascii)
        $path.Add($ID,$_.FullName)
        ++$ID
    }
}
