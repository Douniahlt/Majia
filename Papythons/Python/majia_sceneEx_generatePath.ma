//Maya ASCII 2024 scene
//Name: majia_sceneEx_generatePath.ma
//Last modified: Tue, Nov 18, 2025 04:28:34 PM
//Codeset: 1252
requires maya "2024";
requires -nodeType "aiOptions" -nodeType "aiAOVDriver" -nodeType "aiAOVFilter" "mtoa" "5.3.4.1";
requires -nodeType "mayaUsdLayerManager" -dataType "pxrUsdStageData" "mayaUsdPlugin" "0.25.0";
currentUnit -l centimeter -a degree -t film;
fileInfo "application" "maya";
fileInfo "product" "Maya 2024";
fileInfo "version" "2024";
fileInfo "cutIdentifier" "202310181224-69282f2959";
fileInfo "osv" "Windows 11 Pro v2009 (Build: 26200)";
fileInfo "UUID" "C2321ED7-45D3-F9B3-4154-F1BED6EAD717";
createNode transform -s -n "persp";
	rename -uid "3A13D6D2-4D7A-BE85-E249-80AECFC63FE4";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 16.543874253558162 18.583473190547981 1.6786715724718331 ;
	setAttr ".r" -type "double3" -41.73835272960801 436.19999999996759 0 ;
createNode camera -s -n "perspShape" -p "persp";
	rename -uid "4C8088C2-435C-FD32-B296-25A4F46E974F";
	setAttr -k off ".v" no;
	setAttr ".fl" 34.999999999999993;
	setAttr ".coi" 14.803387439636307;
	setAttr ".imn" -type "string" "persp";
	setAttr ".den" -type "string" "persp_depth";
	setAttr ".man" -type "string" "persp_mask";
	setAttr ".hc" -type "string" "viewSet -p %camera";
createNode transform -s -n "top";
	rename -uid "5E4B586C-41CE-C0DD-8AD7-33B17128CD9C";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 0 1000.1 0 ;
	setAttr ".r" -type "double3" -90 0 0 ;
createNode camera -s -n "topShape" -p "top";
	rename -uid "D0073E9B-4D72-F1D3-EB2F-30ACF052B324";
	setAttr -k off ".v" no;
	setAttr ".rnd" no;
	setAttr ".coi" 1000.1;
	setAttr ".ow" 30;
	setAttr ".imn" -type "string" "top";
	setAttr ".den" -type "string" "top_depth";
	setAttr ".man" -type "string" "top_mask";
	setAttr ".hc" -type "string" "viewSet -t %camera";
	setAttr ".o" yes;
	setAttr ".ai_translator" -type "string" "orthographic";
createNode transform -s -n "front";
	rename -uid "78BE24CF-45A3-7C4F-8B40-D49EFF9AE2C7";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 0 0 1000.1 ;
createNode camera -s -n "frontShape" -p "front";
	rename -uid "7B520845-479D-9B2E-F58B-278CBE1DCA89";
	setAttr -k off ".v" no;
	setAttr ".rnd" no;
	setAttr ".coi" 1000.1;
	setAttr ".ow" 30;
	setAttr ".imn" -type "string" "front";
	setAttr ".den" -type "string" "front_depth";
	setAttr ".man" -type "string" "front_mask";
	setAttr ".hc" -type "string" "viewSet -f %camera";
	setAttr ".o" yes;
	setAttr ".ai_translator" -type "string" "orthographic";
createNode transform -s -n "side";
	rename -uid "159E67D3-4EBB-AA8F-8C0D-0EBEB49210CE";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 1000.1 0 0 ;
	setAttr ".r" -type "double3" 0 90 0 ;
createNode camera -s -n "sideShape" -p "side";
	rename -uid "BA3B1040-4FD2-254E-F6C7-7CB99D542D2C";
	setAttr -k off ".v" no;
	setAttr ".rnd" no;
	setAttr ".coi" 1000.1;
	setAttr ".ow" 30;
	setAttr ".imn" -type "string" "side";
	setAttr ".den" -type "string" "side_depth";
	setAttr ".man" -type "string" "side_mask";
	setAttr ".hc" -type "string" "viewSet -s %camera";
	setAttr ".o" yes;
	setAttr ".ai_translator" -type "string" "orthographic";
createNode transform -n "curve1";
	rename -uid "4531F7CB-4A3C-C875-414D-E7A9733A561B";
	setAttr ".v" no;
createNode nurbsCurve -n "curveShape1" -p "curve1";
	rename -uid "97EE4DCA-45BE-7AC7-B98E-ACA5FB06EF18";
	setAttr -k off ".v";
	setAttr ".cc" -type "nurbsCurve" 
		3 12 0 no 3
		17 0 0 0 1 2 3 4 5 6 7 8 9 10 11 12 12 12
		15
		0 0 12.00000000000062
		1.5826605173756605 0 10.459023705138332
		4.7479815521269542 0 7.3770711154137061
		-0.99192620850669 0 6.4917155383472869
		-6.7802767181005335 0 2.6560667311964754
		-1.8869669190913392 0 0.88401753686716067
		2.3281443944657569 0 5.8078631213347451
		4.5743893412286898 0 -0.11547002220580807
		3.3742982406195035 0 -5.3459830325115565
		-0.07158230370663296 0 -2.5005978477480588
		-9.0879690257928392 0 -2.6516255764960768
		-5.5765415931219913 0 -10.892899846267685
		7.3941353982805609 0 -7.7767750384331311
		10.464711799426897 0 -10.592258346144421
		12.000000000000046 0 -12.000000000000046
		;
createNode transform -n "positionMarker1" -p "curveShape1";
	rename -uid "699CF6F0-4B05-7A7E-8FF0-2BA7665ABDE7";
createNode positionMarker -n "positionMarkerShape1" -p "positionMarker1";
	rename -uid "EF3907E7-4EF1-E309-8FD1-D18F359C130D";
	setAttr -k off ".v";
	setAttr ".uwo" yes;
createNode transform -n "positionMarker2" -p "curveShape1";
	rename -uid "69AAC0B0-4F05-CF1E-20EF-46BFD434D89D";
createNode positionMarker -n "positionMarkerShape2" -p "positionMarker2";
	rename -uid "24A301FA-42BA-0FE8-AC9D-B7B8CB4DA2CB";
	setAttr -k off ".v";
	setAttr ".uwo" yes;
	setAttr ".lp" -type "double3" 1 0 0 ;
	setAttr ".t" 75;
createNode transform -n "positionMarker3" -p "curveShape1";
	rename -uid "8F0F626E-4BF7-D310-677C-999E5352D9A4";
createNode positionMarker -n "positionMarkerShape3" -p "positionMarker3";
	rename -uid "C65BEDC2-48D7-FE01-C588-DAAB5E4251FC";
	setAttr -k off ".v";
	setAttr ".uwo" yes;
	setAttr ".lp" -type "double3" 0.191296 0 0 ;
	setAttr ".t" 21;
createNode transform -n "positionMarker4" -p "curveShape1";
	rename -uid "2546C3F0-4E2B-22B0-A721-748EFD8A23B4";
createNode positionMarker -n "positionMarkerShape4" -p "positionMarker4";
	rename -uid "0F8BC3B5-4C7F-8D1E-4C24-40B67F71940C";
	setAttr -k off ".v";
	setAttr ".uwo" yes;
	setAttr ".lp" -type "double3" 0.86631143209876527 0 0 ;
	setAttr ".t" 58.5;
createNode transform -n "positionMarker5" -p "curveShape1";
	rename -uid "2A19D4CD-4747-ADF9-BFCB-57BCA4377B17";
createNode positionMarker -n "positionMarkerShape5" -p "positionMarker5";
	rename -uid "C10831F0-44E0-B433-8A38-EBA4D479DAF8";
	setAttr -k off ".v";
	setAttr ".uwo" yes;
	setAttr ".lp" -type "double3" 0.38292220907525476 0 0 ;
	setAttr ".t" 39;
createNode transform -n "target_pt";
	rename -uid "584FDF2D-4E6C-EBBD-EBCF-5FA2E844FB6E";
	setAttr ".smd" 7;
createNode locator -n "target_ptShape" -p "target_pt";
	rename -uid "BA1EC239-43D3-625A-19CF-FB809D2EC1EB";
	setAttr -k off ".v";
createNode transform -n "pSphere1";
	rename -uid "B603DEED-42F3-188C-38C1-9DB904763381";
	setAttr ".v" no;
