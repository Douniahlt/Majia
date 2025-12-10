//Maya ASCII 2024 scene
//Name: majia_sceneEx_generatePath.ma
//Last modified: Wed, Dec 10, 2025 12:22:42 PM
//Codeset: 1252
file -rdi 1 -ns "papython" -rfn "majia_model_papython_publishRN" -op "v=0;" 
		-typ "mayaAscii" "F:/Travail/MayaPythonMEL/PARTIEL/Majia/Papythons/Modeling/majia_model_papython_publish.ma";
file -r -ns "papython" -dr 1 -rfn "majia_model_papython_publishRN" -op "v=0;" -typ
		 "mayaAscii" "F:/Travail/MayaPythonMEL/PARTIEL/Majia/Papythons/Modeling/majia_model_papython_publish.ma";
requires maya "2024";
requires "stereoCamera" "10.0";
requires -nodeType "aiOptions" -nodeType "aiAOVDriver" -nodeType "aiAOVFilter" "mtoa" "5.3.4.1";
requires -nodeType "mayaUsdLayerManager" -dataType "pxrUsdStageData" "mayaUsdPlugin" "0.25.0";
requires "stereoCamera" "10.0";
currentUnit -l centimeter -a degree -t film;
fileInfo "application" "maya";
fileInfo "product" "Maya 2024";
fileInfo "version" "2024";
fileInfo "cutIdentifier" "202310181224-69282f2959";
fileInfo "osv" "Windows 11 Pro v2009 (Build: 26200)";
fileInfo "UUID" "DD886727-407A-4E1B-AAAA-6C87634E71B5";
createNode transform -s -n "persp";
	rename -uid "3A13D6D2-4D7A-BE85-E249-80AECFC63FE4";
	setAttr ".v" no;
	setAttr ".t" -type "double3" -36.747579207847508 18.073009065615956 0.018748566868582728 ;
	setAttr ".r" -type "double3" -24.338352728029079 628.59999999997342 0 ;
createNode camera -s -n "perspShape" -p "persp";
	rename -uid "4C8088C2-435C-FD32-B296-25A4F46E974F";
	setAttr -k off ".v" no;
	setAttr ".fl" 34.999999999999993;
	setAttr ".coi" 45.787243574480641;
	setAttr ".imn" -type "string" "persp";
	setAttr ".den" -type "string" "persp_depth";
	setAttr ".man" -type "string" "persp_mask";
	setAttr ".tp" -type "double3" -0.53244169801473618 0.26672988702380418 -0.076924235917294193 ;
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
createNode transform -n "plane";
	rename -uid "4B893964-4DB7-859C-71B0-5DB4E7BC6DEA";
createNode mesh -n "planeShape" -p "plane";
	rename -uid "61CAF03A-4934-6AB9-01DE-C3A3AD744F1C";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".pv" -type "double2" 0.5 0 ;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Ambient+Diffuse";
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr -s 2 ".pt[0:1]" -type "float3"  0.36488765 0 0 -0.36488765 
		0 0;
	setAttr ".db" yes;
	setAttr ".de" 1;
createNode transform -n "target_lctr";
	rename -uid "584FDF2D-4E6C-EBBD-EBCF-5FA2E844FB6E";
	setAttr ".smd" 7;
createNode locator -n "target_lctrShape" -p "target_lctr";
	rename -uid "BA1EC239-43D3-625A-19CF-FB809D2EC1EB";
	setAttr -k off ".v";
createNode transform -n "L_wing_ms";
	rename -uid "57EE0509-4213-31B2-9576-089BC65AB38E";
createNode mesh -n "L_wing_msShape" -p "L_wing_ms";
	rename -uid "C2DBE99B-49CA-4D39-F589-D5A073F990D9";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr -s 5 ".gtag";
	setAttr ".gtag[0].gtagnm" -type "string" "back";
	setAttr ".gtag[0].gtagcmp" -type "componentList" 1 "e[3]";
	setAttr ".gtag[1].gtagnm" -type "string" "front";
	setAttr ".gtag[1].gtagcmp" -type "componentList" 1 "e[0]";
	setAttr ".gtag[2].gtagnm" -type "string" "left";
	setAttr ".gtag[2].gtagcmp" -type "componentList" 1 "e[1]";
	setAttr ".gtag[3].gtagnm" -type "string" "right";
	setAttr ".gtag[3].gtagcmp" -type "componentList" 1 "e[2]";
	setAttr ".gtag[4].gtagnm" -type "string" "rim";
	setAttr ".gtag[4].gtagcmp" -type "componentList" 1 "e[0:3]";
	setAttr ".pv" -type "double2" 0.5 0 ;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr -s 4 ".uvst[0].uvsp[0:3]" -type "float2" 0 0 1 0 0 1 1 1;
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Ambient+Diffuse";
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr -s 2 ".pt[0:1]" -type "float3"  0.36488765 0 0 -0.36488765 
		0 0;
	setAttr -s 4 ".vt[0:3]"  -0.5 0 0.5 0.5 0 0.5 -0.5 0 -0.5 0.5 0 -0.5;
	setAttr -s 4 ".ed[0:3]"  0 1 0 0 2 0 1 3 0 2 3 0;
	setAttr -ch 4 ".fc[0]" -type "polyFaces" 
		f 4 0 2 -4 -2
		mu 0 4 0 1 3 2;
	setAttr ".cd" -type "dataPolyComponent" Index_Data Edge 0 ;
	setAttr ".cvd" -type "dataPolyComponent" Index_Data Vertex 0 ;
	setAttr ".pd[0]" -type "dataPolyComponent" Index_Data UV 0 ;
	setAttr ".hfd" -type "dataPolyComponent" Index_Data Face 0 ;
	setAttr ".db" yes;
	setAttr ".de" 1;
createNode transform -n "GENERATOR_DEFAULTPROJECT_GRP";
	rename -uid "7063FB05-4091-AEFB-6533-56A88CD07078";
createNode transform -n "DefaultProject_root_placeHolders_ctrl" -p "GENERATOR_DEFAULTPROJECT_GRP";
	rename -uid "F2074B51-4666-EE15-FFEF-6C8DCF96ADFA";
createNode lightLinker -s -n "lightLinker1";
	rename -uid "80438DBF-44E1-97F0-BBD8-0FBFFB425EF5";
	setAttr -s 3 ".lnk";
	setAttr -s 3 ".slnk";
createNode shapeEditorManager -n "shapeEditorManager";
	rename -uid "5CC43229-4C31-61A2-475C-E499D8B2E062";
createNode poseInterpolatorManager -n "poseInterpolatorManager";
	rename -uid "1B6263DF-42D2-B1AE-AF74-CEB344A55D6D";
createNode displayLayerManager -n "layerManager";
	rename -uid "6F2FC962-46FC-41DE-8250-2988CA866A4F";
createNode displayLayer -n "defaultLayer";
	rename -uid "2B9A63AA-4963-2152-91EC-0896A5000E7F";
	setAttr ".ufem" -type "stringArray" 0  ;
