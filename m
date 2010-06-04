From: Daniel Mack <daniel@caiaq.de>
Subject: Libertas/SDIO deep sleep mode
Date: Fri, 4 Jun 2010 14:12:45 +0200
Message-ID: <20100604121245.GW2695@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from buzzloop.caiaq.de ([212.112.241.133]:54020 "EHLO
	buzzloop.caiaq.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752057Ab0FDMMu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Jun 2010 08:12:50 -0400
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: libertas-dev@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: Sven Neumann <s.neumann@raumfeld.com>

Hi,

I read about the recently added features in the libertas driver to send
the chip to its deep-sleep mode when the system suspends, so the wakeup
phase is shortened.

I tried this with a recent 2.6.35-rc1 kernel on a PXA300 based design,
and this is what I get:


[    0.721643] Freezing user space processes ... (elapsed 0.01 seconds) done.
[    0.740588] Freezing remaining freezable tasks ... (elapsed 0.01 seconds) done.
[    0.760687] Suspending console(s) (use no_console_suspend to debug)
[    0.879657] libertas: 00:19:88:3a:cb:ac, fw 9.70.3p36, cap 0x00000303
[    0.880567] ------------[ cut here ]------------
[    0.880622] WARNING: at drivers/base/power/main.c:101 device_pm_add+0x94/0xd8()
[    0.880639] Device: ieee80211
[    0.880646] Parentless device registered during a PM transaction (phy1)
[    0.880660] Modules linked in: eeti_ts libertas_sdio libertas pxamci ds2760_battery w1_ds2760 wire
[    0.880754] [<c00493a0>] (unwind_backtrace+0x0/0xec) from [<c0056db0>] (warn_slowpath_common+0x4c/0x7c)
[    0.880793] [<c0056db0>] (warn_slowpath_common+0x4c/0x7c) from [<c0056e74>] (warn_slowpath_fmt+0x30/0x40)
[    0.880829] [<c0056e74>] (warn_slowpath_fmt+0x30/0x40) from [<c01d4cc8>] (device_pm_add+0x94/0xd8)
[    0.880875] [<c01d4cc8>] (device_pm_add+0x94/0xd8) from [<c01ce4dc>] (device_add+0x350/0x510)
[    0.880910] [<c01ce4dc>] (device_add+0x350/0x510) from [<c032d500>] (wiphy_register+0x1ac/0x298)
[    0.881033] [<c032d500>] (wiphy_register+0x1ac/0x298) from [<bf0285dc>] (lbs_cfg_register+0x54/0x9c [libertas])
[    0.881142] [<bf0285dc>] (lbs_cfg_register+0x54/0x9c [libertas]) from [<bf02c228>] (lbs_start_card+0xa0/0x130 [libertas])
[    0.881226] [<bf02c228>] (lbs_start_card+0xa0/0x130 [libertas]) from [<bf040b94>] (if_sdio_probe+0x84c/0x954 [libertas_sdio])
[    0.881276] [<bf040b94>] (if_sdio_probe+0x84c/0x954 [libertas_sdio]) from [<c024fd98>] (sdio_bus_probe+0xcc/0xe8)
[    0.881322] [<c024fd98>] (sdio_bus_probe+0xcc/0xe8) from [<c01d069c>] (driver_probe_device+0xb4/0x198)
[    0.881359] [<c01d069c>] (driver_probe_device+0xb4/0x198) from [<c01cfc08>] (bus_for_each_drv+0x4c/0x8c)
[    0.881396] [<c01cfc08>] (bus_for_each_drv+0x4c/0x8c) from [<c01d08d4>] (device_attach+0x54/0x70)
[    0.881430] [<c01d08d4>] (device_attach+0x54/0x70) from [<c01cfa2c>] (bus_probe_device+0x28/0x50)
[    0.881464] [<c01cfa2c>] (bus_probe_device+0x28/0x50) from [<c01ce510>] (device_add+0x384/0x510)
[    0.881496] [<c01ce510>] (device_add+0x384/0x510) from [<c024fbd4>] (sdio_add_func+0x38/0x54)
[    0.881527] [<c024fbd4>] (sdio_add_func+0x38/0x54) from [<c024f28c>] (mmc_attach_sdio+0x21c/0x2a8)
[    0.881581] [<c024f28c>] (mmc_attach_sdio+0x21c/0x2a8) from [<c024b97c>] (mmc_rescan+0x1ec/0x28c)
[    0.881624] [<c024b97c>] (mmc_rescan+0x1ec/0x28c) from [<c0067a60>] (worker_thread+0x168/0x1f0)
[    0.881667] [<c0067a60>] (worker_thread+0x168/0x1f0) from [<c006abd8>] (kthread+0x78/0x80)
[    0.881720] [<c006abd8>] (kthread+0x78/0x80) from [<c00458bc>] (kernel_thread_exit+0x0/0x8)
[    0.881742] ---[ end trace 919a8d4b06013c07 ]---
[    0.884319] libertas: wlan0: Marvell WLAN 802.11 adapter
[    1.138756] mmc0: card 0001 removed
[    1.139448] PM: suspend of devices complete after 255.035 msecs
[    1.140076] PM: late suspend of devices complete after 0.598 msecs
[    0.000943] PM: early resume of devices complete after 0.634 msecs
[    0.060955] usb usb1: root hub lost power or was reset
[    0.136987] mmc0: new SDIO card at address 0001
[    0.137101] mmc mmc0:0001: parent mmc0 should not be sleeping
[    0.298199] PM: resume of devices complete after 297.118 msecs
[    0.571350] Restarting tasks ... 
[    0.768454] done.
[    1.179764] libertas: 00:19:88:3a:cb:ac, fw 9.70.3p36, cap 0x00000303
[    1.198354] libertas: wlan0: Marvell WLAN 802.11 adapter


Also, the 8686's supply voltage (which is controlled via a regulator in
the pxamci code) drops to zero during the suspend phase.

Here are some questions that I have about this:

* The "Parentless device registered during a PM transaction" looks like
  a bug to me. Note that I added kobject_name(&dev->kobj) to the output
  to get a clue about what's going on.

* The firmware survives the suspend/resume transition and works fine
  after that. I just wonder why, as the voltage was switched off?

* I believe that if we need to keep the power switched on, there should
  be a call to sdio_set_host_pm_flags(MMC_PM_KEEP_POWER) somewhere in
  the libertas_sdio layer, right? How should the pxamci core get to
  know it shouldn't switch off its regulator?

* Should the message about mmc0 which should not be sleeping go away
  once the other issues are solved?


Thanks,
Daniel

