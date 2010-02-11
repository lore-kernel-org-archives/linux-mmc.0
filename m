From: Mike Rapoport <mike@compulab.co.il>
Subject: Re: [PATCH 0/3] mmc: omap_hsmmc: support SDIO cards
Date: Thu, 11 Feb 2010 13:42:52 +0200
Message-ID: <4B73ED3C.9010107@compulab.co.il>
References: <cover.1265801967.git.david.vrabel@csr.com> <4B73BFD3.8090106@compulab.co.il> <4B73E59F.3020400@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:58665 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751110Ab0BKLnx (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 11 Feb 2010 06:43:53 -0500
In-Reply-To: <4B73E59F.3020400@csr.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: David Vrabel <david.vrabel@csr.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, madhu.cr@ti.com

David Vrabel wrote:
> Mike Rapoport wrote:
>> Hi David,
>>
>> David Vrabel wrote:
>>> These patches add support for SDIO cards to the omap_hsmmc driver.  Less
>>> restrictions on the sizes of transfers, power management changes to 
>>> prevent SDIO cards from being turned off and losing all state, and card
>>> interrupts.
>>>
>>> I've been unable to test these exact patches as I only have an N900 for 
>>> testing and the N900 support in mainline is incomplete.
>> I've tried your patches on CM-T35 that has 8686 SDIO and the result was
>> absence of MMC/SDIO devices at all :( Morover, kmmcd hangs:
>>
>> [  399.427764] INFO: task kmmcd:149 blocked for more than 120 seconds.
>> [...]
>> [  399.485290] [<c01e6264>] (mmc_wait_for_cmd+0x64/0x74) from
>> [<c01e86b0>] (mmc_go_idle+0x60/0xac)
> 
> I suspect interrupts aren't enabled correctly as this command does not
> complete.  Try reverting this hunk.

I did. No changes...

I've started to apply the patches one by one and after the first patch
is applied, the SD card works Ok, but libertas fails to initialize with
the following messages:

> modprobe libertas_sdio
[   82.233489] lib80211: common routines for IEEE802.11 drivers
[   82.833251] cfg80211: Calling CRDA to update world regulatory domain
[   83.327911] libertas_sdio: Libertas SDIO driver
[   83.332489] libertas_sdio: Copyright Pierre Ossman
[   83.348510] libertas_sdio mmc1:0001:1: firmware: requesting
sd8686_helper.bin
[   83.497619] libertas_sdio mmc1:0001:1: firmware: requesting sd8686.bin
[   83.679229] DMA synchronization event drop occurred with device 47

And then modprobe hangs:

[  258.700561] INFO: task modprobe:1191 blocked for more than 120
seconds.
[  258.707336] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  258.715270] modprobe      D c027f794     0  1191   1182 0x00000003
[  258.721588] [<c027f794>] (schedule+0x274/0x2ac) from [<c027f998>]
(schedule_timeout+0x18/0x17c)
[  258.730377] [<c027f998>] (schedule_timeout+0x18/0x17c) from
[<c027f414>] (wait_for_common+0xc0/0x14c)
[  258.739746] [<c027f414>] (wait_for_common+0xc0/0x14c) from
[<c01e61e0>] (mmc_wait_for_req+0x1f4/0x214)
[  258.749145] [<c01e61e0>] (mmc_wait_for_req+0x1f4/0x214) from
[<c01ea2a0>] (mmc_io_rw_extended+0x188/0x1f0)
[  258.758911] [<c01ea2a0>] (mmc_io_rw_extended+0x188/0x1f0) from
[<c01eb1c4>] (sdio_io_rw_ext_helper+0xc4/0x184)
[  258.769012] [<c01eb1c4>] (sdio_io_rw_ext_helper+0xc4/0x184) from
[<c01eb29c>] (sdio_writesb+0x18/0x1c)
[  258.778442] [<c01eb29c>] (sdio_writesb+0x18/0x1c) from [<bf0638dc>]
(if_sdio_probe+0x63c/0x938 [libertas_sdio])
[  258.788665] [<bf0638dc>] (if_sdio_probe+0x63c/0x938 [libertas_sdio])
from [<c01ea724>] (sdio_bus_probe+0x5c/0x68)
[  258.799041] [<c01ea724>] (sdio_bus_probe+0x5c/0x68) from [<c01a67a4>]
(driver_probe_device+0xa0/0x14c)
[  258.808441] [<c01a67a4>] (driver_probe_device+0xa0/0x14c) from
[<c01a68b0>] (__driver_attach+0x60/0x84)
[  258.817932] [<c01a68b0>] (__driver_attach+0x60/0x84) from
[<c01a5c8c>] (bus_for_each_dev+0x44/0x78)
[  258.827087] [<c01a5c8c>] (bus_for_each_dev+0x44/0x78) from
[<c01a6224>] (bus_add_driver+0x9c/0x224)
[  258.836212] [<c01a6224>] (bus_add_driver+0x9c/0x224) from
[<c01a6c08>] (driver_register+0xa8/0x130)
[  258.845367] [<c01a6c08>] (driver_register+0xa8/0x130) from
[<bf06701c>] (if_sdio_init_module+0x1c/0x3c [libertas_sdio])
[  258.856292] [<bf06701c>] (if_sdio_init_module+0x1c/0x3c
[libertas_sdio]) from [<c0029344>] (do_one_initcall+0x54/0x190)
[  258.867187] [<c0029344>] (do_one_initcall+0x54/0x190) from
[<c0073130>] (sys_init_module+0xb8/0x1e4)
[  258.876403] [<c0073130>] (sys_init_module+0xb8/0x1e4) from
[<c0029e80>] (ret_fast_syscall+0x0/0x2c)


> @@ -426,12 +431,6 @@ omap_hsmmc_start_command(struct omap_hsmmc_host
> *host, struct mmc_command *cmd,
>                 mmc_hostname(host->mmc), cmd->opcode, cmd->arg);
>         host->cmd = cmd;
> 
> -       /*
> -        * Clear status bits and enable interrupts
> -        */
> -       OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
> -       OMAP_HSMMC_WRITE(host->base, ISE, INT_EN_MASK);
> -
>         if (host->use_dma)
>                 OMAP_HSMMC_WRITE(host->base, IE,
>                                  INT_EN_MASK & ~(BRR_ENABLE | BWR_ENABLE));
> 
> David


-- 
Sincerely yours,
Mike.