createNode renderLayerManager -n "renderLayerManager";
	rename -uid "F20378A1-46F2-59B1-C1C0-62B9F2570C05";
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
		+ "            -hulls 1\n            -grid 1\n            -imagePlane 1\n            -joints 1\n            -ikHandles 1\n            -deformers 1\n            -dynamics 1\n            -particleInstancers 1\n            -fluids 1\n            -hairSystems 1\n            -follicles 1\n            -nCloths 1\n            -nParticles 1\n            -nRigids 1\n            -dynamicConstraints 1\n            -locators 1\n            -manipulators 1\n            -pluginShapes 1\n            -dimensions 1\n            -handles 1\n            -pivots 1\n            -textures 1\n            -strokes 1\n            -motionTrails 1\n            -clipGhosts 1\n            -bluePencil 1\n            -greasePencils 0\n            -excludeObjectPreset \"All\" \n            -shadows 0\n            -captureSequenceNumber -1\n            -width 1\n            -height 1\n            -sceneRenderFilter 0\n            $editorName;\n        modelEditor -e -viewSelected 0 $editorName;\n        modelEditor -e \n            -pluginObjects \"gpuCacheDisplayFilter\" 1 \n            $editorName;\n"
		+ "\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"modelPanel\" (localizedPanelLabel(\"Side View\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tmodelPanel -edit -l (localizedPanelLabel(\"Side View\")) -mbv $menusOkayInPanels  $panelName;\n\t\t$editorName = $panelName;\n        modelEditor -e \n            -camera \"|side\" \n            -useInteractiveMode 0\n            -displayLights \"default\" \n            -displayAppearance \"smoothShaded\" \n            -activeOnly 0\n            -ignorePanZoom 0\n            -wireframeOnShaded 0\n            -headsUpDisplay 1\n            -holdOuts 1\n            -selectionHiliteDisplay 1\n            -useDefaultMaterial 0\n            -bufferMode \"double\" \n            -twoSidedLighting 0\n            -backfaceCulling 0\n            -xray 0\n            -jointXray 0\n            -activeComponentsXray 0\n            -displayTextures 0\n            -smoothWireframe 0\n            -lineWidth 1\n            -textureAnisotropic 0\n"
		+ "            -textureHilight 1\n            -textureSampling 2\n            -textureDisplay \"modulate\" \n            -textureMaxSize 32768\n            -fogging 0\n            -fogSource \"fragment\" \n            -fogMode \"linear\" \n            -fogStart 0\n            -fogEnd 100\n            -fogDensity 0.1\n            -fogColor 0.5 0.5 0.5 1 \n            -depthOfFieldPreview 1\n            -maxConstantTransparency 1\n            -rendererName \"vp2Renderer\" \n            -objectFilterShowInHUD 1\n            -isFiltered 0\n            -colorResolution 256 256 \n            -bumpResolution 512 512 \n            -textureCompression 0\n            -transparencyAlgorithm \"frontAndBackCull\" \n            -transpInShadows 0\n            -cullingOverride \"none\" \n            -lowQualityLighting 0\n            -maximumNumHardwareLights 1\n            -occlusionCulling 0\n            -shadingModel 0\n            -useBaseRenderer 0\n            -useReducedRenderer 0\n            -smallObjectCulling 0\n            -smallObjectThreshold -1 \n            -interactiveDisableShadows 0\n"
		+ "            -interactiveBackFaceCull 0\n            -sortTransparent 1\n            -controllers 1\n            -nurbsCurves 1\n            -nurbsSurfaces 1\n            -polymeshes 1\n            -subdivSurfaces 1\n            -planes 1\n            -lights 1\n            -cameras 1\n            -controlVertices 1\n            -hulls 1\n            -grid 1\n            -imagePlane 1\n            -joints 1\n            -ikHandles 1\n            -deformers 1\n            -dynamics 1\n            -particleInstancers 1\n            -fluids 1\n            -hairSystems 1\n            -follicles 1\n            -nCloths 1\n            -nParticles 1\n            -nRigids 1\n            -dynamicConstraints 1\n            -locators 1\n            -manipulators 1\n            -pluginShapes 1\n            -dimensions 1\n            -handles 1\n            -pivots 1\n            -textures 1\n            -strokes 1\n            -motionTrails 1\n            -clipGhosts 1\n            -bluePencil 1\n            -greasePencils 0\n            -excludeObjectPreset \"All\" \n"
		+ "            -shadows 0\n            -captureSequenceNumber -1\n            -width 1\n            -height 1\n            -sceneRenderFilter 0\n            $editorName;\n        modelEditor -e -viewSelected 0 $editorName;\n        modelEditor -e \n            -pluginObjects \"gpuCacheDisplayFilter\" 1 \n            $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"modelPanel\" (localizedPanelLabel(\"Front View\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tmodelPanel -edit -l (localizedPanelLabel(\"Front View\")) -mbv $menusOkayInPanels  $panelName;\n\t\t$editorName = $panelName;\n        modelEditor -e \n            -camera \"|front\" \n            -useInteractiveMode 0\n            -displayLights \"default\" \n            -displayAppearance \"smoothShaded\" \n            -activeOnly 0\n            -ignorePanZoom 0\n            -wireframeOnShaded 0\n            -headsUpDisplay 1\n            -holdOuts 1\n            -selectionHiliteDisplay 1\n"
		+ "            -useDefaultMaterial 0\n            -bufferMode \"double\" \n            -twoSidedLighting 0\n            -backfaceCulling 0\n            -xray 0\n            -jointXray 0\n            -activeComponentsXray 0\n            -displayTextures 0\n            -smoothWireframe 0\n            -lineWidth 1\n            -textureAnisotropic 0\n            -textureHilight 1\n            -textureSampling 2\n            -textureDisplay \"modulate\" \n            -textureMaxSize 32768\n            -fogging 0\n            -fogSource \"fragment\" \n            -fogMode \"linear\" \n            -fogStart 0\n            -fogEnd 100\n            -fogDensity 0.1\n            -fogColor 0.5 0.5 0.5 1 \n            -depthOfFieldPreview 1\n            -maxConstantTransparency 1\n            -rendererName \"vp2Renderer\" \n            -objectFilterShowInHUD 1\n            -isFiltered 0\n            -colorResolution 256 256 \n            -bumpResolution 512 512 \n            -textureCompression 0\n            -transparencyAlgorithm \"frontAndBackCull\" \n            -transpInShadows 0\n"
		+ "            -cullingOverride \"none\" \n            -lowQualityLighting 0\n            -maximumNumHardwareLights 1\n            -occlusionCulling 0\n            -shadingModel 0\n            -useBaseRenderer 0\n            -useReducedRenderer 0\n            -smallObjectCulling 0\n            -smallObjectThreshold -1 \n            -interactiveDisableShadows 0\n            -interactiveBackFaceCull 0\n            -sortTransparent 1\n            -controllers 1\n            -nurbsCurves 1\n            -nurbsSurfaces 1\n            -polymeshes 1\n            -subdivSurfaces 1\n            -planes 1\n            -lights 1\n            -cameras 1\n            -controlVertices 1\n            -hulls 1\n            -grid 1\n            -imagePlane 1\n            -joints 1\n            -ikHandles 1\n            -deformers 1\n            -dynamics 1\n            -particleInstancers 1\n            -fluids 1\n            -hairSystems 1\n            -follicles 1\n            -nCloths 1\n            -nParticles 1\n            -nRigids 1\n            -dynamicConstraints 1\n"
		+ "            -locators 1\n            -manipulators 1\n            -pluginShapes 1\n            -dimensions 1\n            -handles 1\n            -pivots 1\n            -textures 1\n            -strokes 1\n            -motionTrails 1\n            -clipGhosts 1\n            -bluePencil 1\n            -greasePencils 0\n            -excludeObjectPreset \"All\" \n            -shadows 0\n            -captureSequenceNumber -1\n            -width 1\n            -height 1\n            -sceneRenderFilter 0\n            $editorName;\n        modelEditor -e -viewSelected 0 $editorName;\n        modelEditor -e \n            -pluginObjects \"gpuCacheDisplayFilter\" 1 \n            $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"modelPanel\" (localizedPanelLabel(\"Persp View\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tmodelPanel -edit -l (localizedPanelLabel(\"Persp View\")) -mbv $menusOkayInPanels  $panelName;\n\t\t$editorName = $panelName;\n        modelEditor -e \n"
		+ "            -camera \"|persp\" \n            -useInteractiveMode 0\n            -displayLights \"default\" \n            -displayAppearance \"smoothShaded\" \n            -activeOnly 0\n            -ignorePanZoom 0\n            -wireframeOnShaded 0\n            -headsUpDisplay 1\n            -holdOuts 1\n            -selectionHiliteDisplay 1\n            -useDefaultMaterial 0\n            -bufferMode \"double\" \n            -twoSidedLighting 0\n            -backfaceCulling 0\n            -xray 0\n            -jointXray 0\n            -activeComponentsXray 0\n            -displayTextures 0\n            -smoothWireframe 0\n            -lineWidth 1\n            -textureAnisotropic 0\n            -textureHilight 1\n            -textureSampling 2\n            -textureDisplay \"modulate\" \n            -textureMaxSize 32768\n            -fogging 0\n            -fogSource \"fragment\" \n            -fogMode \"linear\" \n            -fogStart 0\n            -fogEnd 100\n            -fogDensity 0.1\n            -fogColor 0.5 0.5 0.5 1 \n            -depthOfFieldPreview 1\n"
		+ "            -maxConstantTransparency 1\n            -rendererName \"vp2Renderer\" \n            -objectFilterShowInHUD 1\n            -isFiltered 0\n            -colorResolution 256 256 \n            -bumpResolution 512 512 \n            -textureCompression 0\n            -transparencyAlgorithm \"frontAndBackCull\" \n            -transpInShadows 0\n            -cullingOverride \"none\" \n            -lowQualityLighting 0\n            -maximumNumHardwareLights 1\n            -occlusionCulling 0\n            -shadingModel 0\n            -useBaseRenderer 0\n            -useReducedRenderer 0\n            -smallObjectCulling 0\n            -smallObjectThreshold -1 \n            -interactiveDisableShadows 0\n            -interactiveBackFaceCull 0\n            -sortTransparent 1\n            -controllers 1\n            -nurbsCurves 1\n            -nurbsSurfaces 1\n            -polymeshes 1\n            -subdivSurfaces 1\n            -planes 1\n            -lights 1\n            -cameras 1\n            -controlVertices 1\n            -hulls 1\n            -grid 1\n"
		+ "            -imagePlane 1\n            -joints 1\n            -ikHandles 1\n            -deformers 1\n            -dynamics 1\n            -particleInstancers 1\n            -fluids 1\n            -hairSystems 1\n            -follicles 1\n            -nCloths 1\n            -nParticles 1\n            -nRigids 1\n            -dynamicConstraints 1\n            -locators 1\n            -manipulators 1\n            -pluginShapes 1\n            -dimensions 1\n            -handles 1\n            -pivots 1\n            -textures 1\n            -strokes 1\n            -motionTrails 1\n            -clipGhosts 1\n            -bluePencil 1\n            -greasePencils 0\n            -excludeObjectPreset \"All\" \n            -shadows 0\n            -captureSequenceNumber -1\n            -width 699\n            -height 710\n            -sceneRenderFilter 0\n            $editorName;\n        modelEditor -e -viewSelected 0 $editorName;\n        modelEditor -e \n            -pluginObjects \"gpuCacheDisplayFilter\" 1 \n            $editorName;\n\t\tif (!$useSceneConfig) {\n"
		+ "\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"outlinerPanel\" (localizedPanelLabel(\"ToggledOutliner\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\toutlinerPanel -edit -l (localizedPanelLabel(\"ToggledOutliner\")) -mbv $menusOkayInPanels  $panelName;\n\t\t$editorName = $panelName;\n        outlinerEditor -e \n            -docTag \"isolOutln_fromSeln\" \n            -showShapes 0\n            -showAssignedMaterials 0\n            -showTimeEditor 1\n            -showReferenceNodes 1\n            -showReferenceMembers 1\n            -showAttributes 0\n            -showConnected 0\n            -showAnimCurvesOnly 0\n            -showMuteInfo 0\n            -organizeByLayer 1\n            -organizeByClip 1\n            -showAnimLayerWeight 1\n            -autoExpandLayers 1\n            -autoExpand 0\n            -autoExpandAllAnimatedShapes 1\n            -showDagOnly 1\n            -showAssets 1\n            -showContainedOnly 1\n            -showPublishedAsConnected 0\n            -showParentContainers 0\n"
		+ "            -showContainerContents 1\n            -ignoreDagHierarchy 0\n            -expandConnections 0\n            -showUpstreamCurves 1\n            -showUnitlessCurves 1\n            -showCompounds 1\n            -showLeafs 1\n            -showNumericAttrsOnly 0\n            -highlightActive 1\n            -autoSelectNewObjects 0\n            -doNotSelectNewObjects 0\n            -dropIsParent 1\n            -transmitFilters 0\n            -setFilter \"defaultSetFilter\" \n            -showSetMembers 1\n            -allowMultiSelection 1\n            -alwaysToggleSelect 0\n            -directSelect 0\n            -isSet 0\n            -isSetMember 0\n            -showUfeItems 1\n            -displayMode \"DAG\" \n            -expandObjects 0\n            -setsIgnoreFilters 1\n            -containersIgnoreFilters 0\n            -editAttrName 0\n            -showAttrValues 0\n            -highlightSecondary 0\n            -showUVAttrsOnly 0\n            -showTextureNodesOnly 0\n            -attrAlphaOrder \"default\" \n            -animLayerFilterOptions \"allAffecting\" \n"
		+ "            -sortOrder \"none\" \n            -longNames 0\n            -niceNames 1\n            -selectCommand \"print(\\\"\\\")\" \n            -showNamespace 1\n            -showPinIcons 0\n            -mapMotionTrails 0\n            -ignoreHiddenAttribute 0\n            -ignoreOutlinerColor 0\n            -renderFilterVisible 0\n            -renderFilterIndex 0\n            -selectionOrder \"chronological\" \n            -expandAttribute 0\n            $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"outlinerPanel\" (localizedPanelLabel(\"Outliner\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\toutlinerPanel -edit -l (localizedPanelLabel(\"Outliner\")) -mbv $menusOkayInPanels  $panelName;\n\t\t$editorName = $panelName;\n        outlinerEditor -e \n            -showShapes 0\n            -showAssignedMaterials 0\n            -showTimeEditor 1\n            -showReferenceNodes 0\n            -showReferenceMembers 0\n            -showAttributes 0\n"
		+ "            -showConnected 0\n            -showAnimCurvesOnly 0\n            -showMuteInfo 0\n            -organizeByLayer 1\n            -organizeByClip 1\n            -showAnimLayerWeight 1\n            -autoExpandLayers 1\n            -autoExpand 0\n            -autoExpandAllAnimatedShapes 1\n            -showDagOnly 1\n            -showAssets 1\n            -showContainedOnly 1\n            -showPublishedAsConnected 0\n            -showParentContainers 0\n            -showContainerContents 1\n            -ignoreDagHierarchy 0\n            -expandConnections 0\n            -showUpstreamCurves 1\n            -showUnitlessCurves 1\n            -showCompounds 1\n            -showLeafs 1\n            -showNumericAttrsOnly 0\n            -highlightActive 1\n            -autoSelectNewObjects 0\n            -doNotSelectNewObjects 0\n            -dropIsParent 1\n            -transmitFilters 0\n            -setFilter \"defaultSetFilter\" \n            -showSetMembers 1\n            -allowMultiSelection 1\n            -alwaysToggleSelect 0\n            -directSelect 0\n"
		+ "            -showUfeItems 1\n            -displayMode \"DAG\" \n            -expandObjects 0\n            -setsIgnoreFilters 1\n            -containersIgnoreFilters 0\n            -editAttrName 0\n            -showAttrValues 0\n            -highlightSecondary 0\n            -showUVAttrsOnly 0\n            -showTextureNodesOnly 0\n            -attrAlphaOrder \"default\" \n            -animLayerFilterOptions \"allAffecting\" \n            -sortOrder \"none\" \n            -longNames 0\n            -niceNames 1\n            -showNamespace 1\n            -showPinIcons 0\n            -mapMotionTrails 0\n            -ignoreHiddenAttribute 0\n            -ignoreOutlinerColor 0\n            -renderFilterVisible 0\n            $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"graphEditor\" (localizedPanelLabel(\"Graph Editor\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Graph Editor\")) -mbv $menusOkayInPanels  $panelName;\n"
		+ "\n\t\t\t$editorName = ($panelName+\"OutlineEd\");\n            outlinerEditor -e \n                -showShapes 1\n                -showAssignedMaterials 0\n                -showTimeEditor 1\n                -showReferenceNodes 0\n                -showReferenceMembers 0\n                -showAttributes 1\n                -showConnected 1\n                -showAnimCurvesOnly 1\n                -showMuteInfo 0\n                -organizeByLayer 1\n                -organizeByClip 1\n                -showAnimLayerWeight 1\n                -autoExpandLayers 1\n                -autoExpand 1\n                -autoExpandAllAnimatedShapes 1\n                -showDagOnly 0\n                -showAssets 1\n                -showContainedOnly 0\n                -showPublishedAsConnected 0\n                -showParentContainers 0\n                -showContainerContents 0\n                -ignoreDagHierarchy 0\n                -expandConnections 1\n                -showUpstreamCurves 1\n                -showUnitlessCurves 1\n                -showCompounds 0\n                -showLeafs 1\n"
		+ "                -showNumericAttrsOnly 1\n                -highlightActive 0\n                -autoSelectNewObjects 1\n                -doNotSelectNewObjects 0\n                -dropIsParent 1\n                -transmitFilters 1\n                -setFilter \"0\" \n                -showSetMembers 0\n                -allowMultiSelection 1\n                -alwaysToggleSelect 0\n                -directSelect 0\n                -showUfeItems 1\n                -displayMode \"DAG\" \n                -expandObjects 0\n                -setsIgnoreFilters 1\n                -containersIgnoreFilters 0\n                -editAttrName 0\n                -showAttrValues 0\n                -highlightSecondary 0\n                -showUVAttrsOnly 0\n                -showTextureNodesOnly 0\n                -attrAlphaOrder \"default\" \n                -animLayerFilterOptions \"allAffecting\" \n                -sortOrder \"none\" \n                -longNames 0\n                -niceNames 1\n                -showNamespace 1\n                -showPinIcons 1\n                -mapMotionTrails 1\n"
		+ "                -ignoreHiddenAttribute 0\n                -ignoreOutlinerColor 0\n                -renderFilterVisible 0\n                $editorName;\n\n\t\t\t$editorName = ($panelName+\"GraphEd\");\n            animCurveEditor -e \n                -displayValues 0\n                -snapTime \"integer\" \n                -snapValue \"none\" \n                -showPlayRangeShades \"off\" \n                -lockPlayRangeShades \"off\" \n                -smoothness \"fine\" \n                -resultSamples 1\n                -resultScreenSamples 0\n                -resultUpdate \"delayed\" \n                -showUpstreamCurves 1\n                -keyMinScale 1\n                -stackedCurvesMin -1\n                -stackedCurvesMax 1\n                -stackedCurvesSpace 0.2\n                -preSelectionHighlight 1\n                -limitToSelectedCurves 0\n                -constrainDrag 0\n                -valueLinesToggle 0\n                -outliner \"graphEditor1OutlineEd\" \n                -highlightAffectedCurves 1\n                $editorName;\n\t\tif (!$useSceneConfig) {\n"
		+ "\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"dopeSheetPanel\" (localizedPanelLabel(\"Dope Sheet\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Dope Sheet\")) -mbv $menusOkayInPanels  $panelName;\n\n\t\t\t$editorName = ($panelName+\"OutlineEd\");\n            outlinerEditor -e \n                -showShapes 1\n                -showAssignedMaterials 0\n                -showTimeEditor 1\n                -showReferenceNodes 0\n                -showReferenceMembers 0\n                -showAttributes 1\n                -showConnected 1\n                -showAnimCurvesOnly 1\n                -showMuteInfo 0\n                -organizeByLayer 1\n                -organizeByClip 1\n                -showAnimLayerWeight 1\n                -autoExpandLayers 1\n                -autoExpand 0\n                -autoExpandAllAnimatedShapes 1\n                -showDagOnly 0\n                -showAssets 1\n                -showContainedOnly 0\n"
		+ "                -showPublishedAsConnected 0\n                -showParentContainers 0\n                -showContainerContents 0\n                -ignoreDagHierarchy 0\n                -expandConnections 1\n                -showUpstreamCurves 1\n                -showUnitlessCurves 0\n                -showCompounds 1\n                -showLeafs 1\n                -showNumericAttrsOnly 1\n                -highlightActive 0\n                -autoSelectNewObjects 0\n                -doNotSelectNewObjects 1\n                -dropIsParent 1\n                -transmitFilters 0\n                -setFilter \"0\" \n                -showSetMembers 0\n                -allowMultiSelection 1\n                -alwaysToggleSelect 0\n                -directSelect 0\n                -showUfeItems 1\n                -displayMode \"DAG\" \n                -expandObjects 0\n                -setsIgnoreFilters 1\n                -containersIgnoreFilters 0\n                -editAttrName 0\n                -showAttrValues 0\n                -highlightSecondary 0\n                -showUVAttrsOnly 0\n"
		+ "                -showTextureNodesOnly 0\n                -attrAlphaOrder \"default\" \n                -animLayerFilterOptions \"allAffecting\" \n                -sortOrder \"none\" \n                -longNames 0\n                -niceNames 1\n                -showNamespace 1\n                -showPinIcons 0\n                -mapMotionTrails 1\n                -ignoreHiddenAttribute 0\n                -ignoreOutlinerColor 0\n                -renderFilterVisible 0\n                $editorName;\n\n\t\t\t$editorName = ($panelName+\"DopeSheetEd\");\n            dopeSheetEditor -e \n                -displayValues 0\n                -snapTime \"integer\" \n                -snapValue \"none\" \n                -outliner \"dopeSheetPanel1OutlineEd\" \n                -showSummary 1\n                -showScene 0\n                -hierarchyBelow 0\n                -showTicks 1\n                -selectionWindow 0 0 0 0 \n                $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"timeEditorPanel\" (localizedPanelLabel(\"Time Editor\")) `;\n"
		+ "\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Time Editor\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"clipEditorPanel\" (localizedPanelLabel(\"Trax Editor\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Trax Editor\")) -mbv $menusOkayInPanels  $panelName;\n\n\t\t\t$editorName = clipEditorNameFromPanel($panelName);\n            clipEditor -e \n                -displayValues 0\n                -snapTime \"none\" \n                -snapValue \"none\" \n                -initialized 0\n                -manageSequencer 0 \n                $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"sequenceEditorPanel\" (localizedPanelLabel(\"Camera Sequencer\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n"
		+ "\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Camera Sequencer\")) -mbv $menusOkayInPanels  $panelName;\n\n\t\t\t$editorName = sequenceEditorNameFromPanel($panelName);\n            clipEditor -e \n                -displayValues 0\n                -snapTime \"none\" \n                -snapValue \"none\" \n                -initialized 0\n                -manageSequencer 1 \n                $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"hyperGraphPanel\" (localizedPanelLabel(\"Hypergraph Hierarchy\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Hypergraph Hierarchy\")) -mbv $menusOkayInPanels  $panelName;\n\n\t\t\t$editorName = ($panelName+\"HyperGraphEd\");\n            hyperGraph -e \n                -graphLayoutStyle \"hierarchicalLayout\" \n                -orientation \"horiz\" \n                -mergeConnections 0\n                -zoom 1\n                -animateTransition 0\n                -showRelationships 1\n"
		+ "                -showShapes 0\n                -showDeformers 0\n                -showExpressions 0\n                -showConstraints 0\n                -showConnectionFromSelected 0\n                -showConnectionToSelected 0\n                -showConstraintLabels 0\n                -showUnderworld 0\n                -showInvisible 0\n                -transitionFrames 1\n                -opaqueContainers 0\n                -freeform 0\n                -imagePosition 0 0 \n                -imageScale 1\n                -imageEnabled 0\n                -graphType \"DAG\" \n                -heatMapDisplay 0\n                -updateSelection 1\n                -updateNodeAdded 1\n                -useDrawOverrideColor 0\n                -limitGraphTraversal -1\n                -range 0 0 \n                -iconSize \"smallIcons\" \n                -showCachedConnections 0\n                $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"hyperShadePanel\" (localizedPanelLabel(\"Hypershade\")) `;\n"
		+ "\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Hypershade\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"visorPanel\" (localizedPanelLabel(\"Visor\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Visor\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"nodeEditorPanel\" (localizedPanelLabel(\"Node Editor\")) `;\n\tif ($nodeEditorPanelVisible || $nodeEditorWorkspaceControlOpen) {\n\t\tif (\"\" == $panelName) {\n\t\t\tif ($useSceneConfig) {\n\t\t\t\t$panelName = `scriptedPanel -unParent  -type \"nodeEditorPanel\" -l (localizedPanelLabel(\"Node Editor\")) -mbv $menusOkayInPanels `;\n\n\t\t\t$editorName = ($panelName+\"NodeEditorEd\");\n            nodeEditor -e \n                -allAttributes 0\n"
		+ "                -allNodes 0\n                -autoSizeNodes 1\n                -consistentNameSize 1\n                -createNodeCommand \"nodeEdCreateNodeCommand\" \n                -connectNodeOnCreation 0\n                -connectOnDrop 0\n                -copyConnectionsOnPaste 0\n                -connectionStyle \"bezier\" \n                -defaultPinnedState 0\n                -additiveGraphingMode 0\n                -connectedGraphingMode 1\n                -settingsChangedCallback \"nodeEdSyncControls\" \n                -traversalDepthLimit -1\n                -keyPressCommand \"nodeEdKeyPressCommand\" \n                -nodeTitleMode \"name\" \n                -gridSnap 0\n                -gridVisibility 1\n                -crosshairOnEdgeDragging 0\n                -popupMenuScript \"nodeEdBuildPanelMenus\" \n                -showNamespace 1\n                -showShapes 1\n                -showSGShapes 0\n                -showTransforms 1\n                -useAssets 1\n                -syncedSelection 1\n                -extendToShapes 1\n"
		+ "                -showUnitConversions 1\n                -editorMode \"default\" \n                -hasWatchpoint 0\n                $editorName;\n\t\t\t}\n\t\t} else {\n\t\t\t$label = `panel -q -label $panelName`;\n\t\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Node Editor\")) -mbv $menusOkayInPanels  $panelName;\n\n\t\t\t$editorName = ($panelName+\"NodeEditorEd\");\n            nodeEditor -e \n                -allAttributes 0\n                -allNodes 0\n                -autoSizeNodes 1\n                -consistentNameSize 1\n                -createNodeCommand \"nodeEdCreateNodeCommand\" \n                -connectNodeOnCreation 0\n                -connectOnDrop 0\n                -copyConnectionsOnPaste 0\n                -connectionStyle \"bezier\" \n                -defaultPinnedState 0\n                -additiveGraphingMode 0\n                -connectedGraphingMode 1\n                -settingsChangedCallback \"nodeEdSyncControls\" \n                -traversalDepthLimit -1\n                -keyPressCommand \"nodeEdKeyPressCommand\" \n                -nodeTitleMode \"name\" \n"
		+ "                -gridSnap 0\n                -gridVisibility 1\n                -crosshairOnEdgeDragging 0\n                -popupMenuScript \"nodeEdBuildPanelMenus\" \n                -showNamespace 1\n                -showShapes 1\n                -showSGShapes 0\n                -showTransforms 1\n                -useAssets 1\n                -syncedSelection 1\n                -extendToShapes 1\n                -showUnitConversions 1\n                -editorMode \"default\" \n                -hasWatchpoint 0\n                $editorName;\n\t\t\tif (!$useSceneConfig) {\n\t\t\t\tpanel -e -l $label $panelName;\n\t\t\t}\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"createNodePanel\" (localizedPanelLabel(\"Create Node\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Create Node\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"polyTexturePlacementPanel\" (localizedPanelLabel(\"UV Editor\")) `;\n"
		+ "\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"UV Editor\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"renderWindowPanel\" (localizedPanelLabel(\"Render View\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Render View\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"shapePanel\" (localizedPanelLabel(\"Shape Editor\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tshapePanel -edit -l (localizedPanelLabel(\"Shape Editor\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"posePanel\" (localizedPanelLabel(\"Pose Editor\")) `;\n\tif (\"\" != $panelName) {\n"
		+ "\t\t$label = `panel -q -label $panelName`;\n\t\tposePanel -edit -l (localizedPanelLabel(\"Pose Editor\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"dynRelEdPanel\" (localizedPanelLabel(\"Dynamic Relationships\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Dynamic Relationships\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"relationshipPanel\" (localizedPanelLabel(\"Relationship Editor\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Relationship Editor\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"referenceEditorPanel\" (localizedPanelLabel(\"Reference Editor\")) `;\n"
		+ "\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Reference Editor\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"dynPaintScriptedPanelType\" (localizedPanelLabel(\"Paint Effects\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Paint Effects\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"scriptEditorPanel\" (localizedPanelLabel(\"Script Editor\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Script Editor\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"profilerPanel\" (localizedPanelLabel(\"Profiler Tool\")) `;\n"
		+ "\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Profiler Tool\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"contentBrowserPanel\" (localizedPanelLabel(\"Content Browser\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Content Browser\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"Stereo\" (localizedPanelLabel(\"Stereo\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Stereo\")) -mbv $menusOkayInPanels  $panelName;\n{ string $editorName = ($panelName+\"Editor\");\n            stereoCameraView -e \n                -camera \"|persp\" \n                -useInteractiveMode 0\n                -displayLights \"default\" \n"
		+ "                -displayAppearance \"wireframe\" \n                -activeOnly 0\n                -ignorePanZoom 0\n                -wireframeOnShaded 0\n                -headsUpDisplay 1\n                -holdOuts 1\n                -selectionHiliteDisplay 1\n                -useDefaultMaterial 0\n                -bufferMode \"double\" \n                -twoSidedLighting 1\n                -backfaceCulling 0\n                -xray 0\n                -jointXray 0\n                -activeComponentsXray 0\n                -displayTextures 0\n                -smoothWireframe 0\n                -lineWidth 1\n                -textureAnisotropic 0\n                -textureHilight 1\n                -textureSampling 2\n                -textureDisplay \"modulate\" \n                -textureMaxSize 32768\n                -fogging 0\n                -fogSource \"fragment\" \n                -fogMode \"linear\" \n                -fogStart 0\n                -fogEnd 100\n                -fogDensity 0.1\n                -fogColor 0.5 0.5 0.5 1 \n                -depthOfFieldPreview 1\n"
		+ "                -maxConstantTransparency 1\n                -objectFilterShowInHUD 1\n                -isFiltered 0\n                -colorResolution 4 4 \n                -bumpResolution 4 4 \n                -textureCompression 0\n                -transparencyAlgorithm \"frontAndBackCull\" \n                -transpInShadows 0\n                -cullingOverride \"none\" \n                -lowQualityLighting 0\n                -maximumNumHardwareLights 0\n                -occlusionCulling 0\n                -shadingModel 0\n                -useBaseRenderer 0\n                -useReducedRenderer 0\n                -smallObjectCulling 0\n                -smallObjectThreshold -1 \n                -interactiveDisableShadows 0\n                -interactiveBackFaceCull 0\n                -sortTransparent 1\n                -controllers 1\n                -nurbsCurves 1\n                -nurbsSurfaces 1\n                -polymeshes 1\n                -subdivSurfaces 1\n                -planes 1\n                -lights 1\n                -cameras 1\n"
		+ "                -controlVertices 1\n                -hulls 1\n                -grid 1\n                -imagePlane 1\n                -joints 1\n                -ikHandles 1\n                -deformers 1\n                -dynamics 1\n                -particleInstancers 1\n                -fluids 1\n                -hairSystems 1\n                -follicles 1\n                -nCloths 1\n                -nParticles 1\n                -nRigids 1\n                -dynamicConstraints 1\n                -locators 1\n                -manipulators 1\n                -pluginShapes 1\n                -dimensions 1\n                -handles 1\n                -pivots 1\n                -textures 1\n                -strokes 1\n                -motionTrails 1\n                -clipGhosts 1\n                -bluePencil 1\n                -greasePencils 0\n                -shadows 0\n                -captureSequenceNumber -1\n                -width 0\n                -height 0\n                -sceneRenderFilter 0\n                -displayMode \"centerEye\" \n"
		+ "                -viewColor 0 0 0 1 \n                -useCustomBackground 1\n                $editorName;\n            stereoCameraView -e -viewSelected 0 $editorName;\n            stereoCameraView -e \n                -pluginObjects \"gpuCacheDisplayFilter\" 1 \n                $editorName; };\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\tif ($useSceneConfig) {\n        string $configName = `getPanel -cwl (localizedPanelLabel(\"Current Layout\"))`;\n        if (\"\" != $configName) {\n\t\t\tpanelConfiguration -edit -label (localizedPanelLabel(\"Current Layout\")) \n\t\t\t\t-userCreated false\n\t\t\t\t-defaultImage \"vacantCell.xP:/\"\n\t\t\t\t-image \"\"\n\t\t\t\t-sc false\n\t\t\t\t-configString \"global string $gMainPane; paneLayout -e -cn \\\"single\\\" -ps 1 100 100 $gMainPane;\"\n\t\t\t\t-removeAllPanels\n\t\t\t\t-ap false\n\t\t\t\t\t(localizedPanelLabel(\"Persp View\")) \n\t\t\t\t\t\"modelPanel\"\n"
		+ "\t\t\t\t\t\"$panelName = `modelPanel -unParent -l (localizedPanelLabel(\\\"Persp View\\\")) -mbv $menusOkayInPanels `;\\n$editorName = $panelName;\\nmodelEditor -e \\n    -cam `findStartUpCamera persp` \\n    -useInteractiveMode 0\\n    -displayLights \\\"default\\\" \\n    -displayAppearance \\\"smoothShaded\\\" \\n    -activeOnly 0\\n    -ignorePanZoom 0\\n    -wireframeOnShaded 0\\n    -headsUpDisplay 1\\n    -holdOuts 1\\n    -selectionHiliteDisplay 1\\n    -useDefaultMaterial 0\\n    -bufferMode \\\"double\\\" \\n    -twoSidedLighting 0\\n    -backfaceCulling 0\\n    -xray 0\\n    -jointXray 0\\n    -activeComponentsXray 0\\n    -displayTextures 0\\n    -smoothWireframe 0\\n    -lineWidth 1\\n    -textureAnisotropic 0\\n    -textureHilight 1\\n    -textureSampling 2\\n    -textureDisplay \\\"modulate\\\" \\n    -textureMaxSize 32768\\n    -fogging 0\\n    -fogSource \\\"fragment\\\" \\n    -fogMode \\\"linear\\\" \\n    -fogStart 0\\n    -fogEnd 100\\n    -fogDensity 0.1\\n    -fogColor 0.5 0.5 0.5 1 \\n    -depthOfFieldPreview 1\\n    -maxConstantTransparency 1\\n    -rendererName \\\"vp2Renderer\\\" \\n    -objectFilterShowInHUD 1\\n    -isFiltered 0\\n    -colorResolution 256 256 \\n    -bumpResolution 512 512 \\n    -textureCompression 0\\n    -transparencyAlgorithm \\\"frontAndBackCull\\\" \\n    -transpInShadows 0\\n    -cullingOverride \\\"none\\\" \\n    -lowQualityLighting 0\\n    -maximumNumHardwareLights 1\\n    -occlusionCulling 0\\n    -shadingModel 0\\n    -useBaseRenderer 0\\n    -useReducedRenderer 0\\n    -smallObjectCulling 0\\n    -smallObjectThreshold -1 \\n    -interactiveDisableShadows 0\\n    -interactiveBackFaceCull 0\\n    -sortTransparent 1\\n    -controllers 1\\n    -nurbsCurves 1\\n    -nurbsSurfaces 1\\n    -polymeshes 1\\n    -subdivSurfaces 1\\n    -planes 1\\n    -lights 1\\n    -cameras 1\\n    -controlVertices 1\\n    -hulls 1\\n    -grid 1\\n    -imagePlane 1\\n    -joints 1\\n    -ikHandles 1\\n    -deformers 1\\n    -dynamics 1\\n    -particleInstancers 1\\n    -fluids 1\\n    -hairSystems 1\\n    -follicles 1\\n    -nCloths 1\\n    -nParticles 1\\n    -nRigids 1\\n    -dynamicConstraints 1\\n    -locators 1\\n    -manipulators 1\\n    -pluginShapes 1\\n    -dimensions 1\\n    -handles 1\\n    -pivots 1\\n    -textures 1\\n    -strokes 1\\n    -motionTrails 1\\n    -clipGhosts 1\\n    -bluePencil 1\\n    -greasePencils 0\\n    -excludeObjectPreset \\\"All\\\" \\n    -shadows 0\\n    -captureSequenceNumber -1\\n    -width 699\\n    -height 710\\n    -sceneRenderFilter 0\\n    $editorName;\\nmodelEditor -e -viewSelected 0 $editorName;\\nmodelEditor -e \\n    -pluginObjects \\\"gpuCacheDisplayFilter\\\" 1 \\n    $editorName\"\n"
		+ "\t\t\t\t\t\"modelPanel -edit -l (localizedPanelLabel(\\\"Persp View\\\")) -mbv $menusOkayInPanels  $panelName;\\n$editorName = $panelName;\\nmodelEditor -e \\n    -cam `findStartUpCamera persp` \\n    -useInteractiveMode 0\\n    -displayLights \\\"default\\\" \\n    -displayAppearance \\\"smoothShaded\\\" \\n    -activeOnly 0\\n    -ignorePanZoom 0\\n    -wireframeOnShaded 0\\n    -headsUpDisplay 1\\n    -holdOuts 1\\n    -selectionHiliteDisplay 1\\n    -useDefaultMaterial 0\\n    -bufferMode \\\"double\\\" \\n    -twoSidedLighting 0\\n    -backfaceCulling 0\\n    -xray 0\\n    -jointXray 0\\n    -activeComponentsXray 0\\n    -displayTextures 0\\n    -smoothWireframe 0\\n    -lineWidth 1\\n    -textureAnisotropic 0\\n    -textureHilight 1\\n    -textureSampling 2\\n    -textureDisplay \\\"modulate\\\" \\n    -textureMaxSize 32768\\n    -fogging 0\\n    -fogSource \\\"fragment\\\" \\n    -fogMode \\\"linear\\\" \\n    -fogStart 0\\n    -fogEnd 100\\n    -fogDensity 0.1\\n    -fogColor 0.5 0.5 0.5 1 \\n    -depthOfFieldPreview 1\\n    -maxConstantTransparency 1\\n    -rendererName \\\"vp2Renderer\\\" \\n    -objectFilterShowInHUD 1\\n    -isFiltered 0\\n    -colorResolution 256 256 \\n    -bumpResolution 512 512 \\n    -textureCompression 0\\n    -transparencyAlgorithm \\\"frontAndBackCull\\\" \\n    -transpInShadows 0\\n    -cullingOverride \\\"none\\\" \\n    -lowQualityLighting 0\\n    -maximumNumHardwareLights 1\\n    -occlusionCulling 0\\n    -shadingModel 0\\n    -useBaseRenderer 0\\n    -useReducedRenderer 0\\n    -smallObjectCulling 0\\n    -smallObjectThreshold -1 \\n    -interactiveDisableShadows 0\\n    -interactiveBackFaceCull 0\\n    -sortTransparent 1\\n    -controllers 1\\n    -nurbsCurves 1\\n    -nurbsSurfaces 1\\n    -polymeshes 1\\n    -subdivSurfaces 1\\n    -planes 1\\n    -lights 1\\n    -cameras 1\\n    -controlVertices 1\\n    -hulls 1\\n    -grid 1\\n    -imagePlane 1\\n    -joints 1\\n    -ikHandles 1\\n    -deformers 1\\n    -dynamics 1\\n    -particleInstancers 1\\n    -fluids 1\\n    -hairSystems 1\\n    -follicles 1\\n    -nCloths 1\\n    -nParticles 1\\n    -nRigids 1\\n    -dynamicConstraints 1\\n    -locators 1\\n    -manipulators 1\\n    -pluginShapes 1\\n    -dimensions 1\\n    -handles 1\\n    -pivots 1\\n    -textures 1\\n    -strokes 1\\n    -motionTrails 1\\n    -clipGhosts 1\\n    -bluePencil 1\\n    -greasePencils 0\\n    -excludeObjectPreset \\\"All\\\" \\n    -shadows 0\\n    -captureSequenceNumber -1\\n    -width 699\\n    -height 710\\n    -sceneRenderFilter 0\\n    $editorName;\\nmodelEditor -e -viewSelected 0 $editorName;\\nmodelEditor -e \\n    -pluginObjects \\\"gpuCacheDisplayFilter\\\" 1 \\n    $editorName\"\n"
		+ "\t\t\t\t$configName;\n\n            setNamedPanelLayout (localizedPanelLabel(\"Current Layout\"));\n        }\n\n        panelHistory -e -clear mainPanelHistory;\n        sceneUIReplacement -clear;\n\t}\n\n\ngrid -spacing 5 -size 12 -divisions 5 -displayAxes yes -displayGridLines yes -displayDivisionLines yes -displayPerspectiveLabels no -displayOrthographicLabels no -displayAxesBold yes -perspectiveLabelPosition axis -orthographicLabelPosition edge;\nviewManip -drawCompass 0 -compassAngle 0 -frontParameters \"\" -homeParameters \"\" -selectionLockParameters \"\";\n}\n");
	setAttr ".st" 3;
