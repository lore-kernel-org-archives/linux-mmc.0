From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Huge lockdep warning from sdhci/imx esdhc code
Date: Thu, 16 Jan 2014 11:46:54 +0000
Message-ID: <20140116114654.GU15937@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:38889 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752129AbaAPLrD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Jan 2014 06:47:03 -0500
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

======================================================
[ INFO: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected ]
3.13.0-rc7+ #401 Not tainted
------------------------------------------------------
kworker/u8:1/44 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
 (prepare_lock){+.+.+.}, at: [<c04d10d4>] clk_prepare_lock+0x80/0xf4

and this task is already holding:
 (&(&host->lock)->rlock){-.-...}, at: [<c04b0528>] sdhci_do_set_ios+0x20/0x740
which would create a new lock dependency:
 (&(&host->lock)->rlock){-.-...} -> (prepare_lock){+.+.+.}

but this new dependency connects a HARDIRQ-irq-safe lock:
 (&(&host->lock)->rlock){-.-...}
... which became HARDIRQ-irq-safe at:
  [<c0062e18>] mark_lock+0x15c/0x704
  [<c0063f4c>] __lock_acquire+0xb8c/0x1e14
  [<c00657a0>] lock_acquire+0xa4/0x114
  [<c0687c88>] _raw_spin_lock+0x34/0x44
  [<c04af8f0>] sdhci_irq+0x20/0xa14
  [<c006fc78>] handle_irq_event_percpu+0x68/0x254
  [<c006fea8>] handle_irq_event+0x44/0x64
  [<c0072eac>] handle_fasteoi_irq+0xac/0x180
  [<c006f5d4>] generic_handle_irq+0x28/0x38
  [<c000f294>] handle_IRQ+0x40/0x98
  [<c0008548>] gic_handle_irq+0x30/0x64
  [<c00132c4>] __irq_svc+0x44/0x58
  [<c02f36f4>] pin_get_from_name+0x6c/0x8c
  [<c02f57a8>] pinconf_map_to_setting+0x44/0xb0
  [<c02f3014>] pinctrl_get+0x2fc/0x430
  [<c02f35ac>] devm_pinctrl_get+0x34/0x68
  [<c0384964>] pinctrl_bind_pins+0x38/0xfc
  [<c036bd64>] driver_probe_device+0x74/0x248
  [<c036bfd4>] __driver_attach+0x9c/0xa0
  [<c036a548>] bus_for_each_dev+0x70/0x94
  [<c036ba08>] driver_attach+0x24/0x28
  [<c036b560>] bus_add_driver+0x14c/0x1dc
  [<c036c678>] driver_register+0x80/0xfc
  [<c036d424>] __platform_driver_register+0x50/0x64
  [<c092847c>] sdhci_esdhc_imx_driver_init+0x18/0x20
  [<c0008800>] do_one_initcall+0x38/0x168
  [<c08f5c6c>] kernel_init_freeable+0x104/0x1d0
  [<c06811bc>] kernel_init+0x10/0xec
  [<c000ea48>] ret_from_fork+0x14/0x2c

to a HARDIRQ-irq-unsafe lock:
 (prepare_lock){+.+.+.}
... which became HARDIRQ-irq-unsafe at:
...  [<c0062e18>] mark_lock+0x15c/0x704
  [<c006604c>] mark_held_locks+0x70/0x150
  [<c00661dc>] trace_hardirqs_on_caller+0xb0/0x1b8
  [<c00662f8>] trace_hardirqs_on+0x14/0x18
  [<c0684c7c>] mutex_trylock+0x174/0x1f0
  [<c04d1068>] clk_prepare_lock+0x14/0xf4
  [<c04d1bb8>] clk_notifier_register+0x34/0xf8
  [<c0015134>] twd_clk_init+0x3c/0x50
  [<c0008800>] do_one_initcall+0x38/0x168
  [<c08f5c6c>] kernel_init_freeable+0x104/0x1d0
  [<c06811bc>] kernel_init+0x10/0xec
  [<c000ea48>] ret_from_fork+0x14/0x2c

other info that might help us debug this:

 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(prepare_lock);
                               local_irq_disable();
                               lock(&(&host->lock)->rlock);
                               lock(prepare_lock);
  <Interrupt>
    lock(&(&host->lock)->rlock);

 *** DEADLOCK ***

3 locks held by kworker/u8:1/44:
 #0:  (kmmcd){.+.+..}, at: [<c003d498>] process_one_work+0x130/0x4ac
 #1:  ((&(&host->detect)->work)){+.+...}, at: [<c003d498>] process_one_work+0x130/0x4ac
 #2:  (&(&host->lock)->rlock){-.-...}, at: [<c04b0528>] sdhci_do_set_ios+0x20/0x740

