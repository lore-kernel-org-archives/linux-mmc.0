From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] mmc: add SDHCI driver for STM platforms (V2)
Date: Tue, 21 Sep 2010 11:44:57 +0200
Message-ID: <20100921094457.GD3168@pengutronix.de>
References: <1284970817-11293-1-git-send-email-peppe.cavallaro@st.com>
 <20100920083842.GA4058@pengutronix.de>
 <4C98792C.5000900@st.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u65IjBhB3TIa72Vp"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53004 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756478Ab0IUJpC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Sep 2010 05:45:02 -0400
Content-Disposition: inline
In-Reply-To: <4C98792C.5000900@st.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Peppe CAVALLARO <peppe.cavallaro@st.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "matt@console-pimps.org" <matt@console-pimps.org>


--u65IjBhB3TIa72Vp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 21, 2010 at 11:21:48AM +0200, Peppe CAVALLARO wrote:
> On 09/20/2010 10:38 AM, Wolfram Sang wrote:
> > On Mon, Sep 20, 2010 at 10:20:17AM +0200, Giuseppe CAVALLARO wrote:
> >> This patch adds the Arasan MMC/SD/SDIO driver
> >> for the STM ST40 platforms. It is based on the
> >> SDHCI driver.
> >> It has been tested on the STx7106/STx7108/STx5289
> >> platforms.
> >>
> >> Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
> >=20
> > Looks to me that you could just use the sdhci-pltfm driver?
> >=20
>=20
> Hello Wolfram,
> some weeks ago I discussed about this driver and I reworked it according
> to the changes required. This is the meaning of this patch.
>=20
> At any rate, I can look at the sdhci-pltfm driver: at first glance, it
> could actually help on our platforms. This could take a while.

Sorry, I didn't spot the first version of your patch. I would have said
the same then, simply to avoid the code duplication. Oh, and no need to
hurry from my side :)

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--u65IjBhB3TIa72Vp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkyYfpkACgkQD27XaX1/VRuHPACffoxC8zQnzZ5X4gzP3un08Amy
a+wAnjptPYDnubzce7UfurtTBEC3qemQ
=nrgv
-----END PGP SIGNATURE-----

--u65IjBhB3TIa72Vp--
