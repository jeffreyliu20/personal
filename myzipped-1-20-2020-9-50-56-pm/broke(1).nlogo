globals [was-mouse-down? score map? unlocked gametime hi1 hi2 hi3 hi4 hi5 survive]
patches-own [wall? spawn]
turtles-own [ricochets player? bullet-limit pair bullet-count]
bullets-own [ogheading]
breed [guns gun]
breed [bullets bullet]
breed [ais ai]
breed [spotters spotter]
breed [aibullets aibullet]
breed [rockets rocket]
to start
  ca
  reset-ticks
  set unlocked 1
  menu
end
to Setup
  cp
  ct
  cd
  reset-ticks
  set survive false
  create-guns 1 [ set color gray set heading 0
    set shape "tiger" set size 3.5
  set player? 1]
  create-guns 1 [
    set player? 1 set color gray set heading 0
    set shape "tigerturret"
    set size 3.5
  ]
  set was-mouse-down? false
map1
end

to firep
  if bullet-count < 3
  [ask patch-at-heading-and-distance ([heading] of gun 1) 1 [sprout-bullets 1 [
    set shape "bullet-demo"
    set heading [heading] of gun 1
    set color red
    set size 1
    set ricochets 0
    set ogheading heading
    ask gun 1 [set bullet-count bullet-count + 1]
  ]]]
  display
end
to fire
  if bullet-count < bullet-limit and color != blue
  [hatch-aibullets 1 [
    set shape "bullet-demo"
    set heading [heading] of myself
    set color red
    set size 1
    set ricochets 0
    fd 1
  ]set bullet-count bullet-count + 1]
  if bullet-count < bullet-limit and color = blue
  [hatch-rockets 1 [
    set shape "rocket"
    set heading [heading] of myself
    set color red
    set size 1
    set ricochets 0
    fd 2
  ]set bullet-count bullet-count + 1]
  display
end

To Go
  carefully [if count bullets > 0 [
     ask bullets [fd 1]
     wait .0001
  ]
    if count rockets > 0 [
     ask rockets [fd 2]
     wait .0001
  ]
    if count aibullets > 0 [
     ask aibullets [fd 1]
      wait .0001]
  tick
    if any? guns with [player? = 1] [
    ask gun 1 [
      if (round mouse-xcor) != 0 or (round mouse-ycor) != 0
      [  set heading towardsxy mouse-xcor mouse-ycor ]
    ]
    if mouse-down? and not was-mouse-down? [ask gun 1 [firep] ]
    set was-mouse-down? mouse-down?
  ]
  ask gun 1 [move-to gun 0]
  boom
  bounce
  spot
    kill
    if any? bullets [ask gun 1 [set bullet-count count bullets]]
    ask spotters [fd 1]
    if map? != 1 and any? ais [ask ais with [color != blue and color != brown and color != violet] [ask patch-ahead 1.2 [if wall? = 0 [ask myself [fd 0.1]]]]]
    if any? ais with [color = brown] [ask ais with [color = brown] [fd 0.2]]
      if any? ais with [color = violet] [ask ais with [color = violet] [fd 0.15]]
    if any? ais with [color = orange] [ask ais with [color = orange] [ask patch-ahead 1.2 [if wall? = 0 [ask myself [fd 0.1]]]]]
    if any? ais with [color = brown] [ask ais with [color = brown] [set bullet-limit 3]]
    if any? ais with [color = blue] [ask ais with [color = blue] [set bullet-limit 1]]
    if any? ais with [color = yellow] [ask ais with [color = yellow] [set bullet-limit 1]]
    if any? ais with [color = green] [ask ais with [color = green] [set bullet-limit 2]]
    if any? ais with [color = violet] [ask ais with [color = violet] [set bullet-limit 2]]
    if any? ais with [color = black] [ask ais with [color = black] [set bullet-limit 2]]
    if any? ais with [color = orange] [ask ais with [color = orange] [set bullet-limit 3]]
  if survive = false [if not any? turtles with [player? = 2] and map? = 1 [cp map2 set unlocked 2]
  if not any? turtles with [player? = 2] and map? = 2 [cp map3 set unlocked 3]
  if not any? turtles with [player? = 2] and map? = 3 [cp map4 set unlocked 4]
  if not any? turtles with [player? = 2] and map? = 4 [cp map5 set unlocked 5]
  if not any? turtles with [player? = 2] and map? = 5 [cp map6 set unlocked 6]
  if not any? turtles with [player? = 2] and map? = 6 [cp map7 set unlocked 7]
  if not any? turtles with [player? = 2] and map? = 7 [cp map8 set unlocked 8]
    if not any? turtles with [player? = 2] and map? = 8 [cp map9 set unlocked 9]
    if not any? turtles with [player? = 2] and map? = 9 [cp map10 set unlocked 10]
      if not any? turtles with [player? = 2] and map? = 10 [cp victory set unlocked 11]
  if not any? turtles with [player? = 1] and ((map? = 1) or (map? = 2) or (map? = 3) or (map? = 4) or (map? = 5) or (map? = 6) or (map? = 7) or (map? = 8) or (map? = 9) or (map? = 10))
        [gameover]]]
  [if map? = 11 and mouse-down? and mouse-xcor >= -5 and mouse-xcor <= 6 and mouse-ycor <= -10 and mouse-ycor >= -13
  [menu]
  if map? = 0 and mouse-down? and mouse-xcor >= -14 and mouse-xcor <= -10 and mouse-ycor <= 5 and mouse-ycor >= 2
  [setup]
  if map? = 0 and mouse-down? and mouse-xcor >= -8 and mouse-xcor <= -5 and mouse-ycor <= 5 and mouse-ycor >= 2 and unlocked >= 2
  [cp ct cd map2]
  if map? = 0 and mouse-down? and mouse-xcor >= -2 and mouse-xcor <= 2 and mouse-ycor <= 5 and mouse-ycor >= 2 and unlocked >= 3
  [cp ct cd map3]
  if map? = 0 and mouse-down? and mouse-xcor >= 4 and mouse-xcor <= 8 and mouse-ycor <= 5 and mouse-ycor >= 2 and unlocked >= 4
  [cp ct cd map4]
  if map? = 0 and mouse-down? and mouse-xcor >= 10 and mouse-xcor <= 14 and mouse-ycor <= 5 and mouse-ycor >= 2 and unlocked >= 5
  [cp ct cd map5]
  if map? = 0 and mouse-down? and mouse-xcor >= -14 and mouse-xcor <= -10 and mouse-ycor <= 1 and mouse-ycor >= -2 and unlocked >= 6
  [cp ct cd map6]
  if map? = 0 and mouse-down? and mouse-xcor >= -8 and mouse-xcor <= -5 and mouse-ycor <= 1 and mouse-ycor >= -2 and unlocked >= 7
  [cp ct cd map7]
  if map? = 0 and mouse-down? and mouse-xcor >= -2 and mouse-xcor <= 2 and mouse-ycor <= 1 and mouse-ycor >= -2 and unlocked >= 8
  [cp ct cd map8]
  if map? = 0 and mouse-down? and mouse-xcor >= 4 and mouse-xcor <= 8 and mouse-ycor <= 1 and mouse-ycor >= -2 and unlocked >= 9
  [cp ct cd map9]
  if map? = 0 and mouse-down? and mouse-xcor >= 10 and mouse-xcor <= 14 and mouse-ycor <= 1 and mouse-ycor >= -2 and unlocked >= 10
    [cp ct cd map10]
    if map? = 0 and mouse-down? and mouse-xcor > -6 and mouse-xcor < 6 and mouse-ycor < -4 and mouse-ycor > -8 and unlocked >= 11
    [cp ct cd surviv]
  ]
    if survive = true
  [set gametime gametime + 1
    every 10 [if gametime > 0 and gametime < 30 [ask patches with [spawn = 1] [sprout-ais 1 [ set color one-of [yellow green orange] set heading 0
    set shape "tank1" set size 3.5
      set player? 2]]
      ]
  ]]
