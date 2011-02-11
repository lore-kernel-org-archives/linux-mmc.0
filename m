From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH 1/7] mmc: mxs-mmc: add mmc host driver for i.MX23/28
Date: Sat, 12 Feb 2011 06:11:11 +0800
Message-ID: <20110211221110.GB9289@S2100-06.ap.freescale.net>
References: <1296872327-21166-1-git-send-email-shawn.guo@freescale.com>
 <1296872327-21166-2-git-send-email-shawn.guo@freescale.com>
 <19793.11232.308502.128439@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe006.messaging.microsoft.com ([216.32.180.16]:26114
	"EHLO VA3EHSOBE009.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753581Ab1BLAib convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 11 Feb 2011 19:38:31 -0500
Received: from mail91-va3 (localhost.localdomain [127.0.0.1])	by
 mail91-va3-R.bigfish.com (Postfix) with ESMTP id CEB9F6803FF	for
 <linux-mmc@vger.kernel.org>; Sat, 12 Feb 2011 00:38:29 +0000 (UTC)
Received: from VA3EHSMHS011.bigfish.com (unknown [10.7.14.244])	by
 mail91-va3.bigfish.com (Postfix) with ESMTP id 650C910E804B	for
 <linux-mmc@vger.kernel.org>; Sat, 12 Feb 2011 00:38:29 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
 [10.64.34.199])	by de01egw01.freescale.net (8.14.3/8.14.3) with ESMTP id
 p1BEBl0k026444	for <linux-mmc@vger.kernel.org>; Fri, 11 Feb 2011 07:11:47
 -0700 (MST)
Received: from S2100-06.ap.freescale.net (S2100-06.ap.freescale.net
 [10.192.242.50])	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
 p1BEBjXu026450	for <linux-mmc@vger.kernel.org>; Fri, 11 Feb 2011 08:11:46
 -0600 (CST)
Content-Disposition: inline
In-Reply-To: <19793.11232.308502.128439@ipc1.ka-ro>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Cc: cjb@laptop.org, s.hauer@pengutronix.de, u.kleine-koenig@pengutronix.de, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Lothar,

On Tue, Feb 08, 2011 at 12:41:20PM +0100, Lothar Wa=DFmann wrote:
> Hi,
>=20
> Shawn Guo writes:
> [...]
> > +static int mxs_mmc_remove(struct platform_device *pdev)
> > +{
> > +	struct mmc_host *mmc =3D platform_get_drvdata(pdev);
> > +	struct mxs_mmc_host *host =3D mmc_priv(mmc);
> > +
> > +	platform_set_drvdata(pdev, NULL);
> > +
> > +	mmc_remove_host(mmc);
> > +
> > +	del_timer(&host->timer);
> > +
> > +	free_irq(host->irq, host);
> > +
> > +	if (host->dmach)
> > +		dma_release_channel(host->dmach);
> > +
> > +	clk_disable(host->clk);
> > +	clk_put(host->clk);
> > +
> > +	iounmap(host->base);
> > +
> > +	mmc_free_host(mmc);
> > +
> > +	release_mem_region(host->res->start, resource_size(host->res));
> >
> When compiled with CONFIG_PAGE_POISON this leads to:
> |mmc0: card cdef removed
> |Unable to handle kernel paging request at virtual address 6b6b6b6b
> |pgd =3D c6ea4000
> |[6b6b6b6b] *pgd=3D00000000
> |Internal error: Oops: 1 [#1] PREEMPT
> |last sysfs file: /sys/module/mxs_mmc/refcnt
> |Modules linked in: mxs_mmc(-) evdev nand nand_ids nand_ecc tsc2007 p=
ca953x
> |CPU: 0    Not tainted  (2.6.37-karo+ #100)
> |PC is at mxs_mmc_remove+0x78/0x94 [mxs_mmc]
> |LR is at mark_held_locks+0x5c/0x84
> |pc : [<bf03310c>]    lr : [<c0071da0>]    psr: 20000013
> |sp : c6e33ef8  ip : 6b6b6b6b  fp : be825a38
> |r10: 00000000  r9 : c6e32000  r8 : c0037888
> |r7 : 00591700  r6 : c78d24bc  r5 : c6c6ea80  r4 : c6c6ed60
> |r3 : 6b6b6b6b  r2 : 00000040  r1 : c6d833d0  r0 : c043af18
> |Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
> |Control: 0005317f  Table: 46ea4000  DAC: 00000015
> |Process modprobe (pid: 1217, stack limit =3D 0xc6e32270)
> |Stack: (0xc6e33ef8 to 0xc6e34000)
> |3ee0:                                                       c78d2488=
 bf034100
> |3f00: c78d24bc c0237034 c78d2488 c0235e68 c78d2488 bf034100 c78d24bc=
 c0235f34
> |3f20: bf034100 00000080 c045c3e8 c02351c4 bf034138 00000080 c6e33f44=
 c007de4c
> |3f40: be82599c 5f73786d 00636d6d 00000000 c01efdf0 c6d830c0 c6d830c0=
 c03195ec
> |3f60: 00000001 c6dddbd8 c6e33f7c c0045fc4 c6d830c0 c00377d8 00000001=
 00000081
> |3f80: 60000010 c00720d4 be825a2c 00000000 00000001 be825a2c 005916b0=
 00000001
> |3fa0: 00000081 c00376c0 be825a2c 005916b0 00591700 00000080 be825994=
 00000000
> |3fc0: be825a2c 005916b0 00000001 00000081 00591700 0000c69c 005916bc=
 be825a38
> |3fe0: 00591520 be8259a0 0000a42c 402aee3c 60000010 00591700 aaaaaaaa=
 aaaaaaaa
> |[<bf03310c>] (mxs_mmc_remove+0x78/0x94 [mxs_mmc]) from [<c0237034>] =
(platform_drv_remove+0x18/0x1c)
> |[<c0237034>] (platform_drv_remove+0x18/0x1c) from [<c0235e68>] (__de=
vice_release_driver+0x64/0xa4)
> |[<c0235e68>] (__device_release_driver+0x64/0xa4) from [<c0235f34>] (=
driver_detach+0x8c/0xb4)
> |[<c0235f34>] (driver_detach+0x8c/0xb4) from [<c02351c4>] (bus_remove=
_driver+0x8c/0xb4)
> |[<c02351c4>] (bus_remove_driver+0x8c/0xb4) from [<c007de4c>] (sys_de=
lete_module+0x1f4/0x260)
> |[<c007de4c>] (sys_delete_module+0x1f4/0x260) from [<c00376c0>] (ret_=
fast_syscall+0x0/0x38)
> |Code: e1a00005 eb48cd47 e5943008 e59f0014 (e8930006)=20
> |---[ end trace bb06175839554c3b ]---
> indicating a use_after_free BUG!

Thanks for catching this.

> The struct mxs_mmc_host has been already freed here by the
> preceding mmc_free_host() call. This should be:
> 	struct resource *res =3D host->res;
> ...
> 	mmc_free_host(mmc);
> 	release_mem_region(res->start, resource_size(res));
>=20
How about fixing it like below?

	release_mem_region(host->res->start, resource_size(host->res));
	mmc_free_host(mmc);

Regards,
Shawn

