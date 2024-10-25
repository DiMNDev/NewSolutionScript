param (
    $name
)

$ConsoleProj = $name + ".Console"
$ClasslibProj = $name + ".Classlib"
$xUnitProj = $name + ".Tests"
$blazorProj = $name + ".Blazor"

dotnet new sln -o $name

Set-Location $name

git init

dotnet new gitignore

dotnet new console -n $ConsoleProj

dotnet new classlib -n $ClasslibProj

dotnet new xunit -n $xUnitProj

dotnet new blazor -ai -e -n $blazorProj

dotnet add $ConsoleProj reference $ClasslibProj
dotnet add $xUnitProj reference $ClasslibProj
dotnet add $blazorProj reference $ClasslibProj

dir -Directory | ForEach-Object {
    dotnet sln add $_
}

cd $xUnitProj
dotnet add package FluentAssertions
cd ../

git init
git add --all
git commit -m "Initial Project Creation"
code .