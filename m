From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 5/7] sdhci: Tidy up spaces in sdhci_intel_mid
Date: Tue, 14 Sep 2010 16:45:12 +0200
Message-ID: <20100914144512.GH2629@pengutronix.de>
References: <20100913172738.20345.61119.stgit@localhost.localdomain>
 <20100913173940.20345.66285.stgit@localhost.localdomain>
 <20100914142129.GF2629@pengutronix.de>
 <20100914144057.0d13f843@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="K1n7F7fSdjvFAEnM"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40187 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754382Ab0INOpN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Sep 2010 10:45:13 -0400
Content-Disposition: inline
In-Reply-To: <20100914144057.0d13f843@linux.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org


--K1n7F7fSdjvFAEnM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 14, 2010 at 02:40:57PM +0100, Alan Cox wrote:
> On Tue, 14 Sep 2010 16:21:29 +0200
> Wolfram Sang <w.sang@pengutronix.de> wrote:
>=20
> > On Mon, Sep 13, 2010 at 06:39:41PM +0100, Alan Cox wrote:
> > > Coding style fixes
> > >=20
> > > Signed-off-by: Alan Cox <alan@linux.intel.com>
> >=20
> > Shouldn't this be folded into the patch which initially creates
> > sdhci-intel-mid.c?
>=20
> The work was done later and the signoffs are not the same. In the ideal
> world - yes of course. I can redo them this way if you want but it'll
> probably be about a month.

I would indeed prefer to first have minimal changes to the
mmc/sdhci-core and then have the final version of sdhci-intel-mid.c put
on top of that (also applies to patch 4/7). Less error prone and easier
to review. Yet, I am not the one who is picking up the patches.

(BTW can't you just combine SoB if you fold patches?)

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--K1n7F7fSdjvFAEnM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkyPingACgkQD27XaX1/VRvregCdF8QjjEa8Ql5dgtT+r8siukpo
2n0AoKc7OW+47joRYPqvOKKUynPFoynC
=/kN9
-----END PGP SIGNATURE-----

--K1n7F7fSdjvFAEnM--
