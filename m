From: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
Subject: Re: [PATCH] arch/avr32: Fix build failure for avr32 caused by typo
Date: Mon, 28 Dec 2009 11:02:44 +0100
Message-ID: <20091228110244.3957a358@hcegtvedt.norway.atmel.com>
References: <200912252008.45602.PeterHuewe@gmx.de>
	<20091228091318.454c4713@hcegtvedt.norway.atmel.com>
	<200912281059.30450.PeterHuewe@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relay.atmel.no ([80.232.32.139]:57101 "EHLO relay.atmel.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751167AbZL1KD3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Dec 2009 05:03:29 -0500
In-Reply-To: <200912281059.30450.PeterHuewe@gmx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Peter =?UTF-8?B?SMO8d2U=?= <PeterHuewe@gmx.de>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Haavard Skinnemoen <hskinnemoen@atmel.com>, Andrew Morton <akpm@linux-foundation.org>, Peter Ma <pma@mediamatech.com>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org

On Mon, 28 Dec 2009 10:59:30 +0100
Peter H=C3=BCwe <PeterHuewe@gmx.de> wrote:

> Am Montag 28 Dezember 2009 09:13:18 schrieb Hans-Christian Egtvedt:
> > On Fri, 25 Dec 2009 20:08:45 +0100
> >=20
> > Peter Huewe <PeterHuewe@gmx.de> wrote:
> > > This patch fixes a build failure introduced by the patch
> > >   atmel-mci: change use of dma slave interface by Nicolas Ferre
> > > by changing mci_dma_slave to the correct name of mci_dma_data
> > >
> > > This should make the avr32 tree build again.
> >=20
> > Ah, great, I have not gotten around to test this yet. Thanks for th=
e
> > patch. I've done some minor changes and also fixed the kzalloc/kfre=
e
> > error handling. Please see the inlined patch below.
> >=20
>=20
> > @@ -1344,7 +1344,7 @@ at32_add_device_mci(unsigned int id, struct
> >  mci_platform_data *data) ARRAY_SIZE(atmel_mci0_resource)))
> >  		goto fail;
> >=20
> > -	slave =3D kzalloc(sizeof(struct mci_dma_slave), GFP_KERNEL);
> > +	slave =3D kzalloc(sizeof(struct mci_dma_data), GFP_KERNEL);
> >=20
> >  	slave->sdata.dma_dev =3D &dw_dmac0_device.dev;
> >  	slave->sdata.reg_width =3D DW_DMA_SLAVE_WIDTH_32BIT;
>=20
>=20
> Great, thanks for the update.
> The only thing that still catches my eye is that the kzalloc line can=
 fail, so=20
> you should perhaps add something like
> if (!slave) {
> 	printk(KERN_ERR "No memory left for at32ap700x: at32_add_device_mc")=
;
> 	goto fail;
> }
>=20

Sounds like the patch should be split in two, one addressing the proper
naming of the struct mci_dma_data and one fixing the allocation of
memory and proper cleanup.

--=20
Best regards,
Hans-Christian Egtvedt