end
to leftie
  if any? guns[
    ask gun 0 [lt 5]]
end
to rightie
  if any? guns[
    ask gun 0 [rt 5]]
end
to charge
  if any? guns[
    ask gun 0 [ask patch-ahead 1.2 [if wall? = 0 [ask gun 0 [fd 0.2]]]]]
end
to flee
  if any? guns[
    ask gun 0 [ask patch-ahead -1.15 [if wall? = 0 [ask gun 0 [bk 0.15]]]]]
end
to boom
  if count bullets > 0 and survive
  [ask bullets [if any? other turtles in-radius 1 with [breed = ais]
    [ask other turtles in-radius 1 [if breed = ais [set score score + 1] ask myself [die]
      die]]]]
  if count bullets > 0 and survive = false
  [ask bullets [if any? other turtles in-radius 1 with [breed = ais]
    [ask other turtles in-radius 1 [die]
      die]]]
end
to kill
  if count aibullets > 0
  [ask aibullets [if any? other turtles in-radius 1 with [breed = guns or breed = bullets]
    [ask other turtles in-radius 1 [die]
      ask turtles with [pair = [pair] of myself] [set bullet-count bullet-count - 1]
      die]
  ]]
  if count rockets > 0
  [ask rockets [if any? other turtles in-radius 1 with [breed = guns or breed = bullets]
    [ask other turtles in-radius 1 [die]
      ask turtles with [pair = [pair] of myself] [set bullet-count bullet-count - 1]
      die]
  ]]
end
to bounce
  ask bullets [if pcolor = brown [ifelse (ogheading >= 150 and ogheading <= 340)
    [set heading 360 - heading
    set ricochets ricochets + 1]
    [set heading 180 - heading
      set ricochets ricochets + 1]
    ask bullets [if ricochets > 3 [die]]]]
  ask aibullets [if pcolor = brown
    [set heading 360 - heading
      set ricochets ricochets + 1]]
  ask aibullets [if ricochets > 3 [ask turtles with [pair = [pair] of myself] [set bullet-count bullet-count - 1] die]]
  ask rockets [if pcolor = brown
    [set heading 360 - heading
      set ricochets ricochets + 1]]
  ask rockets [if ricochets > 3 [ask turtles with [pair = [pair] of myself] [set bullet-count bullet-count - 1] die]]
end
to map1
  import-pcolors "map1.png"
  ask patches [ifelse (pcolor = 35.4)
    [set wall? 1]
    [set wall? 0]]
  ask patches with [abs pxcor = max-pxcor] [set wall? 1]
  ask patches with [abs pycor = max-pycor] [set wall? 1]
  ask patches [set pcolor black]
  ask patches with [wall? = 1] [set pcolor brown]
  ask patch 6 -14 [set spawn 1]
  ask patch -12 -8 [set spawn 1]
  ask patch 2 14 [set spawn 1]
  ask patch 7 14 [set spawn 1]
  ask patches with [spawn = 1] [sprout-ais 1 [set color gray
    set shape "tank1"
    set size 3.5 set player? 2
  ]]
  set map? 1
  ask ais [set color white set bullet-limit 1]
  ask gun 1 [set bullet-limit 3]
