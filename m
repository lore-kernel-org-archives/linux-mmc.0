From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH 1/7] mmc: mxs-mmc: add mmc host driver for i.MX23/28
Date: Sat, 12 Feb 2011 09:08:00 +0800
Message-ID: <20110212010759.GF9289@S2100-06.ap.freescale.net>
References: <1296872327-21166-1-git-send-email-shawn.guo@freescale.com>
 <1296872327-21166-2-git-send-email-shawn.guo@freescale.com>
 <19793.11232.308502.128439@ipc1.ka-ro>
 <20110211221110.GB9289@S2100-06.ap.freescale.net>
 <19797.19042.257018.636040@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]:29176 "EHLO
	TX2EHSOBE008.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756377Ab1BKTAu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Feb 2011 14:00:50 -0500
Received: from mail156-tx2 (localhost.localdomain [127.0.0.1])	by
 mail156-tx2-R.bigfish.com (Postfix) with ESMTP id 7739F19F05DB	for
 <linux-mmc@vger.kernel.org>; Fri, 11 Feb 2011 19:00:49 +0000 (UTC)
Received: from TX2EHSMHS025.bigfish.com (unknown [10.9.14.244])	by
 mail156-tx2.bigfish.com (Postfix) with ESMTP id 069901A3804C	for
 <linux-mmc@vger.kernel.org>; Fri, 11 Feb 2011 19:00:49 +0000 (UTC)
Received: from az33smr02.freescale.net (az33smr02.freescale.net
 [10.64.34.200])	by de01egw01.freescale.net (8.14.3/8.14.3) with ESMTP id
 p1BH8aa9010629	for <linux-mmc@vger.kernel.org>; Fri, 11 Feb 2011 10:08:37
 -0700 (MST)
Received: from S2100-06.ap.freescale.net (S2100-06.ap.freescale.net
 [10.192.242.50])	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id
 p1BH8ZkO012315	for <linux-mmc@vger.kernel.org>; Fri, 11 Feb 2011 11:08:36
 -0600 (CST)
