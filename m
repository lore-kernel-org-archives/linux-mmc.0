From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Problem report: lockdep warning in mmc-next
Date: Thu, 5 Jan 2012 18:16:05 +0530
Message-ID: <CANfBPZ82eepKwXr2TNnDKX5P1ix1VZqb0S-s2K4Uo5Asxo43ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:39717 "HELO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751361Ab2AEMq1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Jan 2012 07:46:27 -0500
Received: by mail-ey0-f180.google.com with SMTP id c11so561421eaa.39
        for <linux-mmc@vger.kernel.org>; Thu, 05 Jan 2012 04:46:26 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc Mailing List <linux-mmc@vger.kernel.org>, John Beckett <john.beckett@stericsson.com>, Johan Rudholm <johan.rudholm@stericsson.com>
Cc: Chris Ball <cjb@laptop.org>

While running some usual tests on mmc-next, I came across this warning..
[    1.379608] ------------[ cut here ]------------
[    1.384552] WARNING: at
/home/svenkatr/views/linux-2.6/kernel/lockdep.c:2980
sysfs_add_file_mode+0x84/0xe8()
[    1.394927] Modules linked in:
[    1.398223] [<c001b364>] (unwind_backtrace+0x0/0xf0) from
[<c0052c20>] (warn_slowpath_common+0x4c/0x64)
[    1.408142] [<c0052c20>] (warn_slowpath_common+0x4c/0x64) from
[<c0052c54>] (warn_slowpath_null+0x1c/0x24)
[    1.418334] [<c0052c54>] (warn_slowpath_null+0x1c/0x24) from
[<c016366c>] (sysfs_add_file_mode+0x84/0xe8)
[    1.428466] [<c016366c>] (sysfs_add_file_mode+0x84/0xe8) from
[<c037274c>] (mmc_add_disk+0xb4/0x100)
[    1.438110] [<c037274c>] (mmc_add_disk+0xb4/0x100) from
[<c0372dc8>] (mmc_blk_probe+0x27c/0x2c8)
[    1.447418] [<c0372dc8>] (mmc_blk_probe+0x27c/0x2c8) from
[<c0367478>] (mmc_bus_probe+0x18/0x1c)
[    1.456756] [<c0367478>] (mmc_bus_probe+0x18/0x1c) from
[<c02b0df8>] (driver_probe_device+0x98/0x1a0)
[    1.466491] [<c02b0df8>] (driver_probe_device+0x98/0x1a0) from
[<c02afc10>] (bus_for_each_drv+0x5c/0x88)
[    1.476531] [<c02afc10>] (bus_for_each_drv+0x5c/0x88) from
[<c02b0c90>] (device_attach+0x98/0xbc)
[    1.485900] [<c02b0c90>] (device_attach+0x98/0xbc) from
[<c02b0530>] (bus_probe_device+0x24/0x44)
[    1.495269] [<c02b0530>] (bus_probe_device+0x24/0x44) from
[<c02aec68>] (device_add+0x4f4/0x5c4)
[    1.504547] [<c02aec68>] (device_add+0x4f4/0x5c4) from [<c03677b4>]
(mmc_add_card+0xb8/0x1ac)
[    1.513549] [<c03677b4>] (mmc_add_card+0xb8/0x1ac) from
[<c0369658>] (mmc_attach_mmc+0xdc/0x1d0)
[    1.522857] [<c0369658>] (mmc_attach_mmc+0xdc/0x1d0) from
[<c0366fbc>] (mmc_rescan+0x230/0x45c)
[    1.532043] [<c0366fbc>] (mmc_rescan+0x230/0x45c) from [<c006b904>]
(process_one_work+0x18c/0x4e4)
[    1.541534] [<c006b904>] (process_one_work+0x18c/0x4e4) from
[<c006e41c>] (worker_thread+0x174/0x378)
[    1.551269] [<c006e41c>] (worker_thread+0x174/0x378) from
[<c0072e50>] (kthread+0x8c/0x94)
[    1.560028] [<c0072e50>] (kthread+0x8c/0x94) from [<c0014cb8>]
(kernel_thread_exit+0x0/0x8)
[    1.568847] ---[ end trace 668d8a1c4404b72e ]---

The problem seems to be introduced by this commit
b289263f7b313dc8e3ef4eb7f77694585fe556ca. I haven't had the time to
look into this, hoping someone else can..

Best regards,
Venkat.
