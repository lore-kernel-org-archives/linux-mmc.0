From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v2] mmc mxcmmc: fix falling back to PIO
Date: Fri, 11 Nov 2011 16:28:58 +0100
Message-ID: <20111111152858.GY16886@pengutronix.de>
References: <1314264785-19224-1-git-send-email-s.hauer@pengutronix.de>
 <20111111144815.GW16886@pengutronix.de>
 <20157.15269.398865.274711@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58398 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751284Ab1KKP3H (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Nov 2011 10:29:07 -0500
Content-Disposition: inline
In-Reply-To: <20157.15269.398865.274711@ipc1.ka-ro>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lothar =?iso-8859-15?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Nov 11, 2011 at 04:13:41PM +0100, Lothar Wa=DFmann wrote:
> Hi,
>=20
> Sascha Hauer writes:
> > Hi Chris,
> >=20
> > Can you take this one please?
> >=20
> > Sascha
> >=20
> > On Thu, Aug 25, 2011 at 11:33:05AM +0200, Sascha Hauer wrote:
> > > When we can't configure the dma channel we want to fall
> > > back to PIO. We do this by setting host->do_dma to zero.
> > > This does not work as do_dma is used to see whether dma
> > > can be used for the current transfer. Instead, we have
> > > to set host->dma to NULL.
> > >=20
> > > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > > Cc: Chris Ball <cjb@laptop.org>
> > > Cc: linux-mmc@vger.kernel.org
> > > ---
> > >  drivers/mmc/host/mxcmmc.c |    3 ++-
> > >  1 files changed, 2 insertions(+), 1 deletions(-)
> > >=20
> > > diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.=
c
> > > index 14aa213..4dc9008 100644
> > > --- a/drivers/mmc/host/mxcmmc.c
> > > +++ b/drivers/mmc/host/mxcmmc.c
> > > @@ -730,7 +730,8 @@ static void mxcmci_set_ios(struct mmc_host *m=
mc, struct mmc_ios *ios)
> > >  			dev_err(mmc_dev(host->mmc),
> > >  				"failed to config DMA channel. Falling back to PIO\n");
> > >  			dma_release_channel(host->dma);
> > > -			host->do_dma =3D 0;
> > > +			host->dma =3D NULL;
> > > +			host->dma =3D 0;
> NULL or 0, that is the question? Or both?
> That looks a little bit screwed.

NULL. Hm, this was already fixed in my tree. I just sent an updated
patch.

Sascha

--=20
Pengutronix e.K.                           |                           =
  |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0  =
  |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-555=
5 |