the dependencies between HARDIRQ-irq-safe lock and the holding lock:
-> (&(&host->lock)->rlock){-.-...} ops: 183 {
   IN-HARDIRQ-W at:
                    [<c0062e18>] mark_lock+0x15c/0x704
                    [<c0063f4c>] __lock_acquire+0xb8c/0x1e14
                    [<c00657a0>] lock_acquire+0xa4/0x114
                    [<c0687c88>] _raw_spin_lock+0x34/0x44
                    [<c04af8f0>] sdhci_irq+0x20/0xa14
                    [<c006fc78>] handle_irq_event_percpu+0x68/0x254
                    [<c006fea8>] handle_irq_event+0x44/0x64
                    [<c0072eac>] handle_fasteoi_irq+0xac/0x180
                    [<c006f5d4>] generic_handle_irq+0x28/0x38
                    [<c000f294>] handle_IRQ+0x40/0x98
                    [<c0008548>] gic_handle_irq+0x30/0x64
                    [<c00132c4>] __irq_svc+0x44/0x58
                    [<c02f36f4>] pin_get_from_name+0x6c/0x8c
                    [<c02f57a8>] pinconf_map_to_setting+0x44/0xb0
                    [<c02f3014>] pinctrl_get+0x2fc/0x430
                    [<c02f35ac>] devm_pinctrl_get+0x34/0x68
                    [<c0384964>] pinctrl_bind_pins+0x38/0xfc
                    [<c036bd64>] driver_probe_device+0x74/0x248
                    [<c036bfd4>] __driver_attach+0x9c/0xa0
                    [<c036a548>] bus_for_each_dev+0x70/0x94
                    [<c036ba08>] driver_attach+0x24/0x28
                    [<c036b560>] bus_add_driver+0x14c/0x1dc
                    [<c036c678>] driver_register+0x80/0xfc
                    [<c036d424>] __platform_driver_register+0x50/0x64
                    [<c092847c>] sdhci_esdhc_imx_driver_init+0x18/0x20
                    [<c0008800>] do_one_initcall+0x38/0x168
                    [<c08f5c6c>] kernel_init_freeable+0x104/0x1d0
                    [<c06811bc>] kernel_init+0x10/0xec
                    [<c000ea48>] ret_from_fork+0x14/0x2c
   IN-SOFTIRQ-W at:
                    [<c0062e18>] mark_lock+0x15c/0x704
                    [<c0063974>] __lock_acquire+0x5b4/0x1e14
                    [<c00657a0>] lock_acquire+0xa4/0x114
                    [<c0687da0>] _raw_spin_lock_irqsave+0x4c/0x60
                    [<c04b19c4>] sdhci_tasklet_finish+0x1c/0x120
                    [<c00298d4>] tasklet_action+0x6c/0x104
                    [<c00290ec>] __do_softirq+0x118/0x2d8
                    [<c0029698>] irq_exit+0xc0/0x110
                    [<c000f298>] handle_IRQ+0x44/0x98
                    [<c0008548>] gic_handle_irq+0x30/0x64
                    [<c00132c4>] __irq_svc+0x44/0x58
                    [<c02f36f4>] pin_get_from_name+0x6c/0x8c
                    [<c02f57a8>] pinconf_map_to_setting+0x44/0xb0
                    [<c02f3014>] pinctrl_get+0x2fc/0x430
                    [<c02f35ac>] devm_pinctrl_get+0x34/0x68
                    [<c0384964>] pinctrl_bind_pins+0x38/0xfc
                    [<c036bd64>] driver_probe_device+0x74/0x248
                    [<c036bfd4>] __driver_attach+0x9c/0xa0
                    [<c036a548>] bus_for_each_dev+0x70/0x94
                    [<c036ba08>] driver_attach+0x24/0x28
                    [<c036b560>] bus_add_driver+0x14c/0x1dc
                    [<c036c678>] driver_register+0x80/0xfc
                    [<c036d424>] __platform_driver_register+0x50/0x64
                    [<c092847c>] sdhci_esdhc_imx_driver_init+0x18/0x20
                    [<c0008800>] do_one_initcall+0x38/0x168
                    [<c08f5c6c>] kernel_init_freeable+0x104/0x1d0
                    [<c06811bc>] kernel_init+0x10/0xec
                    [<c000ea48>] ret_from_fork+0x14/0x2c
   INITIAL USE at:
                   [<c0062e18>] mark_lock+0x15c/0x704
                   [<c00636c8>] __lock_acquire+0x308/0x1e14
                   [<c00657a0>] lock_acquire+0xa4/0x114
                   [<c0687da0>] _raw_spin_lock_irqsave+0x4c/0x60
                   [<c04b0528>] sdhci_do_set_ios+0x20/0x740
                   [<c04b0490>] sdhci_set_ios+0x2c/0x38
                   [<c049c8e8>] mmc_power_up+0x70/0xd4
                   [<c049d63c>] mmc_start_host+0x44/0x70
                   [<c049e0ac>] mmc_add_host+0x4c/0x70
                   [<c04b1490>] sdhci_add_host+0x848/0xc30
                   [<c04b41a8>] sdhci_esdhc_imx_probe+0x320/0x5fc
                   [<c036d508>] platform_drv_probe+0x24/0x54
                   [<c036bd94>] driver_probe_device+0xa4/0x248
                   [<c036bfd4>] __driver_attach+0x9c/0xa0
                   [<c036a548>] bus_for_each_dev+0x70/0x94
                   [<c036ba08>] driver_attach+0x24/0x28
                   [<c036b560>] bus_add_driver+0x14c/0x1dc
                   [<c036c678>] driver_register+0x80/0xfc
                   [<c036d424>] __platform_driver_register+0x50/0x64
                   [<c092847c>] sdhci_esdhc_imx_driver_init+0x18/0x20
                   [<c0008800>] do_one_initcall+0x38/0x168
                   [<c08f5c6c>] kernel_init_freeable+0x104/0x1d0
                   [<c06811bc>] kernel_init+0x10/0xec
                   [<c000ea48>] ret_from_fork+0x14/0x2c
 }
 ... key      at: [<c0f25cf4>] __key.24505+0x0/0x8
 ... acquired at:
   [<c0062628>] check_usage+0x3fc/0x618
   [<c00628a0>] check_irq_usage+0x5c/0xb8
   [<c00644c0>] __lock_acquire+0x1100/0x1e14
   [<c00657a0>] lock_acquire+0xa4/0x114
   [<c0686668>] mutex_lock_nested+0x5c/0x39c
   [<c04d10d4>] clk_prepare_lock+0x80/0xf4
   [<c04d1f14>] clk_get_rate+0x14/0x64
   [<c04b3414>] esdhc_pltfm_set_clock+0x20/0x2ac
   [<c04ada78>] sdhci_set_clock+0x4c/0x410
   [<c04b05f0>] sdhci_do_set_ios+0xe8/0x740
   [<c04b0490>] sdhci_set_ios+0x2c/0x38
   [<c049cac4>] mmc_power_off+0x64/0x84
   [<c049d5b8>] mmc_rescan+0x29c/0x2dc
   [<c003d51c>] process_one_work+0x1b4/0x4ac
   [<c003e8fc>] worker_thread+0x13c/0x410
   [<c00451a8>] kthread+0xd0/0xec
   [<c000ea48>] ret_from_fork+0x14/0x2c


