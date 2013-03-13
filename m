From: Johan Rudholm <jrudholm@gmail.com>
Subject: Trouble suspending with "mmc: queue: exclude asynchronous transfer
 for special request"
Date: Wed, 13 Mar 2013 17:40:18 +0100
Message-ID: <CA+20K0Bzbg3m0TvgRgk8Fsuqdc1keqyGuY6y1-M8mp7chPR2+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f175.google.com ([209.85.216.175]:60240 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755591Ab3CMQkS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Mar 2013 12:40:18 -0400
Received: by mail-qc0-f175.google.com with SMTP id j3so551738qcs.20
        for <linux-mmc@vger.kernel.org>; Wed, 13 Mar 2013 09:40:18 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, Konstantin Dorfman <kdorfman@codeaurora.org>, Chris Ball <cjb@laptop.org>

Hi Seungwon,

we've just backported mmc-related patches from 3.9rc1 to our internal
tree, and I'm seeing an issue with:

369d321 mmc: queue: exclude asynchronous transfer for special request

When the device is going into suspend, it seems that mmcqd still has
claimed the host and so the 20s DPM device timeout happens, and we get
a kernel BUG:

[   42.049865] PM: Syncing filesystems ... done.
[   42.058044] Freezing user space processes ... (elapsed 0.03 seconds) done.
[   42.098937] Freezing remaining freezable tasks ... (elapsed 0.01
seconds) done.
[   42.118988] Suspending console(s) (use no_console_suspend to debug)
[   42.129455] alarmtimer alarmtimer: Next rtc wakeup 2000.01.04 - 19:48:10
[   42.155517] regulator regulator.24: VEXTSUPPLY3-disable (bank, reg,
mask, value): 0x04, 0x08, 0x30, 0x00
[   54.185241] **** DPM device timeout: sdi2 (mmci-pl18x)
[   54.185241] dpm suspend stack:
[   54.185302] [<c071276c>] (__schedule+0x310/0x624) from [<c0712bd0>]
(schedule+0x40/0x80)
[   54.185302] [<c0712bd0>] (schedule+0x40/0x80) from [<c0488774>]
(__mmc_claim_host+0xa4/0x1a8)
[   54.185333] [<c0488774>] (__mmc_claim_host+0xa4/0x1a8) from
[<c048dd68>] (mmc_suspend+0x34/0x134)
[   54.185363] [<c048dd68>] (mmc_suspend+0x34/0x134) from [<c048b688>]
(mmc_suspend_host.part.20+0x98/0x1b0)
[   54.185363] [<c048b688>] (mmc_suspend_host.part.20+0x98/0x1b0) from
[<c048b7fc>] (mmc_suspend_host+0x5c/0x70)
[   54.185394] [<c048b7fc>] (mmc_suspend_host+0x5c/0x70) from
[<c049cce8>] (mmci_suspend+0x28/0x64)
[   54.185424] [<c049cce8>] (mmci_suspend+0x28/0x64) from [<c0315d54>]
(amba_pm_suspend+0x3c/0x68)
[   54.185455] [<c0315d54>] (amba_pm_suspend+0x3c/0x68) from
[<c0022b2c>] (ux500_pd_amba_pm_suspend+0x3c/0x50)
[   54.185455] [<c0022b2c>] (ux500_pd_amba_pm_suspend+0x3c/0x50) from
[<c0374a8c>] (dpm_run_callback+0x54/0x8c)
[   54.185485] [<c0374a8c>] (dpm_run_callback+0x54/0x8c) from
[<c0375c54>] (__device_suspend+0x174/0x3f0)
[   54.185516] [<c0375c54>] (__device_suspend+0x174/0x3f0) from
[<c03768a4>] (dpm_suspend+0x60/0x21c)
[   54.185516] [<c03768a4>] (dpm_suspend+0x60/0x21c) from [<c0376bd4>]
(dpm_suspend_start+0x68/0x70)
[   54.185546] [<c0376bd4>] (dpm_suspend_start+0x68/0x70) from
[<c007d424>] (suspend_devices_and_enter+0x70/0x20c)
[   54.185546] [<c007d424>] (suspend_devices_and_enter+0x70/0x20c)
from [<c007d66c>] (enter_state+0xac/0x184)
[   54.185577] [<c007d66c>] (enter_state+0xac/0x184) from [<c007d768>]
(pm_suspend+0x24/0x80)
[   54.185607] [<c007d768>] (pm_suspend+0x24/0x80) from [<c007e774>]
(suspend.part.2+0x44/0x174)
[   54.185607] [<c007e774>] (suspend.part.2+0x44/0x174) from
[<c007ea04>] (suspend+0x44/0x50)
[   54.185638] [<c007ea04>] (suspend+0x44/0x50) from [<c0058280>]
(process_one_work+0x138/0x4b0)
[   54.185638] [<c0058280>] (process_one_work+0x138/0x4b0) from
[<c0058748>] (worker_thread+0x150/0x37c)
[   54.185668] [<c0058748>] (worker_thread+0x150/0x37c) from
[<c005d768>] (kthread+0x98/0xa4)
[   54.185699] [<c005d768>] (kthread+0x98/0xa4) from [<c00106a8>]
(kernel_thread_exit+0x0/0x8)

Do you have any idea what causes this? Please disregard the
amba-stuff, this is our power domain.

Kind regards, Johan
