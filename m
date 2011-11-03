From: Kevin Hilman <khilman@ti.com>
Subject: omap_hsmmc noisy/broken for suspend resume
Date: Thu, 03 Nov 2011 14:24:24 -0700
Message-ID: <878vnwhpbr.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
To: svenkatr@ti.com, linux-omap <linux-omap@vger.kernel.org>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, cjb@laptop.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hello,

Using Linus' master branch, I was testing PM functionality on OMAP3/4
and noticed that the MMC driver is now rather noisy during suspend on
OMAP3[1], but seems to work.

On OMAP4, MMC seems to prevent suspend/resume all together.  I haven't
found the root cause, but know that by not buidling the MMC driver, I
have working suspend/resume again on OMAP4.

Venkat, can you investigate this?

For OMAP4, please use my for_3.2/omap4-pm branch which has the OMAP4
MPUSS retention support from Santosh.

Kevin


[1]
/ # echo mem > /sys/power/state 
[  811.145507] PM: Syncing filesystems ... done.
[  811.150268] PM: Preparing system for mem sleep
[  811.155059] Freezing user space processes ... (elapsed 0.01 seconds) done.
[  811.179992] Freezing remaining freezable tasks ... (elapsed 0.01 seconds) done.
[  811.203460] PM: Entering mem sleep
[  811.207489] Suspending console(s) (use no_console_suspend to debug)
a[  811.225860] ------------[ cut here ]------------
[  811.225891] WARNING: at /work/kernel/omap/pm/drivers/mmc/core/core.c:453 mmc_wait_for_cmd+0x78/0x84()
[  811.225921] Modules linked in:
[  811.225952] [<c001a810>] (unwind_backtrace+0x0/0xf0) from [<c00525d0>] (warn_slowpath_common+0x4c/0x64)
[  811.225982] [<c00525d0>] (warn_slowpath_common+0x4c/0x64) from [<c0052604>] (warn_slowpath_null+0x1c/0x24)
[  811.226013] [<c0052604>] (warn_slowpath_null+0x1c/0x24) from [<c033a494>] (mmc_wait_for_cmd+0x78/0x84)
[  811.226043] [<c033a494>] (mmc_wait_for_cmd+0x78/0x84) from [<c033e7b8>] (mmc_switch+0x74/0x118)
[  811.226074] [<c033e7b8>] (mmc_switch+0x74/0x118) from [<c033b034>] (mmc_power_off+0xd8/0x108)
[  811.226104] [<c033b034>] (mmc_power_off+0xd8/0x108) from [<c033b3a4>] (mmc_suspend_host+0xe4/0x1b8)
[  811.226135] [<c033b3a4>] (mmc_suspend_host+0xe4/0x1b8) from [<c034a77c>] (omap_hsmmc_suspend+0x74/0xfc)
[  811.226165] [<c034a77c>] (omap_hsmmc_suspend+0x74/0xfc) from [<c028df74>] (platform_pm_suspend+0x2c/0x5c)
[  811.226196] [<c028df74>] (platform_pm_suspend+0x2c/0x5c) from [<c0291a60>] (pm_op.clone.4+0x70/0xb8)
[  811.226226] [<c0291a60>] (pm_op.clone.4+0x70/0xb8) from [<c0291b70>] (__device_suspend+0xc8/0x1f0)
[  811.226257] [<c0291b70>] (__device_suspend+0xc8/0x1f0) from [<c02929d0>] (dpm_suspend+0x5c/0x218)
[  811.226287] [<c02929d0>] (dpm_suspend+0x5c/0x218) from [<c00970c8>] (suspend_devices_and_enter+0x8c/0x18c)
[  811.226318] [<c00970c8>] (suspend_devices_and_enter+0x8c/0x18c) from [<c0097308>] (enter_state+0x140/0x180)
[  811.226318] [<c0097308>] (enter_state+0x140/0x180) from [<c00961d4>] (state_store+0xb8/0x104)
[  811.226348] [<c00961d4>] (state_store+0xb8/0x104) from [<c022f7b8>] (kobj_attr_store+0x14/0x20)
[  811.226379] [<c022f7b8>] (kobj_attr_store+0x14/0x20) from [<c01542a8>] (sysfs_write_file+0x100/0x184)
[  811.226409] [<c01542a8>] (sysfs_write_file+0x100/0x184) from [<c00f8d88>] (vfs_write+0xb4/0x148)
[  811.226440] [<c00f8d88>] (vfs_write+0xb4/0x148) from [<c00f9010>] (sys_write+0x40/0x70)
[  811.226470] [<c00f9010>] (sys_write+0x40/0x70) from [<c00132a0>] (ret_fast_syscall+0x0/0x3c)
[  811.226501] ---[ end trace 870223ea4a1b1518 ]---
[  811.226501] ------------[ cut here ]------------
[  811.226531] WARNING: at /work/kernel/omap/pm/drivers/mmc/core/core.c:210 mmc_start_request+0xd4/0xdc()
[  811.226531] Modules linked in:
[  811.226562] [<c001a810>] (unwind_backtrace+0x0/0xf0) from [<c00525d0>] (warn_slowpath_common+0x4c/0x64)
[  811.226593] [<c00525d0>] (warn_slowpath_common+0x4c/0x64) from [<c0052604>] (warn_slowpath_null+0x1c/0x24)
[  811.226623] [<c0052604>] (warn_slowpath_null+0x1c/0x24) from [<c0339da8>] (mmc_start_request+0xd4/0xdc)
[  811.226654] [<c0339da8>] (mmc_start_request+0xd4/0xdc) from [<c033a404>] (mmc_wait_for_req+0x34/0x4c)
[  811.226684] [<c033a404>] (mmc_wait_for_req+0x34/0x4c) from [<c033a47c>] (mmc_wait_for_cmd+0x60/0x84)
[  811.226715] [<c033a47c>] (mmc_wait_for_cmd+0x60/0x84) from [<c033e7b8>] (mmc_switch+0x74/0x118)
[  811.226715] [<c033e7b8>] (mmc_switch+0x74/0x118) from [<c033b034>] (mmc_power_off+0xd8/0x108)
[  811.226745] [<c033b034>] (mmc_power_off+0xd8/0x108) from [<c033b3a4>] (mmc_suspend_host+0xe4/0x1b8)
[  811.226776] [<c033b3a4>] (mmc_suspend_host+0xe4/0x1b8) from [<c034a77c>] (omap_hsmmc_suspend+0x74/0xfc)
[  811.226806] [<c034a77c>] (omap_hsmmc_suspend+0x74/0xfc) from [<c028df74>] (platform_pm_suspend+0x2c/0x5c)
[  811.226837] [<c028df74>] (platform_pm_suspend+0x2c/0x5c) from [<c0291a60>] (pm_op.clone.4+0x70/0xb8)
[  811.226867] [<c0291a60>] (pm_op.clone.4+0x70/0xb8) from [<c0291b70>] (__device_suspend+0xc8/0x1f0)
[  811.226867] [<c0291b70>] (__device_suspend+0xc8/0x1f0) from [<c02929d0>] (dpm_suspend+0x5c/0x218)
[  811.226898] [<c02929d0>] (dpm_suspend+0x5c/0x218) from [<c00970c8>] (suspend_devices_and_enter+0x8c/0x18c)
[  811.226928] [<c00970c8>] (suspend_devices_and_enter+0x8c/0x18c) from [<c0097308>] (enter_state+0x140/0x180)
[  811.226959] [<c0097308>] (enter_state+0x140/0x180) from [<c00961d4>] (state_store+0xb8/0x104)
[  811.226989] [<c00961d4>] (state_store+0xb8/0x104) from [<c022f7b8>] (kobj_attr_store+0x14/0x20)
[  811.227020] [<c022f7b8>] (kobj_attr_store+0x14/0x20) from [<c01542a8>] (sysfs_write_file+0x100/0x184)
[  811.227020] [<c01542a8>] (sysfs_write_file+0x100/0x184) from [<c00f8d88>] (vfs_write+0xb4/0x148)
[  811.227050] [<c00f8d88>] (vfs_write+0xb4/0x148) from [<c00f9010>] (sys_write+0x40/0x70)
[  811.227081] [<c00f9010>] (sys_write+0x40/0x70) from [<c00132a0>] (ret_fast_syscall+0x0/0x3c)
[  811.227111] ---[ end trace 870223ea4a1b1519 ]---
[  811.227294] Device failed to respond within 0 poweroff time. Forcefully powering down the device
[  811.336791] PM: suspend of devices complete after 119.435 msecs
[  811.340118] PM: late suspend of devices complete after 3.328 msecs
[  811.340148] Disabling non-boot CPUs ...
[  811.340393] PM: Resume timer in 4.000 secs (131072 ticks at 32768 ticks/sec.)
[  812.226165] Successfully put all powerdomains to target state
[  812.228851] PM: early resume of devices complete after 2.229 msecs
[  812.994049] PM: resume of devices complete after 763.887 msecs
[  813.452484] PM: Finishing wakeup.
[  813.455871] Restarting tasks ... done.
/ # a