Content-Disposition: inline
In-Reply-To: <19797.19042.257018.636040@ipc1.ka-ro>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Cc: cjb@laptop.org, s.hauer@pengutronix.de, u.kleine-koenig@pengutronix.de, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Feb 11, 2011 at 03:40:34PM +0100, Lothar Wa=DFmann wrote:
> Shawn Guo writes:
> > Hi Lothar,
> >=20
> > On Tue, Feb 08, 2011 at 12:41:20PM +0100, Lothar Wa=DFmann wrote:
> > > Hi,
> > >=20
> > > Shawn Guo writes:
> > > [...]
> > > > +static int mxs_mmc_remove(struct platform_device *pdev)
> > > > +{
> > > > +	struct mmc_host *mmc =3D platform_get_drvdata(pdev);
> > > > +	struct mxs_mmc_host *host =3D mmc_priv(mmc);
> > > > +
> > > > +	platform_set_drvdata(pdev, NULL);
> > > > +
> > > > +	mmc_remove_host(mmc);
> > > > +
> > > > +	del_timer(&host->timer);
> > > > +
> > > > +	free_irq(host->irq, host);
> > > > +
> > > > +	if (host->dmach)
> > > > +		dma_release_channel(host->dmach);
> > > > +
> > > > +	clk_disable(host->clk);
> > > > +	clk_put(host->clk);
> > > > +
> > > > +	iounmap(host->base);
> > > > +
> > > > +	mmc_free_host(mmc);
> > > > +
> > > > +	release_mem_region(host->res->start, resource_size(host->res)=
);
> > > >
> > > When compiled with CONFIG_PAGE_POISON this leads to:
> > > |mmc0: card cdef removed
> > > |Unable to handle kernel paging request at virtual address 6b6b6b=
6b
> > > |pgd =3D c6ea4000
> > > |[6b6b6b6b] *pgd=3D00000000
> > > |Internal error: Oops: 1 [#1] PREEMPT
> > > |last sysfs file: /sys/module/mxs_mmc/refcnt
> > > |Modules linked in: mxs_mmc(-) evdev nand nand_ids nand_ecc tsc20=
07 pca953x
> > > |CPU: 0    Not tainted  (2.6.37-karo+ #100)
> > > |PC is at mxs_mmc_remove+0x78/0x94 [mxs_mmc]
> > > |LR is at mark_held_locks+0x5c/0x84
> > > |pc : [<bf03310c>]    lr : [<c0071da0>]    psr: 20000013
> > > |sp : c6e33ef8  ip : 6b6b6b6b  fp : be825a38
> > > |r10: 00000000  r9 : c6e32000  r8 : c0037888
> > > |r7 : 00591700  r6 : c78d24bc  r5 : c6c6ea80  r4 : c6c6ed60
> > > |r3 : 6b6b6b6b  r2 : 00000040  r1 : c6d833d0  r0 : c043af18
> > > |Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment use=
r
> > > |Control: 0005317f  Table: 46ea4000  DAC: 00000015
> > > |Process modprobe (pid: 1217, stack limit =3D 0xc6e32270)
> > > |Stack: (0xc6e33ef8 to 0xc6e34000)
> > > |3ee0:                                                       c78d=
2488 bf034100
> > > |3f00: c78d24bc c0237034 c78d2488 c0235e68 c78d2488 bf034100 c78d=
24bc c0235f34
> > > |3f20: bf034100 00000080 c045c3e8 c02351c4 bf034138 00000080 c6e3=
3f44 c007de4c
> > > |3f40: be82599c 5f73786d 00636d6d 00000000 c01efdf0 c6d830c0 c6d8=
30c0 c03195ec
> > > |3f60: 00000001 c6dddbd8 c6e33f7c c0045fc4 c6d830c0 c00377d8 0000=
0001 00000081
> > > |3f80: 60000010 c00720d4 be825a2c 00000000 00000001 be825a2c 0059=
16b0 00000001
> > > |3fa0: 00000081 c00376c0 be825a2c 005916b0 00591700 00000080 be82=
5994 00000000
> > > |3fc0: be825a2c 005916b0 00000001 00000081 00591700 0000c69c 0059=
16bc be825a38
> > > |3fe0: 00591520 be8259a0 0000a42c 402aee3c 60000010 00591700 aaaa=
aaaa aaaaaaaa
> > > |[<bf03310c>] (mxs_mmc_remove+0x78/0x94 [mxs_mmc]) from [<c023703=
4>] (platform_drv_remove+0x18/0x1c)
> > > |[<c0237034>] (platform_drv_remove+0x18/0x1c) from [<c0235e68>] (=
__device_release_driver+0x64/0xa4)
> > > |[<c0235e68>] (__device_release_driver+0x64/0xa4) from [<c0235f34=
>] (driver_detach+0x8c/0xb4)
> > > |[<c0235f34>] (driver_detach+0x8c/0xb4) from [<c02351c4>] (bus_re=
move_driver+0x8c/0xb4)
> > > |[<c02351c4>] (bus_remove_driver+0x8c/0xb4) from [<c007de4c>] (sy=
s_delete_module+0x1f4/0x260)
> > > |[<c007de4c>] (sys_delete_module+0x1f4/0x260) from [<c00376c0>] (=
ret_fast_syscall+0x0/0x38)
> > > |Code: e1a00005 eb48cd47 e5943008 e59f0014 (e8930006)=20
> > > |---[ end trace bb06175839554c3b ]---
> > > indicating a use_after_free BUG!
> >=20
> > Thanks for catching this.
> >=20
> > > The struct mxs_mmc_host has been already freed here by the
> > > preceding mmc_free_host() call. This should be:
> > > 	struct resource *res =3D host->res;
> > > ...
> > > 	mmc_free_host(mmc);
> > > 	release_mem_region(res->start, resource_size(res));
> > >=20
> > How about fixing it like below?
> >=20
> > 	release_mem_region(host->res->start, resource_size(host->res));
> > 	mmc_free_host(mmc);
> >=20
> It's also OK. Although I prefer to do the release_mem_region() as the
> last action, because the corresponding request_mem_region() is the
> first action of the driver.
>=20
OK, will respect the comment.

> I still have some more comments:
> |static int mxs_mmc_remove(struct platform_device *pdev)
> |{
> |	struct mmc_host *mmc =3D platform_get_drvdata(pdev);
> |	struct mxs_mmc_host *host =3D mmc_priv(mmc);
> |
> |	platform_set_drvdata(pdev, NULL);
> This should be done after the driver has been quiesced (i.e. after
> free_irq). It's not relevant in this case right now, but cleaner
> anyway since some timer or IRQ handler might still be triggered and
> call platform_get_drvdata().

OK.

> If you always care to do the actions in the remove() function in the
> opposite order as the corresponding actions in the probe() function
> things will usually be in the right order automatically.
>=20
I do care the action order in remove() vs. probe(), and that's why
I firstly call platform_set_drvdata(pdev, NULL) in remove() ;)  So
should I move platform_set_drvdata(pdev, mmc) in probe() ahead of
request_irq()?

> |static int mxs_mmc_suspend(struct device *dev)
> |{
> |	struct mmc_host *mmc =3D dev_get_drvdata(dev);
> |	struct mxs_mmc_host *host =3D mmc_priv(mmc);
> |	int ret =3D 0;
> |
> |	if (mmc)
> 'mmc' cannot be NULL here. And as it has already been dereferenced
> by mmc_priv(mmc) above, it makes even less sense to check it here.
>=20
OK.

> |static int mxs_mmc_resume(struct device *dev)
> |{
> |	struct mmc_host *mmc =3D dev_get_drvdata(dev);
> |	struct mxs_mmc_host *host =3D mmc_priv(mmc);
> |	int ret =3D 0;
> |
> |	clk_enable(host->clk);
> |
> |	if (mmc)
> same as above.
>=20
OK.

Regards,
Shawn