createNode script -n "sceneConfigurationScriptNode";
	rename -uid "6BA40F4A-42D6-7AB0-8BF1-04945A278A16";
	setAttr ".b" -type "string" "playbackOptions -min 1 -max 170 -ast 1 -aet 170 ";
	setAttr ".st" 6;
createNode animCurveTU -n "target_pt_visibility";
	rename -uid "376D3A80-4D7D-ADFB-694C-9D83A7E125AC";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 76 ".ktv[0:75]"  0 1 2 1 4 1 6 1 8 1 10 1 12 1 14 1 16 1
		 18 1 20 1 22 1 24 1 26 1 28 1 30 1 32 1 34 1 36 1 38 1 40 1 42 1 44 1 46 1 48 1 50 1
		 52 1 54 1 56 1 58 1 60 1 62 1 64 1 66 1 68 1 70 1 72 1 74 1 76 1 78 1 80 1 82 1 84 1
		 86 1 88 1 90 1 92 1 94 1 96 1 98 1 100 1 102 1 104 1 106 1 108 1 110 1 112 1 114 1
		 116 1 118 1 120 1 122 1 124 1 126 1 128 1 130 1 132 1 134 1 136 1 138 1 140 1 142 1
		 144 1 146 1 148 1 150 1;
createNode animCurveTL -n "target_pt_translateX";
	rename -uid "A860536C-4DA8-ABA3-07F7-4E98AD2631F4";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 76 ".ktv[0:75]"  0 0 2 0.038599354569765099 4 0.15079607100527903
		 6 0.33096618536238898 8 0.57331513460078976 10 0.87126346116947506 12 1.2172565964520008
		 14 1.601854627178247 16 2.0123772454637199 18 2.4286842479208866 20 2.8088023651027658
		 22 3.0117253168266664 24 2.6525329313773098 26 1.9712022879839219 28 1.2254336913847688
		 30 0.46415693598789853 32 -0.29274311527773311 34 -1.0305761100071338 36 -1.736390387477653
		 38 -2.4022837924975953 40 -3.0205290085462062 42 -3.5826071523607625 44 -4.0827299817706404
		 46 -4.5170700692250323 48 -4.8605360203382286 50 -5.0086951901855166 52 -4.7949021008485229
		 54 -4.3587839869927265 56 -3.8424609611325926 58 -3.2871709731183127 60 -2.7060974930665207
		 62 -2.1086054462909898 64 -1.5064245299840602 66 -0.89930745837014314 68 -0.27208994456926472
		 70 0.40150016683222001 72 1.1701341529457543 74 2.1030749454066795 76 2.9197277651406548
		 78 3.4587787821249174 80 3.8209882387432872 82 4.0183728249603092 84 3.9957215430097071
		 86 3.6092966978175438 88 2.2976558070751687 90 0.64311414902041419 92 -1.0882451180834787
		 94 -2.9183000891057649 96 -4.7815954227340587 98 -6.5244942138724422 100 -7.3080197315973514
		 102 -6.7782903018104763 104 -5.5663615462595057 106 -4.0044589894493008 108 -2.3413457367528694
		 110 -0.73107746802730411 112 0.78130183472310488 114 2.1792163589201885 116 3.4503199710627461
		 118 4.5904198703226475 120 5.6444723980675677 122 6.6174184730394137 124 7.5018298618338619
		 126 8.2908265282077807 128 8.9822047712784023 130 9.5791194944278271 132 10.089414123457324
		 134 10.522905907113644 136 10.889000176711916 138 11.195394835614229 140 11.447821289308958
		 142 11.650092698950953 144 11.80489510468143 146 11.914051035692763 148 11.978681767152942
		 150 12.000000000000046;