end
to map2
  reset-ticks
  import-pcolors "map2.png"
  ask patches [ifelse (pcolor = 34.7)
    [set wall? 1]
    [set wall? 0]]
  ask patches with [abs pxcor = max-pxcor] [set wall? 1]
  ask patches with [abs pycor = max-pycor] [set wall? 1]
  ask patches [set pcolor black]
  ask patches with [wall? = 1] [set pcolor brown]
  if not any? guns [create-guns 2 [set color grey
  ask gun 0 [set xcor 14 set ycor -14 set heading 0 set shape "tiger" set size 3.5 set player? 1 set color gray]
    ask gun 1 [set xcor 14 set ycor -14 set player? 1 set color gray set heading 0
    set shape "tigerturret"
    set size 3.5]]]
  if any? guns [ask guns [set xcor 14 set ycor -14]]
  ask patch -3 13 [set spawn 1]
  ask patch -14 14 [set spawn 1]
  ask patch 14 13 [set spawn 1]
  ask patch -15 -1 [set spawn 1]
  ask patches with [spawn = 1] [sprout-ais 1 [ set color gray set heading 0
    set shape "tank1" set size 3.5
    set player? 2]]
  set map? 2
  ask ais [set color yellow set bullet-limit 1]
  ask gun 1 [set bullet-limit 3]
end
to map3
  reset-ticks
  import-pcolors "map3.png"
  ask patches [ifelse (pcolor = 34.7)
    [set wall? 1]
    [set wall? 0]]
  ask patches with [abs pxcor = max-pxcor] [set wall? 1]
  ask patches with [abs pycor = max-pycor] [set wall? 1]
  ask patches [set pcolor black]
  ask patches with [wall? = 1] [set pcolor brown]
  if not any? guns [create-guns 2 [set color grey
  ask gun 0 [set xcor -14 set ycor -14 set heading 0 set shape "tiger" set size 3.5 set player? 1 set color gray]
    ask gun 1 [set xcor -14 set ycor -14 set player? 1 set color gray set heading 0
    set shape "tigerturret"
    set size 3.5]]]
  if any? guns [ask guns [set xcor -14 set ycor -14]]
  ask patch 15 14 [set spawn 1]
  ask patch 12 2 [set spawn 2]
  ask patch -5 5 [set spawn 2]
  ask patch 13 -14 [set spawn 2]
  ask patch -14 6 [set spawn 1]
  set map? 3
  ask gun 1 [set bullet-limit 3]
  ask patches with [spawn = 2] [sprout-ais 1 [ set color green set heading 0
    set shape "tank1" set size 3.5 set bullet-limit 2
    set player? 2]]
  ask patches with [spawn = 1] [sprout-ais 1 [ set color violet set heading 0
    set shape "tank1" set size 3.5 set bullet-limit 2
    set player? 2]]
end
to map4
  reset-ticks
  import-pcolors "map4.png"
  ask patches [ifelse (pcolor = 34.7)
    [set wall? 1]
    [set wall? 0]]
  ask patches [set pcolor black]
  ask patches with [abs pxcor = max-pxcor] [set wall? 1]
  ask patches with [abs pycor = max-pycor] [set wall? 1]
  ask patches with [wall? = 1] [set pcolor brown]
  if not any? guns [create-guns 2 [set color grey
  ask gun 0 [set xcor 1 set ycor 3 set heading 0 set shape "tiger" set size 3.5 set player? 1 set color gray]
    ask gun 1 [set xcor 1 set ycor 3 set player? 1 set color gray set heading 0
    set shape "tigerturret"
    set size 3.5]]]
  if any? guns [ask guns [set xcor 1 set ycor 3]]
  set map? 4
  ask gun 1 [set bullet-limit 3]
  ask patch 1 -12 [set spawn 1]
  ask patch -3 -12 [set spawn 3]
  ask patch 1 12 [set spawn 3]
  ask patch -3 12 [set spawn 1]
  ask patch -15 2 [set spawn 2]
  ask patch 15 2 [set spawn 2]
  ask patches with [spawn = 2] [sprout-ais 1 [ set color violet set heading 0
    set shape "tank1" set size 3.5 set bullet-limit 2
    set player? 2]]
  ask patches with [spawn = 1] [sprout-ais 1 [ set color green set heading 0
    set shape "tank1" set size 3.5 set bullet-limit 2
    set player? 2]]
  ask patches with [spawn = 3] [sprout-ais 1 [ set color orange set heading 0
    set shape "tank1" set size 3.5 set bullet-limit 2
    set player? 2]]
