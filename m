From: joancarles <joancarles@fqingenieria.es>
Subject: RE: [MX25][MMC] mmc esdhc failure in 3.3-rc5
Date: Fri, 16 Mar 2012 16:03:24 +0100
Message-ID: <a06e68c3687c7390e15950bc20831fd4@mail.fqingenieria.es>
References: <5e57eb999780335721212bb8d411406f@mail.fqingenieria.es>
 <20120312132423.GC2459@pengutronix.de>
 <9018463dfcd3c9e9a311aeed42b758bf@mail.fqingenieria.es>
 <0E83723C55F66F43A6041464FE31119D099A34@039-SN2MPN1-011.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from llsa736-a03.servidoresdns.net ([82.223.190.27]:39739 "EHLO
	llsa736-a03.servidoresdns.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1031130Ab2CPPDa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Mar 2012 11:03:30 -0400
In-Reply-To: <0E83723C55F66F43A6041464FE31119D099A34@039-SN2MPN1-011.039d.mgd.msft.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhu Richard-R65037 <r65037@freescale.com>
Cc: Wolfram Sang <w.sang@pengutronix.de>, linux-mmc@vger.kernel.org, shawn.guo@linaro.org

Hi

Thank you for your reply. I has taken me a while to figure out what you 
meant, but I believe I have added a sdhci_dumpregs(host) to the place 
where CMD24 is issued with a -110 return error.

> Hi:
> -110 is the timeout problem.
> You can dump the esdhc registers if you want to debug into this issue
> when this timeout problem occurred.
> The register dump can help to figure out what's wrong on the bus.

I have no familiarity with the SDHC drivers, so there's nothing useful 
for me in the output as of this moment:

[ 1080.818765] sdhci: ===========================================
[ 1080.818830] mmc0: req done (CMD17): 0: 00000900 00000000 00000000 
00000000
[ 1080.818862] mmc0:     512 bytes transferred: 0
[ 1080.819395] mmc0: starting CMD24 arg 00008800 flags 000000b5
[ 1080.819444] mmc0:     blksz 512 blocks 1 flags 00000100 tsac 300 ms 
nsac 0
[ 1080.819544] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000009
[ 1080.819595] sdhci [sdhci_data_irq()]: mmc0: DMA base 0x82547c00, 
transferred 0x038400 bytes, next 0x82580000
[ 1080.819630] sdhci: =========== REGISTER DUMP (mmc0)===========
[ 1080.819658] sdhci: Sys addr: 0x82547e00 | Version:  0x00000000
[ 1080.819683] sdhci: Blk size: 0x00000200 | Blk cnt:  0x00000000
[ 1080.819707] sdhci: Argument: 0x00008800 | Trn mode: 0x00000003
[ 1080.819732] sdhci: Present:  0xfe880006 | Host ctl: 0x00000023
[ 1080.819756] sdhci: Power:    0x00000000 | Blk gap:  0x00000000
[ 1080.819780] sdhci: Wake-up:  0x00000000 | Clock:    0x00000107
[ 1080.819804] sdhci: Timeout:  0x0000000c | Int stat: 0x00100002
[ 1080.819830] sdhci: Int enab: 0x107f000b | Sig enab: 0x107f000b
[ 1080.819854] sdhci: AC12 err: 0x00000000 | Slot int: 0x00001001
[ 1080.819879] sdhci: Caps:     0x07eb0000 | Caps_1:   0x04100410
[ 1080.819904] sdhci: Cmd:      0x0000183a | Max curr: 0x00000000
[ 1080.819926] sdhci: Host ctl2: 0x00000000
[ 1080.819942] sdhci: ===========================================
[ 1080.819985] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00100002
[ 1080.820048] mmc0: req done (CMD24): 0: 00000900 00000000 00000000 
00000000
[ 1080.820082] mmc0:     0 bytes transferred: -110
[ 1080.820134] mmc0: starting CMD13 arg 00020000 flags 00000195
[ 1080.820201] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[ 1080.820259] mmc0: req done (CMD13): 0: 00000e00 00000000 00000000 
00000000
[ 1080.820330] mmc0: starting CMD13 arg 00020000 flags 00000195
[ 1080.820391] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[ 1080.820445] mmc0: req done (CMD13): 0: 00000e00 00000000 00000000 
00000000
[ 1080.820504] mmc0: starting CMD13 arg 00020000 flags 00000195
[ 1080.820572] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[ 1080.820627] mmc0: req done (CMD13): 0: 00000e00 00000000 00000000 
00000000
[ 1080.820785] mmc0: starting CMD13 arg 00020000 flags 00000195
[ 1080.820879] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[ 1080.820946] mmc0: req done (CMD13): 0: 00000e00 00000000 00000000 
00000000
[ 1080.821021] mmc0: starting CMD13 arg 00020000 flags 00000195
[ 1080.821085] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[ 1080.821140] mmc0: req done (CMD13): 0: 00000e00 00000000 00000000 
00000000
[ 1080.821197] mmc0: starting CMD13 arg 00020000 flags 00000195
[ 1080.821255] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[ 1080.821308] mmc0: req done (CMD13): 0: 00000e00 00000000 00000000 
00000000
[ 1080.824944] mmc0: starting CMD13 arg 00020000 flags 00000195
[ 1080.825041] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[ 1080.825112] mmc0: req done (CMD13): 0: 00000e00 00000000 00000000 
00000000
[ 1080.825186] mmc0: starting CMD13 arg 00020000 flags 00000195
[ 1080.825248] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[ 1080.825302] mmc0: req done (CMD13): 0: 00000e00 00000000 00000000 
00000000
[ 1080.825364] mmc0: starting CMD13 arg 00020000 flags 00000195
[ 1080.825432] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[ 1080.825485] mmc0: req done (CMD13): 0: 00000e00 00000000 00000000 
00000000
[ 1080.825640] mmc0: starting CMD13 arg 00020000 flags 00000195
[ 1080.825736] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[ 1080.825803] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 
00000000
[ 1080.825883] mmcblk0: error -110 transferring data, sector 68, nr 1, 
cmd response 0x900, card status 0x0
[ 1080.849435] mmc0: starting CMD55 arg 00020000 flags 00000095
[ 1080.849531] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[ 1080.849596] mmc0: req done (CMD55): 0: 00000920 00000000 00000000 
00000000
[ 1080.850319] mmc0: starting CMD22 arg 00000000 flags 000000b5
[ 1080.850367] mmc0:     blksz 4 blocks 1 flags 00000200 tsac 100 ms 
nsac 0
[ 1080.850468] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[ 1080.850523] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x0020000a
[ 1080.850591] mmc0: req done (CMD22): 0: 00000920 00000000 00000000 
00000000
[ 1080.850624] mmc0:     0 bytes transferred: -84
[ 1080.851339] end_request: I/O error, dev mmcblk0, sector 68
[ 1080.856881] Buffer I/O error on device mmcblk0p1, logical block 6
[ 1080.862998] lost page write due to I/O error on mmcblk0p1
[ 1080.897203] mmc0: starting CMD17 arg 00008800 flags 000000b5
[ 1080.897250] mmc0:     blksz 512 blocks 1 flags 00000200 tsac 100 ms 
nsac 0
[ 1080.897350] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[ 1080.898143] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x0020000a
[ 1080.898241] mmc0: req done (CMD17): 0: 00000900 00000000 00000000 
00000000
[ 1080.898276] mmc0:     0 bytes transferred: -84
[ 1080.898949] mmc0: starting CMD13 arg 00020000 flags 00000195
[ 1080.899134] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[ 1080.899204] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 
00000000
[ 1080.899284] mmcblk0: error -84 transferring data, sector 68, nr 1, 
cmd response 0x900, card status 0x0
[ 1080.908738] end_request: I/O error, dev mmcblk0, sector 68
[ 1080.914465] FAT-fs (mmcblk0p1): FAT read failed (blocknr 6)
[ 1085.809683] mmc0: starting CMD24 arg 00045e00 flags 000000b5
[ 1085.809731] mmc0:     blksz 512 blocks 1 flags 00000100 tsac 300 ms 
nsac 0
[ 1085.809831] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000009
[ 1085.809880] sdhci [sdhci_data_irq()]: mmc0: DMA base 0x82548200, 
transferred 0x037e00 bytes, next 0x82580000
[ 1085.809914] sdhci: =========== REGISTER DUMP (mmc0)===========
[ 1085.809941] sdhci: Sys addr: 0x82548400 | Version:  0x00000000
[ 1085.809967] sdhci: Blk size: 0x00000200 | Blk cnt:  0x00000000
[ 1085.809992] sdhci: Argument: 0x00045e00 | Trn mode: 0x00000003
[ 1085.810017] sdhci: Present:  0xff880000 | Host ctl: 0x00000021
[ 1085.810042] sdhci: Power:    0x00000000 | Blk gap:  0x00000000
[ 1085.810067] sdhci: Wake-up:  0x00000000 | Clock:    0x00000107
[ 1085.810093] sdhci: Timeout:  0x0000000c | Int stat: 0x00200002
[ 1085.810119] sdhci: Int enab: 0x107f000b | Sig enab: 0x107f000b
[ 1085.810143] sdhci: AC12 err: 0x00000000 | Slot int: 0x00001001
[ 1085.810169] sdhci: Caps:     0x07eb0000 | Caps_1:   0x04100410
[ 1085.810193] sdhci: Cmd:      0x0000183a | Max curr: 0x00000000
[ 1085.810214] sdhci: Host ctl2: 0x00000000
[ 1085.810232] sdhci: ===========================================
[ 1085.810275] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00200002
[ 1085.810340] mmc0: req done (CMD24): 0: 00000900 00000000 00000000 
00000000
[ 1085.810373] mmc0:     0 bytes transferred: -84
[ 1085.810427] mmc0: starting CMD13 arg 00020000 flags 00000195
[ 1085.810489] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[ 1085.810543] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 
00000000
[ 1085.810616] mmc0: starting CMD13 arg 00020000 flags 00000195
[ 1085.810690] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[ 1085.810747] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 
00000000
[ 1085.810838] mmcblk0: error -84 transferring data, sector 559, nr 1, 
cmd response 0x900, card status 0x0
[ 1085.834557] mmc0: starting CMD55 arg 00020000 flags 00000095
[ 1085.834651] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[ 1085.834722] mmc0: req done (CMD55): 0: 00000920 00000000 00000000 
00000000
[ 1085.834802] mmc0: starting CMD22 arg 00000000 flags 000000b5
[ 1085.834839] mmc0:     blksz 4 blocks 1 flags 00000200 tsac 100 ms 
nsac 0
[ 1085.834915] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[ 1085.834986] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x0020000a
[ 1085.835056] mmc0: req done (CMD22): 0: 00000920 00000000 00000000 
00000000

What else can I provide you with? The MMC/SDHC/eSDHC driver framework 
is a huge piece of software, so I don't really know where to start 
looking. Electrically, there seems nothing really wrong with the signal 
of the clock; the only thing that looks a wee bit suspicious is that the 
MX25 clock for the SDHC is currently offering a 33MHz signal (as 
gathered from the oscilloscope).

>> and look at those commits. You should also include the people who 
>> did
>> those commits in CC when writing mails, otherwise they probably 
>> won't
>> notice. Richard Zhu and Shawn Guo are from Freescale, and have more
>> knowledge about the ESDHC cores.
>
> Done now, thanks. Richard, Shawn, any pointers as to where to start
> looking on this one? Since the i.MX25 eSDHC has four data lines, one
> clock and one command line hard-wired, there is really nothing from a
> hardware point of view that could influence this different behaviour
> between the 2.6.39 and the 3.3-rc7 kernels.

-- 
Joan C. Abelaira
