From: John Tobias <john.tobias.ph@gmail.com>
Subject: [PATCH] mmc: sdhci: Resolved DEADLOCK
Date: Tue, 3 Dec 2013 18:25:50 -0800
Message-ID: <CACUGKYN7shiFp7gfRPVbrAEcv-VSSkH4K7jaj4r_+_qCi_-KCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:38166 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754373Ab3LDCZu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Dec 2013 21:25:50 -0500
Received: by mail-ob0-f179.google.com with SMTP id wm4so15522414obc.10
        for <linux-mmc@vger.kernel.org>; Tue, 03 Dec 2013 18:25:50 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>, Fabio Estevam <festevam@gmail.com>, Dong Aisheng <b29396@freescale.com>, Chris Ball <cjb@laptop.org>, Markus.Niebel@tqs.de, Ulf Hansson <ulf.hansson@linaro.org>, Fabio Estevam <fabio.estevam@freescale.com>

From: John Tobias <john.tobias.ph@gmail.com>

Remove the locking inside sdhci_execute_tuning to avoid the following
warnings when an SDIO device is connected / enabled.

=================================
[ INFO: inconsistent lock state ]
3.13.0-rc1 #12 Not tainted
---------------------------------
inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
kworker/u2:1/13 [HC0[0]:SC0[0]:HE1:SE1] takes:
 (&(&host->lock)->rlock#2){?.-...}, at: [<80315ffc>]
sdhci_execute_tuning+0x4c/0x710
{IN-HARDIRQ-W} state was registered at:
  [<8004d2f4>] mark_lock+0x170/0x684
  [<8004e8d8>] __lock_acquire+0xafc/0x1bc4
  [<80050140>] lock_acquire+0x70/0x84
  [<8048a198>] _raw_spin_lock+0x30/0x40
  [<80316dfc>] sdhci_irq+0x24/0xa74
  [<80058c5c>] handle_irq_event_percpu+0x38/0x1a0
  [<80058e08>] handle_irq_event+0x44/0x64
  [<8005b7d0>] handle_fasteoi_irq+0x80/0x14c
  [<80058468>] generic_handle_irq+0x30/0x44
  [<8000ed60>] handle_IRQ+0x38/0x8c
  [<80008534>] gic_handle_irq+0x30/0x5c
  [<800127e4>] __irq_svc+0x44/0x5c
  [<8024801c>] pin_get_from_name+0x58/0x80
  [<8024a0d8>] pinconf_map_to_setting+0x70/0xb0
  [<80247884>] pinctrl_get+0x210/0x43c
  [<80247ae0>] devm_pinctrl_get+0x30/0x70
  [<8029aa6c>] pinctrl_bind_pins+0x34/0x100
  [<802867cc>] driver_probe_device+0x60/0x234
  [<80286a88>] __driver_attach+0x9c/0xa0
  [<80284c94>] bus_for_each_dev+0x68/0x9c
  [<8028633c>] driver_attach+0x20/0x28
  [<80285fc0>] bus_add_driver+0x148/0x1f4
  [<802870d8>] driver_register+0x80/0x100
  [<8028824c>] __platform_driver_register+0x50/0x64
  [<80606f04>] sdhci_esdhc_imx_driver_init+0x18/0x20
  [<800087a4>] do_one_initcall+0x108/0x16c
  [<805eabe8>] kernel_init_freeable+0xf8/0x1b8
  [<80480144>] kernel_init+0x10/0x120
  [<8000e528>] ret_from_fork+0x14/0x2c
irq event stamp: 366717
hardirqs last  enabled at (366717): [<8048a40c>]
_raw_spin_unlock_irqrestore+0x38/0x4c
hardirqs last disabled at (366716): [<8048a298>]
_raw_spin_lock_irqsave+0x24/0x54
softirqs last  enabled at (365438): [<80025880>] __do_softirq+0x194/0x258
softirqs last disabled at (365431): [<80025d20>] irq_exit+0xb0/0x108

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&(&host->lock)->rlock#2);
  <Interrupt>
    lock(&(&host->lock)->rlock#2);

 *** DEADLOCK ***

2 locks held by kworker/u2:1/13:
 #0:  (kmmcd){.+.+.+}, at: [<80036f64>] process_one_work+0x124/0x444
 #1:  ((&(&host->detect)->work)){+.+.+.}, at: [<80036f64>]
process_one_work+0x124/0x444

stack backtrace:
CPU: 0 PID: 13 Comm: kworker/u2:1 Not tainted 3.13.0-rc1 #12
Workqueue: kmmcd mmc_rescan
Backtrace:
[<8001197c>] (dump_backtrace+0x0/0x10c) from [<80011c54>] (show_stack+0x18/0x1c)
 r6:00000000 r5:807041a4 r4:bf866600 r3:bf866600
[<80011c3c>] (show_stack+0x0/0x1c) from [<80484758>] (dump_stack+0x20/0x28)
[<80484738>] (dump_stack+0x0/0x28) from [<80482900>]
(print_usage_bug.part.34+0x224/0x28c)
[<804826dc>] (print_usage_bug.part.34+0x0/0x28c) from [<8004d380>]
(mark_lock+0x1fc/0x684)
 r8:807041a4 r7:8062bc08 r6:bf866600 r5:bf866970 r4:00000002
[<8004d184>] (mark_lock+0x0/0x684) from [<8004e3cc>]
(__lock_acquire+0x5f0/0x1bc4)
[<8004dddc>] (__lock_acquire+0x0/0x1bc4) from [<80050140>]
(lock_acquire+0x70/0x84)
[<800500d0>] (lock_acquire+0x0/0x84) from [<8048a198>]
(_raw_spin_lock+0x30/0x40)
 r7:00000004 r6:00000005 r5:bf34c000 r4:bf9ad568
[<8048a168>] (_raw_spin_lock+0x0/0x40) from [<80315ffc>]
(sdhci_execute_tuning+0x4c/0x710)
 r4:bf9ad000
[<80315fb0>] (sdhci_execute_tuning+0x0/0x710) from [<8030badc>]
(mmc_sdio_init_card+0xa74/0xab4)
[<8030b068>] (mmc_sdio_init_card+0x0/0xab4) from [<8030be44>]
(mmc_attach_sdio+0x80/0x364)
[<8030bdc4>] (mmc_attach_sdio+0x0/0x364) from [<80304388>]
(mmc_rescan+0x23c/0x2e4)
[<8030414c>] (mmc_rescan+0x0/0x2e4) from [<80036fe0>]
(process_one_work+0x1a0/0x444)
 r8:00000000 r7:bf94deb0 r6:bf84e800 r5:bf9ad2f8 r4:bf916900
r3:8030414c
[<80036e40>] (process_one_work+0x0/0x444) from [<80037f08>]
(worker_thread+0x118/0x3e0)
[<80037df0>] (worker_thread+0x0/0x3e0) from [<8003da34>] (kthread+0xcc/0xe8)
[<8003d968>] (kthread+0x0/0xe8) from [<8000e528>] (ret_from_fork+0x14/0x2c)
 r7:00000000 r6:00000000 r5:8003d968 r4:bf919200