end
to map5
  reset-ticks
  import-pcolors "map5.png"
  ask patches [ifelse (pcolor = 34.7)
    [set wall? 1]
    [set wall? 0]]
  ask patches [set pcolor black]
  ask patches with [abs pxcor = max-pxcor] [set wall? 1]
  ask patches with [abs pycor = max-pycor] [set wall? 1]
  ask patches with [wall? = 1] [set pcolor brown]
  if not any? guns [create-guns 2 [set color grey
  ask gun 0 [set xcor -9 set ycor 14 set heading 180 set shape "tiger" set size 3.5 set player? 1 set color gray]
    ask gun 1 [set xcor -9 set ycor 14 set player? 1 set color gray set heading 180
    set shape "tigerturret"
    set size 3.5]]]
  if any? guns [ask guns [set xcor -9 set ycor 14 set heading 180]]
  set map? 5
  ask gun 1 [set bullet-limit 3]
  ask patch 1 -12 [set spawn 3]
  ask patch -3 2 [set spawn 2]
  ask patch -14 -11 [set spawn 3]
  ask patch 9 7 [set spawn 1]
  ask patch 11 -10 [set spawn 1]
  ask patch 9 15 [set spawn 2]
  ask patches with [spawn = 3] [sprout-ais 1 [ set color blue set heading 0
    set shape "tank1" set size 3.5 set bullet-limit 2
    set player? 2]]
  ask patches with [spawn = 2] [sprout-ais 1 [ set color orange set heading 0
    set shape "tank1" set size 3.5 set bullet-limit 2
    set player? 2]]
  ask patches with [spawn = 1] [sprout-ais 1 [ set color violet set heading 0
    set shape "tank1" set size 3.5 set bullet-limit 2
    set player? 2]]
end
to map6
  reset-ticks
  import-pcolors "map6.png"
  ask patches [ifelse (pcolor = 34.7)
    [set wall? 1]
    [set wall? 0]]
  ask patches [set pcolor black]
  ask patches with [abs pxcor = max-pxcor] [set wall? 1]
  ask patches with [abs pycor = max-pycor] [set wall? 1]
  ask patches with [wall? = 1] [set pcolor brown]
  if not any? guns [create-guns 2 [set color grey
  ask gun 0 [set xcor -7 set ycor 1 set heading 90 set shape "tiger" set size 3.5 set player? 1 set color gray]
    ask gun 1 [set xcor -7 set ycor 1 set player? 1 set color gray set heading 90
    set shape "tigerturret"
    set size 3.5]]]
  if any? guns [ask guns [set xcor -7 set ycor 1 set heading 90]]
  set map? 6
  ask gun 1 [set bullet-limit 3]
  ask patch 4 1 [set spawn 1]
  ask patches with [abs pxcor = 15 and abs pycor = 15] [set spawn 2]
  ask patches with [spawn = 2] [sprout-ais 1 [ set color blue set heading 0
    set shape "tank1" set size 3.5 set bullet-limit 2
    set player? 2]]
  ask patches with [spawn = 1] [sprout-ais 1 [ set color orange set heading 0
    set shape "tank1" set size 3.5 set bullet-limit 2
    set player? 2]]
end
to map7
  reset-ticks
  import-pcolors "map7.png"
  ask patches [ifelse (pcolor = 34.7)
    [set wall? 1]
    [set wall? 0]]
  ask patches [set pcolor black]
  ask patches with [abs pxcor = max-pxcor] [set wall? 1]
  ask patches with [abs pycor = max-pycor] [set wall? 1]
  ask patches with [wall? = 1] [set pcolor brown]
  if not any? guns [create-guns 2 [set color grey
  ask gun 0 [set xcor -14 set ycor -14 set heading 0 set shape "tiger" set size 3.5 set player? 1 set color gray]
    ask gun 1 [set xcor -14 set ycor -14 set player? 1 set color gray set heading 0
    set shape "tigerturret"
    set size 3.5]]]
  if any? guns [ask guns [set xcor -14 set ycor -14]]
  set map? 7
  ask gun 1 [set bullet-limit 3]
  ask patch -14 6 [set spawn 1]
  ask patch 8 8 [set spawn 2]
  ask patch 12 -7 [set spawn 2]
  ask patch 13 15 [set spawn 3]
  ask patch 13 -14 [set spawn 3]
  ask patch 3 7 [set spawn 1]
  ask patch -4 14 [set spawn 2]
  ask patches with [spawn = 1] [sprout-ais 1 [ set color brown set heading 0
    set shape "tank1" set size 3.5
    set player? 2]]
  ask patches with [spawn = 2] [sprout-ais 1 [ set color orange set heading 0
    set shape "tank1" set size 3.5
    set player? 2]]
  ask patches with [spawn = 3] [sprout-ais 1 [ set color blue set heading 0
    set shape "tank1" set size 3.5
    set player? 2]]
end
to map8
  reset-ticks
  import-pcolors "map8.png"
  ask patches [ifelse (pcolor = 34.7)
    [set wall? 1]
    [set wall? 0]]
  ask patches [set pcolor black]
  ask patches with [abs pxcor = max-pxcor] [set wall? 1]
  ask patches with [abs pycor = max-pycor] [set wall? 1]
  ask patches with [wall? = 1] [set pcolor brown]
  if not any? guns [create-guns 2 [set color grey
  ask gun 0 [set xcor -14 set ycor -14 set heading 90 set shape "tiger" set size 3.5 set player? 1 set color gray]
    ask gun 1 [set xcor -14 set ycor -14 set player? 1 set color gray set heading 90
    set shape "tigerturret"
    set size 3.5]]]
  if any? guns [ask guns [set xcor -14 set ycor -14 set heading 90]]
  set map? 8
  ask gun 1 [set bullet-limit 3]
  ask patch -14 -9 [set spawn 1]
  ask patch 13 -4 [set spawn 1]
  ask patch -14 1 [set spawn 1]
  ask patch 13 7 [set spawn 1]
  ask patch -15 14 [set spawn 1]
  ask patch -1 -10 [set spawn 2]
  ask patch -1 -4 [set spawn 2]
  ask patch -1 1 [set spawn 2]
  ask patch -1 7 [set spawn 2]
  ask patch -1 14 [set spawn 2]
  ask patches with [spawn = 1] [sprout-ais 1 [ set color blue set heading 0
    set shape "tank1" set size 3.5
    set player? 2]]
  ask patches with [spawn = 2] [sprout-ais 1 [ set color orange set heading 0
    set shape "tank1" set size 3.5
    set player? 2]]
