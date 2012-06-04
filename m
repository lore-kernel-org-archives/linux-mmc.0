From: Marc Dietrich <marvin24@gmx.de>
Subject: power class selection fails on 3.5-rc1
Date: Mon, 04 Jun 2012 18:35:48 +0200
Message-ID: <6008680.IROCjD91iZ@ax5200p>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart10464560.uUJSFqxE0G"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:57267 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755294Ab2FDQf4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Jun 2012 12:35:56 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org


--nextPart10464560.uUJSFqxE0G
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

somehow I hope this would go away by itself, but it didn't :-( I reported this 
problem some time ago (see: http://www.mail-archive.com/linux-
mmc@vger.kernel.org/msg13688.html ) but got no clear answer or fix.

In addition to the information I posted on the thread above, I also dumped the 
contents of the ext_csd register file (where reg values are not zero):

reg       Sandisk         Toshiba   
241     10      0x0a    50      0x32
239     0       0x00    51      0x33
238     0       0x00    119     0x77
234     0       0x00    30      0x1e
232     1       0x01    4       0x04
231     21      0x15    21      0x15
230     150     0x96    16      0x10
229     150     0x96    66      0x42
228     1       0x01    7       0x07
226     8       0x08    16      0x10
225     6       0x06    7       0x07
224     4       0x04    8       0x08
223     1       0x01    2       0x02
222     8       0x08    16      0x10
221     16      0x10    1       0x01
220     8       0x08    7       0x07
219     7       0x07    7       0x07
217     16      0x10    17      0x11
215     1       0x01    0       0x00
214     218     0xda    238     0xee
213     160     0xa0    128     0x80
210     10      0x0a    0       0x00
209     10      0x0a    60      0x3c
208     10      0x0a    0       0x00
207     10      0x0a    60      0x3c
206     10      0x0a    0       0x00
205     10      0x0a    30      0x1e
203     0       0x00    51      0x33
202     0       0x00    51      0x33
201     0       0x00    119     0x77
200     0       0x00    119     0x77
196     3       0x03    7       0x07
194     2       0x02    2       0x02
192     5       0x05    5       0x05
185     1       0x01    1       0x01
181     0       0x00    1       0x01
179     0       0x00    1       0x01
175     0       0x00    1       0x01
169     1       0x01    0       0x00
168     0       0x00    2       0x02
160     3       0x03    3       0x03
158     0       0x00    3       0x03
157     237     0xed    186     0xba

The second and the third column is from a device with a Sandisk eMCC which 
works fine, while the last two columns are from a Toshiba eMMC which shows the 
error. Looking into it, I found that only the Toshiba eMMC specifies a 
powerclass in registers 203-200 while Sandisk does not, so the powerclass is 
not changed in the latter case and the problem cannot be triggered there.

I also attached a boot log with mmc debug enabled. I think there is not much I 
can do else. Either this eMMC is just bogus and needs blacklisting or there is 
some problem in the driver code.

I hope this problem can be fixed or if it can't, I hope that commit 3d93576e 
(mmc: core: skip card initialization if power class selection fails) is 
reverted until the issues are sorted out.

Greetings,

	Marc

--nextPart10464560.uUJSFqxE0G
Content-Disposition: attachment; filename="mmc_debug.log"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-log; charset="UTF-8"; name="mmc_debug.log"

[    1.493210] sdhci: Secure Digital Host Controller Interface driver
[    1.502081] sdhci: Copyright(c) Pierre Ossman
[    1.509128] sdhci-pltfm: SDHCI platform and OF driver helper
[    1.746274] mmc1: Invalid maximum block size, assuming 512 bytes
[    1.746304] mmc1: no vmmc regulator found
[    1.746310] sdhci: =========== REGISTER DUMP (mmc1)===========
[    1.746315] sdhci: Sys addr: 0x00000000 | Version:  0x00000001
[    1.746319] sdhci: Blk size: 0x00000000 | Blk cnt:  0x00000000
[    1.746323] sdhci: Argument: 0x00000000 | Trn mode: 0x00000000
[    1.746327] sdhci: Present:  0x1fff0000 | Host ctl: 0x00000000
[    1.746330] sdhci: Power:    0x00000000 | Blk gap:  0x00000000
[    1.746334] sdhci: Wake-up:  0x00000000 | Clock:    0x00000000
[    1.746337] sdhci: Timeout:  0x00000000 | Int stat: 0x00000000
[    1.746341] sdhci: Int enab: 0x00ff0003 | Sig enab: 0x00fc0003
[    1.746345] sdhci: AC12 err: 0x00000000 | Slot int: 0x00000000
[    1.746349] sdhci: Caps:     0x61ff30b0 | Caps_1:   0x00000000
[    1.746352] sdhci: Cmd:      0x00000000 | Max curr: 0x00000001
[    1.746354] sdhci: Host ctl2: 0x00000000
[    1.746358] sdhci: ADMA Err: 0x00000000 | ADMA Ptr: 0x00000000
[    1.746360] sdhci: ===========================================
[    1.746540] Registered led device: mmc1::
[    1.746763] mmc1: clock 0Hz busmode 2 powermode 1 cs 0 Vdd 21 width 0 timing 0
[    1.766240] mmc1: clock 400000Hz busmode 2 powermode 2 cs 0 Vdd 21 width 0 timing 0
[    1.940369] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00018001
[    1.944030] mmc1: SDHCI controller on sdhci-tegra.3 [sdhci-tegra.3] using ADMA

