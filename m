From: joancarles <joancarles@fqingenieria.es>
Subject: Re: [MX25][MMC] mmc esdhc failure in 3.3
Date: Wed, 28 Mar 2012 11:26:50 +0200
Message-ID: <c4306c7d39eac8f1751957eefe20a6c2@mail.fqingenieria.es>
References: <5e57eb999780335721212bb8d411406f@mail.fqingenieria.es>
 <20120312132423.GC2459@pengutronix.de>
 <9018463dfcd3c9e9a311aeed42b758bf@mail.fqingenieria.es>
 <0E83723C55F66F43A6041464FE31119D099A34@039-SN2MPN1-011.039d.mgd.msft.net>
 <a06e68c3687c7390e15950bc20831fd4@mail.fqingenieria.es>
 <85b807b77d73328485781d6fa1568e46@mail.fqingenieria.es>
 <20120327101259.73525f9d@eb-e6520>
 <ac05d6e5c1ce4bf9cfc5c28d235f866f@mail.fqingenieria.es>
 <20120327090148.GB6790@pengutronix.de> <20120327110615.3bfaf969@eb-e6520>
 <7f2ae9e3800848e140461a0506808fb4@mail.fqingenieria.es>
 <20120327114048.6af2e178@eb-e6520>
 <137e8b8e079af62aea2fd4d363be6273@mail.fqingenieria.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from llsa736-a03.servidoresdns.net ([82.223.190.27]:55065 "EHLO
	llsa736-a03.servidoresdns.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932187Ab2C1J1A (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Mar 2012 05:27:00 -0400
In-Reply-To: <137e8b8e079af62aea2fd4d363be6273@mail.fqingenieria.es>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: joancarles <joancarles@fqingenieria.es>
Cc: =?UTF-8?Q?Eric_B=C3=A9nard?= <eric@eukrea.com>, Wolfram Sang <w.sang@pengutronix.de>, Zhu Richard-R65037 <r65037@freescale.com>, shawn.guo@linaro.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

ADDENDUM:

>> I tried to increase max_blk_count and it breaks after a few tests.
>
> I will redo your tests in a jiffy, however the latency issues worry
> me a wee bit.

Increasing max_blk_count did not help really, however I am not sure if 
setting it unconditionally to 65535 was the only change I had to make.

> So, what's keeping the driver 8ms from sending the data??? Any
> pointers on where I could twiddle some bits in the driver? Where do I
> start looking?

Using the following setup, I tried to get some more information:

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c 
b/drivers/mmc/host/sdhci-esdhc-imx.c
index 0be4e20..4896f24 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -467,8 +467,7 @@ static int __devinit sdhci_esdhc_imx_probe(struct 
platform_device *pdev)
         clk_enable(clk);
         pltfm_host->clk = clk;

-       if (!is_imx25_esdhc(imx_data))
-               host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
+       host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;

         if (is_imx25_esdhc(imx_data) || is_imx35_esdhc(imx_data))
                 /* Fix errata ENGcm07207 present on i.MX25 and i.MX35 
*/
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 8d66706..0b60d14 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -713,6 +713,8 @@ static void sdhci_prepare_data(struct sdhci_host 
*host, struct mmc_command *cmd)
                 sdhci_writeb(host, count, SDHCI_TIMEOUT_CONTROL);
         }

+       sdhci_dumpregs(host);
+
         if (!data)
                 return;

echo 'file core.c line 193 +p' > 
/sys/kernel/debug/dynamic_debug/control
echo 'file core.c line 158 +p' > 
/sys/kernel/debug/dynamic_debug/control
echo 'file sdhci.c line 72-115 +p' > 
/sys/kernel/debug/dynamic_debug/control
mount /media/card
dd if=/dev/urandom of=/media/card/file-4K bs=4K count=1

[  119.895460] mmc0: starting CMD24 arg 00045e00 flags 000000b5
[  119.895531] sdhci: =========== REGISTER DUMP (mmc0)===========
[  119.895570] sdhci: Sys addr: 0x82480000 | Version:  0x00000000
[  119.895602] sdhci: Blk size: 0x00000200 | Blk cnt:  0x00000000
[  119.895633] sdhci: Argument: 0x00049c00 | Trn mode: 0x00000013
[  119.895664] sdhci: Present:  0xff880000 | Host ctl: 0x00000023
[  119.895693] sdhci: Power:    0x00000000 | Blk gap:  0x00000000
[  119.895724] sdhci: Wake-up:  0x00000000 | Clock:    0x00000107
[  119.895754] sdhci: Timeout:  0x0000000e | Int stat: 0x00000000
[  119.895787] sdhci: Int enab: 0x107f000b | Sig enab: 0x107f000b
[  119.895819] sdhci: AC12 err: 0x00000000 | Slot int: 0x00001001
[  119.895852] sdhci: Caps:     0x07eb0000 | Caps_1:   0x04100410
[  119.895883] sdhci: Cmd:      0x0000113a | Max curr: 0x00000000
[  119.895911] sdhci: Host ctl2: 0x00000000
[  119.895936] sdhci: ===========================================
[  119.900527] mmc0: starting CMD13 arg 00020000 flags 00000195
[  119.900585] sdhci: =========== REGISTER DUMP (mmc0)===========
[  119.900624] sdhci: Sys addr: 0x82452400 | Version:  0x00000000
[  119.900655] sdhci: Blk size: 0x00000200 | Blk cnt:  0x00000000
[  119.900687] sdhci: Argument: 0x00045e00 | Trn mode: 0x00000003
[  119.900718] sdhci: Present:  0xff880000 | Host ctl: 0x00000023
[  119.900746] sdhci: Power:    0x00000000 | Blk gap:  0x00000000
[  119.900776] sdhci: Wake-up:  0x00000000 | Clock:    0x00000107
[  119.900807] sdhci: Timeout:  0x0000000e | Int stat: 0x00000000
[  119.900840] sdhci: Int enab: 0x107f000b | Sig enab: 0x107f000b
[  119.900869] sdhci: AC12 err: 0x00000000 | Slot int: 0x00001001
[  119.900902] sdhci: Caps:     0x07eb0000 | Caps_1:   0x04100410
[  119.900933] sdhci: Cmd:      0x0000183a | Max curr: 0x00000000
[  119.900962] sdhci: Host ctl2: 0x00000000
[  119.900985] sdhci: ===========================================
[  119.901357] mmc0: starting CMD17 arg 00009000 flags 000000b5
[  119.901419] sdhci: =========== REGISTER DUMP (mmc0)===========
[  119.901458] sdhci: Sys addr: 0x82452400 | Version:  0x00000000
[  119.901490] sdhci: Blk size: 0x00000200 | Blk cnt:  0x00000000
[  119.901520] sdhci: Argument: 0x00020000 | Trn mode: 0x00000003
[  119.901551] sdhci: Present:  0xff880000 | Host ctl: 0x00000023
[  119.901579] sdhci: Power:    0x00000000 | Blk gap:  0x00000000
[  119.901610] sdhci: Wake-up:  0x00000000 | Clock:    0x00000107
[  119.901641] sdhci: Timeout:  0x0000000e | Int stat: 0x00000000
[  119.901673] sdhci: Int enab: 0x107f000b | Sig enab: 0x107f000b
[  119.901703] sdhci: AC12 err: 0x00000000 | Slot int: 0x00001001
[  119.901735] sdhci: Caps:     0x07eb0000 | Caps_1:   0x04100410
[  119.901765] sdhci: Cmd:      0x00000d1a | Max curr: 0x00000000
[  119.901793] sdhci: Host ctl2: 0x00000000
[  119.901816] sdhci: ===========================================
[  119.908072] mmc0: starting CMD17 arg 00009200 flags 000000b5
[  119.908141] sdhci: =========== REGISTER DUMP (mmc0)===========
[  119.908179] sdhci: Sys addr: 0x82480000 | Version:  0x00000000
[  119.908212] sdhci: Blk size: 0x00000200 | Blk cnt:  0x00000000
[  119.908243] sdhci: Argument: 0x00009000 | Trn mode: 0x00000013
[  119.908274] sdhci: Present:  0xff880000 | Host ctl: 0x00000023
[  119.908304] sdhci: Power:    0x00000000 | Blk gap:  0x00000000
[  119.908335] sdhci: Wake-up:  0x00000000 | Clock:    0x00000107
[  119.908367] sdhci: Timeout:  0x0000000e | Int stat: 0x00000000
[  119.908400] sdhci: Int enab: 0x107f000b | Sig enab: 0x107f000b
[  119.908432] sdhci: AC12 err: 0x00000000 | Slot int: 0x00001001
[  119.908464] sdhci: Caps:     0x07eb0000 | Caps_1:   0x04100410
[  119.908495] sdhci: Cmd:      0x0000113a | Max curr: 0x00000000
[  119.908524] sdhci: Host ctl2: 0x00000000
[  119.908547] sdhci: ===========================================
[  119.910858] mmc0: starting CMD17 arg 00009400 flags 000000b5
[  119.910929] sdhci: =========== REGISTER DUMP (mmc0)===========
[  119.910969] sdhci: Sys addr: 0x82480000 | Version:  0x00000000
[  119.911002] sdhci: Blk size: 0x00000200 | Blk cnt:  0x00000000
[  119.911034] sdhci: Argument: 0x00009200 | Trn mode: 0x00000013
[  119.911065] sdhci: Present:  0xff880000 | Host ctl: 0x00000023
[  119.911095] sdhci: Power:    0x00000000 | Blk gap:  0x00000000
[  119.911126] sdhci: Wake-up:  0x00000000 | Clock:    0x00000107
[  119.911157] sdhci: Timeout:  0x0000000e | Int stat: 0x00000000
[  119.911191] sdhci: Int enab: 0x107f000b | Sig enab: 0x107f000b
[  119.911223] sdhci: AC12 err: 0x00000000 | Slot int: 0x00001001
[  119.911255] sdhci: Caps:     0x07eb0000 | Caps_1:   0x04100410
[  119.911286] sdhci: Cmd:      0x0000113a | Max curr: 0x00000000
[  119.911314] sdhci: Host ctl2: 0x00000000
[  119.911338] sdhci: ===========================================
[  119.913935] mmc0: starting CMD24 arg 00009000 flags 000000b5
[  119.914004] sdhci: =========== REGISTER DUMP (mmc0)===========
[  119.914042] sdhci: Sys addr: 0x82480000 | Version:  0x00000000
[  119.914073] sdhci: Blk size: 0x00000200 | Blk cnt:  0x00000000
[  119.914105] sdhci: Argument: 0x00009400 | Trn mode: 0x00000013
[  119.914135] sdhci: Present:  0xff880000 | Host ctl: 0x00000023
[  119.914164] sdhci: Power:    0x00000000 | Blk gap:  0x00000000
[  119.914194] sdhci: Wake-up:  0x00000000 | Clock:    0x00000107
[  119.914224] sdhci: Timeout:  0x0000000e | Int stat: 0x00000000
[  119.914257] sdhci: Int enab: 0x107f000b | Sig enab: 0x107f000b
[  119.914288] sdhci: AC12 err: 0x00000000 | Slot int: 0x00001001
[  119.914321] sdhci: Caps:     0x07eb0000 | Caps_1:   0x04100410
[  119.914352] sdhci: Cmd:      0x0000113a | Max curr: 0x00000000
[  119.914380] sdhci: Host ctl2: 0x00000000
[  119.914404] sdhci: ===========================================
[  119.921304] mmc0: starting CMD13 arg 00020000 flags 00000195
[  119.921368] sdhci: =========== REGISTER DUMP (mmc0)===========
[  119.921407] sdhci: Sys addr: 0x82403600 | Version:  0x00000000
[  119.921440] sdhci: Blk size: 0x00000200 | Blk cnt:  0x00000000
[  119.921472] sdhci: Argument: 0x00009000 | Trn mode: 0x00000003
[  119.921503] sdhci: Present:  0xff880000 | Host ctl: 0x00000023
[  119.921532] sdhci: Power:    0x00000000 | Blk gap:  0x00000000
[  119.921564] sdhci: Wake-up:  0x00000000 | Clock:    0x00000107
[  119.921594] sdhci: Timeout:  0x0000000e | Int stat: 0x00000000
[  119.921626] sdhci: Int enab: 0x107f000b | Sig enab: 0x107f000b
[  119.921658] sdhci: AC12 err: 0x00000000 | Slot int: 0x00001001
[  119.921689] sdhci: Caps:     0x07eb0000 | Caps_1:   0x04100410
[  119.921720] sdhci: Cmd:      0x0000183a | Max curr: 0x00000000
[  119.921747] sdhci: Host ctl2: 0x00000000
[  119.921770] sdhci: ===========================================
[  119.921889] mmc0: starting CMD24 arg 00009200 flags 000000b5
[  119.921941] sdhci: =========== REGISTER DUMP (mmc0)===========
[  119.921976] sdhci: Sys addr: 0x82403600 | Version:  0x00000000
[  119.922007] sdhci: Blk size: 0x00000200 | Blk cnt:  0x00000000
[  119.922038] sdhci: Argument: 0x00020000 | Trn mode: 0x00000003
[  119.922070] sdhci: Present:  0xff880000 | Host ctl: 0x00000023
[  119.922098] sdhci: Power:    0x00000000 | Blk gap:  0x00000000
[  119.922129] sdhci: Wake-up:  0x00000000 | Clock:    0x00000107
[  119.922161] sdhci: Timeout:  0x0000000e | Int stat: 0x00000000
[  119.922193] sdhci: Int enab: 0x107f000b | Sig enab: 0x107f000b
[  119.922223] sdhci: AC12 err: 0x00000000 | Slot int: 0x00001001
[  119.922256] sdhci: Caps:     0x07eb0000 | Caps_1:   0x04100410
[  119.922287] sdhci: Cmd:      0x00000d1a | Max curr: 0x00000000
[  119.922315] sdhci: Host ctl2: 0x00000000
[  119.922338] sdhci: ===========================================
[  119.927417] mmc0: starting CMD13 arg 00020000 flags 00000195
[  119.927481] sdhci: =========== REGISTER DUMP (mmc0)===========
[  119.927523] sdhci: Sys addr: 0x82403800 | Version:  0x00000000
[  119.927554] sdhci: Blk size: 0x00000200 | Blk cnt:  0x00000000
[  119.927586] sdhci: Argument: 0x00009200 | Trn mode: 0x00000003
[  119.927616] sdhci: Present:  0xff880000 | Host ctl: 0x00000023
[  119.927645] sdhci: Power:    0x00000000 | Blk gap:  0x00000000
[  119.927675] sdhci: Wake-up:  0x00000000 | Clock:    0x00000107
[  119.927707] sdhci: Timeout:  0x0000000e | Int stat: 0x00000000
[  119.927740] sdhci: Int enab: 0x107f000b | Sig enab: 0x107f000b
[  119.927772] sdhci: AC12 err: 0x00000000 | Slot int: 0x00001001
[  119.927804] sdhci: Caps:     0x07eb0000 | Caps_1:   0x04100410
[  119.927835] sdhci: Cmd:      0x0000183a | Max curr: 0x00000000
[  119.927864] sdhci: Host ctl2: 0x00000000

[CMD24/CMD13 changes go on like this ...]

Anybody with more insights? Why is the interval between two CMD24 more 
or less in the range of 6ms and the CMD13 follows in varying intervals 
between 1ms to 4ms? What's keeping the driver from bursting CMD24 and 
successive CMD13 requests?

Thanks and best regards
-- 
Joan C. Abelaira