createNode animCurveTL -n "target_pt_translateY";
	rename -uid "9CDBA982-4C35-F25E-50EF-F18A207B008A";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 76 ".ktv[0:75]"  0 0 2 0 4 0 6 0 8 0 10 0 12 0 14 0 16 0
		 18 0 20 0 22 0 24 0 26 0 28 0 30 0 32 0 34 0 36 0 38 0 40 0 42 0 44 0 46 0 48 0 50 0
		 52 0 54 0 56 0 58 0 60 0 62 0 64 0 66 0 68 0 70 0 72 0 74 0 76 0 78 0 80 0 82 0 84 0
		 86 0 88 0 90 0 92 0 94 0 96 0 98 0 100 0 102 0 104 0 106 0 108 0 110 0 112 0 114 0
		 116 0 118 0 120 0 122 0 124 0 126 0 128 0 130 0 132 0 134 0 136 0 138 0 140 0 142 0
		 144 0 146 0 148 0 150 0;
createNode animCurveTL -n "target_pt_translateZ";
	rename -uid "8BF33CC6-4230-19AC-9A75-D28C79D12F77";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 76 ".ktv[0:75]"  0 12.00000000000062 2 11.962416698117973
		 4 11.853141000132648 6 11.677383380161245 8 11.439853935035293 10 11.144755659382437
		 12 10.795157613701923 14 10.392605445978214 16 9.9358899236049822 18 9.4188627912694045
		 20 8.8244910027780783 22 8.1196427257895021 24 7.4701517888820792 26 7.0795373292058859
		 28 6.7917790610800921 30 6.5328269254521292 32 6.2707739563170879 34 5.9874373861838164
		 36 5.6745205979728235 38 5.3373867155465549 40 4.9823066345723888 42 4.6138563562222279
		 44 4.2316269791435639 46 3.8243776188669365 48 3.3712829365435826 50 2.8473881145849429
		 52 2.361225773683874 54 2.0481170829536186 56 1.8737099213610968 58 1.8051236615817703
		 60 1.8334136565199028 62 1.9643645139799861 64 2.208489189824022 66 2.5492757082571367
		 68 2.9613507804780363 70 3.4158714786543629 72 3.8476216593510246 74 3.9783288235422556
		 76 3.3546879934729241 78 2.3531460709509622 80 1.1480363835052085 82 -0.22523481586102251
		 84 -1.725607954491351 86 -3.272416873066148 88 -4.0672494548379134 90 -3.492689919522546
		 92 -2.9813379299144818 94 -2.7579725534944379 96 -2.8557732334865111 98 -3.5072306735002639
		 100 -5.1240834696105244 102 -6.8729038270338281 104 -8.2051534621606255 106 -8.9986113728083374
		 108 -9.2987230649931316 110 -9.3364889832179916 112 -9.2618263094850803 114 -9.1519066289339985
		 116 -9.0517764682249329 118 -8.9892680677721533 120 -8.9836059123089154 122 -9.0591788835730718
		 124 -9.2227585407941088 126 -9.46080565921012 128 -9.7527320580909276 130 -10.074537982988774
		 132 -10.403502504729815 134 -10.721261549535441 136 -11.014673083786544 138 -11.275218158114066
		 140 -11.497949486188892 142 -11.680252918810773 144 -11.821293591997971 146 -11.921207634906162
		 148 -11.980453061813707 150 -12.000000000000046;
