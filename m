From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH v2 1/7] mmc: mxs-mmc: add mmc host driver for i.MX23/28
Date: Mon, 14 Feb 2011 17:59:58 +0100
Message-ID: <20110214165958.GH10709@pengutronix.de>
References: <1297650746-12841-1-git-send-email-shawn.guo@freescale.com>
 <1297650746-12841-2-git-send-email-shawn.guo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48170 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752436Ab1BNRAD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Feb 2011 12:00:03 -0500
Content-Disposition: inline
In-Reply-To: <1297650746-12841-2-git-send-email-shawn.guo@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: cjb@laptop.org, s.hauer@pengutronix.de, arnd@arndb.de, LW@KARO-electronics.de, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, Feb 14, 2011 at 10:32:20AM +0800, Shawn Guo wrote:
> This adds the mmc host driver for Freescale MXS-based SoC i.MX23/28.
> The driver calls into mxs-dma via generic dmaengine api for both pio
> and data transfer.
> 
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>

While trying, I got this lockdep-warning and BUG. It might be that my setup is
wrong, causing all these timeouts. But they probably are meant to be handled
more gracefully? I can continue testing tomorrow, maybe this report already
helps identifying a problem?

[    1.000000] mxs-mmc mxs-mmc.0: initialized
[    1.000000] mmc0: mmc_rescan_try_freq: trying to init card at 400000 Hz
[    1.010000] mmc0: clock 0Hz busmode 1 powermode 1 cs 0 Vdd 21 width 0 timing 0
[    1.030000] TCP cubic registered
[    1.030000] NET: Registered protocol family 17
[    1.030000] Registering the dns_resolver key type
[    1.040000] mmc0: clock 400000Hz busmode 1 powermode 2 cs 0 Vdd 21 width 0 timing 0
[    1.050000] mxs-mmc mxs-mmc.0: mxs_mmc_set_clk_rate: div1 2, div2 72, ssp 57600000, bit 400000, rate 400000
[    1.060000] registered taskstats version 1
[    1.070000] i2c i2c-0: master_xfer[0] W, addr=0x68, len=1
[    1.070000] i2c i2c-0: master_xfer[1] R, addr=0x68, len=7
[    1.080000] mmc0: starting CMD52 arg 00000c00 flags 00000195
[    1.080000] mmc0: req done (CMD52): -110: 00000000 00000000 00000000 00000000
[    1.090000] mmc0: starting CMD52 arg 80000c08 flags 00000195
[    1.100000] mmc0: req done (CMD52): -110: 00000000 00000000 00000000 00000000
[    1.110000] mmc0: clock 400000Hz busmode 1 powermode 2 cs 1 Vdd 21 width 0 timing 0
[    1.110000] mxs-mmc mxs-mmc.0: mxs_mmc_set_clk_rate: div1 2, div2 72, ssp 57600000, bit 400000, rate 400000
[    1.120000] rtc-ds1307 0-0068: setting system clock to 2000-01-01 00:00:06 UTC (946684806)
[    1.130000] mmc0: starting CMD0 arg 00000000 flags 000000c0
[    1.140000] mmc0: req done (CMD0): 0: 00000000 00000000 00000000 00000000
[    1.150000] mmc0: clock 400000Hz busmode 1 powermode 2 cs 0 Vdd 21 width 0 timing 0
[    1.150000] mxs-mmc mxs-mmc.0: mxs_mmc_set_clk_rate: div1 2, div2 72, ssp 57600000, bit 400000, rate 400000
[    1.170000] mmc0: starting CMD8 arg 000001aa flags 000002f5
[    1.170000] mmc0: req done (CMD8): -110: 00000000 00000000 00000000 00000000
[    1.180000] mmc0: starting CMD5 arg 00000000 flags 000002e1
[    1.180000] mmc0: req failed (CMD5): -110, retrying...
[    1.180000] 
[    1.180000] =============================================
[    1.180000] [ INFO: possible recursive locking detected ]
[    1.180000] 2.6.38-rc2-00375-gb26872a #134
[    1.180000] ---------------------------------------------
[    1.180000] swapper/0 is trying to acquire lock:
[    1.180000]  (&(&mxs_chan->lock)->rlock){..-...}, at: [<c01fd704>] mxs_dma_tx_submit+0x24/0xf0
[    1.180000] 
[    1.180000] but task is already holding lock:
[    1.180000]  (&(&mxs_chan->lock)->rlock){..-...}, at: [<c01fd7f4>] mxs_dma_tasklet+0x24/0x5c
[    1.180000] 
[    1.180000] other info that might help us debug this:
[    1.180000] 1 lock held by swapper/0:
[    1.180000]  #0:  (&(&mxs_chan->lock)->rlock){..-...}, at: [<c01fd7f4>] mxs_dma_tasklet+0x24/0x5c
[    1.180000] 
[    1.180000] stack backtrace:
[    1.180000] Backtrace: 
[    1.180000] [<c0039cd4>] (dump_backtrace+0x0/0x110) from [<c02a31ec>] (dump_stack+0x1c/0x20)
[    1.180000]  r7:00000000 r6:c0378fb8 r5:c0378fd0 r4:c0378cb0
[    1.180000] [<c02a31d0>] (dump_stack+0x0/0x20) from [<c007ecfc>] (print_deadlock_bug+0xa4/0xd0)
[    1.180000] [<c007ec58>] (print_deadlock_bug+0x0/0xd0) from [<c007ee9c>] (check_deadlock+0x174/0x1ac)
[    1.180000]  r6:c0378cb0 r5:c053783c r4:80000093
[    1.180000] [<c007ed28>] (check_deadlock+0x0/0x1ac) from [<c00804c8>] (validate_chain+0x480/0x6b4)
[    1.180000] [<c0080048>] (validate_chain+0x0/0x6b4) from [<c0080f44>] (__lock_acquire+0x848/0x924)
[    1.180000] [<c00806fc>] (__lock_acquire+0x0/0x924) from [<c0081104>] (lock_acquire+0xe4/0x104)
[    1.180000] [<c0081020>] (lock_acquire+0x0/0x104) from [<c02a5f40>] (_raw_spin_lock_irqsave+0x50/0x64)
[    1.180000] [<c02a5ef0>] (_raw_spin_lock_irqsave+0x0/0x64) from [<c01fd704>] (mxs_dma_tx_submit+0x24/0xf0)
[    1.180000]  r7:c78190dc r6:c798fe14 r5:c798fe14 r4:c7819084
[    1.180000] [<c01fd6e0>] (mxs_dma_tx_submit+0x0/0xf0) from [<c02092d4>] (mxs_mmc_ac+0x90/0xb4)
[    1.180000]  r8:c03a7120 r7:c037cc98 r6:c798fe14 r5:c798fe14 r4:c79972e0
[    1.180000] [<c0209244>] (mxs_mmc_ac+0x0/0xb4) from [<c0209640>] (mxs_mmc_start_cmd+0xb0/0xec)
[    1.180000]  r4:c79972e0
[    1.180000] [<c0209590>] (mxs_mmc_start_cmd+0x0/0xec) from [<c02096bc>] (mxs_mmc_request+0x40/0x4c)
[    1.180000]  r4:c79972e0
[    1.180000] [<c020967c>] (mxs_mmc_request+0x0/0x4c) from [<c01fe700>] (mmc_request_done+0x9c/0x18c)
[    1.180000]  r5:c7997000 r4:c798fe48
[    1.180000] [<c01fe664>] (mmc_request_done+0x0/0x18c) from [<c0209828>] (mxs_mmc_request_done+0x160/0x16c)
[    1.180000]  r6:c798fe14 r5:00000000 r4:c79972e0
[    1.180000] [<c02096c8>] (mxs_mmc_request_done+0x0/0x16c) from [<c0209848>] (mxs_mmc_dma_irq_callback+0x14/0x18)
[    1.180000]  r6:20000013 r5:c78190dc r4:c7819080
[    1.180000] [<c0209834>] (mxs_mmc_dma_irq_callback+0x0/0x18) from [<c01fd80c>] (mxs_dma_tasklet+0x3c/0x5c)
[    1.180000] [<c01fd7d0>] (mxs_dma_tasklet+0x0/0x5c) from [<c0052ea8>] (tasklet_action+0xac/0x148)
[    1.180000]  r6:c03cb340 r5:c78190c8 r4:00000000
[    1.180000] [<c0052dfc>] (tasklet_action+0x0/0x148) from [<c00536d0>] (__do_softirq+0xe0/0x204)
[    1.180000] [<c00535f0>] (__do_softirq+0x0/0x204) from [<c005384c>] (irq_exit+0x58/0xa0)
[    1.180000] [<c00537f4>] (irq_exit+0x0/0xa0) from [<c002f084>] (asm_do_IRQ+0x84/0xa4)
[    1.180000] [<c002f000>] (asm_do_IRQ+0x0/0xa4) from [<c0035ad8>] (__irq_svc+0x38/0x80)
[    1.180000] Exception stack(0xc0375f20 to 0xc0375f68)
[    1.180000] 5f20: 00000001 00000004 0005217f 20000013 c0374000 c037a210 c03aa768 00000002
[    1.180000] 5f40: 4001ee3c 41069265 4001ee08 c0375f74 c0375f38 c0375f68 c007ea54 c0037164
[    1.180000] 5f60: 20000013 ffffffff
[    1.180000]  r5:f5000000 r4:ffffffff
[    1.180000] [<c003712c>] (default_idle+0x0/0x3c) from [<c0037750>] (cpu_idle+0x78/0xc8)
[    1.180000] [<c00376d8>] (cpu_idle+0x0/0xc8) from [<c02a1330>] (rest_init+0xb0/0xd8)
[    1.180000]  r6:c037ed58 r5:00000001 r4:00000000
[    1.180000] [<c02a1280>] (rest_init+0x0/0xd8) from [<c0008b54>] (start_kernel+0x264/0x2b8)
[    1.180000]  r7:c037a198 r6:c002025c r5:c03aa6e0 r4:c0376ee8
[    1.180000] [<c00088f0>] (start_kernel+0x0/0x2b8) from [<40008034>] (0x40008034)
[    1.180000]  r6:c0020660 r5:c037602c r4:00053175
[    1.180000] BUG: spinlock lockup on CPU#0, swapper/0, c78190dc
[    1.180000] Backtrace: 
[    1.180000] [<c0039cd4>] (dump_backtrace+0x0/0x110) from [<c02a31ec>] (dump_stack+0x1c/0x20)
[    1.180000]  r7:c0374000 r6:c78190dc r5:00000000 r4:00000000
[    1.180000] [<c02a31d0>] (dump_stack+0x0/0x20) from [<c01bc8a4>] (do_raw_spin_lock+0x118/0x154)
[    1.180000] [<c01bc78c>] (do_raw_spin_lock+0x0/0x154) from [<c02a5f48>] (_raw_spin_lock_irqsave+0x58/0x64)
[    1.180000] [<c02a5ef0>] (_raw_spin_lock_irqsave+0x0/0x64) from [<c01fd704>] (mxs_dma_tx_submit+0x24/0xf0)
[    1.180000]  r7:c78190dc r6:c798fe14 r5:c798fe14 r4:c7819084
[    1.180000] [<c01fd6e0>] (mxs_dma_tx_submit+0x0/0xf0) from [<c02092d4>] (mxs_mmc_ac+0x90/0xb4)
[    1.180000]  r8:c03a7120 r7:c037cc98 r6:c798fe14 r5:c798fe14 r4:c79972e0
[    1.180000] [<c0209244>] (mxs_mmc_ac+0x0/0xb4) from [<c0209640>] (mxs_mmc_start_cmd+0xb0/0xec)
[    1.180000]  r4:c79972e0
[    1.180000] [<c0209590>] (mxs_mmc_start_cmd+0x0/0xec) from [<c02096bc>] (mxs_mmc_request+0x40/0x4c)
[    1.180000]  r4:c79972e0
[    1.180000] [<c020967c>] (mxs_mmc_request+0x0/0x4c) from [<c01fe700>] (mmc_request_done+0x9c/0x18c)
[    1.180000]  r5:c7997000 r4:c798fe48
[    1.180000] [<c01fe664>] (mmc_request_done+0x0/0x18c) from [<c0209828>] (mxs_mmc_request_done+0x160/0x16c)
[    1.180000]  r6:c798fe14 r5:00000000 r4:c79972e0
[    1.180000] [<c02096c8>] (mxs_mmc_request_done+0x0/0x16c) from [<c0209848>] (mxs_mmc_dma_irq_callback+0x14/0x18)
[    1.180000]  r6:20000013 r5:c78190dc r4:c7819080
[    1.180000] [<c0209834>] (mxs_mmc_dma_irq_callback+0x0/0x18) from [<c01fd80c>] (mxs_dma_tasklet+0x3c/0x5c)
[    1.180000] [<c01fd7d0>] (mxs_dma_tasklet+0x0/0x5c) from [<c0052ea8>] (tasklet_action+0xac/0x148)
[    1.180000]  r6:c03cb340 r5:c78190c8 r4:00000000
[    1.180000] [<c0052dfc>] (tasklet_action+0x0/0x148) from [<c00536d0>] (__do_softirq+0xe0/0x204)
[    1.180000] [<c00535f0>] (__do_softirq+0x0/0x204) from [<c005384c>] (irq_exit+0x58/0xa0)
[    1.180000] [<c00537f4>] (irq_exit+0x0/0xa0) from [<c002f084>] (asm_do_IRQ+0x84/0xa4)
[    1.180000] [<c002f000>] (asm_do_IRQ+0x0/0xa4) from [<c0035ad8>] (__irq_svc+0x38/0x80)
[    1.180000] Exception stack(0xc0375f20 to 0xc0375f68)
[    1.180000] 5f20: 00000001 00000004 0005217f 20000013 c0374000 c037a210 c03aa768 00000002
[    1.180000] 5f40: 4001ee3c 41069265 4001ee08 c0375f74 c0375f38 c0375f68 c007ea54 c0037164
[    1.180000] 5f60: 20000013 ffffffff
[    1.180000]  r5:f5000000 r4:ffffffff
[    1.180000] [<c003712c>] (default_idle+0x0/0x3c) from [<c0037750>] (cpu_idle+0x78/0xc8)
[    1.180000] [<c00376d8>] (cpu_idle+0x0/0xc8) from [<c02a1330>] (rest_init+0xb0/0xd8)
[    1.180000]  r6:c037ed58 r5:00000001 r4:00000000
[    1.180000] [<c02a1280>] (rest_init+0x0/0xd8) from [<c0008b54>] (start_kernel+0x264/0x2b8)
[    1.180000]  r7:c037a198 r6:c002025c r5:c03aa6e0 r4:c0376ee8
[    1.180000] [<c00088f0>] (start_kernel+0x0/0x2b8) from [<40008034>] (0x40008034)
[    1.180000]  r6:c0020660 r5:c037602c r4:00053175

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