mmc0 stuff filtered out.

[    3.553372] mmc1: mmc_rescan_try_freq: trying to init card at 400000 Hz
[    3.553376] mmc1: starting CMD52 arg 00000c00 flags 00000195
[    3.562783] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00018001
[    3.562795] mmc1: req done (CMD52): -110: 00000000 00000000 00000000 00000000
[    3.562806] mmc1: starting CMD52 arg 80000c08 flags 00000195
[    3.571132] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00018001
[    3.571143] mmc1: req done (CMD52): -110: 00000000 00000000 00000000 00000000
[    3.571155] mmc1: clock 400000Hz busmode 2 powermode 2 cs 1 Vdd 21 width 0 timing 0
[    3.572167] mmc1: starting CMD0 arg 00000000 flags 000000c0
[    3.580191] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    3.580205] mmc1: req done (CMD0): 0: 00000000 00000000 00000000 00000000
[    3.580220] psmouse serio0: elantech: synaptics_send_cmd query 0x01 failed.
[    3.581214] mmc1: clock 400000Hz busmode 2 powermode 2 cs 0 Vdd 21 width 0 timing 0
[    3.582226] mmc1: starting CMD8 arg 000001aa flags 000002f5
[    3.590067] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00018001
[    3.590185] mmc1: req done (CMD8): -110: 00000000 00000000 00000000 00000000
[    3.590197] mmc1: starting CMD5 arg 00000000 flags 000002e1
[    3.598522] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00018001
[    3.598538] mmc1: req failed (CMD5): -110, retrying...
[    3.607568] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00018001
[    3.607690] mmc1: req failed (CMD5): -110, retrying...
[    3.615567] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00018001
[    3.615582] mmc1: req failed (CMD5): -110, retrying...
[    3.624604] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00018001
[    3.624616] mmc1: req done (CMD5): -110: 00000000 00000000 00000000 00000000
[    3.624628] mmc1: starting CMD55 arg 00000000 flags 000000f5
[    3.632501] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00018001
[    3.632511] mmc1: req done (CMD55): -110: 00000000 00000000 00000000 00000000
[    3.632523] mmc1: starting CMD55 arg 00000000 flags 000000f5
[    3.641526] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00018001
[    3.641537] mmc1: req done (CMD55): -110: 00000000 00000000 00000000 00000000
[    3.641554] mmc1: starting CMD55 arg 00000000 flags 000000f5
[    3.649424] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00018001
[    3.649434] mmc1: req done (CMD55): -110: 00000000 00000000 00000000 00000000
[    3.649445] mmc1: starting CMD55 arg 00000000 flags 000000f5
[    3.658459] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00018001
[    3.658470] mmc1: req done (CMD55): -110: 00000000 00000000 00000000 00000000
[    3.658482] mmc1: clock 400000Hz busmode 1 powermode 2 cs 0 Vdd 21 width 0 timing 0
[    3.658489] mmc1: starting CMD1 arg 00000000 flags 000000e1
[    3.668284] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    3.668296] mmc1: req done (CMD1): 0: 00ff8080 00000000 00000000 00000000
[    3.668310] mmc1: clock 400000Hz busmode 1 powermode 2 cs 0 Vdd 20 width 0 timing 0
[    3.668318] mmc1: clock 400000Hz busmode 1 powermode 2 cs 0 Vdd 20 width 0 timing 0
[    3.668324] mmc1: clock 400000Hz busmode 1 powermode 2 cs 1 Vdd 20 width 0 timing 0
[    3.669327] mmc1: starting CMD0 arg 00000000 flags 000000c0
[    3.676678] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    3.676687] mmc1: req done (CMD0): 0: 00000000 00000000 00000000 00000000
[    3.677697] mmc1: clock 400000Hz busmode 1 powermode 2 cs 0 Vdd 20 width 0 timing 0
[    3.678700] mmc1: starting CMD1 arg 40300000 flags 000000e1
[    3.685672] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    3.685798] mmc1: req done (CMD1): 0: 00ff8080 00000000 00000000 00000000
[    3.711555] mmc1: starting CMD1 arg 40300000 flags 000000e1
[    3.713099] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    3.713109] mmc1: req done (CMD1): 0: 00ff8080 00000000 00000000 00000000
[    3.741556] mmc1: starting CMD1 arg 40300000 flags 000000e1
[    3.750086] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    3.750095] mmc1: req done (CMD1): 0: c0ff8080 00000000 00000000 00000000
[    3.750106] mmc1: starting CMD2 arg 00000000 flags 00000067
[    3.758430] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    3.758444] mmc1: req done (CMD2): 0: 1101004d 4d433038 47030e18 24996d00
[    3.758465] mmc1: starting CMD3 arg 00010000 flags 00000015
[    3.767386] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    3.767397] mmc1: req done (CMD3): 0: 00000500 00000000 00000000 00000000
[    3.767410] mmc1: clock 400000Hz busmode 2 powermode 2 cs 0 Vdd 20 width 0 timing 0
[    3.767417] mmc1: starting CMD9 arg 00010000 flags 00000007
[    3.777230] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    3.777248] mmc1: req done (CMD9): 0: 900e0032 0f5903ff ffffffe7 96400000
[    3.777262] mmc1: starting CMD7 arg 00010000 flags 00000015
[    3.787637] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    3.787767] mmc1: req done (CMD7): 0: 00000700 00000000 00000000 00000000
[    3.787789] mmc1: starting CMD8 arg 00000000 flags 000000b5
[    3.787794] mmc1:     blksz 512 blocks 1 flags 00000200 tsac 10 ms nsac 0
[    3.796032] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    3.804985] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000002
[    3.805123] mmc1: req done (CMD8): 0: 00000900 00000000 00000000 00000000
[    3.805126] mmc1:     512 bytes transferred: 0
[    3.805144] mmc1: starting CMD6 arg 03af0101 flags 0000049d
[    3.814867] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000003
[    3.814877] mmc1: req done (CMD6): 0: 00000800 00000000 00000000 00000000
[    3.814890] mmc1: starting CMD13 arg 00010000 flags 00000195
[    3.824705] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    3.824717] mmc1: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[    3.824729] mmc1: starting CMD6 arg 03b90101 flags 0000049d
[    3.834020] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000003
[    3.834030] mmc1: req done (CMD6): 0: 00000800 00000000 00000000 00000000
[    3.834041] mmc1: starting CMD13 arg 00010000 flags 00000195
[    3.842346] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    3.842360] mmc1: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[    3.842373] mmc1: clock 400000Hz busmode 2 powermode 2 cs 0 Vdd 20 width 0 timing 1
[    3.842382] mmc1: clock 48000000Hz busmode 2 powermode 2 cs 0 Vdd 20 width 0 timing 1
[    3.842390] mmc1: starting CMD6 arg 03bb0301 flags 0000049d
[    3.851273] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000003
[    3.851282] mmc1: req done (CMD6): 0: 00000800 00000000 00000000 00000000
[    3.851294] mmc1: starting CMD13 arg 00010000 flags 00000195
[    3.861089] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    3.861101] mmc1: req done (CMD13): 0: 00000980 00000000 00000000 00000000
[    3.861111] mmc1: power class selection for ext_csd_bus_width 2 failed
[    3.861115] mmc1: error -74 whilst initialising MMC card
[    3.861120] mmc1: clock 0Hz busmode 1 powermode 0 cs 0 Vdd 0 width 0 timing 0
[    3.862136] mmc1: mmc_rescan_try_freq: trying to init card at 300000 Hz
[    3.862141] mmc1: clock 0Hz busmode 2 powermode 1 cs 0 Vdd 21 width 0 timing 0
[    3.863977] Registered led device: paz00-led
[    3.881562] mmc1: clock 300000Hz busmode 2 powermode 2 cs 0 Vdd 21 width 0 timing 0
[    3.900782] mmc1: starting CMD52 arg 00000c00 flags 00000195
[    3.906916] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00018001
[    3.907055] mmc1: req done (CMD52): -110: 00000000 00000000 00000000 00000000
[    3.907075] mmc1: starting CMD52 arg 80000c08 flags 00000195
[    3.916030] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00018001
[    3.916048] mmc1: req done (CMD52): -110: 00000000 00000000 00000000 00000000
[    3.916064] mmc1: clock 300000Hz busmode 2 powermode 2 cs 1 Vdd 21 width 0 timing 0
[    3.917068] mmc1: starting CMD0 arg 00000000 flags 000000c0
[    3.925544] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    3.925558] mmc1: req done (CMD0): 0: 00000000 00000000 00000000 00000000
[    3.926568] mmc1: clock 300000Hz busmode 2 powermode 2 cs 0 Vdd 21 width 0 timing 0
[    3.927572] mmc1: starting CMD8 arg 000001aa flags 000002f5
[    3.935240] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00018001
[    3.935258] mmc1: req done (CMD8): -110: 00000000 00000000 00000000 00000000
[    3.935270] mmc1: starting CMD5 arg 00000000 flags 000002e1
[    3.945665] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00018001
[    3.945688] mmc1: req failed (CMD5): -110, retrying...
[    3.953973] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00018001
[    3.953996] mmc1: req failed (CMD5): -110, retrying...
[    3.962999] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00018001
[    3.963021] mmc1: req failed (CMD5): -110, retrying...
[    3.972819] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00018001
[    3.972843] mmc1: req done (CMD5): -110: 00000000 00000000 00000000 00000000
[    3.972858] mmc1: starting CMD55 arg 00000000 flags 000000f5
[    3.981163] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00018001
[    3.981181] mmc1: req done (CMD55): -110: 00000000 00000000 00000000 00000000
[    3.981195] mmc1: starting CMD55 arg 00000000 flags 000000f5
[    3.990197] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00018001
[    3.990341] mmc1: req done (CMD55): -110: 00000000 00000000 00000000 00000000
[    3.990353] mmc1: starting CMD55 arg 00000000 flags 000000f5
[    3.998210] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00018001
[    3.998226] mmc1: req done (CMD55): -110: 00000000 00000000 00000000 00000000
[    3.998238] mmc1: starting CMD55 arg 00000000 flags 000000f5
[    4.007235] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00018001
[    4.007377] mmc1: req done (CMD55): -110: 00000000 00000000 00000000 00000000
[    4.007392] mmc1: clock 300000Hz busmode 1 powermode 2 cs 0 Vdd 21 width 0 timing 0
[    4.007399] mmc1: starting CMD1 arg 00000000 flags 000000e1
[    4.015248] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    4.015264] mmc1: req done (CMD1): 0: 00ff8080 00000000 00000000 00000000
[    4.015279] mmc1: clock 300000Hz busmode 1 powermode 2 cs 0 Vdd 20 width 0 timing 0
[    4.015286] mmc1: clock 300000Hz busmode 1 powermode 2 cs 0 Vdd 20 width 0 timing 0
[    4.015293] mmc1: clock 300000Hz busmode 1 powermode 2 cs 1 Vdd 20 width 0 timing 0
[    4.016296] mmc1: starting CMD0 arg 00000000 flags 000000c0
[    4.024281] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    4.024295] mmc1: req done (CMD0): 0: 00000000 00000000 00000000 00000000
[    4.025316] mmc1: clock 300000Hz busmode 1 powermode 2 cs 0 Vdd 20 width 0 timing 0
[    4.026320] mmc1: starting CMD1 arg 40300000 flags 000000e1
[    4.032158] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    4.032174] mmc1: req done (CMD1): 0: 00ff8080 00000000 00000000 00000000
[    4.059424] mmc1: starting CMD1 arg 40300000 flags 000000e1
[    4.068382] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    4.068394] mmc1: req done (CMD1): 0: 00ff8080 00000000 00000000 00000000
[    4.081587] mmc1: starting CMD1 arg 40300000 flags 000000e1
[    4.086623] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    4.086732] mmc1: req done (CMD1): 0: c0ff8080 00000000 00000000 00000000
[    4.086749] mmc1: starting CMD2 arg 00000000 flags 00000067
[    4.095712] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    4.095726] mmc1: req done (CMD2): 0: 1101004d 4d433038 47030e18 24996d00
[    4.095757] mmc1: starting CMD3 arg 00010000 flags 00000015
[    4.105591] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    4.105701] mmc1: req done (CMD3): 0: 00000500 00000000 00000000 00000000
[    4.105719] mmc1: clock 300000Hz busmode 2 powermode 2 cs 0 Vdd 20 width 0 timing 0
[    4.105727] mmc1: starting CMD9 arg 00010000 flags 00000007
[    4.114058] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    4.114072] mmc1: req done (CMD9): 0: 900e0032 0f5903ff ffffffe7 96400000
[    4.114089] mmc1: starting CMD7 arg 00010000 flags 00000015
[    4.123046] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    4.123056] mmc1: req done (CMD7): 0: 00000700 00000000 00000000 00000000
[    4.123083] mmc1: starting CMD8 arg 00000000 flags 000000b5
[    4.123088] mmc1:     blksz 512 blocks 1 flags 00000200 tsac 10 ms nsac 0
[    4.132921] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    4.150214] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000002
[    4.150231] mmc1: req done (CMD8): 0: 00000900 00000000 00000000 00000000
[    4.150234] mmc1:     512 bytes transferred: 0
[    4.150255] mmc1: starting CMD6 arg 03af0101 flags 0000049d
[    4.160089] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000003
[    4.160099] mmc1: req done (CMD6): 0: 00000800 00000000 00000000 00000000
[    4.160116] mmc1: starting CMD13 arg 00010000 flags 00000195
[    4.170486] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    4.170499] mmc1: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[    4.170515] mmc1: starting CMD6 arg 03b90101 flags 0000049d
[    4.178771] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000003
[    4.178786] mmc1: req done (CMD6): 0: 00000800 00000000 00000000 00000000
[    4.178802] mmc1: starting CMD13 arg 00010000 flags 00000195
[    4.187766] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    4.187900] mmc1: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[    4.187917] mmc1: clock 300000Hz busmode 2 powermode 2 cs 0 Vdd 20 width 0 timing 1
[    4.187925] mmc1: clock 48000000Hz busmode 2 powermode 2 cs 0 Vdd 20 width 0 timing 1
[    4.187933] mmc1: starting CMD6 arg 03bb0301 flags 0000049d
[    4.197393] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000003
[    4.197404] mmc1: req done (CMD6): 0: 00000800 00000000 00000000 00000000
[    4.197420] mmc1: starting CMD13 arg 00010000 flags 00000195
[    4.207786] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    4.207918] mmc1: req done (CMD13): 0: 00000980 00000000 00000000 00000000
[    4.207932] mmc1: power class selection for ext_csd_bus_width 2 failed
[    4.207937] mmc1: error -74 whilst initialising MMC card
[    4.207942] mmc1: clock 0Hz busmode 1 powermode 0 cs 0 Vdd 0 width 0 timing 0
[    4.208951] mmc1: mmc_rescan_try_freq: trying to init card at 200000 Hz
[    4.208955] mmc1: clock 0Hz busmode 2 powermode 1 cs 0 Vdd 21 width 0 timing 0
[    4.221589] mmc1: clock 200000Hz busmode 2 powermode 2 cs 0 Vdd 21 width 0 timing 0
[    4.241568] mmc1: starting CMD52 arg 00000c00 flags 00000195
[    4.245273] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00018001
[    4.245289] mmc1: req done (CMD52): -110: 00000000 00000000 00000000 00000000
[    4.245305] mmc1: starting CMD52 arg 80000c08 flags 00000195
[    4.254605] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00018001
[    4.254616] mmc1: req done (CMD52): -110: 00000000 00000000 00000000 00000000
[    4.254633] mmc1: clock 200000Hz busmode 2 powermode 2 cs 1 Vdd 21 width 0 timing 0
[    4.255636] mmc1: starting CMD0 arg 00000000 flags 000000c0
[    4.264830] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    4.264841] mmc1: req done (CMD0): 0: 00000000 00000000 00000000 00000000
[    4.265855] mmc1: clock 200000Hz busmode 2 powermode 2 cs 0 Vdd 21 width 0 timing 0
[    4.266859] mmc1: starting CMD8 arg 000001aa flags 000002f5
[    4.272955] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00018001
[    4.272965] mmc1: req done (CMD8): -110: 00000000 00000000 00000000 00000000
[    4.272981] mmc1: starting CMD5 arg 00000000 flags 000002e1
[    4.281788] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00018001
[    4.281920] mmc1: req failed (CMD5): -110, retrying...
[    4.291248] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00018001
[    4.291266] mmc1: req failed (CMD5): -110, retrying...
[    4.299366] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00018001
[    4.299385] mmc1: req failed (CMD5): -110, retrying...
[    4.308189] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00018001
[    4.308322] mmc1: req done (CMD5): -110: 00000000 00000000 00000000 00000000
[    4.308338] mmc1: starting CMD55 arg 00000000 flags 000000f5
[    4.317673] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00018001
[    4.317684] mmc1: req done (CMD55): -110: 00000000 00000000 00000000 00000000
[    4.317700] mmc1: starting CMD55 arg 00000000 flags 000000f5
[    4.325795] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00018001
[    4.325807] mmc1: req done (CMD55): -110: 00000000 00000000 00000000 00000000
[    4.325823] mmc1: starting CMD55 arg 00000000 flags 000000f5
[    4.334619] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00018001
[    4.334630] mmc1: req done (CMD55): -110: 00000000 00000000 00000000 00000000
[    4.334645] mmc1: starting CMD55 arg 00000000 flags 000000f5
[    4.343981] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00018001
[    4.343993] mmc1: req done (CMD55): -110: 00000000 00000000 00000000 00000000
[    4.344010] mmc1: clock 200000Hz busmode 1 powermode 2 cs 0 Vdd 21 width 0 timing 0
[    4.344016] mmc1: starting CMD1 arg 00000000 flags 000000e1
[    4.352100] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    4.352110] mmc1: req done (CMD1): 0: 00ff8080 00000000 00000000 00000000
[    4.352127] mmc1: clock 200000Hz busmode 1 powermode 2 cs 0 Vdd 20 width 0 timing 0
[    4.352134] mmc1: clock 200000Hz busmode 1 powermode 2 cs 0 Vdd 20 width 0 timing 0
[    4.352141] mmc1: clock 200000Hz busmode 1 powermode 2 cs 1 Vdd 20 width 0 timing 0
[    4.353144] mmc1: starting CMD0 arg 00000000 flags 000000c0
[    4.360908] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    4.360918] mmc1: req done (CMD0): 0: 00000000 00000000 00000000 00000000
[    4.361961] mmc1: clock 200000Hz busmode 1 powermode 2 cs 0 Vdd 20 width 0 timing 0
[    4.362965] mmc1: starting CMD1 arg 40300000 flags 000000e1
[    4.370269] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    4.370280] mmc1: req done (CMD1): 0: 00ff8080 00000000 00000000 00000000
[    4.381584] mmc1: starting CMD1 arg 40300000 flags 000000e1
[    4.387220] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    4.387355] mmc1: req done (CMD1): 0: 00ff8080 00000000 00000000 00000000
[    4.401564] mmc1: starting CMD1 arg 40300000 flags 000000e1
[    4.406944] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    4.407073] mmc1: req done (CMD1): 0: 00ff8080 00000000 00000000 00000000
[    4.421564] mmc1: starting CMD1 arg 40300000 flags 000000e1
[    4.424047] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    4.424059] mmc1: req done (CMD1): 0: c0ff8080 00000000 00000000 00000000
[    4.424074] mmc1: starting CMD2 arg 00000000 flags 00000067
[    4.433444] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    4.433456] mmc1: req done (CMD2): 0: 1101004d 4d433038 47030e18 24996d00
[    4.433480] mmc1: starting CMD3 arg 00010000 flags 00000015
[    4.441591] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    4.441607] mmc1: req done (CMD3): 0: 00000500 00000000 00000000 00000000
[    4.441623] mmc1: clock 200000Hz busmode 2 powermode 2 cs 0 Vdd 20 width 0 timing 0
[    4.441630] mmc1: starting CMD9 arg 00010000 flags 00000007
[    4.450434] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    4.450445] mmc1: req done (CMD9): 0: 900e0032 0f5903ff ffffffe7 96400000
[    4.450461] mmc1: starting CMD7 arg 00010000 flags 00000015
[    4.459799] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    4.459810] mmc1: req done (CMD7): 0: 00000700 00000000 00000000 00000000
[    4.459835] mmc1: starting CMD8 arg 00000000 flags 000000b5
[    4.459840] mmc1:     blksz 512 blocks 1 flags 00000200 tsac 10 ms nsac 0
[    4.467922] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    4.486052] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000002
[    4.486185] mmc1: req done (CMD8): 0: 00000900 00000000 00000000 00000000
[    4.486188] mmc1:     512 bytes transferred: 0
[    4.486209] mmc1: starting CMD6 arg 03af0101 flags 0000049d
[    4.495004] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000003
[    4.495016] mmc1: req done (CMD6): 0: 00000800 00000000 00000000 00000000
[    4.495032] mmc1: starting CMD13 arg 00010000 flags 00000195
[    4.504435] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    4.504562] mmc1: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[    4.504578] mmc1: starting CMD6 arg 03b90101 flags 0000049d
[    4.511589] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000003
[    4.511599] mmc1: req done (CMD6): 0: 00000800 00000000 00000000 00000000
[    4.511614] mmc1: starting CMD13 arg 00010000 flags 00000195
[    4.519736] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    4.519747] mmc1: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[    4.519764] mmc1: clock 200000Hz busmode 2 powermode 2 cs 0 Vdd 20 width 0 timing 1
[    4.519771] mmc1: clock 48000000Hz busmode 2 powermode 2 cs 0 Vdd 20 width 0 timing 1
[    4.519779] mmc1: starting CMD6 arg 03bb0301 flags 0000049d
[    4.528601] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000003
[    4.528611] mmc1: req done (CMD6): 0: 00000800 00000000 00000000 00000000
[    4.528627] mmc1: starting CMD13 arg 00010000 flags 00000195
[    4.537981] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    4.537992] mmc1: req done (CMD13): 0: 00000980 00000000 00000000 00000000
[    4.538006] mmc1: power class selection for ext_csd_bus_width 2 failed
[    4.538010] mmc1: error -74 whilst initialising MMC card
[    4.538015] mmc1: clock 0Hz busmode 1 powermode 0 cs 0 Vdd 0 width 0 timing 0
[    4.539022] mmc1: mmc_rescan_try_freq: trying to init card at 187500 Hz
[    4.539027] mmc1: clock 0Hz busmode 2 powermode 1 cs 0 Vdd 21 width 0 timing 0
[    4.551589] mmc1: clock 187500Hz busmode 2 powermode 2 cs 0 Vdd 21 width 0 timing 0
[    4.572548] mmc1: starting CMD52 arg 00000c00 flags 00000195
[    4.581325] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00018001
[    4.581342] mmc1: req done (CMD52): -110: 00000000 00000000 00000000 00000000
[    4.590725] mmc1: starting CMD52 arg 80000c08 flags 00000195
[    4.598986] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00018001
[    4.598999] mmc1: req done (CMD52): -110: 00000000 00000000 00000000 00000000
[    4.599019] mmc1: clock 187500Hz busmode 2 powermode 2 cs 1 Vdd 21 width 0 timing 0
[    4.600023] mmc1: starting CMD0 arg 00000000 flags 000000c0
[    4.607800] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    4.607931] mmc1: req done (CMD0): 0: 00000000 00000000 00000000 00000000
[    4.608945] mmc1: clock 187500Hz busmode 2 powermode 2 cs 0 Vdd 21 width 0 timing 0
[    4.609949] mmc1: starting CMD8 arg 000001aa flags 000002f5
[    4.617346] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00018001
[    4.617359] mmc1: req done (CMD8): -110: 00000000 00000000 00000000 00000000
[    4.617375] mmc1: starting CMD5 arg 00000000 flags 000002e1
[    4.627580] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00018001
[    4.627600] mmc1: req failed (CMD5): -110, retrying...
[    4.637983] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00018001
[    4.638005] mmc1: req failed (CMD5): -110, retrying...
[    4.646100] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00018001
[    4.646123] mmc1: req failed (CMD5): -110, retrying...
[    4.654932] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00018001
[    4.654945] mmc1: req done (CMD5): -110: 00000000 00000000 00000000 00000000
[    4.654961] mmc1: starting CMD55 arg 00000000 flags 000000f5
[    4.664294] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00018001
[    4.664305] mmc1: req done (CMD55): -110: 00000000 00000000 00000000 00000000
[    4.664321] mmc1: starting CMD55 arg 00000000 flags 000000f5
[    4.672502] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00018001
[    4.672514] mmc1: req done (CMD55): -110: 00000000 00000000 00000000 00000000
[    4.672530] mmc1: starting CMD55 arg 00000000 flags 000000f5
[    4.681304] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00018001
[    4.681313] mmc1: req done (CMD55): -110: 00000000 00000000 00000000 00000000
[    4.681328] mmc1: starting CMD55 arg 00000000 flags 000000f5
[    4.690720] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00018001
[    4.690838] mmc1: req done (CMD55): -110: 00000000 00000000 00000000 00000000
[    4.690855] mmc1: clock 187500Hz busmode 1 powermode 2 cs 0 Vdd 21 width 0 timing 0
[    4.690861] mmc1: starting CMD1 arg 00000000 flags 000000e1
[    4.699895] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    4.699905] mmc1: req done (CMD1): 0: 00ff8080 00000000 00000000 00000000
[    4.699923] mmc1: clock 187500Hz busmode 1 powermode 2 cs 0 Vdd 20 width 0 timing 0
[    4.699930] mmc1: clock 187500Hz busmode 1 powermode 2 cs 0 Vdd 20 width 0 timing 0
[    4.699937] mmc1: clock 187500Hz busmode 1 powermode 2 cs 1 Vdd 20 width 0 timing 0
[    4.700939] mmc1: starting CMD0 arg 00000000 flags 000000c0
[    4.707711] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    4.707826] mmc1: req done (CMD0): 0: 00000000 00000000 00000000 00000000
[    4.708840] mmc1: clock 187500Hz busmode 1 powermode 2 cs 0 Vdd 20 width 0 timing 0
[    4.709844] mmc1: starting CMD1 arg 40300000 flags 000000e1
[    4.717486] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    4.717496] mmc1: req done (CMD1): 0: 00ff8080 00000000 00000000 00000000
[    4.731594] mmc1: starting CMD1 arg 40300000 flags 000000e1
[    4.736368] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    4.736380] mmc1: req done (CMD1): 0: 00ff8080 00000000 00000000 00000000
[    4.751565] mmc1: starting CMD1 arg 40300000 flags 000000e1
[    4.753395] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    4.753407] mmc1: req done (CMD1): 0: 00ff8080 00000000 00000000 00000000
[    4.771567] mmc1: starting CMD1 arg 40300000 flags 000000e1
[    4.780294] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    4.780309] mmc1: req done (CMD1): 0: c0ff8080 00000000 00000000 00000000
[    4.780326] mmc1: starting CMD2 arg 00000000 flags 00000067
[    4.788622] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    4.788738] mmc1: req done (CMD2): 0: 1101004d 4d433038 47030e18 24996d00
[    4.788763] mmc1: starting CMD3 arg 00010000 flags 00000015
[    4.797674] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    4.797684] mmc1: req done (CMD3): 0: 00000500 00000000 00000000 00000000
[    4.797701] mmc1: clock 187500Hz busmode 2 powermode 2 cs 0 Vdd 20 width 0 timing 0
[    4.797708] mmc1: starting CMD9 arg 00010000 flags 00000007
[    4.807503] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    4.807622] mmc1: req done (CMD9): 0: 900e0032 0f5903ff ffffffe7 96400000
[    4.807638] mmc1: starting CMD7 arg 00010000 flags 00000015
[    4.817986] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    4.817996] mmc1: req done (CMD7): 0: 00000700 00000000 00000000 00000000
[    4.818021] mmc1: starting CMD8 arg 00000000 flags 000000b5
[    4.818026] mmc1:     blksz 512 blocks 1 flags 00000200 tsac 10 ms nsac 0
[    4.826268] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    4.844734] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000002
[    4.844754] mmc1: req done (CMD8): 0: 00000900 00000000 00000000 00000000
[    4.844757] mmc1:     512 bytes transferred: 0
[    4.844777] mmc1: starting CMD6 arg 03af0101 flags 0000049d
[    4.855166] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000003
[    4.855177] mmc1: req done (CMD6): 0: 00000800 00000000 00000000 00000000
[    4.855193] mmc1: starting CMD13 arg 00010000 flags 00000195
[    4.863479] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    4.863490] mmc1: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[    4.863506] mmc1: starting CMD6 arg 03b90101 flags 0000049d
[    4.872501] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000003
[    4.872511] mmc1: req done (CMD6): 0: 00000800 00000000 00000000 00000000
[    4.872527] mmc1: starting CMD13 arg 00010000 flags 00000195
[    4.882331] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    4.882440] mmc1: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[    4.882456] mmc1: clock 187500Hz busmode 2 powermode 2 cs 0 Vdd 20 width 0 timing 1
[    4.882465] mmc1: clock 48000000Hz busmode 2 powermode 2 cs 0 Vdd 20 width 0 timing 1
[    4.882472] mmc1: starting CMD6 arg 03bb0301 flags 0000049d
[    4.890746] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000003
[    4.890756] mmc1: req done (CMD6): 0: 00000800 00000000 00000000 00000000
[    4.890771] mmc1: starting CMD13 arg 00010000 flags 00000195
[    4.899774] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    4.899784] mmc1: req done (CMD13): 0: 00000980 00000000 00000000 00000000
[    4.899799] mmc1: power class selection for ext_csd_bus_width 2 failed
[    4.899803] mmc1: error -74 whilst initialising MMC card
[    4.899807] mmc1: clock 0Hz busmode 1 powermode 0 cs 0 Vdd 0 width 0 timing 0

--nextPart10464560.uUJSFqxE0G--