createNode animCurveTA -n "target_pt_rotateX";
	rename -uid "86F00F33-4215-A147-0D49-378C7121652F";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 76 ".ktv[0:75]"  0 0 2 0 4 0 6 0 8 0 10 0 12 0 14 0 16 0
		 18 0 20 0 22 0 24 0 26 0 28 0 30 0 32 0 34 0 36 0 38 0 40 0 42 0 44 0 46 0 48 0 50 0
		 52 0 54 0 56 0 58 0 60 0 62 0 64 0 66 0 68 0 70 0 72 0 74 0 76 0 78 0 80 0 82 0 84 0
		 86 0 88 0 90 0 92 0 94 0 96 0 98 0 100 0 102 0 104 0 106 0 108 0 110 0 112 0 114 0
		 116 0 118 0 120 0 122 0 124 0 126 0 128 0 130 0 132 0 134 0 136 0 138 0 140 0 142 0
		 144 0 146 0 148 0 150 0;
createNode animCurveTA -n "target_pt_rotateY";
	rename -uid "434D5768-414C-E797-745A-00B1568964F4";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 76 ".ktv[0:75]"  0 44.235446241870982 2 44.236771664125428
		 4 44.255703885924142 6 44.333598235297693 8 44.534381217876735 10 44.946917278830433
		 12 45.700394230334176 14 47.006248844278041 16 49.272195361136511 18 53.461015181814794
		 20 62.621625317882078 22 91.225829426301217 24 140.76376247424921 26 156.23658987040145
		 28 160.64796119550275 30 161.37388964106111 32 160.17298466621384 34 157.59800218151975
		 36 154.60122631322838 38 151.66162034591633 40 148.51213453669749 42 144.83551782963374
		 44 140.08498612393848 46 132.95998920578606 48 119.59401634997398 50 87.246796375842891
		 52 47.845870223322109 54 25.789280253517965 56 12.387431680314304 58 2.0220066627245594
		 60 -7.4924785343678453 62 -17.245919753294142 64 -26.22518855192418 66 -31.790503740263496
		 68 -34.265190367274997 70 -32.979764110282943 72 -23.572885950243098 74 14.912848029893187
		 76 53.063452714761787 78 68.335242892276113 80 77.611989158424819 82 86.032071694482795
		 84 96.075033247011604 86 115.00974511296786 88 190.36586391417222 90 200.39051435640525
		 92 191.6845761875322 94 182.38575665293482 96 170.60479046894702 98 143.55178494066834
		 100 89.85007853451161 102 59.075892459507322 104 36.849302825073536 106 17.322267526227805
		 108 4.6582149401625141 110 -1.2944258062829359 112 -3.9922336579906923 114 -4.7410610811399732
		 116 -4.030036520388653 118 -1.9796627037650412 120 1.7406869356096248 122 7.4172803329959853
		 124 13.673628185327392 126 19.963972330184607 128 25.79927387683697 130 30.784034252946064
		 132 34.731466120329891 134 37.653274613326253 136 39.683247573081424 138 41.003167937762804
		 140 41.796791264454143 142 42.226914945477098 144 42.42754940797218 146 42.500782549222414
		 148 42.517352331064295 150 42.518438804998553;
