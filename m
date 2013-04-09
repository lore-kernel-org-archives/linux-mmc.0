From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH] mmc: mxcmmc: Fix bug when card is present during boot
Date: Tue, 9 Apr 2013 09:33:18 +0200
Message-ID: <20130409073318.GF1906@pengutronix.de>
References: <1365228811-10928-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46204 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935161Ab3DIHdU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Apr 2013 03:33:20 -0400
Content-Disposition: inline
In-Reply-To: <1365228811-10928-1-git-send-email-shc_work@mail.ru>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Javier Martin <javier.martin@vista-silicon.com>, Chris Ball <cjb@laptop.org>, Arnd Bergmann <arnd@arndb.de>

On Sat, Apr 06, 2013 at 10:13:31AM +0400, Alexander Shiyan wrote:
> This patch fixes bug when card is present during boot.
> Bug was introduced due commit "mmc: mxcmmc: fix bug that may block a
> data transfer forever". When a card is present "mxcmci_setup_data"
> function is executed, but the timer is not initialized.

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

> 
> ...
> i.MX SDHC driver
> mmc0: SD Status: Invalid Allocation Unit size.
> mmc0: new SD card at address b368
> mmcblk0: mmc0:b368 SDC   1.91 GiB
> ------------[ cut here ]------------
> kernel BUG at kernel/timer.c:729!
> Internal error: Oops - BUG: 0 [#1] PREEMPT ARM
> CPU: 0    Not tainted  (3.9.0-rc5-next-20130404 #2)
> PC is at mod_timer+0x168/0x198
> LR is at mxcmci_request+0x21c/0x328
> pc : [<c0026d28>]    lr : [<c0261928>]    psr: 60000013
> sp : c7933df0  ip : 00001000  fp : 00000001
> r10: c0012edc  r9 : c7920400  r8 : c014f92c
> r7 : c7920600  r6 : ffff8f8f  r5 : ffff8f8f  r4 : c79206a4
> r3 : 00000000  r2 : 00000000  r1 : ffff8f8f  r0 : c79206a4
> Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
> Control: 0005317f  Table: a0004000  DAC: 00000017
> Process mmcqd/0 (pid: 450, stack limit = 0xc79321b8)
> Stack: (0xc7933df0 to 0xc7934000)
> 3de0:                                     c78260f8 00000000 00000001 c78dcce0
> 3e00: c78dcc2c 00000200 c7920600 c014f92c c0012edc c0261928 00000003 00000000
> 3e20: 00000000 c7874210 c78dc800 00000002 c790f720 c78dcc2c c7920400 00000001
> 3e40: c78dcd20 00000001 c7933ee4 00000000 c78dcc2c c02504f0 00000000 c7920400
> 3e60: 00000000 c0251588 c7a60138 c7920000 c78dcc2c c78dcc04 c78dcc00 00000000
> 3e80: 00000000 c025de34 c78dcc04 c7a60138 c78dcc28 c78dcc04 c7920000 c7a60138
> 3ea0: c7920400 c78dcc00 c78dcc2c c025ed3c c7933f44 00000000 c78dcc00 00000000
> 3ec0: 00000000 c0037af0 00000000 c7932000 40000013 c0250d50 c7933f6c 00000000
> 3ee0: c78cb6c0 c003f6b8 00100100 c7920000 c7a60138 c78dcc04 c78dcc00 120d0000
> 3f00: c7920400 c78dcc00 c78dcc0c c025f918 c7847d34 00000001 c7847d40 00000000
> 3f20: c7933f54 c78dcc04 c7a60138 c7932000 00000000 120d0000 c7996b80 00000001
> 3f40: c78dcc0c c0260410 00000000 c7847d2c 00000000 c78dcc04 c0260358 00000000
> 3f60: 00000000 00000000 00000000 c0037094 00000000 00000000 2d656761 c78dcc04
> 3f80: 00000000 c7933f84 c7933f84 00000000 c7933f90 c7933f90 c7933fac c7847d2c
> 3fa0: c0036ff0 00000000 00000000 c000e210 00000000 00000000 00000000 00000000
> 3fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> 3fe0: 00000000 00000000 00000000 00000000 00000013 00000000 7ffff1e5 ef7b8ff9
> [<c0026d28>] (mod_timer+0x168/0x198) from [<c0261928>] (mxcmci_request+0x21c/0x328)
> [<c0261928>] (mxcmci_request+0x21c/0x328) from [<c02504f0>] (mmc_start_request+0xc4/0xe8)
> [<c02504f0>] (mmc_start_request+0xc4/0xe8) from [<c0251588>] (mmc_start_req+0x2d0/0x380)
> [<c0251588>] (mmc_start_req+0x2d0/0x380) from [<c025ed3c>] (mmc_blk_issue_rw_rq+0xb4/0xaf0)
> [<c025ed3c>] (mmc_blk_issue_rw_rq+0xb4/0xaf0) from [<c025f918>] (mmc_blk_issue_rq+0x1a0/0x4ec)
> [<c025f918>] (mmc_blk_issue_rq+0x1a0/0x4ec) from [<c0260410>] (mmc_queue_thread+0xb8/0x150)
> [<c0260410>] (mmc_queue_thread+0xb8/0x150) from [<c0037094>] (kthread+0xa4/0xb0)
> [<c0037094>] (kthread+0xa4/0xb0) from [<c000e210>] (ret_from_fork+0x14/0x24)
> Code: e0065015 eaffffb3 e3a0a001 eaffffea (e7f001f2)
> ---[ end trace 29f2f8ea54d9d99e ]---
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  drivers/mmc/host/mxcmmc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
> index a72936e..28e527e 100644
> --- a/drivers/mmc/host/mxcmmc.c
> +++ b/drivers/mmc/host/mxcmmc.c
> @@ -1052,12 +1052,12 @@ static int mxcmci_probe(struct platform_device *pdev)
>  			goto out_free_irq;
>  	}
>  
> -	mmc_add_host(mmc);
> -
>  	init_timer(&host->watchdog);
>  	host->watchdog.function = &mxcmci_watchdog;
>  	host->watchdog.data = (unsigned long)mmc;
>  
> +	mmc_add_host(mmc);
> +
>  	return 0;
>  
>  out_free_irq:
> -- 
> 1.8.1.5
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