createNode mesh -n "pSphere1Shape" -p "pSphere1";
	rename -uid "3E669FA4-4E2E-150B-A765-7CA2FB612D7E";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr -s 155 ".uvst[0].uvsp[0:154]" -type "float2" 0 0.083333336 0.083333336
		 0.083333336 0.16666667 0.083333336 0.25 0.083333336 0.33333334 0.083333336 0.41666669
		 0.083333336 0.5 0.083333336 0.58333331 0.083333336 0.66666663 0.083333336 0.74999994
		 0.083333336 0.83333325 0.083333336 0.91666657 0.083333336 0.99999988 0.083333336
		 0 0.16666667 0.083333336 0.16666667 0.16666667 0.16666667 0.25 0.16666667 0.33333334
		 0.16666667 0.41666669 0.16666667 0.5 0.16666667 0.58333331 0.16666667 0.66666663
		 0.16666667 0.74999994 0.16666667 0.83333325 0.16666667 0.91666657 0.16666667 0.99999988
		 0.16666667 0 0.25 0.083333336 0.25 0.16666667 0.25 0.25 0.25 0.33333334 0.25 0.41666669
		 0.25 0.5 0.25 0.58333331 0.25 0.66666663 0.25 0.74999994 0.25 0.83333325 0.25 0.91666657
		 0.25 0.99999988 0.25 0 0.33333334 0.083333336 0.33333334 0.16666667 0.33333334 0.25
		 0.33333334 0.33333334 0.33333334 0.41666669 0.33333334 0.5 0.33333334 0.58333331
		 0.33333334 0.66666663 0.33333334 0.74999994 0.33333334 0.83333325 0.33333334 0.91666657
		 0.33333334 0.99999988 0.33333334 0 0.41666669 0.083333336 0.41666669 0.16666667 0.41666669
		 0.25 0.41666669 0.33333334 0.41666669 0.41666669 0.41666669 0.5 0.41666669 0.58333331
		 0.41666669 0.66666663 0.41666669 0.74999994 0.41666669 0.83333325 0.41666669 0.91666657
		 0.41666669 0.99999988 0.41666669 0 0.5 0.083333336 0.5 0.16666667 0.5 0.25 0.5 0.33333334
		 0.5 0.41666669 0.5 0.5 0.5 0.58333331 0.5 0.66666663 0.5 0.74999994 0.5 0.83333325
		 0.5 0.91666657 0.5 0.99999988 0.5 0 0.58333331 0.083333336 0.58333331 0.16666667
		 0.58333331 0.25 0.58333331 0.33333334 0.58333331 0.41666669 0.58333331 0.5 0.58333331
		 0.58333331 0.58333331 0.66666663 0.58333331 0.74999994 0.58333331 0.83333325 0.58333331
		 0.91666657 0.58333331 0.99999988 0.58333331 0 0.66666663 0.083333336 0.66666663 0.16666667
		 0.66666663 0.25 0.66666663 0.33333334 0.66666663 0.41666669 0.66666663 0.5 0.66666663
		 0.58333331 0.66666663 0.66666663 0.66666663 0.74999994 0.66666663 0.83333325 0.66666663
		 0.91666657 0.66666663 0.99999988 0.66666663 0 0.74999994 0.083333336 0.74999994 0.16666667
		 0.74999994 0.25 0.74999994 0.33333334 0.74999994 0.41666669 0.74999994 0.5 0.74999994
		 0.58333331 0.74999994 0.66666663 0.74999994 0.74999994 0.74999994 0.83333325 0.74999994
		 0.91666657 0.74999994 0.99999988 0.74999994 0 0.83333325 0.083333336 0.83333325 0.16666667
		 0.83333325 0.25 0.83333325 0.33333334 0.83333325 0.41666669 0.83333325 0.5 0.83333325
		 0.58333331 0.83333325 0.66666663 0.83333325 0.74999994 0.83333325 0.83333325 0.83333325
		 0.91666657 0.83333325 0.99999988 0.83333325 0 0.91666657 0.083333336 0.91666657 0.16666667
		 0.91666657 0.25 0.91666657 0.33333334 0.91666657 0.41666669 0.91666657 0.5 0.91666657
		 0.58333331 0.91666657 0.66666663 0.91666657 0.74999994 0.91666657 0.83333325 0.91666657
		 0.91666657 0.91666657 0.99999988 0.91666657 0.125 0 0.29166666 0 0.45833334 0 0.62500006
		 0 0.79166669 0 0.95833337 0 0.041666668 1 0.20833334 1 0.375 1 0.54166669 1 0.70833337
		 1 0.87500006 1;
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Ambient+Diffuse";
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr -s 134 ".vt[0:133]"  0.11207193 -0.48296291 -0.064704761 0.064704761 -0.48296291 -0.11207193
		 0 -0.48296291 -0.12940952 -0.064704761 -0.48296291 -0.11207193 -0.11207193 -0.48296291 -0.064704761
		 -0.12940952 -0.48296291 0 -0.11207193 -0.48296291 0.064704761 -0.064704761 -0.48296291 0.11207193
		 0 -0.48296291 0.12940952 0.064704761 -0.48296291 0.11207193 0.11207193 -0.48296291 0.064704761
		 0.12940952 -0.48296291 0 0.21650635 -0.43301269 -0.125 0.125 -0.43301269 -0.21650635
		 0 -0.43301269 -0.25 -0.125 -0.43301269 -0.21650635 -0.21650635 -0.43301269 -0.125
		 -0.25 -0.43301269 0 -0.21650635 -0.43301269 0.125 -0.125 -0.43301269 0.21650635 0 -0.43301269 0.25
		 0.125 -0.43301269 0.21650635 0.21650635 -0.43301269 0.125 0.25 -0.43301269 0 0.3061862 -0.35355338 -0.17677669
		 0.17677669 -0.35355338 -0.3061862 0 -0.35355338 -0.35355338 -0.17677669 -0.35355338 -0.3061862
		 -0.3061862 -0.35355338 -0.17677669 -0.35355338 -0.35355338 0 -0.3061862 -0.35355338 0.17677669
		 -0.17677669 -0.35355338 0.3061862 0 -0.35355338 0.35355338 0.17677669 -0.35355338 0.3061862
		 0.3061862 -0.35355338 0.17677669 0.35355338 -0.35355338 0 0.375 -0.24999999 -0.21650636
		 0.21650636 -0.24999999 -0.375 0 -0.24999999 -0.43301272 -0.21650636 -0.24999999 -0.375
		 -0.375 -0.24999999 -0.21650636 -0.43301272 -0.24999999 0 -0.375 -0.24999999 0.21650636
		 -0.21650636 -0.24999999 0.375 0 -0.24999999 0.43301272 0.21650636 -0.24999999 0.375
		 0.375 -0.24999999 0.21650636 0.43301272 -0.24999999 0 0.41825813 -0.12940954 -0.24148145
		 0.24148145 -0.12940954 -0.41825813 0 -0.12940954 -0.48296291 -0.24148145 -0.12940954 -0.41825813
		 -0.41825813 -0.12940954 -0.24148145 -0.48296291 -0.12940954 0 -0.41825813 -0.12940954 0.24148145
		 -0.24148145 -0.12940954 0.41825813 0 -0.12940954 0.48296291 0.24148145 -0.12940954 0.41825813
		 0.41825813 -0.12940954 0.24148145 0.48296291 -0.12940954 0 0.43301269 0 -0.25 0.25 0 -0.43301269
		 0 0 -0.5 -0.25 0 -0.43301269 -0.43301269 0 -0.25 -0.5 0 0 -0.43301269 0 0.25 -0.25 0 0.43301269
		 0 0 0.5 0.25 0 0.43301269 0.43301269 0 0.25 0.5 0 0 0.41825813 0.12940954 -0.24148145
		 0.24148145 0.12940954 -0.41825813 0 0.12940954 -0.48296291 -0.24148145 0.12940954 -0.41825813
		 -0.41825813 0.12940954 -0.24148145 -0.48296291 0.12940954 0 -0.41825813 0.12940954 0.24148145
		 -0.24148145 0.12940954 0.41825813 0 0.12940954 0.48296291 0.24148145 0.12940954 0.41825813
		 0.41825813 0.12940954 0.24148145 0.48296291 0.12940954 0 0.375 0.24999999 -0.21650636
		 0.21650636 0.24999999 -0.375 0 0.24999999 -0.43301272 -0.21650636 0.24999999 -0.375
		 -0.375 0.24999999 -0.21650636 -0.43301272 0.24999999 0 -0.375 0.24999999 0.21650636
		 -0.21650636 0.24999999 0.375 0 0.24999999 0.43301272 0.21650636 0.24999999 0.375
		 0.375 0.24999999 0.21650636 0.43301272 0.24999999 0 0.3061862 0.35355338 -0.17677669
		 0.17677669 0.35355338 -0.3061862 0 0.35355338 -0.35355338 -0.17677669 0.35355338 -0.3061862
		 -0.3061862 0.35355338 -0.17677669 -0.35355338 0.35355338 0 -0.3061862 0.35355338 0.17677669
		 -0.17677669 0.35355338 0.3061862 0 0.35355338 0.35355338 0.17677669 0.35355338 0.3061862
		 0.3061862 0.35355338 0.17677669 0.35355338 0.35355338 0 0.21650635 0.43301269 -0.125
		 0.125 0.43301269 -0.21650635 0 0.43301269 -0.25 -0.125 0.43301269 -0.21650635 -0.21650635 0.43301269 -0.125
		 -0.25 0.43301269 0 -0.21650635 0.43301269 0.125 -0.125 0.43301269 0.21650635 0 0.43301269 0.25
		 0.125 0.43301269 0.21650635 0.21650635 0.43301269 0.125 0.25 0.43301269 0 0.11207193 0.48296291 -0.064704761
		 0.064704761 0.48296291 -0.11207193 0 0.48296291 -0.12940952 -0.064704761 0.48296291 -0.11207193
		 -0.11207193 0.48296291 -0.064704761 -0.12940952 0.48296291 0 -0.11207193 0.48296291 0.064704761
		 -0.064704761 0.48296291 0.11207193 0 0.48296291 0.12940952 0.064704761 0.48296291 0.11207193
		 0.11207193 0.48296291 0.064704761 0.12940952 0.48296291 0 0 -0.5 0 0 0.5 0;
	setAttr -s 264 ".ed";
	setAttr ".ed[0:165]"  0 1 0 1 2 0 2 3 0 3 4 0 4 5 0 5 6 0 6 7 0 7 8 0 8 9 0
		 9 10 0 10 11 0 11 0 0 12 13 0 13 14 0 14 15 0 15 16 0 16 17 0 17 18 0 18 19 0 19 20 0
		 20 21 0 21 22 0 22 23 0 23 12 0 24 25 0 25 26 0 26 27 0 27 28 0 28 29 0 29 30 0 30 31 0
		 31 32 0 32 33 0 33 34 0 34 35 0 35 24 0 36 37 0 37 38 0 38 39 0 39 40 0 40 41 0 41 42 0
		 42 43 0 43 44 0 44 45 0 45 46 0 46 47 0 47 36 0 48 49 0 49 50 0 50 51 0 51 52 0 52 53 0
		 53 54 0 54 55 0 55 56 0 56 57 0 57 58 0 58 59 0 59 48 0 60 61 0 61 62 0 62 63 0 63 64 0
		 64 65 0 65 66 0 66 67 0 67 68 0 68 69 0 69 70 0 70 71 0 71 60 0 72 73 0 73 74 0 74 75 0
		 75 76 0 76 77 0 77 78 0 78 79 0 79 80 0 80 81 0 81 82 0 82 83 0 83 72 0 84 85 0 85 86 0
		 86 87 0 87 88 0 88 89 0 89 90 0 90 91 0 91 92 0 92 93 0 93 94 0 94 95 0 95 84 0 96 97 0
		 97 98 0 98 99 0 99 100 0 100 101 0 101 102 0 102 103 0 103 104 0 104 105 0 105 106 0
		 106 107 0 107 96 0 108 109 0 109 110 0 110 111 0 111 112 0 112 113 0 113 114 0 114 115 0
		 115 116 0 116 117 0 117 118 0 118 119 0 119 108 0 120 121 0 121 122 0 122 123 0 123 124 0
		 124 125 0 125 126 0 126 127 0 127 128 0 128 129 0 129 130 0 130 131 0 131 120 0 0 12 0
		 1 13 0 2 14 0 3 15 0 4 16 0 5 17 0 6 18 0 7 19 0 8 20 0 9 21 0 10 22 0 11 23 0 12 24 0
		 13 25 0 14 26 0 15 27 0 16 28 0 17 29 0 18 30 0 19 31 0 20 32 0 21 33 0 22 34 0 23 35 0
		 24 36 0 25 37 0 26 38 0 27 39 0 28 40 0 29 41 0 30 42 0 31 43 0 32 44 0 33 45 0;
	setAttr ".ed[166:263]" 34 46 0 35 47 0 36 48 0 37 49 0 38 50 0 39 51 0 40 52 0
		 41 53 0 42 54 0 43 55 0 44 56 0 45 57 0 46 58 0 47 59 0 48 60 0 49 61 0 50 62 0 51 63 0
		 52 64 0 53 65 0 54 66 0 55 67 0 56 68 0 57 69 0 58 70 0 59 71 0 60 72 0 61 73 0 62 74 0
		 63 75 0 64 76 0 65 77 0 66 78 0 67 79 0 68 80 0 69 81 0 70 82 0 71 83 0 72 84 0 73 85 0
		 74 86 0 75 87 0 76 88 0 77 89 0 78 90 0 79 91 0 80 92 0 81 93 0 82 94 0 83 95 0 84 96 0
		 85 97 0 86 98 0 87 99 0 88 100 0 89 101 0 90 102 0 91 103 0 92 104 0 93 105 0 94 106 0
		 95 107 0 96 108 0 97 109 0 98 110 0 99 111 0 100 112 0 101 113 0 102 114 0 103 115 0
		 104 116 0 105 117 0 106 118 0 107 119 0 108 120 0 109 121 0 110 122 0 111 123 0 112 124 0
		 113 125 0 114 126 0 115 127 0 116 128 0 117 129 0 118 130 0 119 131 0 132 0 0 132 2 0
		 132 4 0 132 6 0 132 8 0 132 10 0 120 133 0 122 133 0 124 133 0 126 133 0 128 133 0
		 130 133 0;
	setAttr -s 132 -ch 528 ".fc[0:131]" -type "polyFaces" 
		f 4 0 133 -13 -133
		mu 0 4 0 1 14 13
		f 4 1 134 -14 -134
		mu 0 4 1 2 15 14
		f 4 2 135 -15 -135
		mu 0 4 2 3 16 15
		f 4 3 136 -16 -136
		mu 0 4 3 4 17 16
		f 4 4 137 -17 -137
		mu 0 4 4 5 18 17
		f 4 5 138 -18 -138
		mu 0 4 5 6 19 18
		f 4 6 139 -19 -139
		mu 0 4 6 7 20 19
		f 4 7 140 -20 -140
		mu 0 4 7 8 21 20
		f 4 8 141 -21 -141
		mu 0 4 8 9 22 21
		f 4 9 142 -22 -142
		mu 0 4 9 10 23 22
		f 4 10 143 -23 -143
		mu 0 4 10 11 24 23
		f 4 11 132 -24 -144
		mu 0 4 11 12 25 24
		f 4 12 145 -25 -145
		mu 0 4 13 14 27 26
		f 4 13 146 -26 -146
		mu 0 4 14 15 28 27
		f 4 14 147 -27 -147
		mu 0 4 15 16 29 28
		f 4 15 148 -28 -148
		mu 0 4 16 17 30 29
		f 4 16 149 -29 -149
		mu 0 4 17 18 31 30
		f 4 17 150 -30 -150
		mu 0 4 18 19 32 31
		f 4 18 151 -31 -151
		mu 0 4 19 20 33 32
		f 4 19 152 -32 -152
		mu 0 4 20 21 34 33
		f 4 20 153 -33 -153
		mu 0 4 21 22 35 34
		f 4 21 154 -34 -154
		mu 0 4 22 23 36 35
		f 4 22 155 -35 -155
		mu 0 4 23 24 37 36
		f 4 23 144 -36 -156
		mu 0 4 24 25 38 37
		f 4 24 157 -37 -157
		mu 0 4 26 27 40 39
		f 4 25 158 -38 -158
		mu 0 4 27 28 41 40
		f 4 26 159 -39 -159
		mu 0 4 28 29 42 41
		f 4 27 160 -40 -160
		mu 0 4 29 30 43 42
		f 4 28 161 -41 -161
		mu 0 4 30 31 44 43
		f 4 29 162 -42 -162
		mu 0 4 31 32 45 44
		f 4 30 163 -43 -163
		mu 0 4 32 33 46 45
		f 4 31 164 -44 -164
		mu 0 4 33 34 47 46
		f 4 32 165 -45 -165
		mu 0 4 34 35 48 47
		f 4 33 166 -46 -166
		mu 0 4 35 36 49 48
		f 4 34 167 -47 -167
		mu 0 4 36 37 50 49
		f 4 35 156 -48 -168
		mu 0 4 37 38 51 50
		f 4 36 169 -49 -169
		mu 0 4 39 40 53 52
		f 4 37 170 -50 -170
		mu 0 4 40 41 54 53
		f 4 38 171 -51 -171
		mu 0 4 41 42 55 54
		f 4 39 172 -52 -172
		mu 0 4 42 43 56 55
		f 4 40 173 -53 -173
		mu 0 4 43 44 57 56
		f 4 41 174 -54 -174
		mu 0 4 44 45 58 57
		f 4 42 175 -55 -175
		mu 0 4 45 46 59 58
		f 4 43 176 -56 -176
		mu 0 4 46 47 60 59
		f 4 44 177 -57 -177
		mu 0 4 47 48 61 60
		f 4 45 178 -58 -178
		mu 0 4 48 49 62 61
		f 4 46 179 -59 -179
		mu 0 4 49 50 63 62
		f 4 47 168 -60 -180
		mu 0 4 50 51 64 63
		f 4 48 181 -61 -181
		mu 0 4 52 53 66 65
		f 4 49 182 -62 -182
		mu 0 4 53 54 67 66
		f 4 50 183 -63 -183
		mu 0 4 54 55 68 67
		f 4 51 184 -64 -184
		mu 0 4 55 56 69 68
		f 4 52 185 -65 -185
		mu 0 4 56 57 70 69
		f 4 53 186 -66 -186
		mu 0 4 57 58 71 70
		f 4 54 187 -67 -187
		mu 0 4 58 59 72 71
		f 4 55 188 -68 -188
		mu 0 4 59 60 73 72
		f 4 56 189 -69 -189
		mu 0 4 60 61 74 73
		f 4 57 190 -70 -190
		mu 0 4 61 62 75 74
		f 4 58 191 -71 -191
		mu 0 4 62 63 76 75
		f 4 59 180 -72 -192
		mu 0 4 63 64 77 76
		f 4 60 193 -73 -193
		mu 0 4 65 66 79 78
		f 4 61 194 -74 -194
		mu 0 4 66 67 80 79
		f 4 62 195 -75 -195
		mu 0 4 67 68 81 80
		f 4 63 196 -76 -196
		mu 0 4 68 69 82 81
		f 4 64 197 -77 -197
		mu 0 4 69 70 83 82
		f 4 65 198 -78 -198
		mu 0 4 70 71 84 83
		f 4 66 199 -79 -199
		mu 0 4 71 72 85 84
		f 4 67 200 -80 -200
		mu 0 4 72 73 86 85
		f 4 68 201 -81 -201
		mu 0 4 73 74 87 86
		f 4 69 202 -82 -202
		mu 0 4 74 75 88 87
		f 4 70 203 -83 -203
		mu 0 4 75 76 89 88
		f 4 71 192 -84 -204
		mu 0 4 76 77 90 89
		f 4 72 205 -85 -205
		mu 0 4 78 79 92 91
		f 4 73 206 -86 -206
		mu 0 4 79 80 93 92
		f 4 74 207 -87 -207
		mu 0 4 80 81 94 93
		f 4 75 208 -88 -208
		mu 0 4 81 82 95 94
		f 4 76 209 -89 -209
		mu 0 4 82 83 96 95
		f 4 77 210 -90 -210
		mu 0 4 83 84 97 96
		f 4 78 211 -91 -211
		mu 0 4 84 85 98 97
		f 4 79 212 -92 -212
		mu 0 4 85 86 99 98
		f 4 80 213 -93 -213
		mu 0 4 86 87 100 99
		f 4 81 214 -94 -214
		mu 0 4 87 88 101 100
		f 4 82 215 -95 -215
		mu 0 4 88 89 102 101
		f 4 83 204 -96 -216
		mu 0 4 89 90 103 102
		f 4 84 217 -97 -217
		mu 0 4 91 92 105 104
		f 4 85 218 -98 -218
		mu 0 4 92 93 106 105
		f 4 86 219 -99 -219
		mu 0 4 93 94 107 106
		f 4 87 220 -100 -220
		mu 0 4 94 95 108 107
		f 4 88 221 -101 -221
		mu 0 4 95 96 109 108
		f 4 89 222 -102 -222
		mu 0 4 96 97 110 109
		f 4 90 223 -103 -223
		mu 0 4 97 98 111 110
		f 4 91 224 -104 -224
		mu 0 4 98 99 112 111
		f 4 92 225 -105 -225
		mu 0 4 99 100 113 112
		f 4 93 226 -106 -226
		mu 0 4 100 101 114 113
		f 4 94 227 -107 -227
		mu 0 4 101 102 115 114
		f 4 95 216 -108 -228
		mu 0 4 102 103 116 115
		f 4 96 229 -109 -229
		mu 0 4 104 105 118 117
		f 4 97 230 -110 -230
		mu 0 4 105 106 119 118
		f 4 98 231 -111 -231
		mu 0 4 106 107 120 119
		f 4 99 232 -112 -232
		mu 0 4 107 108 121 120
		f 4 100 233 -113 -233
		mu 0 4 108 109 122 121
		f 4 101 234 -114 -234
		mu 0 4 109 110 123 122
		f 4 102 235 -115 -235
		mu 0 4 110 111 124 123
		f 4 103 236 -116 -236
		mu 0 4 111 112 125 124
		f 4 104 237 -117 -237
		mu 0 4 112 113 126 125
		f 4 105 238 -118 -238
		mu 0 4 113 114 127 126
		f 4 106 239 -119 -239
		mu 0 4 114 115 128 127
		f 4 107 228 -120 -240
		mu 0 4 115 116 129 128
		f 4 108 241 -121 -241
		mu 0 4 117 118 131 130
		f 4 109 242 -122 -242
		mu 0 4 118 119 132 131
		f 4 110 243 -123 -243
		mu 0 4 119 120 133 132
		f 4 111 244 -124 -244
		mu 0 4 120 121 134 133
		f 4 112 245 -125 -245
		mu 0 4 121 122 135 134
		f 4 113 246 -126 -246
		mu 0 4 122 123 136 135
		f 4 114 247 -127 -247
		mu 0 4 123 124 137 136
		f 4 115 248 -128 -248
		mu 0 4 124 125 138 137
		f 4 116 249 -129 -249
		mu 0 4 125 126 139 138
		f 4 117 250 -130 -250
		mu 0 4 126 127 140 139
		f 4 118 251 -131 -251
		mu 0 4 127 128 141 140
		f 4 119 240 -132 -252
		mu 0 4 128 129 142 141
		f 4 -1 -253 253 -2
		mu 0 4 1 0 143 2
		f 4 -3 -254 254 -4
		mu 0 4 3 2 144 4
		f 4 -5 -255 255 -6
		mu 0 4 5 4 145 6
		f 4 -7 -256 256 -8
		mu 0 4 7 6 146 8
		f 4 -9 -257 257 -10
		mu 0 4 9 8 147 10
		f 4 -11 -258 252 -12
		mu 0 4 11 10 148 12
		f 4 -259 120 121 259
		mu 0 4 149 130 131 132
		f 4 -260 122 123 260
		mu 0 4 150 132 133 134
		f 4 -261 124 125 261
		mu 0 4 151 134 135 136
		f 4 -262 126 127 262
		mu 0 4 152 136 137 138
		f 4 -263 128 129 263
		mu 0 4 153 138 139 140
		f 4 -264 130 131 258
		mu 0 4 154 140 141 142;
	setAttr ".cd" -type "dataPolyComponent" Index_Data Edge 0 ;
	setAttr ".cvd" -type "dataPolyComponent" Index_Data Vertex 0 ;
	setAttr ".pd[0]" -type "dataPolyComponent" Index_Data UV 0 ;
	setAttr ".hfd" -type "dataPolyComponent" Index_Data Face 0 ;
	setAttr ".db" yes;
	setAttr ".de" 1;
createNode transform -n "curve2";
	rename -uid "B13E938B-4E84-9771-FEAC-C3B60669D2E3";
	setAttr ".v" no;
createNode nurbsCurve -n "curveShape2" -p "curve2";
	rename -uid "512A15FA-47CC-5830-9777-57A92CEACE71";
	setAttr -k off ".v";
	setAttr ".cc" -type "nurbsCurve" 
		3 2 0 no 3
		7 0 0 0 1 2 2 2
		5
		0 0 12.000000000000094
		0.84192177653313371 0 11.377983649571823
		2.5257653295993916 0 10.13395094871523
		2.156056612730028 0 8.0976752440134696
		1.9712022542953456 0 7.0795373916625852
		;
createNode transform -n "curve3";
	rename -uid "2C1E30BF-4511-D739-FEBA-E1A320D0709F";
	setAttr ".v" no;
createNode nurbsCurve -n "curveShape3" -p "curve3";
	rename -uid "2FF047A0-422C-0459-0190-1CA70B581C48";
	setAttr -k off ".v";
	setAttr ".cc" -type "nurbsCurve" 
		3 72 0 no 3
		77 0 0 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25
		 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52
		 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 72 72
		75
		0.038599354569765099 0 11.962416698117973
		0.15079607100527903 0 11.853141000132648
		0.33096618536238898 0 11.677383380161245
		0.57331513460078976 0 11.439853935035293
		0.87126346116947506 0 11.144755659382437
		1.2172565964520008 0 10.795157613701923
		1.601854627178247 0 10.392605445978214
		2.0123772454637199 0 9.9358899236049822
		2.4286842479208866 0 9.4188627912694045
		2.8088023651027658 0 8.8244910027780783
		3.0117253168266664 0 8.1196427257895021
		2.6525329313773098 0 7.4701517888820792
		1.9712022879839219 0 7.0795373292058859
		1.2254336913847688 0 6.7917790610800921
		0.46415693598789853 0 6.5328269254521292
		-0.29274311527773311 0 6.2707739563170879
		-1.0305761100071338 0 5.9874373861838164
		-1.736390387477653 0 5.6745205979728235
		-2.4022837924975953 0 5.3373867155465549
		-3.0205290085462062 0 4.9823066345723888
		-3.5826071523607625 0 4.6138563562222279
		-4.0827299817706404 0 4.2316269791435639
		-4.5170700692250323 0 3.8243776188669365
		-4.8605360203382286 0 3.3712829365435826
		-5.0086951901855166 0 2.8473881145849429
		-4.7949021008485229 0 2.361225773683874
		-4.3587839869927265 0 2.0481170829536186
		-3.8424609611325926 0 1.8737099213610968
		-3.2871709731183127 0 1.8051236615817703
		-2.7060974930665207 0 1.8334136565199028
		-2.1086054462909898 0 1.9643645139799861
		-1.5064245299840602 0 2.208489189824022
		-0.89930745837014314 0 2.5492757082571367
		-0.27208994456926472 0 2.9613507804780363
		0.40150016683222001 0 3.4158714786543629
		1.1701341529457543 0 3.8476216593510246
		2.1030749454066795 0 3.9783288235422556
		2.9197277651406548 0 3.3546879934729241
		3.4587787821249174 0 2.3531460709509622
		3.8209882387432872 0 1.1480363835052085
		4.0183728249603092 0 -0.22523481586102251
		3.9957215430097071 0 -1.725607954491351
		3.6092966978175438 0 -3.272416873066148
		2.2976558070751687 0 -4.0672494548379134
		0.64311414902041419 0 -3.492689919522546
		-1.0882451180834787 0 -2.9813379299144818
		-2.9183000891057649 0 -2.7579725534944379
		-4.7815954227340587 0 -2.8557732334865111
		-6.5244942138724422 0 -3.5072306735002639
		-7.3080197315973514 0 -5.1240834696105244
		-6.7782903018104763 0 -6.8729038270338281
		-5.5663615462595057 0 -8.2051534621606255
		-4.0044589894493008 0 -8.9986113728083374
		-2.3413457367528694 0 -9.2987230649931316
		-0.73107746802730411 0 -9.3364889832179916
		0.78130183472310488 0 -9.2618263094850803
		2.1792163589201885 0 -9.1519066289339985
		3.4503199710627461 0 -9.0517764682249329
		4.5904198703226475 0 -8.9892680677721533
		5.6444723980675677 0 -8.9836059123089154
		6.6174184730394137 0 -9.0591788835730718
		7.5018298618338619 0 -9.2227585407941088
		8.2908265282077807 0 -9.46080565921012
		8.9822047712784023 0 -9.7527320580909276
		9.5791194944278271 0 -10.074537982988774
		10.089414123457324 0 -10.403502504729815
		10.522905907113644 0 -10.721261549535441
		10.889000176711916 0 -11.014673083786544
		11.195394835614229 0 -11.275218158114066
		11.447821289308958 0 -11.497949486188892
		11.650092698950953 0 -11.680252918810773
		11.80489510468143 0 -11.821293591997971
		11.914051035692763 0 -11.921207634906162
		11.978681767152942 0 -11.980453061813707
		12.000000000000046 0 -12.000000000000046
		;
createNode transform -n "root_grp";
	rename -uid "54C0A9B3-423C-5C90-145D-2EB9D916F981";
	setAttr ".rp" -type "double3" -2.7683871579639781 -1.3947547095750172 0.42524521696577011 ;
	setAttr ".sp" -type "double3" -2.7683871579639781 -1.3947547095750172 0.42524521696577011 ;
createNode transform -n "master01_ctrl" -p "root_grp";
	rename -uid "4ABFE60D-4B9F-A409-B4BC-7DA1767AF4BA";
createNode locator -n "master01_ctrlShape" -p "master01_ctrl";
	rename -uid "9F5E7E39-42E5-5BD0-B0DB-53B1A9551681";
	setAttr -k off ".v";
createNode transform -n "placeHolder01_lctr" -p "master01_ctrl";
	rename -uid "F69E2243-486F-6FC2-EBBB-A09F6E950FB0";
createNode locator -n "placeHolder01_lctrShape" -p "placeHolder01_lctr";
	rename -uid "BF6E3981-4281-1738-D420-548202B339C0";
	setAttr -k off ".v";
	setAttr ".lp" -type "double3" 1 0 0 ;
createNode transform -n "master02_ctrl" -p "root_grp";
	rename -uid "7464EB17-4E13-6A83-197C-52A3A696F173";
createNode locator -n "master02_ctrlShape" -p "master02_ctrl";
	rename -uid "84DFEC9A-4F5E-DA66-4D57-87A0A0FCFA3B";
	setAttr -k off ".v";
createNode transform -n "placeHolder02_lctr" -p "master02_ctrl";
	rename -uid "4A03BE40-42E5-687A-8248-F384A91C4767";
createNode locator -n "placeHolder02_lctrShape" -p "placeHolder02_lctr";
	rename -uid "B03B4A00-4276-6E3A-2D83-A1858C3A1B31";
	setAttr -k off ".v";
	setAttr ".lp" -type "double3" 1 0 0 ;
createNode transform -n "master03_ctrl" -p "root_grp";
	rename -uid "D44D9AE7-4849-F708-A75A-019307542C7E";
createNode locator -n "master03_ctrlShape" -p "master03_ctrl";
	rename -uid "603E0A80-4939-9F51-48FA-579387656FFB";
	setAttr -k off ".v";
createNode transform -n "placeHolder03_lctr" -p "master03_ctrl";
	rename -uid "6E547CCA-4FBF-55D8-F60E-5DA0B1AA766D";
