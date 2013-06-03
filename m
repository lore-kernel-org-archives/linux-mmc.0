From: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [PATCH] mmc: host: use platform_{get,set}_drvdata()
Date: Mon, 03 Jun 2013 13:38:31 +0900
Message-ID: <001c01ce6014$337f5b80$9a7e1280$@samsung.com>
References: <000001ce5e87$284f88e0$78ee9aa0$@samsung.com>
 <20130603013830.GA14722@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:10521 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750781Ab3FCEie convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 3 Jun 2013 00:38:34 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MNS001TBVK6NYA0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 03 Jun 2013 13:38:32 +0900 (KST)
In-reply-to: <20130603013830.GA14722@rere.qmqm.pl>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?iso-8859-2?Q?'Micha=B3_Miros=B3aw'?= <mirq-linux@rere.qmqm.pl>
Cc: 'Chris Ball' <cjb@laptop.org>, linux-mmc@vger.kernel.org, 'Guennadi Liakhovetski' <g.liakhovetski@gmx.de>, 'Ian Molton' <ian@mnementh.co.uk>, Jingoo Han <jg1.han@samsung.com>

On Monday, June 03, 2013 10:39 AM, Micha=B3 Miros=B3aw wrote:
> On Sat, Jun 01, 2013 at 02:16:22PM +0900, Jingoo Han wrote:
> > Use the wrapper functions for getting and setting the driver data u=
sing
> > platform_device instead of using dev_{get,set}_drvdata() with &pdev=
->dev,
> > so we can directly pass a struct platform_device.
> >
> > Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> > ---
> >  drivers/mmc/host/cb710-mmc.c      |    2 +-
> >  drivers/mmc/host/sh_mobile_sdhi.c |    6 +++---
> >  2 files changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/mmc/host/cb710-mmc.c b/drivers/mmc/host/cb710-=
mmc.c
> > index 777ca20..9d6e2b8 100644
> > --- a/drivers/mmc/host/cb710-mmc.c
> > +++ b/drivers/mmc/host/cb710-mmc.c
> > @@ -703,7 +703,7 @@ static int cb710_mmc_init(struct platform_devic=
e *pdev)
> >  	if (!mmc)
> >  		return -ENOMEM;
> >
> > -	dev_set_drvdata(&pdev->dev, mmc);
> > +	platform_set_drvdata(pdev, mmc);
> >
> >  	/* harmless (maybe) magic */
> >  	pci_read_config_dword(chip->pdev, 0x48, &val);
>=20
> You missed the counterpart - cb710_slot_to_mmc() in cb710-mmc.h.
> After the fix:

Oh, thank you for your comment. :)
I will fix and send v2 patch soon.
Thank you.

Best regards,
Jingoo Han

>=20
> Acked-by: Micha=B3 Miros=B3aw <mirq-linux@rere.qmqm.pl>
> [for cb710]
>=20
> Best Regards,
> Micha=B3 Miros=B3aw

