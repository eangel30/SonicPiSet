'CUSTOM MELODY'
car_sound = "C:/Users/emma_angel/Downloads/car_sound.wav"
snap_sound = "C:/Users/emma_angel/Downloads/Snap Sound Effect.wav"
outro = "C:/Users/emma_angel/Downloads/outro.wav"
transition_sound = "C:/Users/emma_angel/Downloads/newTransition.wav"
trans = "C:/Users/emma_angel/Downloads/transitiion_2.wav"


use_bpm 118
use_synth :piano


#defining functions
define :m1 do
  play :Fs4
  sleep 0.5
  play :E4
  sleep 1
  play :Gs4
  sleep 0.5
  play :E4
  sleep 1
  play :E4, sustain: 4
  sleep 2
end
define :m2 do
  play :Fs4
  sleep 0.5
  play :Ds4
  sleep 1
  play :Gs4
  sleep 0.5
  play :Ds4
  sleep 1
  play :Ds4, sustain: 4
  sleep 2
end


#start

sample car_sound

sleep 8

#parameterized function for chords loop
define :parameters do |x, y, z|
  play x, sustain: 5
  play y, sustain: 5
  sleep z
end

live_loop :chords do
  4.times do
    parameters :Cs3, :A3, 2
    parameters :Cs3, :A3, 2
    parameters :Cs3, :A3, 3
    parameters :B3, :B3, 1
    4.times do
      parameters :B3, :Gs3, 2
    end
    parameters :B3, :Gs3, 3
    parameters :B3, :B3, 1
    parameters :Cs3, :A3, 2
    parameters :Cs3, :A3, 2
  end
  stop
end

#snaps with fade in
sleep 8
amp_fadein = 4
live_loop :snaps1 do
  6.times do
    sleep 2
    sample snap_sound, amp: amp_fadein
    amp_fadein += 1
  end
  34.times do
    sleep 2
    sample snap_sound, amp: 10
  end
  stop
end

#sleep 6 till drums

sleep 6

live_loop :drums do
  20.times do
    sample :drum_cymbal_closed, amp: 2
    sample :drum_bass_hard, amp: 3, rate: 4
    sleep 1
    sample :drum_cymbal_closed, amp: 2
    sleep 1
    sample :drum_cymbal_closed, amp: 2
    sample :drum_snare_hard, amp: 3
    sleep 1
    sample :drum_cymbal_closed, amp: 2
    sleep 1
  end
  stop
end

#main_melody

sleep 4
m3 = [:Fs4, :Ds4, :Gs4, :E4, :Fs4, :E4, :Gs4, :Ds4]
index = 0

live_loop :main_melody do
  3.times do
    m1
    m1
    m1
    m2
    8.times do
      play m3[index]
      sleep 0.5
      index = index + 1
    end
    index = 0
  end
  stop
end

#transition

sleep 80
live_loop :transition do
  sample trans, amp: 8, attack: 8, release: 4
  stop
end

sleep 6



use_bpm 148
use_synth :fm

#beat count

beat_count = 0
live_loop :count do
  sleep 1
  beat_count += 1
end

live_loop :snaps2 do
  if beat_count < 75
    sleep 1
    sample snap_sound, amp: 6
    sleep 2
    sample snap_sound, amp: 6
    sleep 2
    sample snap_sound, amp: 6
    sleep 1
    sample snap_sound, amp: 6
    sleep 2
  else
    stop
  end
end

define :para do |x, y, a, b|
  play x, amp: 5
  play y, amp: 5
  sleep 1
  play :r
  sleep 1
  play x, amp: 5
  play y, amp: 5
  sleep 1
  play :r
  sleep 1
  play x, amp: 5
  play y, amp: 5
  sleep 1
  play :r
  sleep 1
  play x, amp: 5
  play y, amp: 5
  sleep 0.5
  play :r
  sleep 0.5
  play x, amp: 5
  play y, amp: 5
  sleep 0.5
  play a, amp: 5
  play b, amp: 5
  sleep 1
end


live_loop :bass do
  if beat_count < 75
    para :B3, :B2, :Cs4, :Cs3
    para :B3, :B2, :Cs3, :Cs2
    para :D3, :D2, :Fs3, :Fs2
    para :G3, :G2, :Fs3, :Fs2
  else
    stop
  end
end


live_loop :drum do
  if beat_count < 100
    sample :drum_cymbal_closed, amp: 2
    sleep 0.5
    sample :drum_snare_hard, amp: 3
    sample :drum_cymbal_closed, amp: 2
    sleep 0.5
    sample :drum_cymbal_closed, amp: 2
    sleep 0.5
    sample :drum_cymbal_closed, amp: 2
    sample :drum_bass_hard, amp: 2
    sleep 0.5
  else
    stop
  end
end

#different synth for melody

use_synth :piano
notes = [:r, :B4, :B4, :B4, :A4, :B4, :Fs4]
s = [1, 1, 0.5, 0.5, 0.5, 1, 0.5]
index = 0
define :function do
  7.times do
    play notes[index]
    sleep s[index]
    index += 1
  end
  index = 0
end

live_loop :melody do
  with_fx :normaliser do
    if beat_count < 100
      function
      play :B4, amp: 6
      sleep 1
      play :Fs4, amp: 6
      sleep 1
      play :E4, amp: 6, finish: 6
      sleep 1
      #secondtime
      function
      play :Fs5, amp: 6
      sleep 1
      play :Fs4, amp: 6
      sleep 2
    else
      stop
    end
  end
end

#outro

sleep 112
sample outro
sleep 1






