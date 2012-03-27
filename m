From: joancarles <joancarles@fqingenieria.es>
Subject: RE: [MX25][MMC] mmc esdhc failure in 3.3
Date: Tue, 27 Mar 2012 09:59:48 +0200
Message-ID: <e96253f3ad8c336db8ff86c3b9ab57e1@mail.fqingenieria.es>
References: <5e57eb999780335721212bb8d411406f@mail.fqingenieria.es>
 <20120312132423.GC2459@pengutronix.de>
 <9018463dfcd3c9e9a311aeed42b758bf@mail.fqingenieria.es>
 <0E83723C55F66F43A6041464FE31119D099A34@039-SN2MPN1-011.039d.mgd.msft.net>
 <a06e68c3687c7390e15950bc20831fd4@mail.fqingenieria.es>
 <85b807b77d73328485781d6fa1568e46@mail.fqingenieria.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from llsa731-a03.servidoresdns.net ([82.223.190.25]:56211 "EHLO
	llsa731-a03.servidoresdns.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753772Ab2C0H74 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Mar 2012 03:59:56 -0400
In-Reply-To: <85b807b77d73328485781d6fa1568e46@mail.fqingenieria.es>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: joancarles <joancarles@fqingenieria.es>
Cc: Zhu Richard-R65037 <r65037@freescale.com>, Wolfram Sang <w.sang@pengutronix.de>, linux-mmc@vger.kernel.org, shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org

ADDENDUM:

On Tue, 27 Mar 2012 09:32:36 +0200, joancarles wrote:
> G'day
>
> This is still present, and we have absolutely no idea where to
> continue searching for the solution of the problem. Any pointers? Any
> git trees of mmc driver changes we could try? Anybody else with a 
> MX25
> that has this issue?

Enabling CONFIG_MMC_CLKGATE, I have managed to create an oops simply be 
trying to remove a file:

[  192.821592] mmcblk0: error -110 transferring data, sector 559, nr 1, 
cmd response 0x900, card status 0x0
[  192.846928] mmc0: starting CMD55 arg 00020000 flags 00000095
[  192.846991] mmc0: clock 50000000Hz busmode 2 powermode 2 cs 0 Vdd 17 
width 2 timing 2
[  192.847048] sdhci-esdhc-imx sdhci-esdhc-imx25.0: desired SD clock: 
50000000, actual: 33250000
[  192.848090] mmc0: ungated MCI clock
[  192.848159] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[  192.848221] mmc0: req done (CMD55): 0: 00000920 00000000 00000000 
00000000
[  192.848353] mmc0: clock 0Hz busmode 2 powermode 2 cs 0 Vdd 17 width 
2 timing 2
[  192.848400] mmc0: gated MCI clock
[  192.848458] Division by zero in kernel.
[  192.852384] [<c00141f0>] (unwind_backtrace+0x0/0x130) from 
[<c01c0bb4>] (Ldiv0+0x8/0x10)
[  192.867389] [<c01c0bb4>] (Ldiv0+0x8/0x10) from [<c029b288>] 
(mmc_sd_num_wr_blocks+0x148/0x230)
[  192.876924] [<c029b288>] (mmc_sd_num_wr_blocks+0x148/0x230) from 
[<c029c900>] (mmc_blk_issue_rw_rq+0x3fc/0x4ac)
[  192.887944] [<c029c900>] (mmc_blk_issue_rw_rq+0x3fc/0x4ac) from 
[<c029cbe8>] (mmc_blk_issue_rq+0x238/0x514)
[  192.898606] [<c029cbe8>] (mmc_blk_issue_rq+0x238/0x514) from 
[<c029d3b8>] (mmc_queue_thread+0x58/0x144)
[  192.908879] [<c029d3b8>] (mmc_queue_thread+0x58/0x144) from 
[<c0038b44>] (kthread+0x84/0x90)
[  192.918477] [<c0038b44>] (kthread+0x84/0x90) from [<c000f9a0>] 
(kernel_thread_exit+0x0/0x8)
[  192.927654] mmc0: starting CMD22 arg 00000000 flags 000000b5
[  192.927700] mmc0:     blksz 4 blocks 1 flags 00000200 tsac 100 ms 
nsac 0
[  192.927752] mmc0: clock 50000000Hz busmode 2 powermode 2 cs 0 Vdd 17 
width 2 timing 2
[  192.927810] sdhci-esdhc-imx sdhci-esdhc-imx25.0: desired SD clock: 
50000000, actual: 33250000
[  192.928852] mmc0: ungated MCI clock
[  192.928940] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[  192.928991] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x0000000a
[  192.929031] sdhci [sdhci_data_irq()]: mmc0: DMA base 0x839a3040, 
transferred 0x05cfc0 bytes, next 0x83a00000
[  192.929094] mmc0: req done (CMD22): 0: 00000920 00000000 00000000 
00000000
[  192.929126] mmc0:     4 bytes transferred: 0
[  192.929242] mmc0: clock 0Hz busmode 2 powermode 2 cs 0 Vdd 17 width 
2 timing 2
[  192.929288] mmc0: gated MCI clock

Maybe this helps. The file, in fact, has been removed, as far as I can 
see. Also, how come, the actual clock differs so much from the desired 
clock of 50MHz? As commented before, we do actually see the 33.25MHz 
clock in the oscilloscope.

Best regards
-- 
Joan C. Abelaira

