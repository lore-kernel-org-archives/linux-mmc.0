From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH resend] sdhci: work around broken dma boundary behaviour
Date: Mon, 14 Mar 2011 18:21:29 +0100
Message-ID: <20110314172129.GA20654@pengutronix.de>
References: <1299530457-19904-1-git-send-email-mmvinni@yahoo.com>
 <20110312214348.GA312@pengutronix.de>
 <423716.64271.qm@web161805.mail.bf1.yahoo.com>
 <20110314101829.GB2206@pengutronix.de>
 <470477.34668.qm@web161814.mail.bf1.yahoo.com>
 <20110314152817.GD2206@pengutronix.de>
 <727376.43956.qm@web161815.mail.bf1.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52656 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751310Ab1CNRVb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Mar 2011 13:21:31 -0400
Content-Disposition: inline
In-Reply-To: <727376.43956.qm@web161815.mail.bf1.yahoo.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mikko Vinni <mmvinni@yahoo.com>
Cc: linux-mmc@vger.kernel.org


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > > intmask)
> > >            * boundaries, but as we can't disable the  feature
> > >           * we need to at least restart  the transfer.
> > >           */
> > > -         if (intmask & SDHCI_INT_DMA_END)
> > > -             sdhci_writel(host, sdhci_readl(host,  SDHCI_DMA_ADDRESS=
),
> > > -                 SDHCI_DMA_ADDRESS);
> > > +        if (intmask  & SDHCI_INT_DMA_END) {
> > > +             u32 dmastart, dmanow;
> > > +             dmastart =3D sg_dma_address(host->data->sg);
> >=20
> > Consecutive transfers  won't work (I know you know ;)).
>=20
> I assume you mean a single transfer that exceeds whatever is
> defined in SDHCI_DEFAULT_BOUNDARY_SIZE. As long as
> it is kept at 512K things should be fine, but adding the auxiliary
> variable to facilitate smaller values would make the patch
> more invasive. Being an mmc non-hacker, I would rather leave
> that kind of invasive patches for others :)

If you don't want to invest the effort, this is your decision, which is
fine. Other than that, I'd say you are not missing the required skills
for that change. (/me is just helping out here as well)

Cheers,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk1+TpkACgkQD27XaX1/VRvSsACeIM2N7JBWvD/RiggFDfrCenOv
xhIAoKufx0y+r9EtFtOv7K2nPgQEreFx
=EuTX
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
