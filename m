From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH (mmc-next) 2/3] mmc: split the sdhci.h to help
 platforms that uses shdci-pltfm d.d.
Date: Mon, 27 Sep 2010 16:13:04 +0200
Message-ID: <20100927141304.GH2664@pengutronix.de>
References: <1285233266-5039-1-git-send-email-peppe.cavallaro@st.com>
 <1285233266-5039-2-git-send-email-peppe.cavallaro@st.com>
 <20100927104320.GD2664@pengutronix.de>
 <4CA094CE.2010904@st.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RwGu8mu1E+uYXPWP"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38761 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759221Ab0I0ONG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Sep 2010 10:13:06 -0400
Content-Disposition: inline
In-Reply-To: <4CA094CE.2010904@st.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Peppe CAVALLARO <peppe.cavallaro@st.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>


--RwGu8mu1E+uYXPWP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 27, 2010 at 02:57:50PM +0200, Peppe CAVALLARO wrote:
> Hi Wolfram,
>=20
> On 09/27/2010 12:43 PM, Wolfram Sang wrote:
> > On Thu, Sep 23, 2010 at 11:14:25AM +0200, Giuseppe CAVALLARO wrote:
> >> Some platforms based on the shdci-pltfm device driver need to
> >> set own quirks (that currently are in drivers/mmc/host/sdhci.h).
> >>
> >> This patch splits this header file in two parts:
> >>
> >> o drivers/mmc/host/sdhci.h
> >>      it includes the HC registers
> >>
> >> o include/linux/mmc/sdhci.h
> >>      it includes the private structures, callbacks, quirks etc.
> >>
> >> So, instead of including the shdci.h from devices/mmc/host, all
> >> the  platforms based on shdci-pltfm will be able to only include:
> >> include/linux/mmc/sdhci.h and include/linux/sdhci-pltfm.h.
> >>
> >> This has been tested on STM targets (STx7106, STx7108, STx5206).
> >>
> >> Note: drivers/mmc/host/sdhci.h also includes the linux/mmc/sdhci.h
> >> and no modifications should be needed on other sdhci-<XXX> drivers.
> >>
> >> Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
> >
> > IMO this is too much exporting here. I can't see a reason to export the
> > sdhci_host-structure, for example. My idea would be to start with a
> > minimal approach and just copy over the stuff we need now (the quirks).
> > If we need more later, we add it seperately then.
>=20
> I had just started doing that but I decided to split the file to solve
> the issue for the .init call (we discussed in the thread
> http://marc.info/?l=3Dlinux-mmc&m=3D128523426925028&w=3D2).
> Indeed, this approach avoids to add other callbacks and reuses the
> existent code.

OK for the host-struct. What about the io-accessors? Do we really need
them?

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--RwGu8mu1E+uYXPWP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkygpnAACgkQD27XaX1/VRv3wwCgx6Nw0oVOhs0QegKwkJw73U5U
I0AAoJ1CCvOZTnXKgX95ikzDkxQ5cruF
=8grG
-----END PGP SIGNATURE-----

--RwGu8mu1E+uYXPWP--
