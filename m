From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH] mmc: mxs-mmc: Add wp-inverted property
Date: Thu, 19 Jul 2012 17:06:05 +0200
Message-ID: <201207191706.06058.marex@denx.de>
References: <1339181738-22769-1-git-send-email-marex@denx.de> <87hat394lp.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:35768 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750882Ab2GSPGM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Jul 2012 11:06:12 -0400
In-Reply-To: <87hat394lp.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>, Fabio Estevam <fabio.estevam@freescale.com>, Lothar =?iso-8859-1?q?Wa=DFmann?= <LW@karo-electronics.de>

Dear Chris Ball,

> Hi Marek,
>=20
> On Fri, Jun 08 2012, Marek Vasut wrote:
> > The write-protect GPIO is inverted on some boards. Handle such case=
=2E
> >=20
> > Signed-off-by: Marek Vasut <marex@denx.de>
> > Cc: Shawn Guo <shawn.guo@linaro.org>
> > Cc: Fabio Estevam <fabio.estevam@freescale.com>
> > Cc: linux-mmc@vger.kernel.org
> > Cc: Chris Ball <cjb@laptop.org>
> > Cc: Lothar Wa=DFmann <LW@karo-electronics.de>
> > ---
> >=20
> >  drivers/mmc/host/mxs-mmc.c |   15 +++++++++++++--
> >  1 file changed, 13 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.=
c
> > index 34a9026..c6964e1 100644
> > --- a/drivers/mmc/host/mxs-mmc.c
> > +++ b/drivers/mmc/host/mxs-mmc.c
> > @@ -164,16 +164,23 @@ struct mxs_mmc_host {
> >=20
> >  	spinlock_t			lock;
> >  	int				sdio_irq_en;
> >  	int				wp_gpio;
> >=20
> > +	int				wp_inverted:1;
>=20
> Mind if I change this to "bool wp_inverted;"?  Other than that, looks
> fine and I'll merge it for 3.6.

That should be fine. Thanks!

> Thanks,
>=20
> - Chris.

Best regards,
Marek Vasut
