proc findFiles { basedir pattern } {

    set basedir [string trimright [file join [file normalize $basedir] { }]]
    set fileList {}
	
    foreach fileName [glob -nocomplain -type {f r} -path $basedir $pattern] {
        lappend fileList $fileName
    }	
	
    foreach dirName [glob -nocomplain -type {d  r} -path $basedir *] {
        set subDirList [findFiles $dirName $pattern]
        if { [llength $subDirList] > 0 } {
            foreach subDirFile $subDirList {
		lappend fileList $subDirFile
            }
        }
    }
    return $fileList
}
set TclPath [file dirname [file normalize [info script]]]
puts $TclPath
#set NewLoc [string range $TclPath 0 [string last / $TclPath]]
#puts $NewLoc
set PartDev "xcvu19p-fsva3824-2-e"
set PrjDir $TclPath/vivado_prj_auto
puts $PrjDir
file mkdir $PrjDir
#[string range $TclPath 0 [string last / $TclPath]]
puts $PrjDir
set TopName [string range $TclPath [string last / $TclPath]+1 end]
puts $TopName
set PrjName $TopName.xpr
set SrcDir  $TclPath/src
puts $SrcDir
set VivNm "vivado"
set VivDir $PrjDir
puts $VivDir
set top_prefix _top
#
file mkdir $PrjDir/$TopName
cd $PrjDir/$TopName
pwd

set SrcVer [findFiles $SrcDir "*.sv"]
puts $SrcVer
create_project -force $TopName $VivDir -part $PartDev
set_property target_language Verilog [current_project]
add_files $SrcVer
set_property top "$TopName$top_prefix" [current_fileset]
set_property strategy Flow_PerfOptimized_high [get_runs synth_1]
set_property strategy Performance_ExtraTimingOpt [get_runs impl_1]

launch_runs synth_1
wait_on_run synth_1
open_run synth_1 -name synth_1
#launch_runs impl_1 -to_step write_bitstream
#wait_on_run impl_1

#create_run -flow {Vivado Synthesis 2022} synth_2
#launch_runs synth_2
#route_design
#generate_ml_strategies [get_runs impl_1] -force
exit