createNode animCurveTA -n "target_pt_rotateZ";
	rename -uid "5C047649-414C-E323-B922-3DAE324C72A2";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 76 ".ktv[0:75]"  0 0 2 0 4 0 6 0 8 0 10 0 12 0 14 0 16 0
		 18 0 20 0 22 0 24 0 26 0 28 0 30 0 32 0 34 0 36 0 38 0 40 0 42 0 44 0 46 0 48 0 50 0
		 52 0 54 0 56 0 58 0 60 0 62 0 64 0 66 0 68 0 70 0 72 0 74 0 76 0 78 0 80 0 82 0 84 0
		 86 0 88 0 90 0 92 0 94 0 96 0 98 0 100 0 102 0 104 0 106 0 108 0 110 0 112 0 114 0
		 116 0 118 0 120 0 122 0 124 0 126 0 128 0 130 0 132 0 134 0 136 0 138 0 140 0 142 0
		 144 0 146 0 148 0 150 0;
createNode animCurveTU -n "target_pt_scaleX";
	rename -uid "80C775B4-49F9-CC21-FC4C-33A17DE5C0C5";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 76 ".ktv[0:75]"  0 1 2 1 4 1 6 1 8 1 10 1 12 1 14 1 16 1
		 18 1 20 1 22 1 24 1 26 1 28 1 30 1 32 1 34 1 36 1 38 1 40 1 42 1 44 1 46 1 48 1 50 1
		 52 1 54 1 56 1 58 1 60 1 62 1 64 1 66 1 68 1 70 1 72 1 74 1 76 1 78 1 80 1 82 1 84 1
		 86 1 88 1 90 1 92 1 94 1 96 1 98 1 100 1 102 1 104 1 106 1 108 1 110 1 112 1 114 1
		 116 1 118 1 120 1 122 1 124 1 126 1 128 1 130 1 132 1 134 1 136 1 138 1 140 1 142 1
		 144 1 146 1 148 1 150 1;