the dependencies between the lock to be acquired and HARDIRQ-irq-unsafe lock:
-> (prepare_lock){+.+.+.} ops: 314 {
   HARDIRQ-ON-W at:
                    [<c0062e18>] mark_lock+0x15c/0x704
                    [<c006604c>] mark_held_locks+0x70/0x150
                    [<c00661dc>] trace_hardirqs_on_caller+0xb0/0x1b8
                    [<c00662f8>] trace_hardirqs_on+0x14/0x18
                    [<c0684c7c>] mutex_trylock+0x174/0x1f0
                    [<c04d1068>] clk_prepare_lock+0x14/0xf4
                    [<c04d1bb8>] clk_notifier_register+0x34/0xf8
                    [<c0015134>] twd_clk_init+0x3c/0x50
                    [<c0008800>] do_one_initcall+0x38/0x168
                    [<c08f5c6c>] kernel_init_freeable+0x104/0x1d0
                    [<c06811bc>] kernel_init+0x10/0xec
                    [<c000ea48>] ret_from_fork+0x14/0x2c
   SOFTIRQ-ON-W at:
                    [<c0062e18>] mark_lock+0x15c/0x704
                    [<c006604c>] mark_held_locks+0x70/0x150
                    [<c0066220>] trace_hardirqs_on_caller+0xf4/0x1b8
                    [<c00662f8>] trace_hardirqs_on+0x14/0x18
                    [<c0684c7c>] mutex_trylock+0x174/0x1f0
                    [<c04d1068>] clk_prepare_lock+0x14/0xf4
                    [<c04d1bb8>] clk_notifier_register+0x34/0xf8
                    [<c0015134>] twd_clk_init+0x3c/0x50
                    [<c0008800>] do_one_initcall+0x38/0x168
                    [<c08f5c6c>] kernel_init_freeable+0x104/0x1d0
                    [<c06811bc>] kernel_init+0x10/0xec
                    [<c000ea48>] ret_from_fork+0x14/0x2c
   RECLAIM_FS-ON-W at:
                       [<c0062e18>] mark_lock+0x15c/0x704
                       [<c006604c>] mark_held_locks+0x70/0x150
                       [<c00668bc>] lockdep_trace_alloc+0xac/0xf8
                       [<c00c8674>] __alloc_pages_nodemask+0x70/0x8dc
                       [<c00fb8a4>] new_slab+0x74/0x244
                       [<c00fcb3c>] __slab_alloc.clone.67.clone.74+0x124/0x4dc
                       [<c00fd000>] kmem_cache_alloc+0x10c/0x158
                       [<c011b3e4>] alloc_inode+0x5c/0xa4
                       [<c011c920>] new_inode_pseudo+0x10/0x48
                       [<c011c970>] new_inode+0x18/0x30
                       [<c0291444>] debugfs_mknod.clone.16.clone.17+0x40/0x12c
                       [<c02915f0>] __create_file+0xc0/0x1cc
                       [<c02917c8>] debugfs_create_file+0x30/0x38
                       [<c0291af4>] debugfs_create_x32+0x50/0x60
                       [<c04d1310>] clk_debug_create_subtree+0x64/0x120
                       [<c09296bc>] clk_debug_init+0xac/0x134
                       [<c0008800>] do_one_initcall+0x38/0x168
                       [<c08f5c6c>] kernel_init_freeable+0x104/0x1d0
                       [<c06811bc>] kernel_init+0x10/0xec
                       [<c000ea48>] ret_from_fork+0x14/0x2c
   INITIAL USE at:
                   [<c0062e18>] mark_lock+0x15c/0x704
                   [<c00636c8>] __lock_acquire+0x308/0x1e14
                   [<c00657a0>] lock_acquire+0xa4/0x114
                   [<c0684c10>] mutex_trylock+0x108/0x1f0
                   [<c04d1068>] clk_prepare_lock+0x14/0xf4
                   [<c04d318c>] __clk_init+0x20/0x460
                   [<c04d369c>] _clk_register+0xd0/0x164
                   [<c04d37ec>] clk_register+0x48/0x8c
                   [<c04d416c>] clk_register_fixed_rate+0x8c/0xd0
                   [<c04d4218>] of_fixed_clk_setup+0x68/0x90
                   [<c0929788>] of_clk_init+0x44/0x6c
                   [<c08f9458>] time_init+0x2c/0x38
                   [<c08f59f4>] start_kernel+0x1e0/0x354
                   [<10008074>] 0x10008074
 }
 ... key      at: [<c09a1acc>] prepare_lock+0x38/0x48
 ... acquired at:
   [<c0062658>] check_usage+0x42c/0x618
   [<c00628a0>] check_irq_usage+0x5c/0xb8
   [<c00644c0>] __lock_acquire+0x1100/0x1e14
   [<c00657a0>] lock_acquire+0xa4/0x114
   [<c0686668>] mutex_lock_nested+0x5c/0x39c
   [<c04d10d4>] clk_prepare_lock+0x80/0xf4
   [<c04d1f14>] clk_get_rate+0x14/0x64
   [<c04b3414>] esdhc_pltfm_set_clock+0x20/0x2ac
   [<c04ada78>] sdhci_set_clock+0x4c/0x410
   [<c04b05f0>] sdhci_do_set_ios+0xe8/0x740
   [<c04b0490>] sdhci_set_ios+0x2c/0x38
   [<c049cac4>] mmc_power_off+0x64/0x84
   [<c049d5b8>] mmc_rescan+0x29c/0x2dc
   [<c003d51c>] process_one_work+0x1b4/0x4ac
   [<c003e8fc>] worker_thread+0x13c/0x410
   [<c00451a8>] kthread+0xd0/0xec
   [<c000ea48>] ret_from_fork+0x14/0x2c


