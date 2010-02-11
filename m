From: Mike Rapoport <mike@compulab.co.il>
Subject: Re: [PATCH 0/3] mmc: omap_hsmmc: support SDIO cards
Date: Thu, 11 Feb 2010 10:29:07 +0200
Message-ID: <4B73BFD3.8090106@compulab.co.il>
References: <cover.1265801967.git.david.vrabel@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:57283 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751259Ab0BKIag (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 11 Feb 2010 03:30:36 -0500
In-Reply-To: <cover.1265801967.git.david.vrabel@csr.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: David Vrabel <david.vrabel@csr.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, madhu.cr@ti.com

Hi David,

David Vrabel wrote:
> These patches add support for SDIO cards to the omap_hsmmc driver.  Less
> restrictions on the sizes of transfers, power management changes to 
> prevent SDIO cards from being turned off and losing all state, and card
> interrupts.
> 
> I've been unable to test these exact patches as I only have an N900 for 
> testing and the N900 support in mainline is incomplete.

I've tried your patches on CM-T35 that has 8686 SDIO and the result was
absence of MMC/SDIO devices at all :( Morover, kmmcd hangs:

[  399.427764] INFO: task kmmcd:149 blocked for more than 120 seconds.

[  399.434082] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.

[  399.442016] kmmcd         D c027f804     0   149      2 0x00000000

[  399.448333] [<c027f804>] (schedule+0x274/0x2ac) from [<c027fa08>]
(schedule_timeout+0x18/0x17c)

[  399.457122] [<c027fa08>] (schedule_timeout+0x18/0x17c) from
[<c027f484>] (wait_for_common+0xc0/0x14c)

[  399.466461] [<c027f484>] (wait_for_common+0xc0/0x14c) from
[<c01e61e0>] (mmc_wait_for_req+0x1f4/0x214)

[  399.475860] [<c01e61e0>] (mmc_wait_for_req+0x1f4/0x214) from
[<c01e6264>] (mmc_wait_for_cmd+0x64/0x74)

[  399.485290] [<c01e6264>] (mmc_wait_for_cmd+0x64/0x74) from
[<c01e86b0>] (mmc_go_idle+0x60/0xac)

[  399.494079] [<c01e86b0>] (mmc_go_idle+0x60/0xac) from [<c01e6bb8>]
(mmc_rescan+0x150/0x208)

[  399.502532] [<c01e6bb8>] (mmc_rescan+0x150/0x208) from [<c005e288>]
(worker_thread+0xf0/0x168)

[  399.511260] [<c005e288>] (worker_thread+0xf0/0x168) from [<c0060dbc>]
(kthread+0x7c/0x84)

[  399.519531] [<c0060dbc>] (kthread+0x7c/0x84) from [<c002ae50>]
(kernel_thread_exit+0x0/0x8)


I'll try to debug it more today and see what is going on wrong...

> David Vrabel (3):
>   mmc: omap_hsmmc: use packet sync'd DMA
>   mmc: omap_hsmmc: don't turn SDIO cards off when idle
>   mmc: omap_hsmmc: enable SDIO card interrupts
> 
>  drivers/mmc/host/omap_hsmmc.c |  123 ++++++++++++++++++++++++++---------------
>  1 files changed, 78 insertions(+), 45 deletions(-)
> 


-- 
Sincerely yours,
Mike.