createNode animCurveTU -n "target_pt_scaleY";
	rename -uid "5961A50C-488D-9AC8-4CB0-33B3DB019475";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 76 ".ktv[0:75]"  0 1 2 1 4 1 6 1 8 1 10 1 12 1 14 1 16 1
		 18 1 20 1 22 1 24 1 26 1 28 1 30 1 32 1 34 1 36 1 38 1 40 1 42 1 44 1 46 1 48 1 50 1
		 52 1 54 1 56 1 58 1 60 1 62 1 64 1 66 1 68 1 70 1 72 1 74 1 76 1 78 1 80 1 82 1 84 1
		 86 1 88 1 90 1 92 1 94 1 96 1 98 1 100 1 102 1 104 1 106 1 108 1 110 1 112 1 114 1
		 116 1 118 1 120 1 122 1 124 1 126 1 128 1 130 1 132 1 134 1 136 1 138 1 140 1 142 1
		 144 1 146 1 148 1 150 1;
createNode animCurveTU -n "target_pt_scaleZ";
	rename -uid "6A6096DE-476F-B5B4-F79F-048351B09C5A";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 76 ".ktv[0:75]"  0 1 2 1 4 1 6 1 8 1 10 1 12 1 14 1 16 1
		 18 1 20 1 22 1 24 1 26 1 28 1 30 1 32 1 34 1 36 1 38 1 40 1 42 1 44 1 46 1 48 1 50 1
		 52 1 54 1 56 1 58 1 60 1 62 1 64 1 66 1 68 1 70 1 72 1 74 1 76 1 78 1 80 1 82 1 84 1
		 86 1 88 1 90 1 92 1 94 1 96 1 98 1 100 1 102 1 104 1 106 1 108 1 110 1 112 1 114 1
		 116 1 118 1 120 1 122 1 124 1 126 1 128 1 130 1 132 1 134 1 136 1 138 1 140 1 142 1
		 144 1 146 1 148 1 150 1;
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
createNode polyPlane -n "polyPlane1";
	rename -uid "508CC2A9-407B-24A5-F301-52A3A5941E45";
	setAttr ".sw" 1;
	setAttr ".sh" 1;
createNode reference -n "majia_model_papython_publishRN";
	rename -uid "ADEC90B5-4164-E355-8A5C-8C8F74CE6815";
	setAttr ".ed" -type "dataReferenceEdits" 
		"majia_model_papython_publishRN"
		"majia_model_papython_publishRN" 0
		"majia_model_papython_publishRN" 5
		2 "|papython:papython_grp" "visibility" " 1"
		2 "|papython:papython_grp" "rotate" " -type \"double3\" 68 0 0"
		2 "|papython:papython_grp" "scale" " -type \"double3\" 0.5 0.5 0.5"
		2 "|papython:papython_grp|papython:R_wing_msh" "rotate" " -type \"double3\" 0 0 0"
		
		2 "|papython:papython_grp|papython:L_wing_msh" "rotate" " -type \"double3\" 0 0 0";
	setAttr ".ptag" -type "string" "";
lockNode -l 1 ;
createNode animCurveTL -n "DefaultProject_root_placeHolders_ctrl_translateX";
	rename -uid "AA810C52-4AD1-ADFE-B31F-3285331BECC1";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 170 ".ktv[0:169]"  1 0.038599354569765099 2 0.038599354569765099
		 3 0.038599354569765099 4 0.038599354569765099 5 0.038599354569765099 6 0.038599354569765099
		 7 0.038599354569765099 8 0.085849540300813029 9 0.15079607100527903 10 0.23274661363365362
		 11 0.33096618536238898 12 0.44477952171836599 13 0.57331513460078976 14 0.71581153625737459
		 15 0.87126346116947506 16 1.0388444223008901 17 1.2172565964520008 18 1.4055225191274394
		 19 1.601854627178247 20 1.8051341255878008 21 2.0123772454637199 22 2.222431028011278
		 23 2.4286842479208866 24 2.6320798096826548 25 2.8088023651027658 26 2.9467039077713273
		 27 3.0117253168266664 28 2.8971618134046593 29 2.6525329313773098 30 2.3360286228774774
		 31 1.9712022879839219 32 1.6033146216845631 33 1.2254336913847688 34 0.84549102960298961
		 35 0.46415693598789853 36 0.084241675313364794 37 -0.29274311527773311 38 -0.66485247350462795
		 39 -1.0305761100071338 40 -1.3879794730992332 41 -1.736390387477653 42 -2.0748101563264947
		 43 -2.4022837924975953 44 -2.7178948543472372 45 -3.0205290085462062 46 -3.3089507296184042
		 47 -3.5826071523607625 48 -3.8406521955882127 49 -4.0827299817706404 50 -4.3096910803913788
		 51 -4.5170700692250323 52 -4.7066893521320736 53 -4.8605360203382286 54 -4.9653421753219025
		 55 -5.0086951901855166 56 -4.9424180957165689 57 -4.7949021008485229 58 -4.5957511649533194
		 59 -4.3587839869927265 60 -4.1080707161975667 61 -3.8424609611325926 62 -3.5688628705124312
		 63 -3.2871709731183127 64 -2.9992718617649934 65 -2.7060974930665207 66 -2.408670684444703
		 67 -2.1086054462909898 68 -1.8081165521899245 69 -1.5064245299840602 70 -1.2044307815204713
		 71 -0.89930745837014314 72 -0.58985326645642866 73 -0.27208994456926472 74 0.055866581611936694
		 75 0.40150016683222001 76 0.76960774232277396 77 1.1701341529457543 78 1.6336033720749361
		 79 2.1030749454066795 80 2.5360194662409588 81 2.9197277651406548 82 3.2176559838275134
		 83 3.4587787821249174 84 3.6612376623570535 85 3.8209882387432872 86 3.9546551595290103
		 87 4.0183728249603092 88 4.0155414147164841 89 3.9957215430097071 90 3.9001439981780592
		 91 3.6092966978175438 92 3.0327335532502691 93 2.2976558070751687 94 1.4966173765703807
		 95 0.64311414902041419 96 -0.21159590247105753 97 -1.0882451180834787 98 -1.9950265994368435
		 99 -2.9183000891057649 100 -3.8553950171626648 101 -4.7815954227340587 102 -5.7205304317972256
		 103 -6.5244942138724422 104 -7.0741584920388547 105 -7.3080197315973514 106 -7.1520086532875329
		 107 -6.7782903018104763 108 -6.2368367444739432 109 -5.5663615462595057 110 -4.8136092989259982
		 111 -4.0044589894493008 112 -3.1759252200957961 113 -2.3413457367528694 114 -1.5267907305184556
		 115 -0.73107746802730411 116 0.038384292380929219 117 0.78130183472310488 118 1.4953388274846275
		 119 2.1792163589201885 120 2.8308815790500539 121 3.4503199710627461 122 4.0339356134675457
		 123 4.5904198703226475 124 5.1278932482131054 125 5.6444723980675677 126 6.1415480067379029
		 127 6.6174184730394137 128 7.0711210054740086 129 7.5018298618338619 130 7.9083927666285554
		 131 8.2908265282077807 132 8.6485207711946259 133 8.9822047712784023 134 9.2919798587306861
		 135 9.5791194944278271 136 9.8444807426608918 137 10.089414123457324 138 10.315172537749937
		 139 10.522905907113644 140 10.713896612209906 141 10.889000176711916 142 11.049301744657042
		 143 11.195394835614229 144 11.328115765540366 145 11.447821289308958 146 11.555058497127721
		 147 11.650092698950953 148 11.733313619230607 149 11.80489510468143 150 11.86510879982899
		 151 11.914051035692763 152 11.951856257558116 153 11.978681767152942 154 11.994712693845699
		 155 12.000000000000046 156 12.000000000000046 157 12.000000000000046 158 12.000000000000046
		 159 12.000000000000046 160 12.000000000000046 161 12.000000000000046 162 12.000000000000046
		 163 12.000000000000046 164 12.000000000000046 165 12.000000000000046 166 12.000000000000046
		 167 12.000000000000046 168 12.000000000000046 169 12.000000000000046 170 12.000000000000046;
