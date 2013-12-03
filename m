From: John Tobias <john.tobias.ph@gmail.com>
Subject: *** DEADLOCK ***
Date: Mon, 2 Dec 2013 18:51:44 -0800
Message-ID: <CACUGKYOFTw78WTAQyy6g6Z1e8k7YnQiXT8LyVhtSNE8di+zEcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:60590 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751982Ab3LCCvp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Dec 2013 21:51:45 -0500
Received: by mail-ob0-f181.google.com with SMTP id uy5so13565220obc.26
        for <linux-mmc@vger.kernel.org>; Mon, 02 Dec 2013 18:51:45 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Dong Aisheng <b29396@freescale.com>, Shawn Guo <shawn.guo@linaro.org>, Fabio Estevam <festevam@gmail.com>

Hello all,

I am using 3.13-rc1 kernel for iMX6SL. I got these errors when I
enable my wifi device, the wifi driver is not loaded when the errors
occurred.

Do you guys have any patches that I can grab?.

Regards,

john



[ INFO: inconsistent lock state ]
3.13.0-rc1 #1 Not tainted
---------------------------------
inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
kworker/u2:1/13 [HC0[0]:SC0[0]:HE1:SE1] takes:
 (&(&host->lock)->rlock#2){?.-...}, at: [<80309f14>]
sdhci_execute_tuning+0x3c/0x720
{IN-HARDIRQ-W} state was registered at:
  [<8004c228>] mark_lock+0x140/0x66c
  [<8004d21c>] __lock_acquire+0xac8/0x1b84
  [<8004e7a4>] lock_acquire+0x68/0x7c
  [<8047b938>] _raw_spin_lock+0x30/0x40
  [<8030ade0>] sdhci_irq+0x24/0xa1c
  [<8005789c>] handle_irq_event_percpu+0x54/0x1c0
  [<80057a4c>] handle_irq_event+0x44/0x64
  [<8005a3ec>] handle_fasteoi_irq+0x80/0x13c
  [<80057144>] generic_handle_irq+0x28/0x38
  [<8000f0c0>] handle_IRQ+0x38/0x8c
  [<8000852c>] gic_handle_irq+0x30/0x5c
  [<800122a4>] __irq_svc+0x44/0x5c
  [<80243a64>] pin_get_from_name+0x58/0x80
  [<80245a90>] pinconf_map_to_setting+0x44/0xb0
  [<80243358>] pinctrl_get+0x26c/0x3e8
  [<8024392c>] devm_pinctrl_get+0x34/0x68
  [<80295224>] pinctrl_bind_pins+0x34/0x100
  [<802813a4>] driver_probe_device+0x60/0x234
  [<80281614>] __driver_attach+0x9c/0xa0
  [<8027fa20>] bus_for_each_dev+0x5c/0x90
  [<80280f58>] driver_attach+0x20/0x28
  [<80280b54>] bus_add_driver+0xdc/0x1dc
  [<80281ccc>] driver_register+0x80/0xfc
  [<8028298c>] __platform_driver_register+0x50/0x64
  [<805f4bcc>] sdhci_esdhc_imx_driver_init+0x18/0x20
  [<80008790>] do_one_initcall+0xfc/0x160
  [<805d8be0>] kernel_init_freeable+0xf0/0x1bc
  [<80471468>] kernel_init+0x10/0x120
  [<8000e888>] ret_from_fork+0x14/0x2c
irq event stamp: 25267
hardirqs last  enabled at (25267): [<8047bf9c>]
_raw_spin_unlock_irqrestore+0x38/0x4c
hardirqs last disabled at (25266): [<8047b9f0>] _raw_spin_lock_irqsave+0x24/0x54
softirqs last  enabled at (23976): [<80024f80>] __do_softirq+0x178/0x234
softirqs last disabled at (23969): [<800253ec>] irq_exit+0xac/0x104

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&(&host->lock)->rlock#2);
  <Interrupt>
    lock(&(&host->lock)->rlock#2);

 *** DEADLOCK ***

2 locks held by kworker/u2:1/13:
 #0:  (kmmcd){.+.+.+}, at: [<80036310>] process_one_work+0x12c/0x434
 #1:  ((&(&host->detect)->work)){+.+.+.}, at: [<80036310>]
process_one_work+0x12c/0x434

stack backtrace:
CPU: 0 PID: 13 Comm: kworker/u2:1 Not tainted 3.13.0-rc1 #1
Workqueue: kmmcd mmc_rescan
Backtrace:
[<800115d0>] (dump_backtrace+0x0/0x10c) from [<8001176c>] (show_stack+0x18/0x1c)
 r6:00000000 r5:806f1004 r4:bf866600 r3:bf866600
[<80011754>] (show_stack+0x0/0x1c) from [<80476118>] (dump_stack+0x20/0x28)
[<804760f8>] (dump_stack+0x0/0x28) from [<80474368>]
(print_usage_bug.part.25+0x224/0x28c)
[<80474144>] (print_usage_bug.part.25+0x0/0x28c) from [<8004c378>]
(mark_lock+0x290/0x66c)
 r8:00000000 r7:bf866600 r6:00000001 r5:bf866970 r4:00000002
[<8004c0e8>] (mark_lock+0x0/0x66c) from [<8004cd40>]
(__lock_acquire+0x5ec/0x1b84)
[<8004c754>] (__lock_acquire+0x0/0x1b84) from [<8004e7a4>]
(lock_acquire+0x68/0x7c)
[<8004e73c>] (lock_acquire+0x0/0x7c) from [<8047b938>]
(_raw_spin_lock+0x30/0x40)
 r7:bf9ad440 r6:bf9ad568 r5:bf0e4000 r4:bf9ad568
[<8047b908>] (_raw_spin_lock+0x0/0x40) from [<80309f14>]
(sdhci_execute_tuning+0x3c/0x720)
 r4:bf9ad000
[<80309ed8>] (sdhci_execute_tuning+0x0/0x720) from [<802ffa1c>]
(mmc_sdio_init_card+0xa0c/0xa70)
[<802ff010>] (mmc_sdio_init_card+0x0/0xa70) from [<802fff44>]
(mmc_attach_sdio+0x88/0x370)
[<802ffebc>] (mmc_attach_sdio+0x0/0x370) from [<802f856c>]
(mmc_rescan+0x230/0x2c0)
[<802f833c>] (mmc_rescan+0x0/0x2c0) from [<8003638c>]
(process_one_work+0x1a8/0x434)
 r8:00000000 r7:bf94dea8 r6:bf84e800 r5:bf9ad2f8 r4:bf916900
r3:802f833c
[<800361e4>] (process_one_work+0x0/0x434) from [<800369f8>]
(worker_thread+0x124/0x394)
[<800368d4>] (worker_thread+0x0/0x394) from [<8003cebc>] (kthread+0xc4/0xe0)
[<8003cdf8>] (kthread+0x0/0xe0) from [<8000e888>] (ret_from_fork+0x14/0x2c)
 r7:00000000 r6:00000000 r5:8003cdf8 r4:bf919000
