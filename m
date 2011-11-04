From: Girish K S <girish.shivananjappa@linaro.org>
Subject: Re: omap_hsmmc noisy/broken for suspend resume
Date: Fri, 4 Nov 2011 00:21:44 -0400
Message-ID: <CAGxe1ZFsTYt+8YyBuQZjUJ78d=19v9spFxrZkqYKiKgw0vpABg@mail.gmail.com>
References: <878vnwhpbr.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:63174 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751168Ab1KDEVq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Nov 2011 00:21:46 -0400
In-Reply-To: <878vnwhpbr.fsf@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: svenkatr@ti.com, linux-omap <linux-omap@vger.kernel.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, cjb@laptop.org, linux-mmc@vger.kernel.org

On 3 November 2011 17:24, Kevin Hilman <khilman@ti.com> wrote:
> Hello,
>
> Using Linus' master branch, I was testing PM functionality on OMAP3/4
> and noticed that the MMC driver is now rather noisy during suspend on
> OMAP3[1], but seems to work.
>
> On OMAP4, MMC seems to prevent suspend/resume all together. =A0I have=
n't
> found the root cause, but know that by not buidling the MMC driver, I
> have working suspend/resume again on OMAP4.
>
> Venkat, can you investigate this?
>
> For OMAP4, please use my for_3.2/omap4-pm branch which has the OMAP4
> MPUSS retention support from Santosh.
>
> Kevin
>
>
> [1]
> / # echo mem > /sys/power/state
> [ =A0811.145507] PM: Syncing filesystems ... done.
> [ =A0811.150268] PM: Preparing system for mem sleep
> [ =A0811.155059] Freezing user space processes ... (elapsed 0.01 seco=
nds) done.
> [ =A0811.179992] Freezing remaining freezable tasks ... (elapsed 0.01=
 seconds) done.
> [ =A0811.203460] PM: Entering mem sleep
> [ =A0811.207489] Suspending console(s) (use no_console_suspend to deb=
ug)
> a[ =A0811.225860] ------------[ cut here ]------------
> [ =A0811.225891] WARNING: at /work/kernel/omap/pm/drivers/mmc/core/co=
re.c:453 mmc_wait_for_cmd+0x78/0x84()
> [ =A0811.225921] Modules linked in:
> [ =A0811.225952] [<c001a810>] (unwind_backtrace+0x0/0xf0) from [<c005=
25d0>] (warn_slowpath_common+0x4c/0x64)
> [ =A0811.225982] [<c00525d0>] (warn_slowpath_common+0x4c/0x64) from [=
<c0052604>] (warn_slowpath_null+0x1c/0x24)
> [ =A0811.226013] [<c0052604>] (warn_slowpath_null+0x1c/0x24) from [<c=
033a494>] (mmc_wait_for_cmd+0x78/0x84)
> [ =A0811.226043] [<c033a494>] (mmc_wait_for_cmd+0x78/0x84) from [<c03=
3e7b8>] (mmc_switch+0x74/0x118)
> [ =A0811.226074] [<c033e7b8>] (mmc_switch+0x74/0x118) from [<c033b034=
>] (mmc_power_off+0xd8/0x108)
The problem is caused by the card->poweroff_notify_state =3D
MMC_POWERED_ON; statement in the mmc_card_init function
it is set for the non eMMC4.5 devices. I will rectify this and soon
send a patch for the same.
> [ =A0811.226104] [<c033b034>] (mmc_power_off+0xd8/0x108) from [<c033b=
3a4>] (mmc_suspend_host+0xe4/0x1b8)
> [ =A0811.226135] [<c033b3a4>] (mmc_suspend_host+0xe4/0x1b8) from [<c0=
34a77c>] (omap_hsmmc_suspend+0x74/0xfc)
> [ =A0811.226165] [<c034a77c>] (omap_hsmmc_suspend+0x74/0xfc) from [<c=
028df74>] (platform_pm_suspend+0x2c/0x5c)
> [ =A0811.226196] [<c028df74>] (platform_pm_suspend+0x2c/0x5c) from [<=
c0291a60>] (pm_op.clone.4+0x70/0xb8)
> [ =A0811.226226] [<c0291a60>] (pm_op.clone.4+0x70/0xb8) from [<c0291b=
70>] (__device_suspend+0xc8/0x1f0)
> [ =A0811.226257] [<c0291b70>] (__device_suspend+0xc8/0x1f0) from [<c0=
2929d0>] (dpm_suspend+0x5c/0x218)
> [ =A0811.226287] [<c02929d0>] (dpm_suspend+0x5c/0x218) from [<c00970c=
8>] (suspend_devices_and_enter+0x8c/0x18c)
> [ =A0811.226318] [<c00970c8>] (suspend_devices_and_enter+0x8c/0x18c) =
from [<c0097308>] (enter_state+0x140/0x180)
> [ =A0811.226318] [<c0097308>] (enter_state+0x140/0x180) from [<c00961=
d4>] (state_store+0xb8/0x104)
> [ =A0811.226348] [<c00961d4>] (state_store+0xb8/0x104) from [<c022f7b=
8>] (kobj_attr_store+0x14/0x20)
> [ =A0811.226379] [<c022f7b8>] (kobj_attr_store+0x14/0x20) from [<c015=
42a8>] (sysfs_write_file+0x100/0x184)
> [ =A0811.226409] [<c01542a8>] (sysfs_write_file+0x100/0x184) from [<c=
00f8d88>] (vfs_write+0xb4/0x148)
> [ =A0811.226440] [<c00f8d88>] (vfs_write+0xb4/0x148) from [<c00f9010>=
] (sys_write+0x40/0x70)
> [ =A0811.226470] [<c00f9010>] (sys_write+0x40/0x70) from [<c00132a0>]=
 (ret_fast_syscall+0x0/0x3c)