createNode animCurveTL -n "DefaultProject_root_placeHolders_ctrl_translateY";
	rename -uid "F170C44B-493C-D9DB-9AC4-04AB0A1F39A9";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 170 ".ktv[0:169]"  1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 9 0 10 0
		 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0
		 28 0 29 0 30 0 31 0 32 0 33 0 34 0 35 0 36 0 37 0 38 0 39 0 40 0 41 0 42 0 43 0 44 0
		 45 0 46 0 47 0 48 0 49 0 50 0 51 0 52 0 53 0 54 0 55 0 56 0 57 0 58 0 59 0 60 0 61 0
		 62 0 63 0 64 0 65 0 66 0 67 0 68 0 69 0 70 0 71 0 72 0 73 0 74 0 75 0 76 0 77 0 78 0
		 79 0 80 0 81 0 82 0 83 0 84 0 85 0 86 0 87 0 88 0 89 0 90 0 91 0 92 0 93 0 94 0 95 0
		 96 0 97 0 98 0 99 0 100 0 101 0 102 0 103 0 104 0 105 0 106 0 107 0 108 0 109 0 110 0
		 111 0 112 0 113 0 114 0 115 0 116 0 117 0 118 0 119 0 120 0 121 0 122 0 123 0 124 0
		 125 0 126 0 127 0 128 0 129 0 130 0 131 0 132 0 133 0 134 0 135 0 136 0 137 0 138 0
		 139 0 140 0 141 0 142 0 143 0 144 0 145 0 146 0 147 0 148 0 149 0 150 0 151 0 152 0
		 153 0 154 0 155 0 156 0 157 0 158 0 159 0 160 0 161 0 162 0 163 0 164 0 165 0 166 0
		 167 0 168 0 169 0 170 0;
createNode animCurveTL -n "DefaultProject_root_placeHolders_ctrl_translateZ";
	rename -uid "67CFE9FE-4021-9436-DE1A-DC8549C36076";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 170 ".ktv[0:169]"  1 11.962416698117973 2 11.962416698117973
		 3 11.962416698117973 4 11.962416698117973 5 11.962416698117973 6 11.962416698117973
		 7 11.962416698117973 8 11.916414744005857 9 11.853141000132648 10 11.773278049343237
		 11 11.677383380161245 12 11.56607744857836 13 11.439853935035293 14 11.299309084743525
		 15 11.144755659382437 16 10.976672504796609 17 10.795157613701923 18 10.600576372133364
		 19 10.392605445978214 20 10.171402370079839 21 9.9358899236049822 22 9.6859798740695737
		 23 9.4188627912694045 24 9.1334157185645548 25 8.8244910027780783 26 8.4755118110597962
		 27 8.1196427257895021 28 7.7752576437537666 29 7.4701517888820792 30 7.2522362672451299
		 31 7.0795373292058859 32 6.9274292998899742 33 6.7917790610800921 34 6.6606964120791892
		 35 6.5328269254521292 36 6.4033244680411903 37 6.2707739563170879 38 6.132284659942699
		 39 5.9874373861838164 40 5.8343413240966324 41 5.6745205979728235 42 5.5085888625573869
		 43 5.3373867155465549 44 5.1618039498047148 45 4.9823066345723888 46 4.7997783264038398
		 47 4.6138563562222279 48 4.4251666103032994 49 4.2316269791435639 50 4.0324313805830432
		 51 3.8243776188669365 52 3.6051206190603859 53 3.3712829365435826 54 3.1114022542253714
		 55 2.8473881145849429 56 2.5911328109326344 57 2.361225773683874 58 2.1851867296119609
		 59 2.0481170829536186 60 1.9456308502229251 61 1.8737099213610968 62 1.8242297026356931
		 63 1.8051236615817703 64 1.8093161057759481 65 1.8334136565199028 66 1.8853994176933251
		 67 1.9643645139799861 68 2.0733121230911897 69 2.208489189824022 70 2.3683855492670265
		 71 2.5492757082571367 72 2.7482048581336342 73 2.9613507804780363 74 3.1873814352864649
		 75 3.4158714786543629 76 3.6519849148767634 77 3.8476216593510246 78 3.948128825502133
		 79 3.9783288235422556 80 3.7680823305445448 81 3.3546879934729241 82 2.8902588357979671
		 83 2.3531460709509622 84 1.7738243070308553 85 1.1480363835052085 86 0.47985474952112772
		 87 -0.22523481586102251 88 -0.96457527772565466 89 -1.725607954491351 90 -2.5431086985824058
		 91 -3.272416873066148 92 -3.8161857577236895 93 -4.0672494548379134 94 -3.8478391574879427
		 95 -3.492689919522546 96 -3.2150642897875574 97 -2.9813379299144818 98 -2.8237354063277031
		 99 -2.7579725534944379 100 -2.7701976384934475 101 -2.8557732334865111 102 -3.0764078187326684
		 103 -3.5072306735002639 104 -4.2470718892173016 105 -5.1240834696105244 106 -6.0162813458836286
		 107 -6.8729038270338281 108 -7.5987387975207072 109 -8.2051534621606255 110 -8.6663910389183574
		 111 -8.9986113728083374 112 -9.2028530997434412 113 -9.2987230649931316 114 -9.3317682434398836
		 115 -9.3364889832179916 116 -9.3106940434942853 117 -9.2618263094850803 118 -9.2084581871455491
		 119 -9.1519066289339985 120 -9.0988783435733218 121 -9.0517764682249329 122 -9.0124806662246417
		 123 -8.9892680677721533 124 -8.9843136817418205 125 -8.9836059123089154 126 -9.0064453586606703
		 127 -9.0591788835730718 128 -9.1308140779865994 129 -9.2227585407941088 130 -9.3337604286483771
		 131 -9.46080565921012 132 -9.6015339332454115 133 -9.7527320580909276 134 -9.911320137861086
		 135 -10.074537982988774 136 -10.239273173865056 137 -10.403502504729815 138 -10.564604088850752
		 139 -10.721261549535441 140 -10.871543189815874 141 -11.014673083786544 142 -11.149363133836321
		 143 -11.275218158114066 144 -11.391473924758083 145 -11.497949486188892 146 -11.594206868430309
		 147 -11.680252918810773 148 -11.755922592261477 149 -11.821293591997971 150 -11.876362816344546
		 151 -11.921207634906162 152 -11.955853292405051 153 -11.980453061813707 154 -11.995151053725245
		 155 -12.000000000000046 156 -12.000000000000046 157 -12.000000000000046 158 -12.000000000000046
		 159 -12.000000000000046 160 -12.000000000000046 161 -12.000000000000046 162 -12.000000000000046
		 163 -12.000000000000046 164 -12.000000000000046 165 -12.000000000000046 166 -12.000000000000046
		 167 -12.000000000000046 168 -12.000000000000046 169 -12.000000000000046 170 -12.000000000000046;
createNode mayaUsdLayerManager -n "mayaUsdLayerManager1";
	rename -uid "1B4A8BFD-4338-0B12-1C37-34AB784DB1AC";
	setAttr ".sst" -type "string" "";
select -ne :time1;
	setAttr ".o" 170;
	setAttr ".unw" 170;
select -ne :hardwareRenderingGlobals;
	setAttr ".otfna" -type "stringArray" 22 "NURBS Curves" "NURBS Surfaces" "Polygons" "Subdiv Surface" "Particles" "Particle Instance" "Fluids" "Strokes" "Image Planes" "UI" "Lights" "Cameras" "Locators" "Joints" "IK Handles" "Deformers" "Motion Trails" "Components" "Hair Systems" "Follicles" "Misc. UI" "Ornaments"  ;
	setAttr ".otfva" -type "Int32Array" 22 0 1 1 1 1 1
		 1 1 1 0 0 0 0 0 0 0 0 0
		 0 0 0 0 ;
	setAttr ".msaa" yes;
	setAttr ".fprt" yes;
	setAttr ".rtfm" 1;
select -ne :renderPartition;
	setAttr -s 3 ".st";
select -ne :renderGlobalsList1;
select -ne :defaultShaderList1;
	setAttr -s 6 ".s";
select -ne :postProcessList1;
	setAttr -s 2 ".p";
select -ne :defaultRenderingList1;
	setAttr -s 2 ".r";
select -ne :standardSurface1;
	setAttr ".bc" -type "float3" 0.40000001 0.40000001 0.40000001 ;
	setAttr ".sr" 0.5;
select -ne :initialShadingGroup;
	setAttr -s 2 ".dsm";
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
connectAttr "polyPlane1.out" "planeShape.i";
connectAttr "target_pt_translateX.o" "target_lctr.tx";
connectAttr "target_pt_translateY.o" "target_lctr.ty";
connectAttr "target_pt_translateZ.o" "target_lctr.tz";
connectAttr "motionPath1.msg" "target_lctr.sml";
connectAttr "target_pt_rotateX.o" "target_lctr.rx";
connectAttr "target_pt_rotateY.o" "target_lctr.ry";
connectAttr "target_pt_rotateZ.o" "target_lctr.rz";
connectAttr "motionPath1.ro" "target_lctr.ro";
connectAttr "target_pt_visibility.o" "target_lctr.v";
connectAttr "target_pt_scaleX.o" "target_lctr.sx";
connectAttr "target_pt_scaleY.o" "target_lctr.sy";
connectAttr "target_pt_scaleZ.o" "target_lctr.sz";
connectAttr "DefaultProject_root_placeHolders_ctrl_translateX.o" "DefaultProject_root_placeHolders_ctrl.tx"
		;
connectAttr "DefaultProject_root_placeHolders_ctrl_translateY.o" "DefaultProject_root_placeHolders_ctrl.ty"
		;
connectAttr "DefaultProject_root_placeHolders_ctrl_translateZ.o" "DefaultProject_root_placeHolders_ctrl.tz"
		;
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
connectAttr "target_lctr.msg" "MayaNodeEditorSavedTabsInfo.tgi[0].ni[5].dn";
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
connectAttr "planeShape.iog" ":initialShadingGroup.dsm" -na;
connectAttr "L_wing_msShape.iog" ":initialShadingGroup.dsm" -na;
// End of majia_sceneEx_generatePath.ma
