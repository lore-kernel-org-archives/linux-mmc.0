From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH resend] sdhci: work around broken dma boundary behaviour
Date: Mon, 14 Mar 2011 11:18:29 +0100
Message-ID: <20110314101829.GB2206@pengutronix.de>
References: <1299530457-19904-1-git-send-email-mmvinni@yahoo.com>
 <20110312214348.GA312@pengutronix.de>
 <423716.64271.qm@web161805.mail.bf1.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="v9Ux+11Zm5mwPlX6"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38742 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750990Ab1CNKSd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Mar 2011 06:18:33 -0400
Content-Disposition: inline
In-Reply-To: <423716.64271.qm@web161805.mail.bf1.yahoo.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mikko Vinni <mmvinni@yahoo.com>
Cc: linux-mmc@vger.kernel.org, mikko.vinni@gmail.com


--v9Ux+11Zm5mwPlX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > But we can't guarantee that. Transfer could be up to 65535 *  2K.
>=20
> In sdhci.c function sdhci_prepare_data there are these checks:
>=20
>     /* Sanity checks */
>     BUG_ON(data->blksz * data->blocks > 524288);
>     BUG_ON(data->blksz > host->mmc->max_blk_size);
>     BUG_ON(data->blocks > 65535);
>=20
> I thought the first BUG_ON makes sure that the transfer doesn't go too bi=
g.
> Then again, I might be missing something. Is 524288 not in bytes?

Sorry, I simply missed that. Hmmm, another hard coded value :(

> > > Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=3D28462
> > >=20
> > >  Signed-off-by: Mikko Vinni <mmvinni <at> yahoo.com>
> >=20
> > Proper EMail  please.
>=20
> Hm, @gmail.com? (cc added for further emails)

I was just referring to using "<at>" instead of "@". The provider
doesn't really matter :)

> > > diff --git a/drivers/mmc/host/sdhci.c  b/drivers/mmc/host/sdhci.c
> > > index a25db42..8651731 100644
> > > ---  a/drivers/mmc/host/sdhci.c
> > > +++ b/drivers/mmc/host/sdhci.c
> > > @@  -1537,9 +1537,27 @@ static void sdhci_data_irq(struct sdhci_host =
*host,=20
> >u32  intmask)
> > >           * boundaries, but  as we can't disable the feature
> > >            * we need to at least restart the transfer.
> > >            */
> > > -         if (intmask & SDHCI_INT_DMA_END)
> > >  -            sdhci_writel(host,  sdhci_readl(host, SDHCI_DMA_ADDRESS=
),
> > > -                  SDHCI_DMA_ADDRESS);
> > > +        if (intmask  & SDHCI_INT_DMA_END) {
> > > +             u32 dmastart, dmanow;
> > > +             dmastart =3D  sg_dma_address(host->data->sg);
> >=20
> > This will only work for the first  512K, right?
>=20
> True. If a transfer can cross more than one boundary, I suppose an
> additional variable is needed to keep track of the current state.

Yeah, thought that, too. I also wondered if we then just could not
always write our own value to DMA_ADDRESS. This is redundant on working
hardware, but the the check is not much cheaper than just doing it.

Would that change also be beyond your comfort zone?

> > > +             dmanow =3D sdhci_readl(host, SDHCI_DMA_ADDRESS);
> > >  +            if (dmanow =3D=3D  dmastart) {
> > > +                 /*
> > > +                  * HW failed to increase the  address.
> > > +                  * Update to the next 512KB block boundary.
> > >  +                  */
> > > +                 dmanow =3D (dmanow & ~0x7ffff) + 0x80000;
> >=20
> > Hmm,  hardcoding these values is probably not a good idea. They should =
be
> > dependent  on what is written to MAKE_BLKSIZE. Maybe a common define?
>=20
> Sorry, implementing that goes beyond my comfort zone. I would be happy to
> test patches, though.

I was imagining something like:

#define SDHCI_DEFAULT_BOUNDARY_SIZE	(512 * 1024)

which could be used directly in your code and later like

SDHCI_MAKE_BLKSZ(ilog2(SDHCI_DEFAULT_BOUNDARY_SIZE) - 12, ...);

(Maybe the ilog2-thingie could be another macro)

> > >  +                if  (dmanow > dmastart + host->data->blksz *
> > > +                              host->data->blocks) {
> > >  +                     WARN_ON(1);
> > > +                     dmanow =3D  dmastart;
> > > +                 }
> >=20
> > Did this happen?
>=20
> No, but I though it brings some protection in case somebody *does*
> change the boundary value without checking the code first (and happens
> to be running on flawed hardware).

So, it could go if we make that dependent if I understand correctly.

Oh, and what I forgot to say last time:

Thanks a lot for your debugging efforts! I read the bugzilla entry and
your persistency for nailing the cause is greatly appreciated. Good
work.

All the best,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--v9Ux+11Zm5mwPlX6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk1963QACgkQD27XaX1/VRv3kQCeOx6mkkMf9vEtNduzqnaibeUa
2k4AoKhQoMngcmyGzO46ZjqRHqfRE9NW
=MLSL
-----END PGP SIGNATURE-----

--v9Ux+11Zm5mwPlX6--