end
to map9
  reset-ticks
  import-pcolors "map9.png"
  ask patches [ifelse (pcolor = 34.7)
    [set wall? 1]
    [set wall? 0]]
  ask patches [set pcolor black]
  ask patches with [abs pxcor = max-pxcor] [set wall? 1]
  ask patches with [abs pycor = max-pycor] [set wall? 1]
  ask patches with [wall? = 1] [set pcolor brown]
  if not any? guns [create-guns 2 [set color grey
  ask gun 0 [set xcor -13 set ycor 4 set heading 90 set shape "tiger" set size 3.5 set player? 1 set color gray]
    ask gun 1 [set xcor -13 set ycor 4 set player? 1 set color gray set heading 90
    set shape "tigerturret"
    set size 3.5]]]
  if any? guns [ask guns [set xcor -13 set ycor 4 set heading 90]]
  set map? 9
  ask gun 1 [set bullet-limit 3]
  ask patch 0 -9 [set spawn 1]
  ask patch 13 3 [set spawn 1]
  ask patch 4 15 [set spawn 2]
  ask patch 8 -15 [set spawn 2]
  ask patch 12 -13 [set spawn 3]
  ask patch 15 0 [set spawn 4]
  ask patches with [spawn = 1] [sprout-ais 1 [ set color blue set heading 0
    set shape "tank1" set size 3.5
    set player? 2]]
  ask patches with [spawn = 2] [sprout-ais 1 [ set color orange set heading 0
    set shape "tank1" set size 3.5
    set player? 2]]
  ask patches with [spawn = 3] [sprout-ais 1 [ set color black set heading 0
    set shape "tank2" set size 3.5
    set player? 2]]
  ask patches with [spawn = 4] [sprout-ais 1 [ set color brown set heading 0
    set shape "tank1" set size 3.5
    set player? 2]]
end
to map10
  reset-ticks
  import-pcolors "map10.png"
  ask patches [ifelse (pcolor = 34.7)
    [set wall? 1]
    [set wall? 0]]
  ask patches [set pcolor black]
  ask patches with [abs pxcor = max-pxcor] [set wall? 1]
  ask patches with [abs pycor = max-pycor] [set wall? 1]
  ask patches with [wall? = 1] [set pcolor brown]
  if not any? guns [create-guns 2 [set color grey
  ask gun 0 [set xcor -14 set ycor -4 set heading 180 set shape "tiger" set size 3.5 set player? 1 set color gray]
    ask gun 1 [set xcor -14 set ycor -4 set player? 1 set color gray set heading 180
    set shape "tigerturret"
    set size 3.5]]]
  if any? guns [ask guns [set xcor -14 set ycor -4 set heading 180]]
  set map? 10
  ask gun 1 [set bullet-limit 3]
  ask patch 7 -4 [set spawn 1]
  ask patch 7 6 [set spawn 1]
  ask patch -14 3 [set spawn 2]
  ask patch -12 14 [set spawn 2]
  ask patch 14 -14 [set spawn 3]
  ask patch -5 -2 [set spawn 4]
  ask patch 8 2 [set spawn 4]
  ask patches with [spawn = 1] [sprout-ais 1 [ set color blue set heading 0
    set shape "tank1" set size 3.5
    set player? 2]]
  ask patches with [spawn = 2] [sprout-ais 1 [ set color orange set heading 0
    set shape "tank1" set size 3.5
    set player? 2]]
  ask patches with [spawn = 3] [sprout-ais 1 [ set color black set heading 0
    set shape "tank2" set size 3.5
    set player? 2]]
  ask patches with [spawn = 4] [sprout-ais 1 [ set color brown set heading 0
    set shape "tank1" set size 3.5
    set player? 2]]
end
to spot
  ask ais [face gun 0 set pair who + 1
    hatch-spotters 1 [set size 0.1 set hidden? true set pair pair]]
  ask spotters [if pcolor = brown [die]
    if any? other turtles in-radius 1 with [player? = 1] [ask ais with [pair = [pair] of myself] [fire]]]
end
to gameover
  cp
  ct
  cd
  set map? 11
  ask patch 5 6 [set plabel "Game Over!"]
    ask patches with [pxcor >= -5 and pxcor <= 6 and pycor <= -10 and pycor >= -13] [set pcolor 85]
  ask patch 2 -11 [set plabel "MENU"]
end
to victory
  cp
  ct
  cd
  set map? 11
  ask patches [set pcolor 44]
  ask patch 3 6 [set plabel "Victory!"]
    ask patches with [pxcor >= -5 and pxcor <= 6 and pycor <= -10 and pycor >= -13] [set pcolor 85]
  ask patch 2 -11 [set plabel "MENU"]