createNode locator -n "placeHolder03_lctrShape" -p "placeHolder03_lctr";
	rename -uid "2314EB08-4861-FCA4-443B-C1B2410FB1A1";
	setAttr -k off ".v";
	setAttr ".lp" -type "double3" 1 0 0 ;
createNode transform -n "master04_ctrl" -p "root_grp";
	rename -uid "9D9D5F7A-42EE-89CE-7326-B386499536C6";
createNode locator -n "master04_ctrlShape" -p "master04_ctrl";
	rename -uid "990F22EB-4AEA-7A71-0DD3-AE86B9A106F9";
	setAttr -k off ".v";
createNode transform -n "placeHolder04_lctr" -p "master04_ctrl";
	rename -uid "6F3369FC-473B-E17B-5F72-88A472EFC28B";
createNode locator -n "placeHolder04_lctrShape" -p "placeHolder04_lctr";
	rename -uid "E9D688E3-4BEC-7ACC-4F22-D3B300571230";
	setAttr -k off ".v";
	setAttr ".lp" -type "double3" 1 0 0 ;
createNode transform -n "master05_ctrl" -p "root_grp";
	rename -uid "114436D6-4755-4887-08DA-84849206EF79";
createNode locator -n "master05_ctrlShape" -p "master05_ctrl";
	rename -uid "D0E85A6D-43C0-F980-892C-78B2B81AD44F";
	setAttr -k off ".v";
createNode transform -n "placeHolder05_lctr" -p "master05_ctrl";
	rename -uid "D376D313-431F-774C-1661-30A3494237FE";
createNode locator -n "placeHolder05_lctrShape" -p "placeHolder05_lctr";
	rename -uid "2D3C30B3-49DA-A154-BFB6-E68C5B8312B5";
	setAttr -k off ".v";
	setAttr ".lp" -type "double3" 1 0 0 ;
createNode lightLinker -s -n "lightLinker1";
	rename -uid "9F5C5DE6-4F99-E281-B9F8-5BB8B0B0A3AA";
	setAttr -s 2 ".lnk";
	setAttr -s 2 ".slnk";
createNode shapeEditorManager -n "shapeEditorManager";
	rename -uid "1ADDC049-4131-CD33-6266-E191F7D53910";
createNode poseInterpolatorManager -n "poseInterpolatorManager";
	rename -uid "6CA4CA0C-4B86-ED5B-13F8-20BA2479638B";
createNode displayLayerManager -n "layerManager";
	rename -uid "5FD4E5A9-44FC-9493-2FA8-B39176C41661";
createNode displayLayer -n "defaultLayer";
	rename -uid "2B9A63AA-4963-2152-91EC-0896A5000E7F";
	setAttr ".ufem" -type "stringArray" 0  ;
createNode renderLayerManager -n "renderLayerManager";
	rename -uid "C76B1158-49E5-E320-1B21-1CB7358A9CDC";
createNode renderLayer -n "defaultRenderLayer";
	rename -uid "15D7AC02-4F38-F636-CDC0-57BD66864B19";
	setAttr ".g" yes;
createNode aiOptions -s -n "defaultArnoldRenderOptions";
	rename -uid "C0E47FED-469E-6A5A-E46C-50AED25FE683";
	setAttr ".version" -type "string" "5.3.4.1";
createNode aiAOVFilter -s -n "defaultArnoldFilter";
	rename -uid "0CBC50F4-45CB-7ED0-428E-FD940A30705D";
	setAttr ".ai_translator" -type "string" "gaussian";
createNode aiAOVDriver -s -n "defaultArnoldDriver";
	rename -uid "E12EB7C0-4F17-6DF6-557B-1D88DB812C9A";
	setAttr ".ai_translator" -type "string" "exr";
createNode aiAOVDriver -s -n "defaultArnoldDisplayDriver";
	rename -uid "E1CAB6E3-4240-B2E4-01F5-D4A9E332493C";
	setAttr ".ai_translator" -type "string" "maya";
	setAttr ".output_mode" 0;
createNode animCurveTL -n "motionPath1_uValue";
	rename -uid "C0CC2665-4852-9F4E-5E59-BFB87FCEA97A";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  0 0 25 1;
createNode nodeGraphEditorInfo -n "MayaNodeEditorSavedTabsInfo";
	rename -uid "ACA760C5-463A-07F6-7EBF-B781200C758D";
	setAttr ".tgi[0].tn" -type "string" "Untitled_1";
	setAttr ".tgi[0].vl" -type "double2" -282.27799660476632 -176.19046918929598 ;
	setAttr ".tgi[0].vh" -type "double2" 1377.5160483220118 172.61904075978325 ;
	setAttr -s 12 ".tgi[0].ni";
	setAttr ".tgi[0].ni[0].x" -158.57142639160156;
	setAttr ".tgi[0].ni[0].y" 248.57142639160156;
	setAttr ".tgi[0].ni[0].nvs" 18304;
	setAttr ".tgi[0].ni[1].x" 1070;
	setAttr ".tgi[0].ni[1].y" 41.428569793701172;
	setAttr ".tgi[0].ni[1].nvs" 18304;
	setAttr ".tgi[0].ni[2].x" -158.57142639160156;
	setAttr ".tgi[0].ni[2].y" 147.14285278320312;
	setAttr ".tgi[0].ni[2].nvs" 18304;
	setAttr ".tgi[0].ni[3].x" 1070;
	setAttr ".tgi[0].ni[3].y" 142.85714721679688;
	setAttr ".tgi[0].ni[3].nvs" 18304;
	setAttr ".tgi[0].ni[4].x" 455.71429443359375;
	setAttr ".tgi[0].ni[4].y" 147.14285278320312;
	setAttr ".tgi[0].ni[4].nvs" 18304;
	setAttr ".tgi[0].ni[5].x" 762.85711669921875;
	setAttr ".tgi[0].ni[5].y" 104.28571319580078;
	setAttr ".tgi[0].ni[5].nvs" 18304;
	setAttr ".tgi[0].ni[6].x" 1070;
	setAttr ".tgi[0].ni[6].y" -187.14285278320312;
	setAttr ".tgi[0].ni[6].nvs" 18304;
	setAttr ".tgi[0].ni[7].x" -158.57142639160156;
	setAttr ".tgi[0].ni[7].y" 45.714286804199219;
	setAttr ".tgi[0].ni[7].nvs" 18304;
	setAttr ".tgi[0].ni[8].x" -158.57142639160156;
	setAttr ".tgi[0].ni[8].y" -55.714286804199219;
	setAttr ".tgi[0].ni[8].nvs" 18304;
	setAttr ".tgi[0].ni[9].x" 148.57142639160156;
	setAttr ".tgi[0].ni[9].y" 97.142860412597656;
	setAttr ".tgi[0].ni[9].nvs" 18304;
	setAttr ".tgi[0].ni[10].x" 1070;
	setAttr ".tgi[0].ni[10].y" -137.14285278320312;
	setAttr ".tgi[0].ni[10].nvs" 18304;
	setAttr ".tgi[0].ni[11].x" 1070;
	setAttr ".tgi[0].ni[11].y" -88.571426391601562;
	setAttr ".tgi[0].ni[11].nvs" 18304;
