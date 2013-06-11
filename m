From: Scott Wood <scottwood@freescale.com>
Subject: lockdep dump on devtree_lock (involving esdhc)
Date: Tue, 11 Jun 2013 18:33:30 -0500
Message-ID: <20130611233330.GA15342@home.buserror.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co1ehsobe006.messaging.microsoft.com ([216.32.180.189]:13955
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752582Ab3FKXdg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Jun 2013 19:33:36 -0400
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: devicetree-discuss@lists.ozlabs.org
Cc: Stephen Warren <swarren@wwwdotorg.org>, Thomas Gleixner <tglx@linutronix.de>, Jerry Huang <Chang-Ming.Huang@freescale.com>, linux-mmc@vger.kernel.org

I get the following lockdump output on p2020rdb using
v3.10-rc5-43-g34376a5.  While it's not particularly polite for the
esdhc driver to be calling OF functions while holding another lock which
can be acquired from interrupt context, why is devtree_lock usually
acquired in an irqsafe manner but sometimes not?

Both types of usage were added by the same commit:

commit d6d3c4e656513dcea61ce900f0ecb9ca820ee7cd
Author: Thomas Gleixner <tglx@linutronix.de>
Date:   Wed Feb 6 15:30:56 2013 -0500

    OF: convert devtree lock from rw_lock to raw spinlock

Stephen, you asked about this here:
http://lkml.indiana.edu/hypermail/linux/kernel/1302.1/01383.html

Did you ever get an answer?

I'm also curious why devtree_lock was made raw to begin with... 
Iterating over a device tree doesn't seem like something you'd want to
trust to be low-latency.

Here's the lockdep output:
sdhci: Secure Digital Host Controller Interface driver
sdhci: Copyright(c) Pierre Ossman
sdhci-pltfm: SDHCI platform and OF driver helper
mmc0: SDHCI controller on ffe2e000.sdhc [ffe2e000.sdhc] using DMA

=========================================================
[ INFO: possible irq lock inversion dependency detected ]
3.10.0-rc5-00043-g34376a5 #3 Not tainted
---------------------------------------------------------
swapper/0/0 just changed the state of lock:
 (&(&host->lock)->rlock#2){-.....}, at: [<c049b7b8>] sdhci_irq+0x20/0xab8
but this lock took another, HARDIRQ-unsafe lock in the past:
 (devtree_lock){+.+...}

and interrupts could create inverse lock ordering between them.


other info that might help us debug this:
 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(devtree_lock);
                               local_irq_disable();
                               lock(&(&host->lock)->rlock#2);
                               lock(devtree_lock);
  <Interrupt>
    lock(&(&host->lock)->rlock#2);

 *** DEADLOCK ***

no locks held by swapper/0/0.

the shortest dependencies between 2nd lock and 1st lock:
 -> (devtree_lock){+.+...} ops: 8177 {
    HARDIRQ-ON-W at:
                      [<c00ac70c>] lock_acquire+0x4c/0x68
                      [<c0655a40>] _raw_spin_lock+0x44/0x60
                      [<c04bfd84>] of_find_node_by_phandle+0x28/0x74
                      [<c04c25e0>] of_irq_find_parent+0x38/0xb0
                      [<c04c2a58>] of_irq_map_one+0x7c/0xd8
                      [<c04c2ac8>] irq_of_parse_and_map+0x14/0x40
                      [<c04c2b14>] of_irq_to_resource+0x20/0xbc
                      [<c04c2c48>] of_irq_count+0x30/0x50
                      [<c04c349c>] of_device_alloc+0x14c/0x18c
                      [<c04c3534>]
                      of_platform_device_create_pdata+0x58/0x9c
                      [<c04c3670>] of_platform_bus_create+0xf8/0x1ac
                      [<c04c386c>] of_platform_bus_probe+0xa0/0xec
                      [<c0840e54>]
                      mpc85xx_common_publish_devices+0x20/0x30
                      [<c08422dc>]
                      __machine_initcall_p2020_rdb_pc_mpc85xx_common_publish_devices+0x2c/0x3c
                      [<c00021a4>] do_one_initcall+0x34/0x1a0
                      [<c083890c>] kernel_init_freeable+0x128/0x1d0
                      [<c0002970>] kernel_init+0x1c/0xfc
                      [<c000ec88>] ret_from_kernel_thread+0x5c/0x64
    SOFTIRQ-ON-W at:
                      [<c00ac70c>] lock_acquire+0x4c/0x68
                      [<c0655a40>] _raw_spin_lock+0x44/0x60
                      [<c04bfd84>] of_find_node_by_phandle+0x28/0x74
                      [<c04c25e0>] of_irq_find_parent+0x38/0xb0
                      [<c04c2a58>] of_irq_map_one+0x7c/0xd8
                      [<c04c2ac8>] irq_of_parse_and_map+0x14/0x40
                      [<c04c2b14>] of_irq_to_resource+0x20/0xbc
                      [<c04c2c48>] of_irq_count+0x30/0x50
                      [<c04c349c>] of_device_alloc+0x14c/0x18c
                      [<c04c3534>]
                      of_platform_device_create_pdata+0x58/0x9c
                      [<c04c3670>] of_platform_bus_create+0xf8/0x1ac
                      [<c04c386c>] of_platform_bus_probe+0xa0/0xec
                      [<c0840e54>]
                      mpc85xx_common_publish_devices+0x20/0x30
                      [<c08422dc>]
                      __machine_initcall_p2020_rdb_pc_mpc85xx_common_publish_devices+0x2c/0x3c
                      [<c00021a4>] do_one_initcall+0x34/0x1a0
                      [<c083890c>] kernel_init_freeable+0x128/0x1d0
                      [<c0002970>] kernel_init+0x1c/0xfc
                      [<c000ec88>] ret_from_kernel_thread+0x5c/0x64
    INITIAL USE at:
                     [<c00ac70c>] lock_acquire+0x4c/0x68
                     [<c0655ba0>] _raw_spin_lock_irqsave+0x58/0x78
                     [<c04bf714>] of_find_property+0x30/0x6c
                     [<c04bf890>] of_get_property+0x10/0x30
                     [<c04c10e4>] unflatten_dt_node+0x38c/0x528
                     [<c04c1334>] __unflatten_device_tree+0xb4/0x124
                     [<c085c924>] unflatten_device_tree+0x30/0x4c
                     [<c083c93c>] setup_arch+0x30/0x29c
                     [<c0838568>] start_kernel+0x90/0x30c
                     [<c00003fc>] skpinv+0x2e8/0x324
  }
  ... key      at: [<c08bd4b4>] devtree_lock+0x10/0x20
  ... acquired at:
   [<c0655ba0>] _raw_spin_lock_irqsave+0x58/0x78
   [<c04c0574>] of_find_compatible_node+0x38/0xfc
   [<c049d8e4>] esdhc_of_set_clock+0x2c/0x224
   [<c0498498>] sdhci_set_clock+0x60/0x428
   [<c0498b44>] sdhci_do_set_ios+0xe0/0x6e4
   [<c0485564>] mmc_power_up+0x88/0x130
   [<c0487d50>] mmc_start_host+0x4c/0x8c
   [<c04888d0>] mmc_add_host+0x58/0x78
   [<c0499b40>] sdhci_add_host+0x7dc/0xaf4
   [<c049d420>] sdhci_pltfm_register+0x38/0x60
   [<c049d790>] sdhci_esdhc_probe+0x18/0x28
   [<c0339294>] platform_drv_probe+0x20/0x30
   [<c0337b2c>] driver_probe_device+0xa8/0x24c
   [<c0337d94>] __driver_attach+0xc4/0xc8
   [<c0335e2c>] bus_for_each_dev+0x80/0xbc
   [<c03376e0>] driver_attach+0x24/0x34
   [<c03371ac>] bus_add_driver+0x1f0/0x250
   [<c03383f4>] driver_register+0x88/0x178
   [<c03395ec>] platform_driver_register+0x68/0x78
   [<c085b934>] sdhci_esdhc_driver_init+0x18/0x28
   [<c00021a4>] do_one_initcall+0x34/0x1a0
   [<c083890c>] kernel_init_freeable+0x128/0x1d0
   [<c0002970>] kernel_init+0x1c/0xfc
   [<c000ec88>] ret_from_kernel_thread+0x5c/0x64

-> (&(&host->lock)->rlock#2){-.....} ops: 4 {
   IN-HARDIRQ-W at:
                    [<c00ac70c>] lock_acquire+0x4c/0x68
                    [<c0655a40>] _raw_spin_lock+0x44/0x60
                    [<c049b7b8>] sdhci_irq+0x20/0xab8
                    [<c00c0458>] handle_irq_event_percpu+0x74/0x1c8
                    [<c00c05f4>] handle_irq_event+0x48/0x78
                    [<c00c3c08>] handle_fasteoi_irq+0xd4/0x1c0
                    [<c000d588>] call_handle_irq+0x18/0x28
                    [<c0004b74>] do_IRQ+0x110/0x174
                    [<c000f20c>] ret_from_except+0x0/0x18
                    [<c00c86a0>] rcu_idle_enter+0xac/0xfc
                    [<c009b3d4>] cpu_startup_entry+0xd4/0x16c
                    [<c00028e0>] rest_init+0x110/0x184
                    [<c08387d0>] start_kernel+0x2f8/0x30c
                    [<c00003fc>] skpinv+0x2e8/0x324
   INITIAL USE at:
                   [<c00ac70c>] lock_acquire+0x4c/0x68
                   [<c0655ba0>] _raw_spin_lock_irqsave+0x58/0x78
                   [<c0498a88>] sdhci_do_set_ios+0x24/0x6e4
                   [<c0485564>] mmc_power_up+0x88/0x130
                   [<c0487d50>] mmc_start_host+0x4c/0x8c
                   [<c04888d0>] mmc_add_host+0x58/0x78
                   [<c0499b40>] sdhci_add_host+0x7dc/0xaf4
                   [<c049d420>] sdhci_pltfm_register+0x38/0x60
                   [<c049d790>] sdhci_esdhc_probe+0x18/0x28
                   [<c0339294>] platform_drv_probe+0x20/0x30
                   [<c0337b2c>] driver_probe_device+0xa8/0x24c
                   [<c0337d94>] __driver_attach+0xc4/0xc8
                   [<c0335e2c>] bus_for_each_dev+0x80/0xbc
                   [<c03376e0>] driver_attach+0x24/0x34
                   [<c03371ac>] bus_add_driver+0x1f0/0x250
                   [<c03383f4>] driver_register+0x88/0x178
                   [<c03395ec>] platform_driver_register+0x68/0x78
                   [<c085b934>] sdhci_esdhc_driver_init+0x18/0x28
                   [<c00021a4>] do_one_initcall+0x34/0x1a0
                   [<c083890c>] kernel_init_freeable+0x128/0x1d0
                   [<c0002970>] kernel_init+0x1c/0xfc
                   [<c000ec88>] ret_from_kernel_thread+0x5c/0x64
 }
 ... key      at: [<c0dee0f0>] __key.24757+0x0/0x8
 ... acquired at:
   [<c00aa198>] mark_lock+0x1fc/0x744
   [<c00aae60>] __lock_acquire+0x780/0x1b6c
   [<c00ac70c>] lock_acquire+0x4c/0x68
   [<c0655a40>] _raw_spin_lock+0x44/0x60
   [<c049b7b8>] sdhci_irq+0x20/0xab8
   [<c00c0458>] handle_irq_event_percpu+0x74/0x1c8
   [<c00c05f4>] handle_irq_event+0x48/0x78
   [<c00c3c08>] handle_fasteoi_irq+0xd4/0x1c0
   [<c000d588>] call_handle_irq+0x18/0x28
   [<c0004b74>] do_IRQ+0x110/0x174
   [<c000f20c>] ret_from_except+0x0/0x18
   [<c00c86a0>] rcu_idle_enter+0xac/0xfc
   [<c009b3d4>] cpu_startup_entry+0xd4/0x16c
   [<c00028e0>] rest_init+0x110/0x184
   [<c08387d0>] start_kernel+0x2f8/0x30c
   [<c00003fc>] skpinv+0x2e8/0x324


stack backtrace:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 3.10.0-rc5-00043-g34376a5 #3
Call Trace:
[effe9d30] [c0007cb8] show_stack+0x44/0x154 (unreliable)
[effe9d70] [c065a224] dump_stack+0x24/0x34
[effe9d80] [c00a9250] print_irq_inversion_bug+0x204/0x264
[effe9db0] [c00a9340] check_usage_forwards+0x90/0x128
[effe9e00] [c00aa198] mark_lock+0x1fc/0x744
[effe9e30] [c00aae60] __lock_acquire+0x780/0x1b6c
[effe9ee0] [c00ac70c] lock_acquire+0x4c/0x68
[effe9f00] [c0655a40] _raw_spin_lock+0x44/0x60
[effe9f10] [c049b7b8] sdhci_irq+0x20/0xab8
[effe9f80] [c00c0458] handle_irq_event_percpu+0x74/0x1c8
[effe9fc0] [c00c05f4] handle_irq_event+0x48/0x78
[effe9fe0] [c00c3c08] handle_fasteoi_irq+0xd4/0x1c0
[effe9ff0] [c000d588] call_handle_irq+0x18/0x28
[c08cbe70] [c0004b74] do_IRQ+0x110/0x174
[c08cbea0] [c000f20c] ret_from_except+0x0/0x18
--- Exception: 501 at arch_cpu_idle+0x24/0x84
    LR = arch_cpu_idle+0x24/0x84
[c08cbf60] [c00c86a0] rcu_idle_enter+0xac/0xfc (unreliable)
[c08cbf70] [c009b3d4] cpu_startup_entry+0xd4/0x16c
[c08cbfa0] [c00028e0] rest_init+0x110/0x184
[c08cbfc0] [c08387d0] start_kernel+0x2f8/0x30c
[c08cbff0] [c00003fc] skpinv+0x2e8/0x324


-Scott

