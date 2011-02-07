From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 1/2] mmc: sdhci: Replace SDHCI_QUIRK_FORCE_BLK_SZ_2048
 with a pklatform hook.
Date: Mon, 7 Feb 2011 19:11:43 +0100
Message-ID: <20110207181143.GA14626@pengutronix.de>
References: <m31v3lofm1.fsf@pullcord.laptop.org>
 <20110207174039.GE3123@pengutronix.de>
 <20110207175424.GA2065@void.printf.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35047 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751962Ab1BGSLp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Feb 2011 13:11:45 -0500
Content-Disposition: inline
In-Reply-To: <20110207175424.GA2065@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Anton Vorontsov <cbouatmailru@gmail.com>


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 07, 2011 at 05:54:24PM +0000, Chris Ball wrote:
> Hi Wolfram, thanks for the review,
>=20
> On Mon, Feb 07, 2011 at 06:40:39PM +0100, Wolfram Sang wrote:
> > On Sun, Feb 06, 2011 at 01:13:10AM -0500, Chris Ball wrote:
> > > Part of a quirk cleanup run.  This quirk was only used by sdhci-esdhc.
> > > This patch is untested.
> > >=20
> > > Signed-off-by: Chris Ball <cjb@laptop.org>
> > > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > > index 9e15f41..fcd6188 100644
> > > --- a/drivers/mmc/host/sdhci.c
> > > +++ b/drivers/mmc/host/sdhci.c
> > > @@ -1962,8 +1962,8 @@ int sdhci_add_host(struct sdhci_host *host)
> > >  	 * Maximum block size. This varies from controller to controller and
> > >  	 * is specified in the capabilities register.
> > >  	 */
> > > -	if (host->quirks & SDHCI_QUIRK_FORCE_BLK_SZ_2048) {
> > > -		mmc->max_blk_size =3D 2;
> > > +	if (host->ops->get_max_blk_size) {
> > > +		mmc->max_blk_size =3D host->ops->get_max_blk_size(host);
> > >  	} else {
> > >  		mmc->max_blk_size =3D (caps & SDHCI_MAX_BLOCK_MASK) >>
> > >  				SDHCI_MAX_BLOCK_SHIFT;
> >=20
> > I tend to think this could be fixed using io-accessors when reading the
> > caps register?
>=20
> Hm, I agree that it would work, but I'm not sure it's going to be
> cleaner/more readable that way.  I like that here we have one place
> for setting the max_blk_size, and it's obvious from the code exactly
> where you need to look to see if it's been overloaded by the driver.

Without the quirk and its handling, we lose the if-else-block which will
lead to:

	mmc->max_blk_size =3D (caps & SDHCI_MAX_BLOCK_MASK) >>
			SDHCI_MAX_BLOCK_SHIFT;
	if (mmc->max_blk_size >=3D 3) {
		printk(KERN_WARNING "%s: Invalid maximum block size, "
			"assuming 512 bytes\n", mmc_hostname(mmc));
		mmc->max_blk_size =3D 0;
	}

This is what I would prefer. Straight code, handling an sdhci-controller
adhering to the standard. A controller failing to do that, will have to take
care of that in its specific source file. For the sdhci-core, it would then
simply look like a "good" controller. We probably can't achieve this for all
quirks, but still...

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk1QNd8ACgkQD27XaX1/VRvqYwCfRdOqeRdHmIGStgzF6wwRCR8R
g0sAn00zYmQo0c2c+6hRT/sF7WgdBoVC
=ke/b
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