createNode script -n "uiConfigurationScriptNode";
	rename -uid "33318FE5-4F29-586E-3F89-52A4D99DA676";
	setAttr ".b" -type "string" (
		"// Maya Mel UI Configuration File.\n//\n//  This script is machine generated.  Edit at your own risk.\n//\n//\n\nglobal string $gMainPane;\nif (`paneLayout -exists $gMainPane`) {\n\n\tglobal int $gUseScenePanelConfig;\n\tint    $useSceneConfig = $gUseScenePanelConfig;\n\tint    $nodeEditorPanelVisible = stringArrayContains(\"nodeEditorPanel1\", `getPanel -vis`);\n\tint    $nodeEditorWorkspaceControlOpen = (`workspaceControl -exists nodeEditorPanel1Window` && `workspaceControl -q -visible nodeEditorPanel1Window`);\n\tint    $menusOkayInPanels = `optionVar -q allowMenusInPanels`;\n\tint    $nVisPanes = `paneLayout -q -nvp $gMainPane`;\n\tint    $nPanes = 0;\n\tstring $editorName;\n\tstring $panelName;\n\tstring $itemFilterName;\n\tstring $panelConfig;\n\n\t//\n\t//  get current state of the UI\n\t//\n\tsceneUIReplacement -update $gMainPane;\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"modelPanel\" (localizedPanelLabel(\"Top View\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tmodelPanel -edit -l (localizedPanelLabel(\"Top View\")) -mbv $menusOkayInPanels  $panelName;\n"
		+ "\t\t$editorName = $panelName;\n        modelEditor -e \n            -camera \"|top\" \n            -useInteractiveMode 0\n            -displayLights \"default\" \n            -displayAppearance \"smoothShaded\" \n            -activeOnly 0\n            -ignorePanZoom 0\n            -wireframeOnShaded 0\n            -headsUpDisplay 1\n            -holdOuts 1\n            -selectionHiliteDisplay 1\n            -useDefaultMaterial 0\n            -bufferMode \"double\" \n            -twoSidedLighting 0\n            -backfaceCulling 0\n            -xray 0\n            -jointXray 0\n            -activeComponentsXray 0\n            -displayTextures 0\n            -smoothWireframe 0\n            -lineWidth 1\n            -textureAnisotropic 0\n            -textureHilight 1\n            -textureSampling 2\n            -textureDisplay \"modulate\" \n            -textureMaxSize 32768\n            -fogging 0\n            -fogSource \"fragment\" \n            -fogMode \"linear\" \n            -fogStart 0\n            -fogEnd 100\n            -fogDensity 0.1\n            -fogColor 0.5 0.5 0.5 1 \n"
		+ "            -depthOfFieldPreview 1\n            -maxConstantTransparency 1\n            -rendererName \"vp2Renderer\" \n            -objectFilterShowInHUD 1\n            -isFiltered 0\n            -colorResolution 256 256 \n            -bumpResolution 512 512 \n            -textureCompression 0\n            -transparencyAlgorithm \"frontAndBackCull\" \n            -transpInShadows 0\n            -cullingOverride \"none\" \n            -lowQualityLighting 0\n            -maximumNumHardwareLights 1\n            -occlusionCulling 0\n            -shadingModel 0\n            -useBaseRenderer 0\n            -useReducedRenderer 0\n            -smallObjectCulling 0\n            -smallObjectThreshold -1 \n            -interactiveDisableShadows 0\n            -interactiveBackFaceCull 0\n            -sortTransparent 1\n            -controllers 1\n            -nurbsCurves 1\n            -nurbsSurfaces 1\n            -polymeshes 1\n            -subdivSurfaces 1\n            -planes 1\n            -lights 1\n            -cameras 1\n            -controlVertices 1\n"
		+ "            -hulls 1\n            -grid 1\n            -imagePlane 1\n            -joints 1\n            -ikHandles 1\n            -deformers 1\n            -dynamics 1\n            -particleInstancers 1\n            -fluids 1\n            -hairSystems 1\n            -follicles 1\n            -nCloths 1\n            -nParticles 1\n            -nRigids 1\n            -dynamicConstraints 1\n            -locators 1\n            -manipulators 1\n            -pluginShapes 1\n            -dimensions 1\n            -handles 1\n            -pivots 1\n            -textures 1\n            -strokes 1\n            -motionTrails 1\n            -clipGhosts 1\n            -bluePencil 1\n            -greasePencils 0\n            -excludeObjectPreset \"All\" \n            -shadows 0\n            -captureSequenceNumber -1\n            -width 575\n            -height 332\n            -sceneRenderFilter 0\n            $editorName;\n        modelEditor -e -viewSelected 0 $editorName;\n        modelEditor -e \n            -pluginObjects \"gpuCacheDisplayFilter\" 1 \n            $editorName;\n"
		+ "\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"modelPanel\" (localizedPanelLabel(\"Side View\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tmodelPanel -edit -l (localizedPanelLabel(\"Side View\")) -mbv $menusOkayInPanels  $panelName;\n\t\t$editorName = $panelName;\n        modelEditor -e \n            -camera \"|side\" \n            -useInteractiveMode 0\n            -displayLights \"default\" \n            -displayAppearance \"smoothShaded\" \n            -activeOnly 0\n            -ignorePanZoom 0\n            -wireframeOnShaded 0\n            -headsUpDisplay 1\n            -holdOuts 1\n            -selectionHiliteDisplay 1\n            -useDefaultMaterial 0\n            -bufferMode \"double\" \n            -twoSidedLighting 0\n            -backfaceCulling 0\n            -xray 0\n            -jointXray 0\n            -activeComponentsXray 0\n            -displayTextures 0\n            -smoothWireframe 0\n            -lineWidth 1\n            -textureAnisotropic 0\n"
		+ "            -textureHilight 1\n            -textureSampling 2\n            -textureDisplay \"modulate\" \n            -textureMaxSize 32768\n            -fogging 0\n            -fogSource \"fragment\" \n            -fogMode \"linear\" \n            -fogStart 0\n            -fogEnd 100\n            -fogDensity 0.1\n            -fogColor 0.5 0.5 0.5 1 \n            -depthOfFieldPreview 1\n            -maxConstantTransparency 1\n            -rendererName \"vp2Renderer\" \n            -objectFilterShowInHUD 1\n            -isFiltered 0\n            -colorResolution 256 256 \n            -bumpResolution 512 512 \n            -textureCompression 0\n            -transparencyAlgorithm \"frontAndBackCull\" \n            -transpInShadows 0\n            -cullingOverride \"none\" \n            -lowQualityLighting 0\n            -maximumNumHardwareLights 1\n            -occlusionCulling 0\n            -shadingModel 0\n            -useBaseRenderer 0\n            -useReducedRenderer 0\n            -smallObjectCulling 0\n            -smallObjectThreshold -1 \n            -interactiveDisableShadows 0\n"
		+ "            -interactiveBackFaceCull 0\n            -sortTransparent 1\n            -controllers 1\n            -nurbsCurves 1\n            -nurbsSurfaces 1\n            -polymeshes 1\n            -subdivSurfaces 1\n            -planes 1\n            -lights 1\n            -cameras 1\n            -controlVertices 1\n            -hulls 1\n            -grid 1\n            -imagePlane 1\n            -joints 1\n            -ikHandles 1\n            -deformers 1\n            -dynamics 1\n            -particleInstancers 1\n            -fluids 1\n            -hairSystems 1\n            -follicles 1\n            -nCloths 1\n            -nParticles 1\n            -nRigids 1\n            -dynamicConstraints 1\n            -locators 1\n            -manipulators 1\n            -pluginShapes 1\n            -dimensions 1\n            -handles 1\n            -pivots 1\n            -textures 1\n            -strokes 1\n            -motionTrails 1\n            -clipGhosts 1\n            -bluePencil 1\n            -greasePencils 0\n            -excludeObjectPreset \"All\" \n"
		+ "            -shadows 0\n            -captureSequenceNumber -1\n            -width 575\n            -height 332\n            -sceneRenderFilter 0\n            $editorName;\n        modelEditor -e -viewSelected 0 $editorName;\n        modelEditor -e \n            -pluginObjects \"gpuCacheDisplayFilter\" 1 \n            $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"modelPanel\" (localizedPanelLabel(\"Front View\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tmodelPanel -edit -l (localizedPanelLabel(\"Front View\")) -mbv $menusOkayInPanels  $panelName;\n\t\t$editorName = $panelName;\n        modelEditor -e \n            -camera \"|front\" \n            -useInteractiveMode 0\n            -displayLights \"default\" \n            -displayAppearance \"smoothShaded\" \n            -activeOnly 0\n            -ignorePanZoom 0\n            -wireframeOnShaded 0\n            -headsUpDisplay 1\n            -holdOuts 1\n            -selectionHiliteDisplay 1\n"
		+ "            -useDefaultMaterial 0\n            -bufferMode \"double\" \n            -twoSidedLighting 0\n            -backfaceCulling 0\n            -xray 0\n            -jointXray 0\n            -activeComponentsXray 0\n            -displayTextures 0\n            -smoothWireframe 0\n            -lineWidth 1\n            -textureAnisotropic 0\n            -textureHilight 1\n            -textureSampling 2\n            -textureDisplay \"modulate\" \n            -textureMaxSize 32768\n            -fogging 0\n            -fogSource \"fragment\" \n            -fogMode \"linear\" \n            -fogStart 0\n            -fogEnd 100\n            -fogDensity 0.1\n            -fogColor 0.5 0.5 0.5 1 \n            -depthOfFieldPreview 1\n            -maxConstantTransparency 1\n            -rendererName \"vp2Renderer\" \n            -objectFilterShowInHUD 1\n            -isFiltered 0\n            -colorResolution 256 256 \n            -bumpResolution 512 512 \n            -textureCompression 0\n            -transparencyAlgorithm \"frontAndBackCull\" \n            -transpInShadows 0\n"
		+ "            -cullingOverride \"none\" \n            -lowQualityLighting 0\n            -maximumNumHardwareLights 1\n            -occlusionCulling 0\n            -shadingModel 0\n            -useBaseRenderer 0\n            -useReducedRenderer 0\n            -smallObjectCulling 0\n            -smallObjectThreshold -1 \n            -interactiveDisableShadows 0\n            -interactiveBackFaceCull 0\n            -sortTransparent 1\n            -controllers 1\n            -nurbsCurves 1\n            -nurbsSurfaces 1\n            -polymeshes 1\n            -subdivSurfaces 1\n            -planes 1\n            -lights 1\n            -cameras 1\n            -controlVertices 1\n            -hulls 1\n            -grid 1\n            -imagePlane 1\n            -joints 1\n            -ikHandles 1\n            -deformers 1\n            -dynamics 1\n            -particleInstancers 1\n            -fluids 1\n            -hairSystems 1\n            -follicles 1\n            -nCloths 1\n            -nParticles 1\n            -nRigids 1\n            -dynamicConstraints 1\n"
		+ "            -locators 1\n            -manipulators 1\n            -pluginShapes 1\n            -dimensions 1\n            -handles 1\n            -pivots 1\n            -textures 1\n            -strokes 1\n            -motionTrails 1\n            -clipGhosts 1\n            -bluePencil 1\n            -greasePencils 0\n            -excludeObjectPreset \"All\" \n            -shadows 0\n            -captureSequenceNumber -1\n            -width 0\n            -height 332\n            -sceneRenderFilter 0\n            $editorName;\n        modelEditor -e -viewSelected 0 $editorName;\n        modelEditor -e \n            -pluginObjects \"gpuCacheDisplayFilter\" 1 \n            $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"modelPanel\" (localizedPanelLabel(\"Persp View\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tmodelPanel -edit -l (localizedPanelLabel(\"Persp View\")) -mbv $menusOkayInPanels  $panelName;\n\t\t$editorName = $panelName;\n        modelEditor -e \n"
		+ "            -camera \"|persp\" \n            -useInteractiveMode 0\n            -displayLights \"default\" \n            -displayAppearance \"smoothShaded\" \n            -activeOnly 0\n            -ignorePanZoom 0\n            -wireframeOnShaded 0\n            -headsUpDisplay 1\n            -holdOuts 1\n            -selectionHiliteDisplay 1\n            -useDefaultMaterial 0\n            -bufferMode \"double\" \n            -twoSidedLighting 0\n            -backfaceCulling 0\n            -xray 0\n            -jointXray 0\n            -activeComponentsXray 0\n            -displayTextures 0\n            -smoothWireframe 0\n            -lineWidth 1\n            -textureAnisotropic 0\n            -textureHilight 1\n            -textureSampling 2\n            -textureDisplay \"modulate\" \n            -textureMaxSize 32768\n            -fogging 0\n            -fogSource \"fragment\" \n            -fogMode \"linear\" \n            -fogStart 0\n            -fogEnd 100\n            -fogDensity 0.1\n            -fogColor 0.5 0.5 0.5 1 \n            -depthOfFieldPreview 1\n"
		+ "            -maxConstantTransparency 1\n            -rendererName \"vp2Renderer\" \n            -objectFilterShowInHUD 1\n            -isFiltered 0\n            -colorResolution 256 256 \n            -bumpResolution 512 512 \n            -textureCompression 0\n            -transparencyAlgorithm \"frontAndBackCull\" \n            -transpInShadows 0\n            -cullingOverride \"none\" \n            -lowQualityLighting 0\n            -maximumNumHardwareLights 1\n            -occlusionCulling 0\n            -shadingModel 0\n            -useBaseRenderer 0\n            -useReducedRenderer 0\n            -smallObjectCulling 0\n            -smallObjectThreshold -1 \n            -interactiveDisableShadows 0\n            -interactiveBackFaceCull 0\n            -sortTransparent 1\n            -controllers 1\n            -nurbsCurves 1\n            -nurbsSurfaces 1\n            -polymeshes 1\n            -subdivSurfaces 1\n            -planes 1\n            -lights 1\n            -cameras 1\n            -controlVertices 1\n            -hulls 1\n            -grid 1\n"
		+ "            -imagePlane 1\n            -joints 1\n            -ikHandles 1\n            -deformers 1\n            -dynamics 1\n            -particleInstancers 1\n            -fluids 1\n            -hairSystems 1\n            -follicles 1\n            -nCloths 1\n            -nParticles 1\n            -nRigids 1\n            -dynamicConstraints 1\n            -locators 1\n            -manipulators 1\n            -pluginShapes 1\n            -dimensions 1\n            -handles 1\n            -pivots 1\n            -textures 1\n            -strokes 1\n            -motionTrails 1\n            -clipGhosts 1\n            -bluePencil 1\n            -greasePencils 0\n            -excludeObjectPreset \"All\" \n            -shadows 0\n            -captureSequenceNumber -1\n            -width 575\n            -height 332\n            -sceneRenderFilter 0\n            $editorName;\n        modelEditor -e -viewSelected 0 $editorName;\n        modelEditor -e \n            -pluginObjects \"gpuCacheDisplayFilter\" 1 \n            $editorName;\n\t\tif (!$useSceneConfig) {\n"
		+ "\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"outlinerPanel\" (localizedPanelLabel(\"ToggledOutliner\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\toutlinerPanel -edit -l (localizedPanelLabel(\"ToggledOutliner\")) -mbv $menusOkayInPanels  $panelName;\n\t\t$editorName = $panelName;\n        outlinerEditor -e \n            -docTag \"isolOutln_fromSeln\" \n            -showShapes 0\n            -showAssignedMaterials 0\n            -showTimeEditor 1\n            -showReferenceNodes 0\n            -showReferenceMembers 0\n            -showAttributes 0\n            -showConnected 0\n            -showAnimCurvesOnly 0\n            -showMuteInfo 0\n            -organizeByLayer 1\n            -organizeByClip 1\n            -showAnimLayerWeight 1\n            -autoExpandLayers 1\n            -autoExpand 0\n            -autoExpandAllAnimatedShapes 1\n            -showDagOnly 1\n            -showAssets 1\n            -showContainedOnly 1\n            -showPublishedAsConnected 0\n            -showParentContainers 0\n"
		+ "            -showContainerContents 1\n            -ignoreDagHierarchy 0\n            -expandConnections 0\n            -showUpstreamCurves 1\n            -showUnitlessCurves 1\n            -showCompounds 1\n            -showLeafs 1\n            -showNumericAttrsOnly 0\n            -highlightActive 1\n            -autoSelectNewObjects 0\n            -doNotSelectNewObjects 0\n            -dropIsParent 1\n            -transmitFilters 0\n            -setFilter \"defaultSetFilter\" \n            -showSetMembers 1\n            -allowMultiSelection 1\n            -alwaysToggleSelect 0\n            -directSelect 0\n            -isSet 0\n            -isSetMember 0\n            -showUfeItems 1\n            -displayMode \"DAG\" \n            -expandObjects 0\n            -setsIgnoreFilters 1\n            -containersIgnoreFilters 0\n            -editAttrName 0\n            -showAttrValues 0\n            -highlightSecondary 0\n            -showUVAttrsOnly 0\n            -showTextureNodesOnly 0\n            -attrAlphaOrder \"default\" \n            -animLayerFilterOptions \"allAffecting\" \n"
		+ "            -sortOrder \"none\" \n            -longNames 0\n            -niceNames 1\n            -selectCommand \"print(\\\"\\\")\" \n            -showNamespace 1\n            -showPinIcons 0\n            -mapMotionTrails 0\n            -ignoreHiddenAttribute 0\n            -ignoreOutlinerColor 0\n            -renderFilterVisible 0\n            -renderFilterIndex 0\n            -selectionOrder \"chronological\" \n            -expandAttribute 0\n            $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"outlinerPanel\" (localizedPanelLabel(\"Outliner\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\toutlinerPanel -edit -l (localizedPanelLabel(\"Outliner\")) -mbv $menusOkayInPanels  $panelName;\n\t\t$editorName = $panelName;\n        outlinerEditor -e \n            -showShapes 0\n            -showAssignedMaterials 0\n            -showTimeEditor 1\n            -showReferenceNodes 0\n            -showReferenceMembers 0\n            -showAttributes 0\n"
		+ "            -showConnected 0\n            -showAnimCurvesOnly 0\n            -showMuteInfo 0\n            -organizeByLayer 1\n            -organizeByClip 1\n            -showAnimLayerWeight 1\n            -autoExpandLayers 1\n            -autoExpand 0\n            -autoExpandAllAnimatedShapes 1\n            -showDagOnly 1\n            -showAssets 1\n            -showContainedOnly 1\n            -showPublishedAsConnected 0\n            -showParentContainers 0\n            -showContainerContents 1\n            -ignoreDagHierarchy 0\n            -expandConnections 0\n            -showUpstreamCurves 1\n            -showUnitlessCurves 1\n            -showCompounds 1\n            -showLeafs 1\n            -showNumericAttrsOnly 0\n            -highlightActive 1\n            -autoSelectNewObjects 0\n            -doNotSelectNewObjects 0\n            -dropIsParent 1\n            -transmitFilters 0\n            -setFilter \"defaultSetFilter\" \n            -showSetMembers 1\n            -allowMultiSelection 1\n            -alwaysToggleSelect 0\n            -directSelect 0\n"
		+ "            -showUfeItems 1\n            -displayMode \"DAG\" \n            -expandObjects 0\n            -setsIgnoreFilters 1\n            -containersIgnoreFilters 0\n            -editAttrName 0\n            -showAttrValues 0\n            -highlightSecondary 0\n            -showUVAttrsOnly 0\n            -showTextureNodesOnly 0\n            -attrAlphaOrder \"default\" \n            -animLayerFilterOptions \"allAffecting\" \n            -sortOrder \"none\" \n            -longNames 0\n            -niceNames 1\n            -showNamespace 1\n            -showPinIcons 0\n            -mapMotionTrails 0\n            -ignoreHiddenAttribute 0\n            -ignoreOutlinerColor 0\n            -renderFilterVisible 0\n            $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"graphEditor\" (localizedPanelLabel(\"Graph Editor\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Graph Editor\")) -mbv $menusOkayInPanels  $panelName;\n"
		+ "\n\t\t\t$editorName = ($panelName+\"OutlineEd\");\n            outlinerEditor -e \n                -showShapes 1\n                -showAssignedMaterials 0\n                -showTimeEditor 1\n                -showReferenceNodes 0\n                -showReferenceMembers 0\n                -showAttributes 1\n                -showConnected 1\n                -showAnimCurvesOnly 1\n                -showMuteInfo 0\n                -organizeByLayer 1\n                -organizeByClip 1\n                -showAnimLayerWeight 1\n                -autoExpandLayers 1\n                -autoExpand 1\n                -autoExpandAllAnimatedShapes 1\n                -showDagOnly 0\n                -showAssets 1\n                -showContainedOnly 0\n                -showPublishedAsConnected 0\n                -showParentContainers 0\n                -showContainerContents 0\n                -ignoreDagHierarchy 0\n                -expandConnections 1\n                -showUpstreamCurves 1\n                -showUnitlessCurves 1\n                -showCompounds 0\n                -showLeafs 1\n"
		+ "                -showNumericAttrsOnly 1\n                -highlightActive 0\n                -autoSelectNewObjects 1\n                -doNotSelectNewObjects 0\n                -dropIsParent 1\n                -transmitFilters 1\n                -setFilter \"0\" \n                -showSetMembers 0\n                -allowMultiSelection 1\n                -alwaysToggleSelect 0\n                -directSelect 0\n                -isSet 0\n                -isSetMember 0\n                -showUfeItems 1\n                -displayMode \"DAG\" \n                -expandObjects 0\n                -setsIgnoreFilters 1\n                -containersIgnoreFilters 0\n                -editAttrName 0\n                -showAttrValues 0\n                -highlightSecondary 0\n                -showUVAttrsOnly 0\n                -showTextureNodesOnly 0\n                -attrAlphaOrder \"default\" \n                -animLayerFilterOptions \"allAffecting\" \n                -sortOrder \"none\" \n                -longNames 0\n                -niceNames 1\n                -showNamespace 1\n"
		+ "                -showPinIcons 1\n                -mapMotionTrails 1\n                -ignoreHiddenAttribute 0\n                -ignoreOutlinerColor 0\n                -renderFilterVisible 0\n                -selectionOrder \"display\" \n                -expandAttribute 1\n                $editorName;\n\n\t\t\t$editorName = ($panelName+\"GraphEd\");\n            animCurveEditor -e \n                -displayValues 0\n                -snapTime \"integer\" \n                -snapValue \"none\" \n                -showPlayRangeShades \"on\" \n                -lockPlayRangeShades \"off\" \n                -smoothness \"fine\" \n                -resultSamples 1\n                -resultScreenSamples 0\n                -resultUpdate \"delayed\" \n                -showUpstreamCurves 1\n                -keyMinScale 1\n                -stackedCurvesMin -1\n                -stackedCurvesMax 1\n                -stackedCurvesSpace 0.2\n                -preSelectionHighlight 1\n                -limitToSelectedCurves 0\n                -constrainDrag 0\n                -valueLinesToggle 0\n"
		+ "                -outliner \"graphEditor1OutlineEd\" \n                -highlightAffectedCurves 0\n                $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"dopeSheetPanel\" (localizedPanelLabel(\"Dope Sheet\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Dope Sheet\")) -mbv $menusOkayInPanels  $panelName;\n\n\t\t\t$editorName = ($panelName+\"OutlineEd\");\n            outlinerEditor -e \n                -showShapes 1\n                -showAssignedMaterials 0\n                -showTimeEditor 1\n                -showReferenceNodes 0\n                -showReferenceMembers 0\n                -showAttributes 1\n                -showConnected 1\n                -showAnimCurvesOnly 1\n                -showMuteInfo 0\n                -organizeByLayer 1\n                -organizeByClip 1\n                -showAnimLayerWeight 1\n                -autoExpandLayers 1\n                -autoExpand 0\n"
		+ "                -autoExpandAllAnimatedShapes 1\n                -showDagOnly 0\n                -showAssets 1\n                -showContainedOnly 0\n                -showPublishedAsConnected 0\n                -showParentContainers 0\n                -showContainerContents 0\n                -ignoreDagHierarchy 0\n                -expandConnections 1\n                -showUpstreamCurves 1\n                -showUnitlessCurves 0\n                -showCompounds 1\n                -showLeafs 1\n                -showNumericAttrsOnly 1\n                -highlightActive 0\n                -autoSelectNewObjects 0\n                -doNotSelectNewObjects 1\n                -dropIsParent 1\n                -transmitFilters 0\n                -setFilter \"0\" \n                -showSetMembers 0\n                -allowMultiSelection 1\n                -alwaysToggleSelect 0\n                -directSelect 0\n                -showUfeItems 1\n                -displayMode \"DAG\" \n                -expandObjects 0\n                -setsIgnoreFilters 1\n                -containersIgnoreFilters 0\n"
		+ "                -editAttrName 0\n                -showAttrValues 0\n                -highlightSecondary 0\n                -showUVAttrsOnly 0\n                -showTextureNodesOnly 0\n                -attrAlphaOrder \"default\" \n                -animLayerFilterOptions \"allAffecting\" \n                -sortOrder \"none\" \n                -longNames 0\n                -niceNames 1\n                -showNamespace 1\n                -showPinIcons 0\n                -mapMotionTrails 1\n                -ignoreHiddenAttribute 0\n                -ignoreOutlinerColor 0\n                -renderFilterVisible 0\n                $editorName;\n\n\t\t\t$editorName = ($panelName+\"DopeSheetEd\");\n            dopeSheetEditor -e \n                -displayValues 0\n                -snapTime \"integer\" \n                -snapValue \"none\" \n                -outliner \"dopeSheetPanel1OutlineEd\" \n                -showSummary 1\n                -showScene 0\n                -hierarchyBelow 0\n                -showTicks 1\n                -selectionWindow 0 0 0 0 \n                $editorName;\n"
		+ "\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"timeEditorPanel\" (localizedPanelLabel(\"Time Editor\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Time Editor\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"clipEditorPanel\" (localizedPanelLabel(\"Trax Editor\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Trax Editor\")) -mbv $menusOkayInPanels  $panelName;\n\n\t\t\t$editorName = clipEditorNameFromPanel($panelName);\n            clipEditor -e \n                -displayValues 0\n                -snapTime \"none\" \n                -snapValue \"none\" \n                -initialized 0\n                -manageSequencer 0 \n                $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n"
		+ "\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"sequenceEditorPanel\" (localizedPanelLabel(\"Camera Sequencer\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Camera Sequencer\")) -mbv $menusOkayInPanels  $panelName;\n\n\t\t\t$editorName = sequenceEditorNameFromPanel($panelName);\n            clipEditor -e \n                -displayValues 0\n                -snapTime \"none\" \n                -snapValue \"none\" \n                -initialized 0\n                -manageSequencer 1 \n                $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"hyperGraphPanel\" (localizedPanelLabel(\"Hypergraph Hierarchy\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Hypergraph Hierarchy\")) -mbv $menusOkayInPanels  $panelName;\n\n\t\t\t$editorName = ($panelName+\"HyperGraphEd\");\n            hyperGraph -e \n"
		+ "                -graphLayoutStyle \"hierarchicalLayout\" \n                -orientation \"horiz\" \n                -mergeConnections 0\n                -zoom 1\n                -animateTransition 0\n                -showRelationships 1\n                -showShapes 0\n                -showDeformers 0\n                -showExpressions 0\n                -showConstraints 0\n                -showConnectionFromSelected 0\n                -showConnectionToSelected 0\n                -showConstraintLabels 0\n                -showUnderworld 0\n                -showInvisible 0\n                -transitionFrames 1\n                -opaqueContainers 0\n                -freeform 0\n                -imagePosition 0 0 \n                -imageScale 1\n                -imageEnabled 0\n                -graphType \"DAG\" \n                -heatMapDisplay 0\n                -updateSelection 1\n                -updateNodeAdded 1\n                -useDrawOverrideColor 0\n                -limitGraphTraversal -1\n                -range 0 0 \n                -iconSize \"smallIcons\" \n"
		+ "                -showCachedConnections 0\n                $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"hyperShadePanel\" (localizedPanelLabel(\"Hypershade\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Hypershade\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"visorPanel\" (localizedPanelLabel(\"Visor\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Visor\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"nodeEditorPanel\" (localizedPanelLabel(\"Node Editor\")) `;\n\tif ($nodeEditorPanelVisible || $nodeEditorWorkspaceControlOpen) {\n\t\tif (\"\" == $panelName) {\n\t\t\tif ($useSceneConfig) {\n"
		+ "\t\t\t\t$panelName = `scriptedPanel -unParent  -type \"nodeEditorPanel\" -l (localizedPanelLabel(\"Node Editor\")) -mbv $menusOkayInPanels `;\n\n\t\t\t$editorName = ($panelName+\"NodeEditorEd\");\n            nodeEditor -e \n                -allAttributes 0\n                -allNodes 0\n                -autoSizeNodes 1\n                -consistentNameSize 1\n                -createNodeCommand \"nodeEdCreateNodeCommand\" \n                -connectNodeOnCreation 0\n                -connectOnDrop 0\n                -copyConnectionsOnPaste 0\n                -connectionStyle \"bezier\" \n                -defaultPinnedState 0\n                -additiveGraphingMode 0\n                -connectedGraphingMode 1\n                -settingsChangedCallback \"nodeEdSyncControls\" \n                -traversalDepthLimit -1\n                -keyPressCommand \"nodeEdKeyPressCommand\" \n                -nodeTitleMode \"name\" \n                -gridSnap 0\n                -gridVisibility 1\n                -crosshairOnEdgeDragging 0\n                -popupMenuScript \"nodeEdBuildPanelMenus\" \n"
		+ "                -showNamespace 1\n                -showShapes 1\n                -showSGShapes 0\n                -showTransforms 1\n                -useAssets 1\n                -syncedSelection 1\n                -extendToShapes 1\n                -showUnitConversions 1\n                -editorMode \"default\" \n                -hasWatchpoint 0\n                $editorName;\n\t\t\t}\n\t\t} else {\n\t\t\t$label = `panel -q -label $panelName`;\n\t\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Node Editor\")) -mbv $menusOkayInPanels  $panelName;\n\n\t\t\t$editorName = ($panelName+\"NodeEditorEd\");\n            nodeEditor -e \n                -allAttributes 0\n                -allNodes 0\n                -autoSizeNodes 1\n                -consistentNameSize 1\n                -createNodeCommand \"nodeEdCreateNodeCommand\" \n                -connectNodeOnCreation 0\n                -connectOnDrop 0\n                -copyConnectionsOnPaste 0\n                -connectionStyle \"bezier\" \n                -defaultPinnedState 0\n                -additiveGraphingMode 0\n"
		+ "                -connectedGraphingMode 1\n                -settingsChangedCallback \"nodeEdSyncControls\" \n                -traversalDepthLimit -1\n                -keyPressCommand \"nodeEdKeyPressCommand\" \n                -nodeTitleMode \"name\" \n                -gridSnap 0\n                -gridVisibility 1\n                -crosshairOnEdgeDragging 0\n                -popupMenuScript \"nodeEdBuildPanelMenus\" \n                -showNamespace 1\n                -showShapes 1\n                -showSGShapes 0\n                -showTransforms 1\n                -useAssets 1\n                -syncedSelection 1\n                -extendToShapes 1\n                -showUnitConversions 1\n                -editorMode \"default\" \n                -hasWatchpoint 0\n                $editorName;\n\t\t\tif (!$useSceneConfig) {\n\t\t\t\tpanel -e -l $label $panelName;\n\t\t\t}\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"createNodePanel\" (localizedPanelLabel(\"Create Node\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n"
		+ "\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Create Node\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"polyTexturePlacementPanel\" (localizedPanelLabel(\"UV Editor\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"UV Editor\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"renderWindowPanel\" (localizedPanelLabel(\"Render View\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Render View\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"shapePanel\" (localizedPanelLabel(\"Shape Editor\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n"
		+ "\t\tshapePanel -edit -l (localizedPanelLabel(\"Shape Editor\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"posePanel\" (localizedPanelLabel(\"Pose Editor\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tposePanel -edit -l (localizedPanelLabel(\"Pose Editor\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"dynRelEdPanel\" (localizedPanelLabel(\"Dynamic Relationships\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Dynamic Relationships\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"relationshipPanel\" (localizedPanelLabel(\"Relationship Editor\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n"
		+ "\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Relationship Editor\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"referenceEditorPanel\" (localizedPanelLabel(\"Reference Editor\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Reference Editor\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"dynPaintScriptedPanelType\" (localizedPanelLabel(\"Paint Effects\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Paint Effects\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"scriptEditorPanel\" (localizedPanelLabel(\"Script Editor\")) `;\n\tif (\"\" != $panelName) {\n"
		+ "\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Script Editor\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"profilerPanel\" (localizedPanelLabel(\"Profiler Tool\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Profiler Tool\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"contentBrowserPanel\" (localizedPanelLabel(\"Content Browser\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Content Browser\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\tif ($useSceneConfig) {\n        string $configName = `getPanel -cwl (localizedPanelLabel(\"Current Layout\"))`;\n"
		+ "        if (\"\" != $configName) {\n\t\t\tpanelConfiguration -edit -label (localizedPanelLabel(\"Current Layout\")) \n\t\t\t\t-userCreated false\n\t\t\t\t-defaultImage \"vacantCell.xP:/\"\n\t\t\t\t-image \"\"\n\t\t\t\t-sc false\n\t\t\t\t-configString \"global string $gMainPane; paneLayout -e -cn \\\"quad\\\" -ps 1 50 50 -ps 2 50 50 -ps 3 99 50 -ps 4 1 50 $gMainPane;\"\n\t\t\t\t-removeAllPanels\n\t\t\t\t-ap false\n\t\t\t\t\t(localizedPanelLabel(\"Top View\")) \n\t\t\t\t\t\"modelPanel\"\n"
		+ "\t\t\t\t\t\"$panelName = `modelPanel -unParent -l (localizedPanelLabel(\\\"Top View\\\")) -mbv $menusOkayInPanels `;\\n$editorName = $panelName;\\nmodelEditor -e \\n    -cam `findStartUpCamera top` \\n    -useInteractiveMode 0\\n    -displayLights \\\"default\\\" \\n    -displayAppearance \\\"smoothShaded\\\" \\n    -activeOnly 0\\n    -ignorePanZoom 0\\n    -wireframeOnShaded 0\\n    -headsUpDisplay 1\\n    -holdOuts 1\\n    -selectionHiliteDisplay 1\\n    -useDefaultMaterial 0\\n    -bufferMode \\\"double\\\" \\n    -twoSidedLighting 0\\n    -backfaceCulling 0\\n    -xray 0\\n    -jointXray 0\\n    -activeComponentsXray 0\\n    -displayTextures 0\\n    -smoothWireframe 0\\n    -lineWidth 1\\n    -textureAnisotropic 0\\n    -textureHilight 1\\n    -textureSampling 2\\n    -textureDisplay \\\"modulate\\\" \\n    -textureMaxSize 32768\\n    -fogging 0\\n    -fogSource \\\"fragment\\\" \\n    -fogMode \\\"linear\\\" \\n    -fogStart 0\\n    -fogEnd 100\\n    -fogDensity 0.1\\n    -fogColor 0.5 0.5 0.5 1 \\n    -depthOfFieldPreview 1\\n    -maxConstantTransparency 1\\n    -rendererName \\\"vp2Renderer\\\" \\n    -objectFilterShowInHUD 1\\n    -isFiltered 0\\n    -colorResolution 256 256 \\n    -bumpResolution 512 512 \\n    -textureCompression 0\\n    -transparencyAlgorithm \\\"frontAndBackCull\\\" \\n    -transpInShadows 0\\n    -cullingOverride \\\"none\\\" \\n    -lowQualityLighting 0\\n    -maximumNumHardwareLights 1\\n    -occlusionCulling 0\\n    -shadingModel 0\\n    -useBaseRenderer 0\\n    -useReducedRenderer 0\\n    -smallObjectCulling 0\\n    -smallObjectThreshold -1 \\n    -interactiveDisableShadows 0\\n    -interactiveBackFaceCull 0\\n    -sortTransparent 1\\n    -controllers 1\\n    -nurbsCurves 1\\n    -nurbsSurfaces 1\\n    -polymeshes 1\\n    -subdivSurfaces 1\\n    -planes 1\\n    -lights 1\\n    -cameras 1\\n    -controlVertices 1\\n    -hulls 1\\n    -grid 1\\n    -imagePlane 1\\n    -joints 1\\n    -ikHandles 1\\n    -deformers 1\\n    -dynamics 1\\n    -particleInstancers 1\\n    -fluids 1\\n    -hairSystems 1\\n    -follicles 1\\n    -nCloths 1\\n    -nParticles 1\\n    -nRigids 1\\n    -dynamicConstraints 1\\n    -locators 1\\n    -manipulators 1\\n    -pluginShapes 1\\n    -dimensions 1\\n    -handles 1\\n    -pivots 1\\n    -textures 1\\n    -strokes 1\\n    -motionTrails 1\\n    -clipGhosts 1\\n    -bluePencil 1\\n    -greasePencils 0\\n    -excludeObjectPreset \\\"All\\\" \\n    -shadows 0\\n    -captureSequenceNumber -1\\n    -width 575\\n    -height 332\\n    -sceneRenderFilter 0\\n    $editorName;\\nmodelEditor -e -viewSelected 0 $editorName;\\nmodelEditor -e \\n    -pluginObjects \\\"gpuCacheDisplayFilter\\\" 1 \\n    $editorName\"\n"
		+ "\t\t\t\t\t\"modelPanel -edit -l (localizedPanelLabel(\\\"Top View\\\")) -mbv $menusOkayInPanels  $panelName;\\n$editorName = $panelName;\\nmodelEditor -e \\n    -cam `findStartUpCamera top` \\n    -useInteractiveMode 0\\n    -displayLights \\\"default\\\" \\n    -displayAppearance \\\"smoothShaded\\\" \\n    -activeOnly 0\\n    -ignorePanZoom 0\\n    -wireframeOnShaded 0\\n    -headsUpDisplay 1\\n    -holdOuts 1\\n    -selectionHiliteDisplay 1\\n    -useDefaultMaterial 0\\n    -bufferMode \\\"double\\\" \\n    -twoSidedLighting 0\\n    -backfaceCulling 0\\n    -xray 0\\n    -jointXray 0\\n    -activeComponentsXray 0\\n    -displayTextures 0\\n    -smoothWireframe 0\\n    -lineWidth 1\\n    -textureAnisotropic 0\\n    -textureHilight 1\\n    -textureSampling 2\\n    -textureDisplay \\\"modulate\\\" \\n    -textureMaxSize 32768\\n    -fogging 0\\n    -fogSource \\\"fragment\\\" \\n    -fogMode \\\"linear\\\" \\n    -fogStart 0\\n    -fogEnd 100\\n    -fogDensity 0.1\\n    -fogColor 0.5 0.5 0.5 1 \\n    -depthOfFieldPreview 1\\n    -maxConstantTransparency 1\\n    -rendererName \\\"vp2Renderer\\\" \\n    -objectFilterShowInHUD 1\\n    -isFiltered 0\\n    -colorResolution 256 256 \\n    -bumpResolution 512 512 \\n    -textureCompression 0\\n    -transparencyAlgorithm \\\"frontAndBackCull\\\" \\n    -transpInShadows 0\\n    -cullingOverride \\\"none\\\" \\n    -lowQualityLighting 0\\n    -maximumNumHardwareLights 1\\n    -occlusionCulling 0\\n    -shadingModel 0\\n    -useBaseRenderer 0\\n    -useReducedRenderer 0\\n    -smallObjectCulling 0\\n    -smallObjectThreshold -1 \\n    -interactiveDisableShadows 0\\n    -interactiveBackFaceCull 0\\n    -sortTransparent 1\\n    -controllers 1\\n    -nurbsCurves 1\\n    -nurbsSurfaces 1\\n    -polymeshes 1\\n    -subdivSurfaces 1\\n    -planes 1\\n    -lights 1\\n    -cameras 1\\n    -controlVertices 1\\n    -hulls 1\\n    -grid 1\\n    -imagePlane 1\\n    -joints 1\\n    -ikHandles 1\\n    -deformers 1\\n    -dynamics 1\\n    -particleInstancers 1\\n    -fluids 1\\n    -hairSystems 1\\n    -follicles 1\\n    -nCloths 1\\n    -nParticles 1\\n    -nRigids 1\\n    -dynamicConstraints 1\\n    -locators 1\\n    -manipulators 1\\n    -pluginShapes 1\\n    -dimensions 1\\n    -handles 1\\n    -pivots 1\\n    -textures 1\\n    -strokes 1\\n    -motionTrails 1\\n    -clipGhosts 1\\n    -bluePencil 1\\n    -greasePencils 0\\n    -excludeObjectPreset \\\"All\\\" \\n    -shadows 0\\n    -captureSequenceNumber -1\\n    -width 575\\n    -height 332\\n    -sceneRenderFilter 0\\n    $editorName;\\nmodelEditor -e -viewSelected 0 $editorName;\\nmodelEditor -e \\n    -pluginObjects \\\"gpuCacheDisplayFilter\\\" 1 \\n    $editorName\"\n"
		+ "\t\t\t\t-ap false\n\t\t\t\t\t(localizedPanelLabel(\"Persp View\")) \n\t\t\t\t\t\"modelPanel\"\n"
		+ "\t\t\t\t\t\"$panelName = `modelPanel -unParent -l (localizedPanelLabel(\\\"Persp View\\\")) -mbv $menusOkayInPanels `;\\n$editorName = $panelName;\\nmodelEditor -e \\n    -cam `findStartUpCamera persp` \\n    -useInteractiveMode 0\\n    -displayLights \\\"default\\\" \\n    -displayAppearance \\\"smoothShaded\\\" \\n    -activeOnly 0\\n    -ignorePanZoom 0\\n    -wireframeOnShaded 0\\n    -headsUpDisplay 1\\n    -holdOuts 1\\n    -selectionHiliteDisplay 1\\n    -useDefaultMaterial 0\\n    -bufferMode \\\"double\\\" \\n    -twoSidedLighting 0\\n    -backfaceCulling 0\\n    -xray 0\\n    -jointXray 0\\n    -activeComponentsXray 0\\n    -displayTextures 0\\n    -smoothWireframe 0\\n    -lineWidth 1\\n    -textureAnisotropic 0\\n    -textureHilight 1\\n    -textureSampling 2\\n    -textureDisplay \\\"modulate\\\" \\n    -textureMaxSize 32768\\n    -fogging 0\\n    -fogSource \\\"fragment\\\" \\n    -fogMode \\\"linear\\\" \\n    -fogStart 0\\n    -fogEnd 100\\n    -fogDensity 0.1\\n    -fogColor 0.5 0.5 0.5 1 \\n    -depthOfFieldPreview 1\\n    -maxConstantTransparency 1\\n    -rendererName \\\"vp2Renderer\\\" \\n    -objectFilterShowInHUD 1\\n    -isFiltered 0\\n    -colorResolution 256 256 \\n    -bumpResolution 512 512 \\n    -textureCompression 0\\n    -transparencyAlgorithm \\\"frontAndBackCull\\\" \\n    -transpInShadows 0\\n    -cullingOverride \\\"none\\\" \\n    -lowQualityLighting 0\\n    -maximumNumHardwareLights 1\\n    -occlusionCulling 0\\n    -shadingModel 0\\n    -useBaseRenderer 0\\n    -useReducedRenderer 0\\n    -smallObjectCulling 0\\n    -smallObjectThreshold -1 \\n    -interactiveDisableShadows 0\\n    -interactiveBackFaceCull 0\\n    -sortTransparent 1\\n    -controllers 1\\n    -nurbsCurves 1\\n    -nurbsSurfaces 1\\n    -polymeshes 1\\n    -subdivSurfaces 1\\n    -planes 1\\n    -lights 1\\n    -cameras 1\\n    -controlVertices 1\\n    -hulls 1\\n    -grid 1\\n    -imagePlane 1\\n    -joints 1\\n    -ikHandles 1\\n    -deformers 1\\n    -dynamics 1\\n    -particleInstancers 1\\n    -fluids 1\\n    -hairSystems 1\\n    -follicles 1\\n    -nCloths 1\\n    -nParticles 1\\n    -nRigids 1\\n    -dynamicConstraints 1\\n    -locators 1\\n    -manipulators 1\\n    -pluginShapes 1\\n    -dimensions 1\\n    -handles 1\\n    -pivots 1\\n    -textures 1\\n    -strokes 1\\n    -motionTrails 1\\n    -clipGhosts 1\\n    -bluePencil 1\\n    -greasePencils 0\\n    -excludeObjectPreset \\\"All\\\" \\n    -shadows 0\\n    -captureSequenceNumber -1\\n    -width 575\\n    -height 332\\n    -sceneRenderFilter 0\\n    $editorName;\\nmodelEditor -e -viewSelected 0 $editorName;\\nmodelEditor -e \\n    -pluginObjects \\\"gpuCacheDisplayFilter\\\" 1 \\n    $editorName\"\n"
		+ "\t\t\t\t\t\"modelPanel -edit -l (localizedPanelLabel(\\\"Persp View\\\")) -mbv $menusOkayInPanels  $panelName;\\n$editorName = $panelName;\\nmodelEditor -e \\n    -cam `findStartUpCamera persp` \\n    -useInteractiveMode 0\\n    -displayLights \\\"default\\\" \\n    -displayAppearance \\\"smoothShaded\\\" \\n    -activeOnly 0\\n    -ignorePanZoom 0\\n    -wireframeOnShaded 0\\n    -headsUpDisplay 1\\n    -holdOuts 1\\n    -selectionHiliteDisplay 1\\n    -useDefaultMaterial 0\\n    -bufferMode \\\"double\\\" \\n    -twoSidedLighting 0\\n    -backfaceCulling 0\\n    -xray 0\\n    -jointXray 0\\n    -activeComponentsXray 0\\n    -displayTextures 0\\n    -smoothWireframe 0\\n    -lineWidth 1\\n    -textureAnisotropic 0\\n    -textureHilight 1\\n    -textureSampling 2\\n    -textureDisplay \\\"modulate\\\" \\n    -textureMaxSize 32768\\n    -fogging 0\\n    -fogSource \\\"fragment\\\" \\n    -fogMode \\\"linear\\\" \\n    -fogStart 0\\n    -fogEnd 100\\n    -fogDensity 0.1\\n    -fogColor 0.5 0.5 0.5 1 \\n    -depthOfFieldPreview 1\\n    -maxConstantTransparency 1\\n    -rendererName \\\"vp2Renderer\\\" \\n    -objectFilterShowInHUD 1\\n    -isFiltered 0\\n    -colorResolution 256 256 \\n    -bumpResolution 512 512 \\n    -textureCompression 0\\n    -transparencyAlgorithm \\\"frontAndBackCull\\\" \\n    -transpInShadows 0\\n    -cullingOverride \\\"none\\\" \\n    -lowQualityLighting 0\\n    -maximumNumHardwareLights 1\\n    -occlusionCulling 0\\n    -shadingModel 0\\n    -useBaseRenderer 0\\n    -useReducedRenderer 0\\n    -smallObjectCulling 0\\n    -smallObjectThreshold -1 \\n    -interactiveDisableShadows 0\\n    -interactiveBackFaceCull 0\\n    -sortTransparent 1\\n    -controllers 1\\n    -nurbsCurves 1\\n    -nurbsSurfaces 1\\n    -polymeshes 1\\n    -subdivSurfaces 1\\n    -planes 1\\n    -lights 1\\n    -cameras 1\\n    -controlVertices 1\\n    -hulls 1\\n    -grid 1\\n    -imagePlane 1\\n    -joints 1\\n    -ikHandles 1\\n    -deformers 1\\n    -dynamics 1\\n    -particleInstancers 1\\n    -fluids 1\\n    -hairSystems 1\\n    -follicles 1\\n    -nCloths 1\\n    -nParticles 1\\n    -nRigids 1\\n    -dynamicConstraints 1\\n    -locators 1\\n    -manipulators 1\\n    -pluginShapes 1\\n    -dimensions 1\\n    -handles 1\\n    -pivots 1\\n    -textures 1\\n    -strokes 1\\n    -motionTrails 1\\n    -clipGhosts 1\\n    -bluePencil 1\\n    -greasePencils 0\\n    -excludeObjectPreset \\\"All\\\" \\n    -shadows 0\\n    -captureSequenceNumber -1\\n    -width 575\\n    -height 332\\n    -sceneRenderFilter 0\\n    $editorName;\\nmodelEditor -e -viewSelected 0 $editorName;\\nmodelEditor -e \\n    -pluginObjects \\\"gpuCacheDisplayFilter\\\" 1 \\n    $editorName\"\n"
		+ "\t\t\t\t-ap false\n\t\t\t\t\t(localizedPanelLabel(\"Graph Editor\")) \n\t\t\t\t\t\"scriptedPanel\"\n"
		+ "\t\t\t\t\t\"$panelName = `scriptedPanel -unParent  -type \\\"graphEditor\\\" -l (localizedPanelLabel(\\\"Graph Editor\\\")) -mbv $menusOkayInPanels `;\\n\\n\\t\\t\\t$editorName = ($panelName+\\\"OutlineEd\\\");\\n            outlinerEditor -e \\n                -showShapes 1\\n                -showAssignedMaterials 0\\n                -showTimeEditor 1\\n                -showReferenceNodes 0\\n                -showReferenceMembers 0\\n                -showAttributes 1\\n                -showConnected 1\\n                -showAnimCurvesOnly 1\\n                -showMuteInfo 0\\n                -organizeByLayer 1\\n                -organizeByClip 1\\n                -showAnimLayerWeight 1\\n                -autoExpandLayers 1\\n                -autoExpand 1\\n                -autoExpandAllAnimatedShapes 1\\n                -showDagOnly 0\\n                -showAssets 1\\n                -showContainedOnly 0\\n                -showPublishedAsConnected 0\\n                -showParentContainers 0\\n                -showContainerContents 0\\n                -ignoreDagHierarchy 0\\n                -expandConnections 1\\n                -showUpstreamCurves 1\\n                -showUnitlessCurves 1\\n                -showCompounds 0\\n                -showLeafs 1\\n                -showNumericAttrsOnly 1\\n                -highlightActive 0\\n                -autoSelectNewObjects 1\\n                -doNotSelectNewObjects 0\\n                -dropIsParent 1\\n                -transmitFilters 1\\n                -setFilter \\\"0\\\" \\n                -showSetMembers 0\\n                -allowMultiSelection 1\\n                -alwaysToggleSelect 0\\n                -directSelect 0\\n                -isSet 0\\n                -isSetMember 0\\n                -showUfeItems 1\\n                -displayMode \\\"DAG\\\" \\n                -expandObjects 0\\n                -setsIgnoreFilters 1\\n                -containersIgnoreFilters 0\\n                -editAttrName 0\\n                -showAttrValues 0\\n                -highlightSecondary 0\\n                -showUVAttrsOnly 0\\n                -showTextureNodesOnly 0\\n                -attrAlphaOrder \\\"default\\\" \\n                -animLayerFilterOptions \\\"allAffecting\\\" \\n                -sortOrder \\\"none\\\" \\n                -longNames 0\\n                -niceNames 1\\n                -showNamespace 1\\n                -showPinIcons 1\\n                -mapMotionTrails 1\\n                -ignoreHiddenAttribute 0\\n                -ignoreOutlinerColor 0\\n                -renderFilterVisible 0\\n                -selectionOrder \\\"display\\\" \\n                -expandAttribute 1\\n                $editorName;\\n\\n\\t\\t\\t$editorName = ($panelName+\\\"GraphEd\\\");\\n            animCurveEditor -e \\n                -displayValues 0\\n                -snapTime \\\"integer\\\" \\n                -snapValue \\\"none\\\" \\n                -showPlayRangeShades \\\"on\\\" \\n                -lockPlayRangeShades \\\"off\\\" \\n                -smoothness \\\"fine\\\" \\n                -resultSamples 1\\n                -resultScreenSamples 0\\n                -resultUpdate \\\"delayed\\\" \\n                -showUpstreamCurves 1\\n                -keyMinScale 1\\n                -stackedCurvesMin -1\\n                -stackedCurvesMax 1\\n                -stackedCurvesSpace 0.2\\n                -preSelectionHighlight 1\\n                -limitToSelectedCurves 0\\n                -constrainDrag 0\\n                -valueLinesToggle 0\\n                -outliner \\\"graphEditor1OutlineEd\\\" \\n                -highlightAffectedCurves 0\\n                $editorName\"\n"
		+ "\t\t\t\t\t\"scriptedPanel -edit -l (localizedPanelLabel(\\\"Graph Editor\\\")) -mbv $menusOkayInPanels  $panelName;\\n\\n\\t\\t\\t$editorName = ($panelName+\\\"OutlineEd\\\");\\n            outlinerEditor -e \\n                -showShapes 1\\n                -showAssignedMaterials 0\\n                -showTimeEditor 1\\n                -showReferenceNodes 0\\n                -showReferenceMembers 0\\n                -showAttributes 1\\n                -showConnected 1\\n                -showAnimCurvesOnly 1\\n                -showMuteInfo 0\\n                -organizeByLayer 1\\n                -organizeByClip 1\\n                -showAnimLayerWeight 1\\n                -autoExpandLayers 1\\n                -autoExpand 1\\n                -autoExpandAllAnimatedShapes 1\\n                -showDagOnly 0\\n                -showAssets 1\\n                -showContainedOnly 0\\n                -showPublishedAsConnected 0\\n                -showParentContainers 0\\n                -showContainerContents 0\\n                -ignoreDagHierarchy 0\\n                -expandConnections 1\\n                -showUpstreamCurves 1\\n                -showUnitlessCurves 1\\n                -showCompounds 0\\n                -showLeafs 1\\n                -showNumericAttrsOnly 1\\n                -highlightActive 0\\n                -autoSelectNewObjects 1\\n                -doNotSelectNewObjects 0\\n                -dropIsParent 1\\n                -transmitFilters 1\\n                -setFilter \\\"0\\\" \\n                -showSetMembers 0\\n                -allowMultiSelection 1\\n                -alwaysToggleSelect 0\\n                -directSelect 0\\n                -isSet 0\\n                -isSetMember 0\\n                -showUfeItems 1\\n                -displayMode \\\"DAG\\\" \\n                -expandObjects 0\\n                -setsIgnoreFilters 1\\n                -containersIgnoreFilters 0\\n                -editAttrName 0\\n                -showAttrValues 0\\n                -highlightSecondary 0\\n                -showUVAttrsOnly 0\\n                -showTextureNodesOnly 0\\n                -attrAlphaOrder \\\"default\\\" \\n                -animLayerFilterOptions \\\"allAffecting\\\" \\n                -sortOrder \\\"none\\\" \\n                -longNames 0\\n                -niceNames 1\\n                -showNamespace 1\\n                -showPinIcons 1\\n                -mapMotionTrails 1\\n                -ignoreHiddenAttribute 0\\n                -ignoreOutlinerColor 0\\n                -renderFilterVisible 0\\n                -selectionOrder \\\"display\\\" \\n                -expandAttribute 1\\n                $editorName;\\n\\n\\t\\t\\t$editorName = ($panelName+\\\"GraphEd\\\");\\n            animCurveEditor -e \\n                -displayValues 0\\n                -snapTime \\\"integer\\\" \\n                -snapValue \\\"none\\\" \\n                -showPlayRangeShades \\\"on\\\" \\n                -lockPlayRangeShades \\\"off\\\" \\n                -smoothness \\\"fine\\\" \\n                -resultSamples 1\\n                -resultScreenSamples 0\\n                -resultUpdate \\\"delayed\\\" \\n                -showUpstreamCurves 1\\n                -keyMinScale 1\\n                -stackedCurvesMin -1\\n                -stackedCurvesMax 1\\n                -stackedCurvesSpace 0.2\\n                -preSelectionHighlight 1\\n                -limitToSelectedCurves 0\\n                -constrainDrag 0\\n                -valueLinesToggle 0\\n                -outliner \\\"graphEditor1OutlineEd\\\" \\n                -highlightAffectedCurves 0\\n                $editorName\"\n"
		+ "\t\t\t\t-ap false\n\t\t\t\t\t(localizedPanelLabel(\"Front View\")) \n\t\t\t\t\t\"modelPanel\"\n"
		+ "\t\t\t\t\t\"$panelName = `modelPanel -unParent -l (localizedPanelLabel(\\\"Front View\\\")) -mbv $menusOkayInPanels `;\\n$editorName = $panelName;\\nmodelEditor -e \\n    -cam `findStartUpCamera front` \\n    -useInteractiveMode 0\\n    -displayLights \\\"default\\\" \\n    -displayAppearance \\\"smoothShaded\\\" \\n    -activeOnly 0\\n    -ignorePanZoom 0\\n    -wireframeOnShaded 0\\n    -headsUpDisplay 1\\n    -holdOuts 1\\n    -selectionHiliteDisplay 1\\n    -useDefaultMaterial 0\\n    -bufferMode \\\"double\\\" \\n    -twoSidedLighting 0\\n    -backfaceCulling 0\\n    -xray 0\\n    -jointXray 0\\n    -activeComponentsXray 0\\n    -displayTextures 0\\n    -smoothWireframe 0\\n    -lineWidth 1\\n    -textureAnisotropic 0\\n    -textureHilight 1\\n    -textureSampling 2\\n    -textureDisplay \\\"modulate\\\" \\n    -textureMaxSize 32768\\n    -fogging 0\\n    -fogSource \\\"fragment\\\" \\n    -fogMode \\\"linear\\\" \\n    -fogStart 0\\n    -fogEnd 100\\n    -fogDensity 0.1\\n    -fogColor 0.5 0.5 0.5 1 \\n    -depthOfFieldPreview 1\\n    -maxConstantTransparency 1\\n    -rendererName \\\"vp2Renderer\\\" \\n    -objectFilterShowInHUD 1\\n    -isFiltered 0\\n    -colorResolution 256 256 \\n    -bumpResolution 512 512 \\n    -textureCompression 0\\n    -transparencyAlgorithm \\\"frontAndBackCull\\\" \\n    -transpInShadows 0\\n    -cullingOverride \\\"none\\\" \\n    -lowQualityLighting 0\\n    -maximumNumHardwareLights 1\\n    -occlusionCulling 0\\n    -shadingModel 0\\n    -useBaseRenderer 0\\n    -useReducedRenderer 0\\n    -smallObjectCulling 0\\n    -smallObjectThreshold -1 \\n    -interactiveDisableShadows 0\\n    -interactiveBackFaceCull 0\\n    -sortTransparent 1\\n    -controllers 1\\n    -nurbsCurves 1\\n    -nurbsSurfaces 1\\n    -polymeshes 1\\n    -subdivSurfaces 1\\n    -planes 1\\n    -lights 1\\n    -cameras 1\\n    -controlVertices 1\\n    -hulls 1\\n    -grid 1\\n    -imagePlane 1\\n    -joints 1\\n    -ikHandles 1\\n    -deformers 1\\n    -dynamics 1\\n    -particleInstancers 1\\n    -fluids 1\\n    -hairSystems 1\\n    -follicles 1\\n    -nCloths 1\\n    -nParticles 1\\n    -nRigids 1\\n    -dynamicConstraints 1\\n    -locators 1\\n    -manipulators 1\\n    -pluginShapes 1\\n    -dimensions 1\\n    -handles 1\\n    -pivots 1\\n    -textures 1\\n    -strokes 1\\n    -motionTrails 1\\n    -clipGhosts 1\\n    -bluePencil 1\\n    -greasePencils 0\\n    -excludeObjectPreset \\\"All\\\" \\n    -shadows 0\\n    -captureSequenceNumber -1\\n    -width 0\\n    -height 332\\n    -sceneRenderFilter 0\\n    $editorName;\\nmodelEditor -e -viewSelected 0 $editorName;\\nmodelEditor -e \\n    -pluginObjects \\\"gpuCacheDisplayFilter\\\" 1 \\n    $editorName\"\n"
		+ "\t\t\t\t\t\"modelPanel -edit -l (localizedPanelLabel(\\\"Front View\\\")) -mbv $menusOkayInPanels  $panelName;\\n$editorName = $panelName;\\nmodelEditor -e \\n    -cam `findStartUpCamera front` \\n    -useInteractiveMode 0\\n    -displayLights \\\"default\\\" \\n    -displayAppearance \\\"smoothShaded\\\" \\n    -activeOnly 0\\n    -ignorePanZoom 0\\n    -wireframeOnShaded 0\\n    -headsUpDisplay 1\\n    -holdOuts 1\\n    -selectionHiliteDisplay 1\\n    -useDefaultMaterial 0\\n    -bufferMode \\\"double\\\" \\n    -twoSidedLighting 0\\n    -backfaceCulling 0\\n    -xray 0\\n    -jointXray 0\\n    -activeComponentsXray 0\\n    -displayTextures 0\\n    -smoothWireframe 0\\n    -lineWidth 1\\n    -textureAnisotropic 0\\n    -textureHilight 1\\n    -textureSampling 2\\n    -textureDisplay \\\"modulate\\\" \\n    -textureMaxSize 32768\\n    -fogging 0\\n    -fogSource \\\"fragment\\\" \\n    -fogMode \\\"linear\\\" \\n    -fogStart 0\\n    -fogEnd 100\\n    -fogDensity 0.1\\n    -fogColor 0.5 0.5 0.5 1 \\n    -depthOfFieldPreview 1\\n    -maxConstantTransparency 1\\n    -rendererName \\\"vp2Renderer\\\" \\n    -objectFilterShowInHUD 1\\n    -isFiltered 0\\n    -colorResolution 256 256 \\n    -bumpResolution 512 512 \\n    -textureCompression 0\\n    -transparencyAlgorithm \\\"frontAndBackCull\\\" \\n    -transpInShadows 0\\n    -cullingOverride \\\"none\\\" \\n    -lowQualityLighting 0\\n    -maximumNumHardwareLights 1\\n    -occlusionCulling 0\\n    -shadingModel 0\\n    -useBaseRenderer 0\\n    -useReducedRenderer 0\\n    -smallObjectCulling 0\\n    -smallObjectThreshold -1 \\n    -interactiveDisableShadows 0\\n    -interactiveBackFaceCull 0\\n    -sortTransparent 1\\n    -controllers 1\\n    -nurbsCurves 1\\n    -nurbsSurfaces 1\\n    -polymeshes 1\\n    -subdivSurfaces 1\\n    -planes 1\\n    -lights 1\\n    -cameras 1\\n    -controlVertices 1\\n    -hulls 1\\n    -grid 1\\n    -imagePlane 1\\n    -joints 1\\n    -ikHandles 1\\n    -deformers 1\\n    -dynamics 1\\n    -particleInstancers 1\\n    -fluids 1\\n    -hairSystems 1\\n    -follicles 1\\n    -nCloths 1\\n    -nParticles 1\\n    -nRigids 1\\n    -dynamicConstraints 1\\n    -locators 1\\n    -manipulators 1\\n    -pluginShapes 1\\n    -dimensions 1\\n    -handles 1\\n    -pivots 1\\n    -textures 1\\n    -strokes 1\\n    -motionTrails 1\\n    -clipGhosts 1\\n    -bluePencil 1\\n    -greasePencils 0\\n    -excludeObjectPreset \\\"All\\\" \\n    -shadows 0\\n    -captureSequenceNumber -1\\n    -width 0\\n    -height 332\\n    -sceneRenderFilter 0\\n    $editorName;\\nmodelEditor -e -viewSelected 0 $editorName;\\nmodelEditor -e \\n    -pluginObjects \\\"gpuCacheDisplayFilter\\\" 1 \\n    $editorName\"\n"
		+ "\t\t\t\t$configName;\n\n            setNamedPanelLayout (localizedPanelLabel(\"Current Layout\"));\n        }\n\n        panelHistory -e -clear mainPanelHistory;\n        sceneUIReplacement -clear;\n\t}\n\n\ngrid -spacing 5 -size 12 -divisions 5 -displayAxes yes -displayGridLines yes -displayDivisionLines yes -displayPerspectiveLabels no -displayOrthographicLabels no -displayAxesBold yes -perspectiveLabelPosition axis -orthographicLabelPosition edge;\nviewManip -drawCompass 0 -compassAngle 0 -frontParameters \"\" -homeParameters \"\" -selectionLockParameters \"\";\n}\n");
	setAttr ".st" 3;
