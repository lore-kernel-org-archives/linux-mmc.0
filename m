From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/3] MMC: OMAP: HSMMC: add runtime pm support
Date: Wed, 29 Jun 2011 13:04:30 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1106291259320.2874@utopia.booyaka.com>
References: <1308752314-32079-1-git-send-email-balajitk@ti.com> <1308752314-32079-3-git-send-email-balajitk@ti.com> <alpine.DEB.2.00.1106281116530.2874@utopia.booyaka.com> <BANLkTimT6nGP_ecJjZ6201=CiddN7BrsPg@mail.gmail.com> <alpine.DEB.2.00.1106281240390.2874@utopia.booyaka.com>
 <BANLkTikni_xO7NQXQyv7XVeEH4Nowpr1Ow@mail.gmail.com> <alpine.DEB.2.00.1106290841160.2874@utopia.booyaka.com> <BANLkTiniSBRpgbW7cE0VritgCgstPbs5tg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:50498 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752500Ab1F2TEb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 29 Jun 2011 15:04:31 -0400
In-Reply-To: <BANLkTiniSBRpgbW7cE0VritgCgstPbs5tg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "T Krishnamoorthy, Balaji" <balajitk@ti.com>, "S, Venkatraman" <svenkatr@ti.com>
Cc: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, tony@atomide.com, madhu.cr@ti.com, khilman@ti.com, b-cousson@ti.com

+ Venkat

Hi Balaji, Venkat,

On Wed, 29 Jun 2011, T Krishnamoorthy, Balaji wrote:

> OOPS pointed to omap_hsmmc_prepare_data / set_data_timeout
> Use case was MMC + SDIO +GPS activity, on kernel 2.6.35 though.
> 
> Unhandled fault: imprecise external abort (0x1406) at 0x4073102c
                   ^^^^^^^^^

That's not good...

> Internal error: : 1406 [#1] PREEMPT SMP
> last sysfs file: /sys/devices/platform/switch-sio/usb_sel
> Modules linked in: param(P) j4fs(P) vibetonz Si4709_driver fm_drv(C)
> bt_drv(C) st_drv(C)
> CPU: 0    Tainted: P        WC   (2.6.35.7 #2)
            ^^^^^^^^^^

Neither is this...

> PC is at clk_get_rate+0x4/0x48
> LR is at set_data_timeout+0x68/0xf4
> [<c06e78e0>] (set_data_timeout+0x0/0xf4) from [<c06e7dc8>]
> (omap_hsmmc_request+0x2d0/0x5c8)
>  r8:efa78400 r7:00000001 r6:00000000 r5:ef9efe78 r4:efa78640
> r3:ef9efee4
> [<c06e7af8>] (omap_hsmmc_request+0x0/0x5c8) from [<c06df040>]
> (mmc_wait_for_req+0x118/0x130)
> [<c06def28>] (mmc_wait_for_req+0x0/0x130) from [<c06e59e8>]
> (mmc_blk_issue_rq+0x1c0/0x500)
>  r6:ef86f000 r5:efa79000 r4:c91e61a0
> [<c06e5828>] (mmc_blk_issue_rq+0x0/0x500) from [<c06e6620>]
> (mmc_queue_thread+0xf4/0xf8)
> [<c06e652c>] (mmc_queue_thread+0x0/0xf8) from [<c045ddec>] (kthread+0x84/0x8c)
> [<c045dd68>] (kthread+0x0/0x8c) from [<c044b748>] (do_exit+0x0/0x604)
>  r7:00000013 r6:c044b748 r5:c045dd68 r4:ef8d5d68

Was CONFIG_PM enabled?  If so, was off-mode enabled for any IP blocks, or 
was it just clock-stop and/or retention?


- Paul