end
to menu
  cd
  cp
  ct
  set was-mouse-down? false
  set map? 0
  ask patch 3 6 [set plabel "Tanks!"]
  ask patch -12 3 [sprout 1 [set shape "button1" set heading 0 set size 8 stamp die]]
  ifelse unlocked >= 2[ask patch -6 3 [sprout 1 [set shape "button2" set heading 0 set size 8 stamp die]]]
    [ask patch -6 3 [sprout 1 [set shape "locked" set heading 0 set size 8 stamp die]]]
  ifelse unlocked >= 3 [ask patch 0 3 [sprout 1 [set shape "button3" set heading 0 set size 8 stamp die]]]
  [ask patch 0 3 [sprout 1 [set shape "locked" set heading 0 set size 8 stamp die]]]
  ifelse unlocked >= 4 [ask patch 6 3 [sprout 1 [set shape "button4" set heading 0 set size 8 stamp die]]]
  [ask patch 6 3 [sprout 1 [set shape "locked" set heading 0 set size 8 stamp die]]]
  ifelse unlocked >= 5 [ask patch 12 3 [sprout 1 [set shape "button5" set heading 0 set size 8 stamp die]]]
  [ask patch 12 3 [sprout 1 [set shape "locked" set heading 0 set size 8 stamp die]]]
   ifelse unlocked >= 6[ask patch -12 -1 [sprout 1 [set shape "button6" set heading 0 set size 8 stamp die]]]
    [ask patch -12 -1 [sprout 1 [set shape "locked" set heading 0 set size 8 stamp die]]]
   ifelse unlocked >= 7[ask patch -6 -1 [sprout 1 [set shape "button7" set heading 0 set size 8 stamp die]]]
    [ask patch -6 -1 [sprout 1 [set shape "locked" set heading 0 set size 8 stamp die]]]
   ifelse unlocked >= 8 [ask patch 0 -1 [sprout 1 [set shape "button8" set heading 0 set size 8 stamp die]]]
  [ask patch 0 -1 [sprout 1 [set shape "locked" set heading 0 set size 8 stamp die]]]
  ifelse unlocked >= 9 [ask patch 6 -1 [sprout 1 [set shape "button9" set heading 0 set size 8 stamp die]]]
  [ask patch 6 -1 [sprout 1 [set shape "locked" set heading 0 set size 8 stamp die]]]
  ifelse unlocked >= 10 [ask patch 12 -1 [sprout 1 [set shape "button10" set heading 0 set size 8 stamp die]]]
  [ask patch 12 -1 [sprout 1 [set shape "locked" set heading 0 set size 8 stamp die]]]
  if unlocked >= 11 [ask patches with [pxcor > -6 and pxcor < 6 and pycor < -4 and pycor > -8] [set pcolor 46]
    ask patch 3 -6 [set plabel "Survival"]]
end
to surviv
  ct
  cp
  cd
  set survive true
  if random 6 = 0 [map2]
  if random 6 = 1 [map4]
  if random 6 = 2 [map6]
  if random 6 = 3 [map7]
  if random 6 = 4 [map8]
  if random 6 = 5 [map10]
  ask turtles with [breed != guns] [die]
  set survive true
end
@#$#@#$#@
GRAPHICS-WINDOW
342
10
770
439
-1
-1
12.0
1
22
1
1
1
0
0
0
1
-17
17
-17
17
1
1
1
ticks
30.0

BUTTON
30
41
134
74
Setup gun
Setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
159
42
222
75
Go
Go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
130
492
198
525
Turn left
leftie
NIL
1
T
OBSERVER
NIL
A
NIL
NIL
1

BUTTON
196
460
278
493
Forward
charge
NIL
1
T
OBSERVER
NIL
W
NIL
NIL
1

BUTTON
197
491
275
524
Reverse
flee
NIL
1
T
OBSERVER
NIL
S
NIL
NIL
1

BUTTON
274
491
348
524
Turn right
rightie
NIL
1
T
OBSERVER
NIL
D
NIL
NIL
1

BUTTON
126
254
189
287
NIL
map1
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
137
99
200
132
NIL
menu
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
92
181
179
214
NIL
gameover
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
55
121
118
154
NIL
start
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

MONITOR
261
186
323
231
NIL
unlocked
17
1
11

MONITOR
264
263
321
308
NIL
map?
17
1
11

@#$#@#$#@
## How to run it?

Click the start button ONCE and then the Go button, which will run forever. Stopping the go button will stop all functions and clicking the start button again will reset all of your progress.

## What's up with the colors?

You control a single gray tank. The enemies have different colors pertaining to their difficulty level. 
White: Stationary, bullet-limit of 1
Yellow: Moves, bullet-limit of 1
Green : Moves, bullet-limit of 2
Purple: Able to move through walls, bullet-limit of 2
Orange: Moves at 150% speed, bullet-limit of 3
Blue: Stationary, shoots rocket bullets that are twice as fast, bullet-limit of 1
Brown: Moves at 200% speed, able to move through walls, bullet-limit of 3
Black: Invisible, the only way to detect them is to let them fire, bullet-limit of 2

Notes: 1)All tanks listed with the exception of orange and brown move 0.1 per tick
2)Bullet-limit refers to how many bullets that tank can have on the screen at once
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

boom
true
0
Circle -955883 true false 45 45 210

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

bullet-demo
true
0
Rectangle -7500403 true true 120 45 180 225
Rectangle -7500403 true true 105 165 195 165
Rectangle -7500403 true true 105 255 195 165
Rectangle -7500403 true true 105 255 150 255
Rectangle -7500403 true true 105 255 195 255
Polygon -7500403 true true 120 180 105 270 195 270 180 180
Polygon -7500403 true true 120 45 150 15 180 45

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