createNode script -n "sceneConfigurationScriptNode";
	rename -uid "6BA40F4A-42D6-7AB0-8BF1-04945A278A16";
	setAttr ".b" -type "string" "playbackOptions -min 0 -max 75 -ast 0 -aet 75 ";
	setAttr ".st" 6;
createNode animCurveTU -n "target_pt_visibility";
	rename -uid "376D3A80-4D7D-ADFB-694C-9D83A7E125AC";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 76 ".ktv[0:75]"  0 1 1 1 2 1 3 1 4 1 5 1 6 1 7 1 8 1 9 1
		 10 1 11 1 12 1 13 1 14 1 15 1 16 1 17 1 18 1 19 1 20 1 21 1 22 1 23 1 24 1 25 1 26 1
		 27 1 28 1 29 1 30 1 31 1 32 1 33 1 34 1 35 1 36 1 37 1 38 1 39 1 40 1 41 1 42 1 43 1
		 44 1 45 1 46 1 47 1 48 1 49 1 50 1 51 1 52 1 53 1 54 1 55 1 56 1 57 1 58 1 59 1 60 1
		 61 1 62 1 63 1 64 1 65 1 66 1 67 1 68 1 69 1 70 1 71 1 72 1 73 1 74 1 75 1;
createNode animCurveTL -n "target_pt_translateX";
	rename -uid "A860536C-4DA8-ABA3-07F7-4E98AD2631F4";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 76 ".ktv[0:75]"  0 0 1 0.038599354569765099 2 0.15079607100527903
		 3 0.33096618536238898 4 0.57331513460078976 5 0.87126346116947506 6 1.2172565964520008
		 7 1.601854627178247 8 2.0123772454637199 9 2.4286842479208866 10 2.8088023651027658
		 11 3.0117253168266664 12 2.6525329313773098 13 1.9712022879839219 14 1.2254336913847688
		 15 0.46415693598789853 16 -0.29274311527773311 17 -1.0305761100071338 18 -1.736390387477653
		 19 -2.4022837924975953 20 -3.0205290085462062 21 -3.5826071523607625 22 -4.0827299817706404
		 23 -4.5170700692250323 24 -4.8605360203382286 25 -5.0086951901855166 26 -4.7949021008485229
		 27 -4.3587839869927265 28 -3.8424609611325926 29 -3.2871709731183127 30 -2.7060974930665207
		 31 -2.1086054462909898 32 -1.5064245299840602 33 -0.89930745837014314 34 -0.27208994456926472
		 35 0.40150016683222001 36 1.1701341529457543 37 2.1030749454066795 38 2.9197277651406548
		 39 3.4587787821249174 40 3.8209882387432872 41 4.0183728249603092 42 3.9957215430097071
		 43 3.6092966978175438 44 2.2976558070751687 45 0.64311414902041419 46 -1.0882451180834787
		 47 -2.9183000891057649 48 -4.7815954227340587 49 -6.5244942138724422 50 -7.3080197315973514
		 51 -6.7782903018104763 52 -5.5663615462595057 53 -4.0044589894493008 54 -2.3413457367528694
		 55 -0.73107746802730411 56 0.78130183472310488 57 2.1792163589201885 58 3.4503199710627461
		 59 4.5904198703226475 60 5.6444723980675677 61 6.6174184730394137 62 7.5018298618338619
		 63 8.2908265282077807 64 8.9822047712784023 65 9.5791194944278271 66 10.089414123457324
		 67 10.522905907113644 68 10.889000176711916 69 11.195394835614229 70 11.447821289308958
		 71 11.650092698950953 72 11.80489510468143 73 11.914051035692763 74 11.978681767152942
		 75 12.000000000000046;
