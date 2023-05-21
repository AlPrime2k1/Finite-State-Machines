regression:
	vlog -coveropt 3 +cover +acc vending_machine.v vending_mac_tb_with_coverage.v  
	
	vsim -coverage -vopt work.vending_mac_tb_with_coverage -c -do "coverage save -onexit -directive -codeAll ven1m.ucdb;run -all" +IDLEtoRS2toCHANGE

	vsim -coverage -vopt work.vending_mac_tb_with_coverage -c -do "coverage save -onexit -directive -codeAll ven2m.ucdb;run -all" +IDLEtoRS2toPRODUCT

	vsim -coverage -vopt work.vending_mac_tb_with_coverage -c -do "coverage save -onexit -directive -codeAll ven3m.ucdb;run -all" +IDLEtoRS1toPRODUCT

	vsim -coverage -vopt work.vending_mac_tb_with_coverage -c -do "coverage save -onexit -directive -codeAll ven4m.ucdb;run -all" +IDLEtoRS1toRS2toPRODUCT

	vsim -coverage -vopt work.vending_mac_tb_with_coverage -c -do "coverage save -onexit -directive -codeAll ven5m.ucdb;run -all" +IDLEtoRS1toRS2toCHANGE

	vsim -coverage -vopt work.vending_mac_tb_with_coverage -c -do "coverage save -onexit -directive -codeAll ven6m.ucdb;run -all" +TIMEOUTRS1

	vsim -coverage -vopt work.vending_mac_tb_with_coverage -c -do "coverage save -onexit -directive -codeAll ven7m.ucdb;run -all" +TIMEOUTRS2

	vcover merge COVERAGE.ucdb ven1m.ucdb ven2m.ucdb ven3m.ucdb ven4m.ucdb ven5m.ucdb ven6m.ucdb ven7m.ucdb

	vcover report -html -htmldir COVERAGE_FOLDER COVERAGE.ucdb