button1
true
0
Rectangle -11221820 true false 75 90 225 195
Polygon -1 true false 127 120 135 132 147 121 142 115 128 121
Polygon -1 true false 144 118
Rectangle -1 true false 142 113 157 163
Rectangle -1 true false 129 159 168 171

button10
true
0
Rectangle -11221820 true false 75 90 225 195
Polygon -1 true false 100 120 108 132 120 121 115 115 101 121
Polygon -1 true false 144 118
Rectangle -1 true false 116 115 131 165
Rectangle -1 true false 102 162 141 174
Circle -1 true false 157 113 34
Circle -1 true false 157 142 34
Rectangle -1 true false 157 125 191 165
Rectangle -11221820 true false 167 131 180 161

button2
true
0
Rectangle -11221820 true false 75 90 225 195
Polygon -1 true false 127 120 135 132 147 121 142 115 128 121
Polygon -1 true false 144 118
Rectangle -1 true false 129 159 168 171
Polygon -1 true false 142 116 147 113 155 113 160 114 162 121 162 128 161 132 154 138 152 140 148 145 144 148 140 152 137 159 132 162 129 159 133 154 135 149 141 143 149 137 152 133 157 128 157 124 155 122 150 122 146 121

button3
true
0
Rectangle -11221820 true false 80 87 230 192
Polygon -1 true false 134 115 142 127 154 116 149 110 135 116
Polygon -1 true false 144 118
Rectangle -1 true false 139 156 166 166
Polygon -7500403 true true 135 120
Polygon -1 true false 142 115 152 113 156 113 162 113 165 118 165 122 166 127 166 131 164 133 159 136 150 139 152 136 151 134 156 131 157 131 161 128 159 123 154 123 148 123
Polygon -1 true false 149 140 153 136 157 136 164 133 166 141 166 145 167 150 167 154 167 161 160 159 156 159 153 159 152 157 157 154 158 154 162 151 160 146 155 146 149 146

button4
true
0
Rectangle -11221820 true false 75 90 225 195
Polygon -1 true false 144 118
Rectangle -1 true false 154 114 168 170
Rectangle -1 true false 126 130 173 139
Rectangle -1 true false 126 113 140 136

button5
true
0
Rectangle -11221820 true false 74 93 224 198
Polygon -1 true false 144 118
Rectangle -1 true false 129 114 168 126
Rectangle -1 true false 129 117 145 150
Polygon -1 true false 157 144 158 146 161 153 163 161 160 167 158 170 154 172 146 175 139 175 131 175 128 175 127 171 128 167 135 166 139 166 145 166 149 165 153 165 154 159 153 152 150 148 143 148 138 148 139 143 145 142 152 141

button6
true
0
Rectangle -11221820 true false 74 93 224 198
Polygon -1 true false 144 118
Circle -1 true false 122 139 44
Circle -11221820 true false 130 147 28
Polygon -1 true false 162 114 161 124 137 125 131 135 131 145 127 150 127 155 122 160 121 154 121 146 121 137 124 127 127 125 129 122 138 116

button7
true
0
Rectangle -11221820 true false 74 93 224 198
Polygon -1 true false 144 118
Rectangle -1 true false 129 114 168 126
Polygon -1 true false 158 119 140 173 149 176 167 124

button8
true
0
Rectangle -11221820 true false 86 91 236 196
Polygon -1 true false 144 118
Circle -1 true false 140 138 44
Circle -11221820 true false 147 147 28
Circle -1 true false 140 101 44
Circle -11221820 true false 148 109 28

button9
true
0
Rectangle -11221820 true false 74 93 224 198
Polygon -1 true false 144 118
Circle -1 true false 122 109 44
Circle -11221820 true false 130 117 28
Polygon -1 true false 126 178 127 168 151 167 157 157 157 147 161 142 161 137 166 132 167 138 167 146 167 155 164 165 161 167 159 170 150 176

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

gun-demo
true
0
Polygon -7500403 true true 135 120 135 15 165 15 165 120
Polygon -7500403 true true 60 120 105 210 195 210 240 120 60 120

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

link
true
0
Line -7500403 true 150 0 150 300

link direction
true
0
Line -7500403 true 150 150 30 225
Line -7500403 true 150 150 270 225

locked
true
1
Rectangle -11221820 true false 77 90 227 195
Polygon -1 true false 144 118
Rectangle -6459832 true false 122 132 181 176
Rectangle -7500403 true false 126 111 136 133
Rectangle -7500403 true false 165 110 175 132
Polygon -7500403 true false 127 112 128 103 132 101 137 100 143 99 147 99 153 99 163 100 166 103 171 103 174 111 167 112 166 110 163 107 159 106 155 106 150 106 147 106 141 106 138 109 135 111

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

rocket
true
3
Rectangle -7500403 true false 120 45 180 225
Rectangle -7500403 true false 105 165 195 165
Rectangle -7500403 true false 105 255 195 165
Rectangle -7500403 true false 105 255 150 255
Rectangle -7500403 true false 105 255 195 255
Polygon -955883 true false 120 180 105 270 195 270 180 180
Polygon -2674135 true false 120 45 150 15 180 45

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