createNode animCurveTL -n "target_pt_translateY";
	rename -uid "9CDBA982-4C35-F25E-50EF-F18A207B008A";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 76 ".ktv[0:75]"  0 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 9 0
		 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0
		 27 0 28 0 29 0 30 0 31 0 32 0 33 0 34 0 35 0 36 0 37 0 38 0 39 0 40 0 41 0 42 0 43 0
		 44 0 45 0 46 0 47 0 48 0 49 0 50 0 51 0 52 0 53 0 54 0 55 0 56 0 57 0 58 0 59 0 60 0
		 61 0 62 0 63 0 64 0 65 0 66 0 67 0 68 0 69 0 70 0 71 0 72 0 73 0 74 0 75 0;
createNode animCurveTL -n "target_pt_translateZ";
	rename -uid "8BF33CC6-4230-19AC-9A75-D28C79D12F77";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 76 ".ktv[0:75]"  0 12.00000000000062 1 11.962416698117973
		 2 11.853141000132648 3 11.677383380161245 4 11.439853935035293 5 11.144755659382437
		 6 10.795157613701923 7 10.392605445978214 8 9.9358899236049822 9 9.4188627912694045
		 10 8.8244910027780783 11 8.1196427257895021 12 7.4701517888820792 13 7.0795373292058859
		 14 6.7917790610800921 15 6.5328269254521292 16 6.2707739563170879 17 5.9874373861838164
		 18 5.6745205979728235 19 5.3373867155465549 20 4.9823066345723888 21 4.6138563562222279
		 22 4.2316269791435639 23 3.8243776188669365 24 3.3712829365435826 25 2.8473881145849429
		 26 2.361225773683874 27 2.0481170829536186 28 1.8737099213610968 29 1.8051236615817703
		 30 1.8334136565199028 31 1.9643645139799861 32 2.208489189824022 33 2.5492757082571367
		 34 2.9613507804780363 35 3.4158714786543629 36 3.8476216593510246 37 3.9783288235422556
		 38 3.3546879934729241 39 2.3531460709509622 40 1.1480363835052085 41 -0.22523481586102251
		 42 -1.725607954491351 43 -3.272416873066148 44 -4.0672494548379134 45 -3.492689919522546
		 46 -2.9813379299144818 47 -2.7579725534944379 48 -2.8557732334865111 49 -3.5072306735002639
		 50 -5.1240834696105244 51 -6.8729038270338281 52 -8.2051534621606255 53 -8.9986113728083374
		 54 -9.2987230649931316 55 -9.3364889832179916 56 -9.2618263094850803 57 -9.1519066289339985
		 58 -9.0517764682249329 59 -8.9892680677721533 60 -8.9836059123089154 61 -9.0591788835730718
		 62 -9.2227585407941088 63 -9.46080565921012 64 -9.7527320580909276 65 -10.074537982988774
		 66 -10.403502504729815 67 -10.721261549535441 68 -11.014673083786544 69 -11.275218158114066
		 70 -11.497949486188892 71 -11.680252918810773 72 -11.821293591997971 73 -11.921207634906162
		 74 -11.980453061813707 75 -12.000000000000046;
createNode animCurveTA -n "target_pt_rotateX";
	rename -uid "86F00F33-4215-A147-0D49-378C7121652F";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 76 ".ktv[0:75]"  0 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 9 0
		 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0
		 27 0 28 0 29 0 30 0 31 0 32 0 33 0 34 0 35 0 36 0 37 0 38 0 39 0 40 0 41 0 42 0 43 0
		 44 0 45 0 46 0 47 0 48 0 49 0 50 0 51 0 52 0 53 0 54 0 55 0 56 0 57 0 58 0 59 0 60 0
		 61 0 62 0 63 0 64 0 65 0 66 0 67 0 68 0 69 0 70 0 71 0 72 0 73 0 74 0 75 0;
createNode animCurveTA -n "target_pt_rotateY";
	rename -uid "434D5768-414C-E797-745A-00B1568964F4";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 76 ".ktv[0:75]"  0 44.235446241870974 1 44.236771664125428
		 2 44.255703885924142 3 44.333598235297693 4 44.534381217876735 5 44.946917278830433
		 6 45.700394230334176 7 47.006248844278041 8 49.272195361136511 9 53.461015181814794
		 10 62.621625317882078 11 91.225829426301217 12 140.76376247424921 13 156.23658987040145
		 14 160.64796119550275 15 161.37388964106111 16 160.17298466621384 17 157.59800218151975
		 18 154.60122631322838 19 151.66162034591633 20 148.51213453669749 21 144.83551782963374
		 22 140.08498612393848 23 132.95998920578606 24 119.59401634997398 25 87.246796375842891
		 26 47.845870223322102 27 25.789280253517965 28 12.387431680314304 29 2.0220066627245594
		 30 -7.4924785343678453 31 -17.245919753294142 32 -26.22518855192418 33 -31.790503740263496
		 34 -34.265190367274997 35 -32.979764110282943 36 -23.572885950243098 37 14.912848029893187
		 38 53.063452714761787 39 68.335242892276099 40 77.611989158424819 41 86.032071694482795
		 42 96.075033247011604 43 115.00974511296786 44 190.36586391417222 45 200.39051435640525
		 46 191.6845761875322 47 182.38575665293482 48 170.60479046894702 49 143.55178494066834
		 50 89.85007853451161 51 59.075892459507322 52 36.849302825073536 53 17.322267526227805
		 54 4.6582149401625141 55 -1.2944258062829359 56 -3.9922336579906923 57 -4.7410610811399732
		 58 -4.030036520388653 59 -1.9796627037650412 60 1.7406869356096248 61 7.4172803329959853
		 62 13.673628185327392 63 19.963972330184607 64 25.79927387683697 65 30.784034252946064
		 66 34.731466120329891 67 37.653274613326253 68 39.683247573081424 69 41.003167937762804
		 70 41.796791264454143 71 42.226914945477098 72 42.42754940797218 73 42.500782549222414
		 74 42.517352331064295 75 42.518438804998553;