> [ =A0811.226501] ---[ end trace 870223ea4a1b1518 ]---
> [ =A0811.226501] ------------[ cut here ]------------
> [ =A0811.226531] WARNING: at /work/kernel/omap/pm/drivers/mmc/core/co=
re.c:210 mmc_start_request+0xd4/0xdc()
> [ =A0811.226531] Modules linked in:
> [ =A0811.226562] [<c001a810>] (unwind_backtrace+0x0/0xf0) from [<c005=
25d0>] (warn_slowpath_common+0x4c/0x64)
> [ =A0811.226593] [<c00525d0>] (warn_slowpath_common+0x4c/0x64) from [=
<c0052604>] (warn_slowpath_null+0x1c/0x24)
> [ =A0811.226623] [<c0052604>] (warn_slowpath_null+0x1c/0x24) from [<c=
0339da8>] (mmc_start_request+0xd4/0xdc)
> [ =A0811.226654] [<c0339da8>] (mmc_start_request+0xd4/0xdc) from [<c0=
33a404>] (mmc_wait_for_req+0x34/0x4c)
> [ =A0811.226684] [<c033a404>] (mmc_wait_for_req+0x34/0x4c) from [<c03=
3a47c>] (mmc_wait_for_cmd+0x60/0x84)
> [ =A0811.226715] [<c033a47c>] (mmc_wait_for_cmd+0x60/0x84) from [<c03=
3e7b8>] (mmc_switch+0x74/0x118)
> [ =A0811.226715] [<c033e7b8>] (mmc_switch+0x74/0x118) from [<c033b034=
>] (mmc_power_off+0xd8/0x108)
> [ =A0811.226745] [<c033b034>] (mmc_power_off+0xd8/0x108) from [<c033b=
3a4>] (mmc_suspend_host+0xe4/0x1b8)
> [ =A0811.226776] [<c033b3a4>] (mmc_suspend_host+0xe4/0x1b8) from [<c0=
34a77c>] (omap_hsmmc_suspend+0x74/0xfc)
> [ =A0811.226806] [<c034a77c>] (omap_hsmmc_suspend+0x74/0xfc) from [<c=
028df74>] (platform_pm_suspend+0x2c/0x5c)
> [ =A0811.226837] [<c028df74>] (platform_pm_suspend+0x2c/0x5c) from [<=
c0291a60>] (pm_op.clone.4+0x70/0xb8)
> [ =A0811.226867] [<c0291a60>] (pm_op.clone.4+0x70/0xb8) from [<c0291b=
70>] (__device_suspend+0xc8/0x1f0)
> [ =A0811.226867] [<c0291b70>] (__device_suspend+0xc8/0x1f0) from [<c0=
2929d0>] (dpm_suspend+0x5c/0x218)
> [ =A0811.226898] [<c02929d0>] (dpm_suspend+0x5c/0x218) from [<c00970c=
8>] (suspend_devices_and_enter+0x8c/0x18c)
> [ =A0811.226928] [<c00970c8>] (suspend_devices_and_enter+0x8c/0x18c) =
from [<c0097308>] (enter_state+0x140/0x180)
> [ =A0811.226959] [<c0097308>] (enter_state+0x140/0x180) from [<c00961=
d4>] (state_store+0xb8/0x104)
> [ =A0811.226989] [<c00961d4>] (state_store+0xb8/0x104) from [<c022f7b=
8>] (kobj_attr_store+0x14/0x20)
> [ =A0811.227020] [<c022f7b8>] (kobj_attr_store+0x14/0x20) from [<c015=
42a8>] (sysfs_write_file+0x100/0x184)
> [ =A0811.227020] [<c01542a8>] (sysfs_write_file+0x100/0x184) from [<c=
00f8d88>] (vfs_write+0xb4/0x148)
> [ =A0811.227050] [<c00f8d88>] (vfs_write+0xb4/0x148) from [<c00f9010>=
] (sys_write+0x40/0x70)
> [ =A0811.227081] [<c00f9010>] (sys_write+0x40/0x70) from [<c00132a0>]=
 (ret_fast_syscall+0x0/0x3c)
> [ =A0811.227111] ---[ end trace 870223ea4a1b1519 ]---
> [ =A0811.227294] Device failed to respond within 0 poweroff time. For=
cefully powering down the device
> [ =A0811.336791] PM: suspend of devices complete after 119.435 msecs
> [ =A0811.340118] PM: late suspend of devices complete after 3.328 mse=
cs
> [ =A0811.340148] Disabling non-boot CPUs ...
> [ =A0811.340393] PM: Resume timer in 4.000 secs (131072 ticks at 3276=
8 ticks/sec.)
> [ =A0812.226165] Successfully put all powerdomains to target state
> [ =A0812.228851] PM: early resume of devices complete after 2.229 mse=
cs
> [ =A0812.994049] PM: resume of devices complete after 763.887 msecs
> [ =A0813.452484] PM: Finishing wakeup.
> [ =A0813.455871] Restarting tasks ... done.
> / # a
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