tank
true
0
Rectangle -6459832 true false 195 45 255 255
Rectangle -16777216 false false 195 45 255 255
Rectangle -6459832 true false 45 45 105 255
Rectangle -16777216 false false 45 45 105 255
Line -16777216 false 45 75 255 75
Line -16777216 false 45 105 255 105
Line -16777216 false 45 60 255 60
Line -16777216 false 45 240 255 240
Line -16777216 false 45 225 255 225
Line -16777216 false 45 195 255 195
Line -16777216 false 45 150 255 150
Polygon -7500403 true true 90 60 60 90 60 240 120 255 180 255 240 240 240 90 210 60
Polygon -16777216 false false 240 90 210 60 211 246 240 240
Polygon -16777216 false false 60 90 90 60 89 246 60 240
Polygon -16777216 false false 89 247 116 254 183 255 211 246 211 237 89 236
Rectangle -16777216 false false 90 60 210 90

tank1
true
0
Rectangle -7500403 true true 144 0 159 105
Rectangle -6459832 true false 195 45 255 255
Rectangle -16777216 false false 195 45 255 255
Rectangle -6459832 true false 45 45 105 255
Rectangle -16777216 false false 45 45 105 255
Line -16777216 false 45 75 255 75
Line -16777216 false 45 105 255 105
Line -16777216 false 45 60 255 60
Line -16777216 false 45 240 255 240
Line -16777216 false 45 225 255 225
Line -16777216 false 45 195 255 195
Line -16777216 false 45 150 255 150
Polygon -7500403 true true 90 60 60 90 60 240 120 255 180 255 240 240 240 90 210 60
Rectangle -16777216 false false 135 105 165 120
Polygon -16777216 false false 135 120 105 135 101 181 120 225 149 234 180 225 199 182 195 135 165 120
Polygon -16777216 false false 240 90 210 60 211 246 240 240
Polygon -16777216 false false 60 90 90 60 89 246 60 240
Polygon -16777216 false false 89 247 116 254 183 255 211 246 211 237 89 236
Rectangle -16777216 false false 90 60 210 90
Rectangle -16777216 false false 143 0 158 105

tank2
true
0
Rectangle -7500403 true true 144 0 159 105
Rectangle -16777216 true false 195 45 255 255
Rectangle -16777216 false false 195 45 255 255
Rectangle -16777216 true false 45 45 105 255
Rectangle -16777216 false false 60 45 120 255
Line -16777216 false 45 75 255 75
Line -16777216 false 45 105 255 105
Line -16777216 false 45 60 255 60
Line -16777216 false 45 240 255 240
Line -16777216 false 45 225 255 225
Line -16777216 false 45 195 255 195
Line -16777216 false 45 150 255 150
Polygon -7500403 true true 90 60 60 90 60 240 120 255 180 255 240 240 240 90 210 60
Rectangle -16777216 false false 135 105 165 120
Polygon -16777216 false false 135 120 105 135 101 181 120 225 149 234 180 225 199 182 195 135 165 120
Polygon -16777216 false false 240 90 210 60 211 246 240 240
Polygon -16777216 false false 60 90 90 60 89 246 60 240
Polygon -16777216 false false 89 247 116 254 183 255 211 246 211 237 89 236
Rectangle -16777216 false false 90 60 210 90
Rectangle -16777216 false false 143 0 158 105

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tiger
true
0
Rectangle -6459832 true false 195 45 255 255
Rectangle -16777216 false false 195 45 255 255
Rectangle -6459832 true false 45 45 105 255
Rectangle -16777216 false false 45 45 105 255
Line -16777216 false 45 75 255 75
Line -16777216 false 45 105 255 105
Line -16777216 false 45 60 255 60
Line -16777216 false 45 240 255 240
Line -16777216 false 45 225 255 225
Line -16777216 false 45 195 255 195
Line -16777216 false 45 150 255 150
Polygon -7500403 true true 90 60 60 90 60 240 120 255 180 255 240 240 240 90 210 60
Polygon -16777216 false false 240 90 210 60 211 246 240 240
Polygon -16777216 false false 60 90 90 60 89 246 60 240
Polygon -16777216 false false 89 247 116 254 183 255 211 246 211 237 89 236
Rectangle -16777216 false false 90 60 210 90
Circle -16777216 false false 165 105 28
Circle -7500403 false true 180 90 30
Circle -16777216 false false 105 105 30
Rectangle -6459832 true false 105 195 135 225
Rectangle -6459832 true false 165 195 195 225

tigerturret
true
0
Rectangle -7500403 true true 144 0 159 105
Line -16777216 false 135 75 165 75
Line -16777216 false 135 60 165 60
Rectangle -16777216 false false 135 105 165 120
Polygon -16777216 false false 135 120 105 135 101 181 120 225 149 234 180 225 199 182 195 135 165 120
Polygon -16777216 false false 89 247 116 254 183 255 211 246 211 237 89 236
Rectangle -16777216 false false 135 45 165 90
Rectangle -16777216 false false 143 0 158 105
Circle -7500403 true true 90 120 120
Polygon -7500403 true true 105 135 105 105 195 105 195 135 195 150 105 150 105 120

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turret
true
0
Rectangle -7500403 true true 144 0 159 105
Line -16777216 false 135 75 165 75
Line -16777216 false 135 60 165 60
Rectangle -16777216 false false 135 105 165 120
Polygon -16777216 false false 135 120 105 135 101 181 120 225 149 234 180 225 199 182 195 135 165 120
Polygon -16777216 false false 89 247 116 254 183 255 211 246 211 237 89 236
Rectangle -16777216 false false 135 45 165 90
Rectangle -16777216 false false 143 0 158 105

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.1.1
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@