createNode animCurveTA -n "target_pt_rotateZ";
	rename -uid "5C047649-414C-E323-B922-3DAE324C72A2";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 76 ".ktv[0:75]"  0 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 9 0
		 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0
		 27 0 28 0 29 0 30 0 31 0 32 0 33 0 34 0 35 0 36 0 37 0 38 0 39 0 40 0 41 0 42 0 43 0
		 44 0 45 0 46 0 47 0 48 0 49 0 50 0 51 0 52 0 53 0 54 0 55 0 56 0 57 0 58 0 59 0 60 0
		 61 0 62 0 63 0 64 0 65 0 66 0 67 0 68 0 69 0 70 0 71 0 72 0 73 0 74 0 75 0;
createNode animCurveTU -n "target_pt_scaleX";
	rename -uid "80C775B4-49F9-CC21-FC4C-33A17DE5C0C5";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 76 ".ktv[0:75]"  0 1 1 1 2 1 3 1 4 1 5 1 6 1 7 1 8 1 9 1
		 10 1 11 1 12 1 13 1 14 1 15 1 16 1 17 1 18 1 19 1 20 1 21 1 22 1 23 1 24 1 25 1 26 1
		 27 1 28 1 29 1 30 1 31 1 32 1 33 1 34 1 35 1 36 1 37 1 38 1 39 1 40 1 41 1 42 1 43 1
		 44 1 45 1 46 1 47 1 48 1 49 1 50 1 51 1 52 1 53 1 54 1 55 1 56 1 57 1 58 1 59 1 60 1
		 61 1 62 1 63 1 64 1 65 1 66 1 67 1 68 1 69 1 70 1 71 1 72 1 73 1 74 1 75 1;
createNode animCurveTU -n "target_pt_scaleY";
	rename -uid "5961A50C-488D-9AC8-4CB0-33B3DB019475";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 76 ".ktv[0:75]"  0 1 1 1 2 1 3 1 4 1 5 1 6 1 7 1 8 1 9 1
		 10 1 11 1 12 1 13 1 14 1 15 1 16 1 17 1 18 1 19 1 20 1 21 1 22 1 23 1 24 1 25 1 26 1
		 27 1 28 1 29 1 30 1 31 1 32 1 33 1 34 1 35 1 36 1 37 1 38 1 39 1 40 1 41 1 42 1 43 1
		 44 1 45 1 46 1 47 1 48 1 49 1 50 1 51 1 52 1 53 1 54 1 55 1 56 1 57 1 58 1 59 1 60 1
		 61 1 62 1 63 1 64 1 65 1 66 1 67 1 68 1 69 1 70 1 71 1 72 1 73 1 74 1 75 1;
createNode animCurveTU -n "target_pt_scaleZ";
	rename -uid "6A6096DE-476F-B5B4-F79F-048351B09C5A";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 76 ".ktv[0:75]"  0 1 1 1 2 1 3 1 4 1 5 1 6 1 7 1 8 1 9 1
		 10 1 11 1 12 1 13 1 14 1 15 1 16 1 17 1 18 1 19 1 20 1 21 1 22 1 23 1 24 1 25 1 26 1
		 27 1 28 1 29 1 30 1 31 1 32 1 33 1 34 1 35 1 36 1 37 1 38 1 39 1 40 1 41 1 42 1 43 1
		 44 1 45 1 46 1 47 1 48 1 49 1 50 1 51 1 52 1 53 1 54 1 55 1 56 1 57 1 58 1 59 1 60 1
		 61 1 62 1 63 1 64 1 65 1 66 1 67 1 68 1 69 1 70 1 71 1 72 1 73 1 74 1 75 1;
createNode motionPath -n "motionPath1";
	rename -uid "E6C5A2FD-4834-A5C0-8A98-78844B92290A";
	setAttr -s 5 ".pmt";
	setAttr -s 5 ".pmt";
	setAttr ".fa" 0;
	setAttr ".ua" 1;
	setAttr ".fm" yes;
createNode animCurveTL -n "motionPath1_uValue1";
	rename -uid "D7652577-428D-79BB-A851-9D8578A74554";
	setAttr ".tan" 9;
	setAttr ".wgt" no;
createNode animCurveTA -n "master01_ctrl_rotateX";
	rename -uid "F74C4FF7-44D5-FEB4-7A3C-BD807AD94D9F";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 32 ".ktv[0:31]"  1 148.59610788394173 3.4 85.538464925316163
		 5.8 107.98981619286485 8.2 172.1393855268326 10.6 161.50857188175561 13 87.200326022839931
		 15.4 -10.701901759192005 17.8 -91.428214692406456 20.2 -63.782392650622427 22.6 -40.825837812519907
		 25 59.087218737500883 27.4 91.442713545297579 29.8 92.803877521101228 32.2 90.781331544943185
		 34.6 86.174028695923724 37 63.489367088652934 39.4 -56.397808212879141 41.8 -144.72285073323908
		 44.2 -131.89940372828858 46.6 -91.226809758345695 49 -34.856939792787401 51.4 26.129193884633491
		 53.8 80.622252549509867 56.2 117.01705671110669 58.6 102.09038106315505 61 -15.149057279058869
		 63.4 -104.40580093251032 65.8 -16.667788409216978 68.2 20.178021135321671 70.6 39.919085110625012
		 73 33.771053874719485 75 -141.65820950957868;
createNode animCurveTA -n "master01_ctrl_rotateY";
	rename -uid "C47FA174-4980-0370-A57B-768B70C2C712";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 32 ".ktv[0:31]"  1 159.12360486347166 3.4 17.289026981083008
		 5.8 49.450244881727194 8.2 100.701080442326 10.6 133.17267493367731 13 89.210800325272615
		 15.4 -30.189053100630638 17.8 -134.15010694787904 20.2 -125.0044260111769 22.6 14.392501224987607
		 25 104.47275535567535 27.4 75.098021953374186 29.8 12.056784400741444 32.2 -46.223295797969286
		 34.6 -63.613701563509409 37 -58.610040298205774 39.4 -48.245147374598744 41.8 -33.624782603500364
		 44.2 -15.948149953489621 46.6 3.5699114799753566 49 23.718138419692607 51.4 49.022557147465861
		 53.8 91.137079598744549 56.2 122.57481857852758 58.6 119.21237311857037 61 69.474174291116057
		 63.4 -30.177278213204907 65.8 72.034039244631813 68.2 163.32802480604309 70.6 173.79134338763788
		 73 149.332064064371 75 -174.42892167134076;
createNode animCurveTA -n "master01_ctrl_rotateZ";
	rename -uid "47EC667A-421B-D987-4DD3-57BC07C55389";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 32 ".ktv[0:31]"  1 -103.3276111740778 3.4 31.218537250251057
		 5.8 44.163300736416701 8.2 31.138499936049566 10.6 10.70112599019328 13 -13.239643434406151
		 15.4 -37.13822663659829 17.8 -57.474095534622158 20.2 -74.563542731054753 22.6 -85.88853398383614
		 25 2.8036965902886175 27.4 10.017537894527658 29.8 32.674310603832907 32.2 63.079377896119574
		 34.6 48.705307207525436 37 -156.26124539405205 39.4 -63.979020890843856 41.8 82.281924847203712
		 44.2 -100.80315787319142 46.6 -157.81070869553952 49 67.558240303729491 51.4 -109.3762816318231
		 53.8 -94.543631222262349 56.2 -73.176652264234974 58.6 -43.542484885093245 61 -8.762122970473861
		 63.4 27.756641174808564 65.8 62.658373399435916 68.2 92.760404072373078 70.6 125.48615568716609
		 73 125.47069318856181 75 -161.88247921571593;
createNode animCurveTU -n "master01_ctrl_scaleX";
	rename -uid "8D78FEF8-404F-15D5-4895-898C5E2F7860";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 32 ".ktv[0:31]"  1 5.6305240484377395 3.4 5.6305906426016641
		 5.8 5.6310552150961239 8.2 5.6323165138168516 10.6 5.6347728615286066 13 5.6388225133391021
		 15.4 5.6448637960161916 17.8 5.6532950365126933 20.2 5.6645145612510595 22.6 5.678920696564516
		 25 5.6969117687757285 27.4 5.7188861042144916 29.8 5.7452420293891198 32.2 5.7763778733417652
		 34.6 5.8126919933903549 37 5.8545829986016882 39.4 5.902451069666367 41.8 5.9566951244565063
		 44.2 6.0181711676306016 46.6 6.1252942081545942 49 6.2922822093699757 51.4 6.4986409229397308
		 53.8 6.7239901048221231 56.2 6.9479746811045064 58.6 7.1501934742176063 61 7.3090327246038882
		 63.4 7.3858506659443917 65.8 6.5608007469816485 68.2 5.2198482059049525 70.6 6.0675480874339032
		 73 7.0009828021237217 75 7.4080040833119094;
createNode animCurveTA -n "master02_ctrl_rotateX";
	rename -uid "71D0BF14-491C-71CE-2ACC-9C8C93A2F2FC";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 32 ".ktv[0:31]"  1 -5.992552760011165 3.4 -34.181025660036291
		 5.8 -94.184399156523341 8.2 -149.37261660830188 10.6 -154.50433256859154 13 -50.431546414002355
		 15.4 -67.77159121292749 17.8 -118.2794961355235 20.2 -70.425440551547197 22.6 3.4804009001795135
		 25 68.540542544596491 27.4 90.328729443246402 29.8 75.862980751268566 32.2 57.081970269265682
		 34.6 50.414217768167553 37 48.446806508788967 39.4 48.162983494667536 41.8 47.447951091458258
		 44.2 44.213209195096894 46.6 33.169070213303797 49 6.8946067340549018 51.4 -27.101618866528316
		 53.8 -72.695145406925576 56.2 -76.213659220506614 58.6 -16.580780113922192 61 146.99705061420585
		 63.4 121.2363094929463 65.8 79.157026971855501 68.2 17.735090864702574 70.6 -77.721374473691967
		 73 -56.385612557558083 75 62.745527276779313;
createNode animCurveTA -n "master02_ctrl_rotateY";
	rename -uid "09C5A2D4-42AF-1BCC-E280-89ACE998750F";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 32 ".ktv[0:31]"  1 -19.504713211538757 3.4 20.687962108064809
		 5.8 93.401125684605319 8.2 126.27526783125546 10.6 50.182088922103212 13 70.480712437620284
		 15.4 -81.176412135137866 17.8 -26.720440677526714 20.2 -23.615878536255366 22.6 -22.559785080610371
		 25 -22.103617581854692 27.4 -22.36775350633058 29.8 -41.518917727162894 32.2 -130.15605036424719
		 34.6 39.447564093385687 37 104.03478613774539 39.4 85.317586916932157 41.8 52.094683272816766
		 44.2 10.581274472515073 46.6 -33.006049466603507 49 -72.425365687554205 51.4 -101.73485835325133
		 53.8 -117.19694257179914 56.2 82.176642166213114 58.6 -62.695038206870457 61 -22.002656318146794
		 63.4 85.712137513638737 65.8 118.07532600009712 68.2 102.97140787884018 70.6 73.620552608336794
		 73 19.860532418753035 75 -72.350727959947761;
createNode animCurveTA -n "master02_ctrl_rotateZ";
	rename -uid "824CE883-4254-60F8-E3BB-57B5063F0597";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 32 ".ktv[0:31]"  1 178.42897728115855 3.4 118.87445501439514
		 5.8 88.606312896207882 8.2 108.36472910006819 10.6 125.68580691879544 13 88.833241625591356
		 15.4 9.2258001189035639 17.8 -39.962141898150492 20.2 -88.676307665865181 22.6 -131.79226797385724
		 25 -160.38446465425676 27.4 -137.71802166635683 29.8 145.21730313870751 32.2 166.83671497787077
		 34.6 102.28389431259792 37 16.838733107170025 39.4 82.24143429874097 41.8 166.73438958894093
		 44.2 44.633304962765145 46.6 -95.310598267838358 49 -110.45353262022024 51.4 6.6568148349431446
		 53.8 94.772168145721466 56.2 76.216713528155964 58.6 30.529060662527232 61 -8.907240981363957
		 63.4 54.940129717207505 65.8 43.0554895686695 68.2 22.223043750944914 70.6 -1.0927316170942634
		 73 -18.564473887279242 75 -25.213881058527193;
createNode animCurveTU -n "master02_ctrl_scaleX";
	rename -uid "8E8E7D4B-4C25-0FFB-C04B-58AB2D850A27";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 32 ".ktv[0:31]"  1 7.3942316756807775 3.4 7.3728686272326671
		 5.8 7.3153224708149338 8.2 7.231054226021552 10.6 7.129641303332023 13 7.0206570779836079
		 15.4 6.9136652980140294 17.8 6.8182293692021716 20.2 6.7439116861330382 22.6 6.7002637990411502
		 25 6.6957688155797799 27.4 6.7218831608648566 29.8 6.7619468529028435 32.2 6.8002407844157871
		 34.6 6.8224315380279812 37 6.6119418689217841 39.4 6.1553738384443246 41.8 6.0154515261357693
		 44.2 6.0384669864571361 46.6 6.0838562127033144 49 6.1482023178434 51.4 6.2275987254138032
		 53.8 6.3180410859465637 56.2 6.4155134132455798 58.6 6.5159986186128096 61 6.6154795309019399
		 63.4 6.7099389857810028 65.8 6.795359934726477 68.2 6.8677262630933216 70.6 6.9230253159441997
		 73 6.9557692026925739 75 6.966711248063632;
createNode animCurveTA -n "master03_ctrl_rotateX";
	rename -uid "1AE93ED3-44B4-A3C7-6057-E8A968D22F2E";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 32 ".ktv[0:31]"  1 131.94922379295247 3.4 -89.521346404655986
		 5.8 -91.456347634583508 8.2 -17.229890813587481 10.6 68.146716140841477 13 -44.71449526450224
		 15.4 -124.46029677009243 17.8 -140.36739145457082 20.2 -149.34079625256419 22.6 -153.41078384896267
		 25 -143.59436594982816 27.4 -55.191662159143355 29.8 65.384833123337813 32.2 147.85875037530681
		 34.6 140.71071443873888 37 81.291519704393224 39.4 2.7675887872729419 41.8 -64.316086251335378
		 44.2 -88.977249675465842 46.6 -26.959915282348184 49 55.370229730699727 51.4 66.110563022935011
		 53.8 55.266708222397604 56.2 -18.421264032668354 58.6 -141.87617384772111 61 -112.67834741390426
		 63.4 -70.611844528271632 65.8 -30.797479026462447 68.2 -6.4979167799396107 70.6 -55.543361250879308
		 73 37.994446075454896 75 148.8985615721287;
createNode animCurveTA -n "master03_ctrl_rotateY";
	rename -uid "94E0CCEA-48BA-48AA-B27F-60ACDFE6964F";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 32 ".ktv[0:31]"  1 136.07063322033207 3.4 147.47283387647747
		 5.8 -49.696800004270209 8.2 -104.00421514370163 10.6 -97.373195720622917 13 -84.378004165952149
		 15.4 -65.018666331261727 17.8 -19.114814305293507 20.2 -107.95654667955223 22.6 -144.27451611237808
		 25 -67.87331468149317 27.4 7.9623851512278554 29.8 81.384011726096603 32.2 136.04433407303117
		 34.6 -29.853830536270728 37 -122.64049871492678 39.4 118.00525255026666 41.8 -92.739499169887253
		 44.2 125.25438096740389 46.6 147.15078274202844 49 119.39981423497834 51.4 74.660226822653499
		 53.8 20.935150899913044 56.2 -34.239917848002989 58.6 -83.367957572363437 61 -118.95772992301448
		 63.4 -133.83922246833194 65.8 -136.14838329431987 68.2 -129.66166414042874 70.6 -89.559070408495913
		 73 -45.598197355304968 75 -26.426489884131854;
createNode animCurveTA -n "master03_ctrl_rotateZ";
	rename -uid "4A3EBC92-4E49-CA04-9074-F0B133773297";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 33 ".ktv[0:32]"  1 -21.021112792335401 3.4 -78.74308309269216
		 5.8 -143.33512691849486 8.2 -131.40224616822982 10.6 -108.88691910119918 13 -76.364617392813003
		 15.4 -26.382887390278341 17.8 27.738552469537883 20.2 68.455318685637593 22.6 78.509553808147913
		 25 61.095900605619185 27.4 58.374484305446011 29.8 3.1483458443049854 32.2 -46.736036846950256
		 34.6 -5.8446343407982866 37 -10.679498579576245 39.4 -12.808508448825053 41.8 -15.566100632557125
		 44.2 -17.576916643277631 46.6 -18.796319353686584 49 -19.331558522830928 51.4 -18.551887515749101
		 53.8 -13.896382626960994 56.2 -6.5177674886471832 58.6 2.0297058578313547 61 10.188178165578265
		 63.4 16.416077506249849 65.8 19.258103177810213 68.2 -4.8397756098670826 70.6 -63.364762841534237
		 73 -120.3073642134505 75.4 31.30317700267625 76 61.191923170210913;
createNode animCurveTU -n "master03_ctrl_scaleX";
	rename -uid "6E685EC9-4F2D-464E-4CF6-659D1736655B";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 32 ".ktv[0:31]"  1 6.2928441768621459 3.4 6.3160453859089714
		 5.8 6.3793937226718445 8.2 6.4738915040784315 10.6 6.5904144556377755 13 6.7198424462865054
		 15.4 6.8530659236203668 17.8 6.9809756451176597 20.2 7.0944624371592315 22.6 7.1844179829506363
		 25 7.2417376011873289 27.4 7.2576399556245708 29.8 7.238907933084417 32.2 7.1950434256630516
		 34.6 7.1296769944678866 37 7.0464776244586167 39.4 6.9491351065885878 41.8 6.8414190796107919
		 44.2 6.7055857125066982 46.6 6.5296173303406411 49 6.3376414811005244 51.4 6.1541542145932011
		 53.8 6.0037521924339901 56.2 5.8790066353440729 58.6 5.7501573981025222 61 5.6220930330309926
		 63.4 5.5001237784947339 65.8 5.3895585583323635 68.2 5.2957065328841813 70.6 5.2238726046297161
		 73 5.1812807494455262 75 5.1670351191909871;
createNode animCurveTA -n "master04_ctrl_rotateX";
	rename -uid "92B14C72-4822-0A38-6383-258E8504B5CE";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 32 ".ktv[0:31]"  1 -72.32601786110655 3.4 -109.66934363496279
		 5.8 -167.28418930167064 8.2 -172.23081097650953 10.6 -133.71883752428218 13 -80.194647455097055
		 15.4 -35.587111912634484 17.8 5.776676480662748 20.2 50.19719758503345 22.6 91.334886043496255
		 25 123.04883164120339 27.4 140.10520748114368 29.8 30.342083481135294 32.2 58.975405770621421
		 34.6 106.27065227484415 37 97.375348562241967 39.4 80.918380518579937 41.8 60.501638946303657
		 44.2 3.7618024997346011 46.6 -17.466120902372314 49 -34.927867278758782 51.4 -45.61494860825529
		 53.8 -45.473337426244228 56.2 -79.180864409645267 58.6 -46.31664399389345 61 15.097357822826721
		 63.4 65.67178578022191 65.8 -2.5357974864438986 68.2 141.76622789878189 70.6 69.526446418421202
		 73 -10.7287973934327 75 -45.747832643465983;
createNode animCurveTA -n "master04_ctrl_rotateY";
	rename -uid "16C43CE0-4C51-562C-0564-D9A4212EB262";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 32 ".ktv[0:31]"  1 -130.20643451672353 3.4 -126.42318747865893
		 5.8 -115.77285732511075 8.2 -99.320518873570705 10.6 -78.88691405897174 13 -9.7486392647982747
		 15.4 38.682219895935816 17.8 87.538883121858575 20.2 126.79934557589083 22.6 147.91710508830204
		 25 23.293476682106956 27.4 41.712418218238838 29.8 56.304429687057002 32.2 33.657380692384628
		 34.6 63.360905450720416 37 25.692651369103647 39.4 -15.583273094363944 41.8 62.240601246280676
		 44.2 151.48375791106582 46.6 128.94225215684708 49 44.509765212956196 51.4 42.181684288639261
		 53.8 50.194892352841798 56.2 54.865294196710934 58.6 58.387464870979805 61 60.510369329647077
		 63.4 58.626271104755823 65.8 -13.487089575687275 68.2 -105.15638789427463 70.6 -131.92679728734774
		 73 -138.86451690429135 75 -139.88308359863896;
