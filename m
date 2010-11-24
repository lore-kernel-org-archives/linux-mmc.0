From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 1/2] mmc: Add support for JMicron 388 SD/MMC controller
Date: Wed, 24 Nov 2010 23:04:25 +0100
Message-ID: <20101124220425.GA18464@pengutronix.de>
References: <1290579674-4616-1-git-send-email-tiwai@suse.de> <1290579674-4616-2-git-send-email-tiwai@suse.de> <20101124095935.GA6812@pengutronix.de> <s5hy68jq7re.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40268 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752190Ab0KXWEa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 24 Nov 2010 17:04:30 -0500
Content-Disposition: inline
In-Reply-To: <s5hy68jq7re.wl%tiwai@suse.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Aries Lee <arieslee@jmicron.com>


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 24, 2010 at 12:29:57PM +0100, Takashi Iwai wrote:
> At Wed, 24 Nov 2010 10:59:35 +0100,
> Wolfram Sang wrote:
> >=20
> > On Wed, Nov 24, 2010 at 07:21:13AM +0100, Takashi Iwai wrote:
> >=20
> > > +/* Controller doesn't support VDD 180 for MMC (for SD/MMC combo chip=
s) */
> > > +#define SDHCI_QUIRK_MMC_VDD_180				(1<<30)
> >=20
> > Can't we handle this more generic? Like setting ocr_avail_* from
> > sdhci-pci.c somehow (just brainstorming, didn't have a deeper look)? I'd
> > like to avoid new quirks as much as possible.
>=20
> OK, what about the one below?

Looks better to me. (sadly, still from a glimpse, no thorough review)

Thanks!

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkzti+kACgkQD27XaX1/VRt8NACcDMJYtu1DKmsWK1hcBLwEd1Bx
SIAAnjEb77jsmgjemoYhMlKIu+1sFzEM
=F0Vq
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
