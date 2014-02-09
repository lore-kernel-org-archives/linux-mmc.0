From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: UHS-1 cards with iMX6Q
Date: Sun, 9 Feb 2014 15:14:41 +0000
Message-ID: <20140209151441.GM26684@n2100.arm.linux.org.uk>
References: <20140207152951.GB26684@n2100.arm.linux.org.uk> <20140207155920.GA10195@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:58780 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751434AbaBIPOy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 9 Feb 2014 10:14:54 -0500
Content-Disposition: inline
In-Reply-To: <20140207155920.GA10195@S2101-09.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>, Dong Aisheng <b29396@freescale.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

Okay, I have this working now - there was a hardware problem.  However,
it's obvious that this has never been tested with lockdep enabled beacuse
of the following:

        disable_irq(host->irq);
        spin_lock(&host->lock);
        host->mrq = &mrq;
 
        sdhci_send_command(host, mrq.cmd);
        
        spin_unlock(&host->lock);  
        enable_irq(host->irq);

You can't "work around" stuff like this.  Use spin_lock_irq()..
spin_unlock_irq().  You can't just disable the interrupt line and
expect lockdep to know that it's safe.

[    2.290584] =================================
[    2.308140] [ INFO: inconsistent lock state ]
[    2.308146] 3.14.0-rc1+ #490 Not tainted
[    2.308148] ---------------------------------
[    2.308152] inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
[    2.308158] kworker/u8:0/6 [HC0[0]:SC0[0]:HE1:SE1] takes:
[    2.308191]  (&(&host->lock)->rlock#2){?.-...}, at: [<c04b57a4>] esdhc_send_tuning_cmd+0x104/0x14c
[    2.308193] {IN-HARDIRQ-W} state was registered at:
[    2.308215]   [<c00652fc>] mark_lock+0x15c/0x6f8
[    2.308224]   [<c0066354>] __lock_acquire+0xabc/0x1ca0
[    2.308231]   [<c0067ad8>] lock_acquire+0xa0/0x130
[    2.308251]   [<c0697a44>] _raw_spin_lock+0x34/0x44
[    2.308258]   [<c04b0dbc>] sdhci_irq+0x20/0xa40
[    2.308272]   [<c0071b1c>] handle_irq_event_percpu+0x74/0x284
[    2.308278]   [<c0071d70>] handle_irq_event+0x44/0x64
[    2.308289]   [<c0074db8>] handle_fasteoi_irq+0xac/0x140
[    2.308296]   [<c007147c>] generic_handle_irq+0x28/0x38
[    2.308311]   [<c000efd4>] handle_IRQ+0x40/0x98
[    2.308317]   [<c0008584>] gic_handle_irq+0x30/0x64
[    2.308324]   [<c0013144>] __irq_svc+0x44/0x58
[    2.308336]   [<c0028fc8>] irq_exit+0xc0/0x120
[    2.308343]   [<c000efd8>] handle_IRQ+0x44/0x98
[    2.308349]   [<c0008584>] gic_handle_irq+0x30/0x64
[    2.308355]   [<c0013144>] __irq_svc+0x44/0x58
[    2.308363]   [<c068f398>] printk+0x3c/0x44
[    2.308378]   [<c03191d0>] _regulator_get+0x1b4/0x1e0
[    2.308385]   [<c031924c>] regulator_get+0x18/0x1c
[    2.308397]   [<c049fbc4>] mmc_add_host+0x30/0x1c0
[    2.308404]   [<c04b2e10>] sdhci_add_host+0x804/0xbbc
[    2.308411]   [<c04b5318>] sdhci_esdhc_imx_probe+0x380/0x674
[    2.308427]   [<c036d530>] platform_drv_probe+0x20/0x50
[    2.308435]   [<c036b948>] driver_probe_device+0x120/0x234
[    2.308441]   [<c036baf8>] __driver_attach+0x9c/0xa0
[    2.308448]   [<c036a04c>] bus_for_each_dev+0x5c/0x90
[    2.308455]   [<c036b418>] driver_attach+0x24/0x28
[    2.308462]   [<c036b018>] bus_add_driver+0xe4/0x1d8
[    2.308468]   [<c036c1b0>] driver_register+0x80/0xfc
[    2.308477]   [<c036ce28>] __platform_driver_register+0x50/0x64
[    2.308497]   [<c093706c>] sdhci_esdhc_imx_driver_init+0x18/0x20
[    2.308504]   [<c0008834>] do_one_initcall+0x3c/0x164
[    2.308519]   [<c0901c94>] kernel_init_freeable+0x104/0x1d0
[    2.308537]   [<c068c45c>] kernel_init+0x10/0x118
[    2.308546]   [<c000e768>] ret_from_fork+0x14/0x2c
[    2.308549] irq event stamp: 5933
[    2.308560] hardirqs last  enabled at (5933): [<c069813c>] _raw_spin_unlock_irqrestore+0x38/0x4c
[    2.308569] hardirqs last disabled at (5932): [<c0697b04>] _raw_spin_lock_irqsave+0x24/0x60
[    2.308577] softirqs last  enabled at (5914): [<c0028ba0>] __do_softirq+0x260/0x360
[    2.308584] softirqs last disabled at (5909): [<c0028fc8>] irq_exit+0xc0/0x120
[    2.308586] 
[    2.308586] other info that might help us debug this:
[    2.308588]  Possible unsafe locking scenario:
[    2.308588] 
[    2.308590]        CPU0
[    2.308592]        ----
[    2.308598]   lock(&(&host->lock)->rlock#2);
[    2.308600]   <Interrupt>
[    2.308606]     lock(&(&host->lock)->rlock#2);
[    2.308607] 
[    2.308607]  *** DEADLOCK ***
[    2.308607] 
[    2.308611] 2 locks held by kworker/u8:0/6:
[    2.308626]  #0:  (kmmcd){.+.+.+}, at: [<c003d890>] process_one_work+0x134/0x4e8
[    2.308638]  #1:  ((&(&host->detect)->work)){+.+.+.}, at: [<c003d890>] process_one_work+0x134/0x4e8
[    2.308640] 
[    2.308640] stack backtrace:
[    2.308649] CPU: 2 PID: 6 Comm: kworker/u8:0 Not tainted 3.14.0-rc1+ #490
[    2.308659] Workqueue: kmmcd mmc_rescan
[    2.308663] Backtrace: 
[    2.308679] [<c00124a0>] (dump_backtrace) from [<c0012640>] (show_stack+0x18/0x1c)
[    2.308689]  r6:ea07b3e0 r5:ea07af80 r4:00000000 r3:ea07af80
[    2.308699] [<c0012628>] (show_stack) from [<c069164c>] (dump_stack+0x70/0x8c)
[    2.308707] [<c06915dc>] (dump_stack) from [<c068f080>] (print_usage_bug+0x274/0x2e4)
[    2.308713]  r4:c0a8a2c0 r3:ea07af80
[    2.308723] [<c068ee0c>] (print_usage_bug) from [<c0065774>] (mark_lock+0x5d4/0x6f8)
[    2.308736]  r10:ea07af80 r8:ea07af80 r7:00000000 r6:c0a8a2c0 r5:ea07b3e0 r4:00000002
[    2.308745] [<c00651a0>] (mark_lock) from [<c0065e6c>] (__lock_acquire+0x5d4/0x1ca0)
[    2.308758]  r10:ea07af80 r9:00000000 r8:ea07b3e0 r7:e988cd28 r6:00000002 r5:00000460
[    2.308762]  r4:ea07af80
[    2.308770] [<c0065898>] (__lock_acquire) from [<c0067ad8>] (lock_acquire+0xa0/0x130)
[    2.308783]  r10:00000000 r9:00000002 r8:00000000 r7:00000000 r6:e988cd28 r5:ea094000
[    2.308787]  r4:00000000
[    2.308797] [<c0067a38>] (lock_acquire) from [<c0697a44>] (_raw_spin_lock+0x34/0x44)
[    2.308809]  r10:00000006 r9:00000002 r8:00000035 r7:e988cd18 r6:ea095bf8 r5:00000002
[    2.308813]  r4:e988cd18
[    2.308823] [<c0697a10>] (_raw_spin_lock) from [<c04b57a4>] (esdhc_send_tuning_cmd+0x104/0x14c)
[    2.308829]  r5:e988cc40 r4:00000000
[    2.308838] [<c04b56a0>] (esdhc_send_tuning_cmd) from [<c04b582c>] (esdhc_executing_tuning+0x40/0x100)
[    2.308849]  r8:e9878800 r7:00000013 r6:e988cd18 r5:e988cc40 r4:00000000
[    2.308858] [<c04b57ec>] (esdhc_executing_tuning) from [<c04afa54>] (sdhci_execute_tuning+0xcc/0x754)
[    2.308867]  r7:00000000 r6:e988cd18 r5:00000000 r4:e988c800
[    2.308879] [<c04af988>] (sdhci_execute_tuning) from [<c04a4684>] (mmc_sd_init_card+0x65c/0x694)
[    2.308891]  r10:00000006 r9:00000002 r8:e9878800 r7:00000000 r6:e982e700 r5:00000000
[    2.308895]  r4:e988c800
[    2.308903] [<c04a4028>] (mmc_sd_init_card) from [<c04a48f0>] (mmc_attach_sd+0xb0/0x184)
[    2.308915]  r10:ea094000 r8:00000000 r7:c0703e20 r6:e988c800 r5:00000000 r4:e988c800
[    2.308923] [<c04a4840>] (mmc_attach_sd) from [<c049eb28>] (mmc_rescan+0x26c/0x2e8)
[    2.308929]  r5:c0703e14 r4:e988cb08
[    2.308936] [<c049e8bc>] (mmc_rescan) from [<c003d914>] (process_one_work+0x1b8/0x4e8)
[    2.308946]  r7:ea190200 r6:ea00dc00 r5:ea02d980 r4:e988cb08
[    2.308953] [<c003d75c>] (process_one_work) from [<c003e090>] (worker_thread+0x13c/0x3f8)
[    2.308965]  r10:ea094000 r9:00000089 r8:ea02d998 r7:ea094000 r6:ea00dc30 r5:ea00dc00
[    2.308969]  r4:ea02d980
[    2.308984] [<c003df54>] (worker_thread) from [<c00449bc>] (kthread+0xcc/0xe8)
[    2.308996]  r10:00000000 r9:00000000 r8:00000000 r7:c003df54 r6:ea02d980 r5:ea040700
[    2.309000]  r4:00000000
[    2.309010] [<c00448f0>] (kthread) from [<c000e768>] (ret_from_fork+0x14/0x2c)
[    2.309020]  r7:00000000 r6:00000000 r5:c00448f0 r4:ea040700


-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