stack backtrace:
CPU: 1 PID: 44 Comm: kworker/u8:1 Not tainted 3.13.0-rc7+ #401
Workqueue: kmmcd mmc_rescan
Backtrace:
[<c0012630>] (dump_backtrace) from [<c00127cc>] (show_stack+0x18/0x1c)
 r6:ea3b7bb4 r5:c0a73520 r4:00000000 r3:ea352400
[<c00127b4>] (show_stack) from [<c06831f8>] (dump_stack+0x70/0x90)
[<c0683188>] (dump_stack) from [<c0062678>] (check_usage+0x44c/0x618)
 r4:00000001 r3:ea352400
[<c006222c>] (check_usage) from [<c00628a0>] (check_irq_usage+0x5c/0xb8)
 r10:00000030 r9:ea3527d0 r8:ea3527e8 r7:ea3527d0 r6:c0695968 r5:ea352400
 r4:00000000
[<c0062844>] (check_irq_usage) from [<c00644c0>] (__lock_acquire+0x1100/0x1e14)
 r8:00000002 r7:c0f1b104 r6:c0ea98fc r5:ea352400 r4:c0a5ac00
[<c00633c0>] (__lock_acquire) from [<c00657a0>] (lock_acquire+0xa4/0x114)
 r10:00000000 r9:00000002 r8:00000000 r7:00000000 r6:c09a1acc r5:ea3b6000
 r4:00000000
