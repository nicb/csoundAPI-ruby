<CsoundSynthesizer>
;<CsOptions>
;</CsOptions>
; ==============================================
<CsInstruments>

sr  = 44100
ksmps = 100
nchnls =  1
0dbfs = 1

instr 1 
  iamp = ampdbfs(p4)
  ifreq = p5

aout oscil iamp, ifreq, 1
  out aout

endin

</CsInstruments>
; ==============================================
<CsScore>

f1 0 4096 10 1

i1 0 3 -8 500
i1 3.2 3 -16 600
i1 6.4 3 -24 700

; these are 9.4 secs @44100 = 1620 256-samples frames

</CsScore>
</CsoundSynthesizer>

