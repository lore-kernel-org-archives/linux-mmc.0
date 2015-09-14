From: Belisko Marek <marek.belisko@gmail.com>
Subject: Re: 4.3-rc1 omap3 mmc boot warning + errors
Date: Mon, 14 Sep 2015 22:21:27 +0200
Message-ID: <CAAfyv355JBGRv7V7cdV=pxrodm--e2+d0sLw6kW2vnp2vmgG8Q@mail.gmail.com>
References: <CAAfyv36s9JijXAFZZJ6ewPrxfno7cPJpDxK6z0K4qZ==F51viA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:38243 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355AbbINUV2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Sep 2015 16:21:28 -0400
Received: by wiclk2 with SMTP id lk2so462470wic.1
        for <linux-mmc@vger.kernel.org>; Mon, 14 Sep 2015 13:21:27 -0700 (PDT)
In-Reply-To: <CAAfyv36s9JijXAFZZJ6ewPrxfno7cPJpDxK6z0K4qZ==F51viA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>, Tony Lindgren <tony@atomide.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>, linux-mmc@vger.kernel.org

On Mon, Sep 14, 2015 at 10:15 PM, Belisko Marek <marek.belisko@gmail.com> wrote:
> Hi,
>
> after upgrading to 4.3-rc gta04 board during boot print following warning:
>
> [    3.111206] omap_wdt: OMAP Watchdog Timer Rev 0x31: initial timeout 60 sec
> [    3.131286] ------------[ cut here ]------------
> [    3.136138] WARNING: CPU: 0 PID: 1 at drivers/regulator/core.c:2105
> _regulator_disable+0x74/0x16c()
> [    3.145721] unbalanced disables for pbias_mmc_omap2430
> [    3.151153] Modules linked in:
> [    3.154357] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.3.0-rc1-letux+ #4
> [    3.161499] Hardware name: Generic OMAP36xx (Flattened Device Tree)
> [    3.168090] [<c001628c>] (unwind_backtrace) from [<c0012b60>]
> (show_stack+0x10/0x14)
> [    3.176208] [<c0012b60>] (show_stack) from [<c029af28>]
> (dump_stack+0x70/0x8c)
> [    3.183837] [<c029af28>] (dump_stack) from [<c0037868>]
> (warn_slowpath_common+0x84/0xb0)
> [    3.192321] [<c0037868>] (warn_slowpath_common) from [<c00378c0>]
> (warn_slowpath_fmt+0x2c/0x3c)
> [    3.201477] [<c00378c0>] (warn_slowpath_fmt) from [<c0315e2c>]
> (_regulator_disable+0x74/0x16c)
> [    3.210540] [<c0315e2c>] (_regulator_disable) from [<c0315f54>]
> (regulator_disable+0x30/0x60)
> [    3.219482] [<c0315f54>] (regulator_disable) from [<c045cb14>]
> (omap_hsmmc_set_power+0x6c/0x1d0)
> [    3.228729] [<c045cb14>] (omap_hsmmc_set_power) from [<c045ccdc>]
> (omap_hsmmc_set_ios+0x64/0x220)
> [    3.238037] [<c045ccdc>] (omap_hsmmc_set_ios) from [<c0448198>]
> (mmc_power_up+0x48/0xc8)
> [    3.246490] [<c0448198>] (mmc_power_up) from [<c0448dac>]
> (mmc_start_host+0x48/0x6c)
> [    3.254699] [<c0448dac>] (mmc_start_host) from [<c0449df4>]
> (mmc_add_host+0x5c/0x80)
> [    3.262817] [<c0449df4>] (mmc_add_host) from [<c045c8e4>]
> (omap_hsmmc_probe+0x790/0x954)
> [    3.271331] [<c045c8e4>] (omap_hsmmc_probe) from [<c034c0b0>]
> (platform_drv_probe+0x48/0x98)
> [    3.280212] [<c034c0b0>] (platform_drv_probe) from [<c034a79c>]
> (driver_probe_device+0x110/0x290)
> [    3.289550] [<c034a79c>] (driver_probe_device) from [<c034a98c>]
> (__driver_attach+0x70/0x94)
> [    3.298400] [<c034a98c>] (__driver_attach) from [<c0348fa4>]
> (bus_for_each_dev+0x68/0x8c)
> [    3.307006] [<c0348fa4>] (bus_for_each_dev) from [<c0349f54>]
> (bus_add_driver+0xcc/0x1e4)
> [    3.315551] [<c0349f54>] (bus_add_driver) from [<c034b2e4>]
> (driver_register+0x9c/0xe0)
> [    3.323974] [<c034b2e4>] (driver_register) from [<c0009804>]
> (do_one_initcall+0x104/0x1b8)
> [    3.332672] [<c0009804>] (do_one_initcall) from [<c07dbd90>]
> (kernel_init_freeable+0x118/0x1e4)
> [    3.341827] [<c07dbd90>] (kernel_init_freeable) from [<c0578fa4>]
> (kernel_init+0x8/0xe4)
> [    3.350341] [<c0578fa4>] (kernel_init) from [<c000ec50>]
> (ret_from_fork+0x14/0x24)
> [    3.358428] ---[ end trace 89c011c14ada579b ]---
> [    3.363281] omap_hsmmc 4809c000.mmc: pbias reg disable fail
>
> after reverting  mmc: host: omap_hsmmc: enable/disable vmmc_aux
> regulator based on previous state
> (3f77f702389b7fbc955ec95721ce3861e40697fc) warning is gone and rootfs
> is mounted properly:
Sorry wrong reference. Correct should be: mmc: host: omap_hsmmc: use
regulator_is_enabled to find pbias status
(c55d7a0553643a7e8f120688b82b594471084d3c)
>
> [    4.904022] EXT4-fs (mmcblk0p2): mounted filesystem with ordered
> data mode. Opts: (null)
> [    4.912811] VFS: Mounted root (ext4 filesystem) on device 179:2.
> [    4.932891] devtmpfs: mounted
> [    4.937133] Freeing unused kernel memory: 436K (c07db000 - c0848000)
> INIT: version 2.88 booting
>
> but we see strange errors during booting like:
>
> -- udevd[984]: timeout: killing '/sbin/modprobe -b
> of:NbciT<NULL>Cti,twl4030-bci' [987]
> udevd[972]: timeout: killing '/sbin/modprobe -b
> of:NpwrbuttonT<NULL>Cti,twl4030-pwrbutton' [988]
>
>
> udevd[970]: timeout: killing '/sbin/modprobe -b
> of:NrtcT<NULL>Cti,twl4030-rtc' [996]
>
> udevd[968]: timeout: killing '/sbin/modprobe -b
> of:Ntwl4030-usbT<NULL>Cti,twl4030-usb' [997]
>
> udevd[973]: timeout: killing '/sbin/modprobe -b
> of:NgpioT<NULL>Cti,twl4030-gpio' [998]
>
> udevd[972]: timeout: killing '/sbin/modprobe -b
> of:NpwrbuttonT<NULL>Cti,twl4030-pwrbutton' [988]
>
> udevd[984]: timeout: killing '/sbin/modprobe -b
> of:NbciT<NULL>Cti,twl4030-bci' [987]
>
> udevd[970]: timeout: killing '/sbin/modprobe -b
> of:NrtcT<NULL>Cti,twl4030-rtc' [996]
>
> udevd[968]: timeout: killing '/sbin/modprobe -b
> of:Ntwl4030-usbT<NULL>Cti,twl4030-usb' [997]
>
> udevd[973]: timeout: killing '/sbin/modprobe -b
> of:NgpioT<NULL>Cti,twl4030-gpio' [998]
>
> which are repeated until we get prompt (after 1-2 minutes).
>
> Any idea what could cause this problems? On 4.2 it works fine. Many thanks.
>
> BR,
>
> marek
>
> as simple and primitive as possible
> -------------------------------------------------
> Marek Belisko - OPEN-NANDRA
> Freelance Developer
>
> Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
> Tel: +421 915 052 184
> skype: marekwhite
> twitter: #opennandra
> web: http://open-nandra.com



-- 
as simple and primitive as possible
-------------------------------------------------
Marek Belisko - OPEN-NANDRA
Freelance Developer

Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
Tel: +421 915 052 184
skype: marekwhite
twitter: #opennandra
web: http://open-nandra.com