[<c00656fc>] (lock_acquire) from [<c0686668>] (mutex_lock_nested+0x5c/0x39c)
 r10:ea352400 r9:00000002 r8:ea3b6000 r7:00000000 r6:c0ea98fc r5:c04d10d4
 r4:c09a1a94
[<c068660c>] (mutex_lock_nested) from [<c04d10d4>] (clk_prepare_lock+0x80/0xf4)
 r10:ea3b6000 r9:00000002 r8:ea397c10 r7:20000113 r6:e9841c40 r5:ea3b6000
 r4:c0f25f84
[<c04d1054>] (clk_prepare_lock) from [<c04d1f14>] (clk_get_rate+0x14/0x64)
 r6:e9841c40 r5:00000000 r4:ea028280 r3:c04b33f4
[<c04d1f00>] (clk_get_rate) from [<c04b3414>] (esdhc_pltfm_set_clock+0x20/0x2ac) r5:00000000 r4:e9841c40
[<c04b33f4>] (esdhc_pltfm_set_clock) from [<c04ada78>] (sdhci_set_clock+0x4c/0x410)
 r10:ea3b6000 r9:00000002 r8:00000000 r7:20000113 r6:e9841d18 r5:00000000
 r4:e9841c40 r3:c04b33f4
[<c04ada2c>] (sdhci_set_clock) from [<c04b05f0>] (sdhci_do_set_ios+0xe8/0x740)
 r10:ea3b6000 r9:00000002 r8:00000000 r7:20000113 r6:e9841d18 r5:e9841aa8
 r4:e9841c40 r3:00000000
[<c04b0508>] (sdhci_do_set_ios) from [<c04b0490>] (sdhci_set_ios+0x2c/0x38)
 r10:ea3b6000 r8:00000000 r7:ea18a100 r6:e9841aa8 r5:e9841c40 r4:e9841800
[<c04b0464>] (sdhci_set_ios) from [<c049cac4>] (mmc_power_off+0x64/0x84)
 r6:c076a858 r5:c076a858 r4:e9841800 r3:c04b0464
[<c049ca60>] (mmc_power_off) from [<c049d5b8>] (mmc_rescan+0x29c/0x2dc)
[<c049d31c>] (mmc_rescan) from [<c003d51c>] (process_one_work+0x1b4/0x4ac)
 r6:ea00dc00 r5:ea393080 r4:e9841af8 r3:c049d31c
[<c003d368>] (process_one_work) from [<c003e8fc>] (worker_thread+0x13c/0x410)
 r10:ea00de80 r9:ea3b6000 r8:ea393098 r7:ea3b6000 r6:ea00dc30 r5:ea00dc00
 r4:ea393080
[<c003e7c0>] (worker_thread) from [<c00451a8>] (kthread+0xd0/0xec)
 r10:00000000 r9:00000000 r8:c003e7c0 r7:ea393080 r6:ea3b7f24 r5:ea392540
 r4:00000000
[<c00450d8>] (kthread) from [<c000ea48>] (ret_from_fork+0x14/0x2c)
 r8:00000000 r7:00000000 r6:00000000 r5:c00450d8 r4:ea392540

static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
{
        unsigned long flags;
        int vdd_bit = -1;
        u8 ctrl;

        spin_lock_irqsave(&host->lock, flags);
...
        sdhci_set_clock(host, ios->clock);

which then goes on to call esdhc_pltfm_set_clock(), and clk_get_rate(),
where clk_get_rate() takes a mutex - and you can't take a mutex under
an IRQs-off region.

This appears to be provoked by providing the non-removable property.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