createNode animCurveTA -n "master04_ctrl_rotateZ";
	rename -uid "6E81A1EA-46B3-BD06-F7C0-7C943258631C";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 32 ".ktv[0:31]"  1 -122.05753074761219 3.4 -131.72025687788687
		 5.8 -152.29832949446285 8.2 -171.33941835926166 10.6 -177.08710309550361 13 -175.97854361632446
		 15.4 -170.83757520477994 17.8 -153.922086836528 20.2 -118.00820410146059 22.6 -78.582720776128497
		 25 -29.667448604938571 27.4 128.27776941067964 29.8 73.684176327811187 32.2 -5.7233067586113755
		 34.6 -67.105034857538215 37 -129.17712216603724 39.4 -166.20050467757869 41.8 89.903257258957396
		 44.2 133.10314542853794 46.6 118.02557520091172 49 119.98054855907051 51.4 122.80014860477206
		 53.8 126.34441609529279 56.2 130.05909597147414 58.6 133.34227977496053 61 135.55229972123007
		 63.4 134.13337534597983 65.8 75.035271661450764 68.2 6.9581244316926245 70.6 3.7863943916814136
		 73 14.164294160819892 75 19.700788099217561;
createNode animCurveTU -n "master04_ctrl_scaleX";
	rename -uid "EB566903-4BA9-278A-E97E-0B9F4942E791";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 32 ".ktv[0:31]"  1 6.3813412748188281 3.4 6.3794147099396081
		 5.8 6.3738808025932725 8.2 6.3650758010256769 10.6 6.3533465250741648 13 6.3390395275072349
		 15.4 6.3225004427631424 17.8 6.3040748810100942 20.2 6.2841084556820173 22.6 6.2629467809591421
		 25 6.2409354711172931 27.4 6.2184201404416752 29.8 6.1957464032180871 32.2 6.1732598737285542
		 34.6 6.1513061662022119 37 6.1302308942993475 39.4 6.1103796668217498 41.8 6.0920980650681047
		 44.2 6.0757317076934347 46.6 6.0616301832407107 49 6.0502159650177871 51.4 6.0428628099699573
		 53.8 6.0505276494372255 56.2 6.2980623672285514 58.6 6.9689281970284584 61 6.8487314693830657
		 63.4 6.7491662577152738 65.8 6.7487415503837802 68.2 6.7681100795219225 70.6 6.7927943222505442
		 73 6.8122292235500383 75 6.8197896463334704;
createNode animCurveTA -n "master05_ctrl_rotateX";
	rename -uid "5A3AC4D7-4618-54DA-5A68-83998DBF9E71";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 32 ".ktv[0:31]"  1 -166.92521619914515 3.4 -166.50572331705374
		 5.8 -163.58197216277804 8.2 -140.70637809148738 10.6 -91.709563674585041 13 -39.734056689649165
		 15.4 -5.545741105710432 17.8 -158.92731149285777 20.2 -5.3210985916116602 22.6 111.91184116005485
		 25 54.740136674349785 27.4 -26.497546237790381 29.8 -72.524839584013705 32.2 -11.571253739540873
		 34.6 100.56831426199609 37 73.283889200386454 39.4 135.28689888998287 41.8 113.6032545464786
		 44.2 20.535263076016868 46.6 -66.414181056388287 49 -70.584995842982707 51.4 32.078887381127991
		 53.8 110.22173611392091 56.2 -84.554761526606612 58.6 -105.66775125385466 61 50.984663311650493
		 63.4 21.149948316052686 65.8 -114.18061277152469 68.2 -76.862068038467584 70.6 -25.214331305673333
		 73 15.553147150703053 75 31.415046782805405;
createNode animCurveTA -n "master05_ctrl_rotateY";
	rename -uid "321FDB13-443C-27E8-6317-31B3CF0C40F7";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 32 ".ktv[0:31]"  1 -172.25091076304841 3.4 -26.041823550272412
		 5.8 -23.376799451957602 8.2 -55.8356484596885 10.6 53.905699186760238 13 133.89570214423603
		 15.4 -62.899213162577006 17.8 97.415144209052286 20.2 112.34317973323387 22.6 111.41040859266555
		 25 105.63155293808332 27.4 96.110655067204235 29.8 83.962395891427192 32.2 70.311597491147197
		 34.6 56.285024800425376 37 43.008697095637807 39.4 31.599013337086912 41.8 23.101135922932041
		 44.2 18.351236956627222 46.6 94.325292890871566 49 115.51685237164932 51.4 89.016979019523546
		 53.8 37.010586923064473 56.2 -27.100854822465646 58.6 -90.919282238758029 61 -142.11467235453972
		 63.4 -168.32050944656532 65.8 -165.38163463098761 68.2 -136.02252066291641 70.6 -49.567101741273866
		 73 74.201354979229833 75 132.29051293107966;
createNode animCurveTA -n "master05_ctrl_rotateZ";
	rename -uid "1688934B-4828-5A67-A90F-F986CDBA6F27";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 32 ".ktv[0:31]"  1 38.359134778789382 3.4 -9.9022768843890336
		 5.8 -63.417987680757406 8.2 -56.324157207720035 10.6 -57.864956882168649 13 -69.800185670117926
		 15.4 -87.523377709728678 17.8 115.79032823700196 20.2 58.215851673886817 22.6 -2.7212750308511464
		 25 -48.893496968674974 27.4 -98.574080837912263 29.8 -141.18177037455663 32.2 -165.17110454591929
		 34.6 -150.96481594843553 37 -82.923018017192348 39.4 6.8465864206202385 41.8 83.533614080791665
		 44.2 112.04475475731695 46.6 59.816357839524407 49 -22.707461466168304 51.4 -89.69492450713112
		 53.8 -62.707184339553059 56.2 -17.844476599191939 58.6 20.237746419202541 61 -139.52837768903117
		 63.4 -159.95585449141478 65.8 -105.20304102330665 68.2 19.141059454015046 70.6 65.253110994966107
		 73 111.02591695210035 75 158.802776504897;
createNode animCurveTU -n "master05_ctrl_scaleX";
	rename -uid "9A623ED3-457F-1217-052D-B781E54B7C85";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 32 ".ktv[0:31]"  1 6.7552434868680065 3.4 6.7538643222297186
		 5.8 6.7504477869835799 8.2 6.7460532315179922 10.6 6.7417498495557222 13 6.7386204825330474
		 15.4 6.7385297214832249 17.8 6.7672133815228532 20.2 6.8167411310997057 22.6 6.8577135280766504
		 25 6.8575551411604927 27.4 6.779934680781416 29.8 6.6535011154538344 32.2 6.5174484103114407
		 34.6 6.4109143611592581 37 6.3653114358051388 39.4 6.3367941756448323 41.8 6.3115801852109268
		 44.2 6.2894569692622042 46.6 6.2702284872922505 49 6.2536950536499951 51.4 6.2396561750767399
		 53.8 6.227911255293539 56.2 6.218259687862993 58.6 6.2105008655432146 61 6.2044341810289616
		 63.4 6.1998590267878191 65.8 6.1965747928596091 68.2 6.1943808486702725 70.6 6.1930764690695383
		 73 6.1924870881194538 75 6.1923306522315231;
createNode animCurveTL -n "root_grp_translateX";
	rename -uid "D02CFA5B-48D8-2E24-CF4B-52B04DF1129B";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 75 ".ktv[0:74]"  1 0.038599354569765099 2 0.15079607100527903
		 3 0.33096618536238898 4 0.57331513460078976 5 0.87126346116947506 6 1.2172565964520008
		 7 1.601854627178247 8 2.0123772454637199 9 2.4286842479208866 10 2.8088023651027658
		 11 3.0117253168266664 12 2.6525329313773098 13 1.9712022879839219 14 1.2254336913847688
		 15 0.46415693598789853 16 -0.29274311527773311 17 -1.0305761100071338 18 -1.736390387477653
		 19 -2.4022837924975953 20 -3.0205290085462062 21 -3.5826071523607625 22 -4.0827299817706404
		 23 -4.5170700692250323 24 -4.8605360203382286 25 -5.0086951901855166 26 -4.7949021008485229
		 27 -4.3587839869927265 28 -3.8424609611325926 29 -3.2871709731183127 30 -2.7060974930665207
		 31 -2.1086054462909898 32 -1.5064245299840602 33 -0.89930745837014314 34 -0.27208994456926472
		 35 0.40150016683222001 36 1.1701341529457543 37 2.1030749454066795 38 2.9197277651406548
		 39 3.4587787821249174 40 3.8209882387432872 41 4.0183728249603092 42 3.9957215430097071
		 43 3.6092966978175438 44 2.2976558070751687 45 0.64311414902041419 46 -1.0882451180834787
		 47 -2.9183000891057649 48 -4.7815954227340587 49 -6.5244942138724422 50 -7.3080197315973514
		 51 -6.7782903018104763 52 -5.5663615462595057 53 -4.0044589894493008 54 -2.3413457367528694
		 55 -0.73107746802730411 56 0.78130183472310488 57 2.1792163589201885 58 3.4503199710627461
		 59 4.5904198703226475 60 5.6444723980675677 61 6.6174184730394137 62 7.5018298618338619
		 63 8.2908265282077807 64 8.9822047712784023 65 9.5791194944278271 66 10.089414123457324
		 67 10.522905907113644 68 10.889000176711916 69 11.195394835614229 70 11.447821289308958
		 71 11.650092698950953 72 11.80489510468143 73 11.914051035692763 74 11.978681767152942
		 75 12.000000000000046;
createNode animCurveTL -n "root_grp_translateY";
	rename -uid "26617E3B-4E4B-DAD7-0CC1-7B87EB83A1B2";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 75 ".ktv[0:74]"  1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 9 0 10 0
		 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0
		 28 0 29 0 30 0 31 0 32 0 33 0 34 0 35 0 36 0 37 0 38 0 39 0 40 0 41 0 42 0 43 0 44 0
		 45 0 46 0 47 0 48 0 49 0 50 0 51 0 52 0 53 0 54 0 55 0 56 0 57 0 58 0 59 0 60 0 61 0
		 62 0 63 0 64 0 65 0 66 0 67 0 68 0 69 0 70 0 71 0 72 0 73 0 74 0 75 0;
createNode animCurveTL -n "root_grp_translateZ";
	rename -uid "6F426723-4E15-9D95-E61F-16BDE2E79393";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 75 ".ktv[0:74]"  1 11.962416698117973 2 11.853141000132648
		 3 11.677383380161245 4 11.439853935035293 5 11.144755659382437 6 10.795157613701923
		 7 10.392605445978214 8 9.9358899236049822 9 9.4188627912694045 10 8.8244910027780783
		 11 8.1196427257895021 12 7.4701517888820792 13 7.0795373292058859 14 6.7917790610800921
		 15 6.5328269254521292 16 6.2707739563170879 17 5.9874373861838164 18 5.6745205979728235
		 19 5.3373867155465549 20 4.9823066345723888 21 4.6138563562222279 22 4.2316269791435639
		 23 3.8243776188669365 24 3.3712829365435826 25 2.8473881145849429 26 2.361225773683874
		 27 2.0481170829536186 28 1.8737099213610968 29 1.8051236615817703 30 1.8334136565199028
		 31 1.9643645139799861 32 2.208489189824022 33 2.5492757082571367 34 2.9613507804780363
		 35 3.4158714786543629 36 3.8476216593510246 37 3.9783288235422556 38 3.3546879934729241
		 39 2.3531460709509622 40 1.1480363835052085 41 -0.22523481586102251 42 -1.725607954491351
		 43 -3.272416873066148 44 -4.0672494548379134 45 -3.492689919522546 46 -2.9813379299144818
		 47 -2.7579725534944379 48 -2.8557732334865111 49 -3.5072306735002639 50 -5.1240834696105244
		 51 -6.8729038270338281 52 -8.2051534621606255 53 -8.9986113728083374 54 -9.2987230649931316
		 55 -9.3364889832179916 56 -9.2618263094850803 57 -9.1519066289339985 58 -9.0517764682249329
		 59 -8.9892680677721533 60 -8.9836059123089154 61 -9.0591788835730718 62 -9.2227585407941088
		 63 -9.46080565921012 64 -9.7527320580909276 65 -10.074537982988774 66 -10.403502504729815
		 67 -10.721261549535441 68 -11.014673083786544 69 -11.275218158114066 70 -11.497949486188892
		 71 -11.680252918810773 72 -11.821293591997971 73 -11.921207634906162 74 -11.980453061813707
		 75 -12.000000000000046;
createNode mayaUsdLayerManager -n "mayaUsdLayerManager1";
	rename -uid "58014252-4C38-CABC-F1A4-9CB0181F8782";
	setAttr ".sst" -type "string" "";
select -ne :time1;
	setAttr ".o" 34;
	setAttr ".unw" 34;
select -ne :hardwareRenderingGlobals;
	setAttr ".otfna" -type "stringArray" 22 "NURBS Curves" "NURBS Surfaces" "Polygons" "Subdiv Surface" "Particles" "Particle Instance" "Fluids" "Strokes" "Image Planes" "UI" "Lights" "Cameras" "Locators" "Joints" "IK Handles" "Deformers" "Motion Trails" "Components" "Hair Systems" "Follicles" "Misc. UI" "Ornaments"  ;
	setAttr ".otfva" -type "Int32Array" 22 0 1 1 1 1 1
		 1 1 1 0 0 0 0 0 0 0 0 0
		 0 0 0 0 ;
	setAttr ".fprt" yes;
	setAttr ".rtfm" 1;
select -ne :renderPartition;
	setAttr -s 2 ".st";
select -ne :renderGlobalsList1;
select -ne :defaultShaderList1;
	setAttr -s 5 ".s";
select -ne :postProcessList1;
	setAttr -s 2 ".p";
select -ne :defaultRenderingList1;
select -ne :standardSurface1;
	setAttr ".bc" -type "float3" 0.40000001 0.40000001 0.40000001 ;
	setAttr ".sr" 0.5;
select -ne :initialShadingGroup;
	setAttr ".ro" yes;
select -ne :initialParticleSE;
	setAttr ".ro" yes;
select -ne :defaultRenderGlobals;
	addAttr -ci true -h true -sn "dss" -ln "defaultSurfaceShader" -dt "string";
	setAttr ".ren" -type "string" "arnold";
	setAttr ".dss" -type "string" "standardSurface1";
select -ne :defaultResolution;
	setAttr ".pa" 1;
select -ne :defaultColorMgtGlobals;
	setAttr ".cfe" yes;
	setAttr ".cfp" -type "string" "<MAYA_RESOURCES>/OCIO-configs/Maya2022-default/config.ocio";
	setAttr ".vtn" -type "string" "ACES 1.0 SDR-video (sRGB)";
	setAttr ".vn" -type "string" "ACES 1.0 SDR-video";
	setAttr ".dn" -type "string" "sRGB";
	setAttr ".wsn" -type "string" "ACEScg";
	setAttr ".otn" -type "string" "ACES 1.0 SDR-video (sRGB)";
	setAttr ".potn" -type "string" "ACES 1.0 SDR-video (sRGB)";
select -ne :hardwareRenderGlobals;
	setAttr ".ctrs" 256;
	setAttr ".btrs" 512;
connectAttr "target_pt_translateX.o" "target_pt.tx";
connectAttr "target_pt_translateY.o" "target_pt.ty";
connectAttr "target_pt_translateZ.o" "target_pt.tz";
connectAttr "motionPath1.msg" "target_pt.sml";
connectAttr "target_pt_rotateX.o" "target_pt.rx";
connectAttr "target_pt_rotateY.o" "target_pt.ry";
connectAttr "target_pt_rotateZ.o" "target_pt.rz";
connectAttr "motionPath1.ro" "target_pt.ro";
connectAttr "target_pt_visibility.o" "target_pt.v";
connectAttr "target_pt_scaleX.o" "target_pt.sx";
connectAttr "target_pt_scaleY.o" "target_pt.sy";
connectAttr "target_pt_scaleZ.o" "target_pt.sz";
connectAttr "root_grp_translateX.o" "root_grp.tx";
connectAttr "root_grp_translateY.o" "root_grp.ty";
connectAttr "root_grp_translateZ.o" "root_grp.tz";
connectAttr "master01_ctrl_rotateX.o" "master01_ctrl.rx";
connectAttr "master01_ctrl_rotateY.o" "master01_ctrl.ry";
connectAttr "master01_ctrl_rotateZ.o" "master01_ctrl.rz";
connectAttr "master01_ctrl_scaleX.o" "master01_ctrl.sx";
connectAttr "master02_ctrl_rotateX.o" "master02_ctrl.rx";
connectAttr "master02_ctrl_rotateY.o" "master02_ctrl.ry";
connectAttr "master02_ctrl_rotateZ.o" "master02_ctrl.rz";
connectAttr "master02_ctrl_scaleX.o" "master02_ctrl.sx";
connectAttr "master03_ctrl_rotateX.o" "master03_ctrl.rx";
connectAttr "master03_ctrl_rotateY.o" "master03_ctrl.ry";
connectAttr "master03_ctrl_rotateZ.o" "master03_ctrl.rz";
connectAttr "master03_ctrl_scaleX.o" "master03_ctrl.sx";
connectAttr "master04_ctrl_rotateX.o" "master04_ctrl.rx";
connectAttr "master04_ctrl_rotateY.o" "master04_ctrl.ry";
connectAttr "master04_ctrl_rotateZ.o" "master04_ctrl.rz";
connectAttr "master04_ctrl_scaleX.o" "master04_ctrl.sx";
connectAttr "master05_ctrl_rotateX.o" "master05_ctrl.rx";
connectAttr "master05_ctrl_rotateY.o" "master05_ctrl.ry";
connectAttr "master05_ctrl_rotateZ.o" "master05_ctrl.rz";
connectAttr "master05_ctrl_scaleX.o" "master05_ctrl.sx";
relationship "link" ":lightLinker1" ":initialShadingGroup.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" ":initialParticleSE.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" ":initialShadingGroup.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" ":initialParticleSE.message" ":defaultLightSet.message";
connectAttr "layerManager.dli[0]" "defaultLayer.id";
connectAttr "renderLayerManager.rlmi[0]" "defaultRenderLayer.rlid";
connectAttr ":defaultArnoldDisplayDriver.msg" ":defaultArnoldRenderOptions.drivers"
		 -na;
connectAttr ":defaultArnoldFilter.msg" ":defaultArnoldRenderOptions.filt";
connectAttr ":defaultArnoldDriver.msg" ":defaultArnoldRenderOptions.drvr";
connectAttr "curveShape1.msg" "MayaNodeEditorSavedTabsInfo.tgi[0].ni[0].dn";
connectAttr "positionMarkerShape3.msg" "MayaNodeEditorSavedTabsInfo.tgi[0].ni[2].dn"
		;
connectAttr "target_pt.msg" "MayaNodeEditorSavedTabsInfo.tgi[0].ni[5].dn";
connectAttr "positionMarker5.msg" "MayaNodeEditorSavedTabsInfo.tgi[0].ni[6].dn";
connectAttr "positionMarkerShape4.msg" "MayaNodeEditorSavedTabsInfo.tgi[0].ni[7].dn"
		;
connectAttr "positionMarkerShape5.msg" "MayaNodeEditorSavedTabsInfo.tgi[0].ni[8].dn"
		;
connectAttr "motionPath1.msg" "MayaNodeEditorSavedTabsInfo.tgi[0].ni[9].dn";
connectAttr "positionMarker4.msg" "MayaNodeEditorSavedTabsInfo.tgi[0].ni[10].dn"
		;
connectAttr "positionMarker3.msg" "MayaNodeEditorSavedTabsInfo.tgi[0].ni[11].dn"
		;
connectAttr "motionPath1_uValue1.o" "motionPath1.u";
connectAttr "curveShape1.ws" "motionPath1.gp";
connectAttr "positionMarkerShape1.t" "motionPath1.pmt[2]";
connectAttr "positionMarkerShape2.t" "motionPath1.pmt[3]";
connectAttr "positionMarkerShape3.t" "motionPath1.pmt[4]";
connectAttr "positionMarkerShape4.t" "motionPath1.pmt[5]";
connectAttr "positionMarkerShape5.t" "motionPath1.pmt[6]";
connectAttr "defaultRenderLayer.msg" ":defaultRenderingList1.r" -na;
connectAttr "pSphere1Shape.iog" ":initialShadingGroup.dsm" -na;
// End of majia_sceneEx_generatePath.ma
