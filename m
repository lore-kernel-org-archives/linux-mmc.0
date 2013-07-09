From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] mmc: omap_hsmmc: use for OMAP5 as well
Date: Tue, 9 Jul 2013 09:55:42 +0300
Message-ID: <20130709065542.GE5552@arwen.pp.htv.fi>
References: <1372422894-23729-1-git-send-email-a-bindra@ti.com>
 <51CDB260.8080108@ti.com>
 <20130707201309.GA5429@localhost>
 <20130708074606.GD16635@arwen.pp.htv.fi>
 <20130708195828.GA28218@kahuna>
 <20130708202749.GA2596@localhost>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5xSkJheCpeK0RUEJ"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49439 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753179Ab3GIGz7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 9 Jul 2013 02:55:59 -0400
Content-Disposition: inline
In-Reply-To: <20130708202749.GA2596@localhost>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Nishanth Menon <nm@ti.com>, Felipe Balbi <balbi@ti.com>, Balaji T K <balajitk@ti.com>, a-bindra@ti.com, linux-mmc@vger.kernel.org, cjb@laptop.org, linux-omap@vger.kernel.org

--5xSkJheCpeK0RUEJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 08, 2013 at 05:27:50PM -0300, Ezequiel Garcia wrote:
> On Mon, Jul 08, 2013 at 02:58:28PM -0500, Nishanth Menon wrote:
> > On 10:46-20130708, Felipe Balbi wrote:
> > > On Sun, Jul 07, 2013 at 05:13:10PM -0300, Ezequiel Garcia wrote:
> > > > Hi guys,
> > > >=20
> > > > On Fri, Jun 28, 2013 at 09:27:20PM +0530, Balaji T K wrote:
> > > > > On Friday 28 June 2013 06:04 PM, a-bindra@ti.com wrote:
> > > > > > From: Amarinder Bindra <a-bindra@ti.com>
> > > > > >
> > > > > > OMAP's hs_mmc driver is also used for OMAP5 MMC controller oper=
ation.
> > > > > > Considering that the device tree entries are already there for =
this,
> > > > > > allow the driver to be built when only OMAP5 is enabled.
> > > > > > This allows MMC root filesystems to be available in "OMAP5 only"
> > > > > > configurations.
> > > > > >
> > > > > > Signed-off-by: Amarinder Bindra <a-bindra@ti.com>
> > > > > > Acked-by: Felipe Balbi <balbi@ti.com>
> > > > > > Acked-by: Nishanth Menon <nm@ti.com>
> > > > >=20
> > > > > Looks good to me,
> > > > > Acked-by: Balaji T K <balajitk@ti.com>
> > > > >=20
> > > >=20
> > > > I came across this same issue while trying MMC patches on AM3xx,
> > > > which is nor OMAP3 neither OMAP4.
> > > >=20
> > > > Now, looking at the driver I don't see any OMAP-specific bits
> > > > (welcome to the multiplatform world ;-) so I think we can just
> > > > remove the 'depends' line. Something like this:
> > >=20
> > > frankly speaking, this driver should be deleted and all users should =
be
> > > moved to sdhci. OMAP's HSMMC controller is compatible with SDHCI exce=
pt
> > > for a couple quirks which can be easily worked around.
>=20
> @Felipe:
> Do you mind giving me some hints about this quirks? I'm not too familiar
> with these drivers.

one of the quirks is that TI decided to registers into one (because they
both had 16-bits reserved, so, well, we can make the HW 0.0000000000001
dollar cheaper :-p )

The other is related where our SDHCI registers start. Because of TI's
added registers (SYSConfig and REVISION, etc), SDHCI registers have an
offset which generic SDHCI driver, doesn't cope with right now.

> > Do we take that as a NAK to this specific patch?
> >=20
> > I am not complaining about the future migration to a solution that is
> > much more generic and scalable, but having fixes for current problems
> > should'nt be ignored IMHO.
> >=20
>=20
> Of course.
>=20
> > How about a depends on CONFIG_ARCH_OMAP2PLUS instead? will that solve
> > our pains with all OMAP2+ usin this?
>=20
> Yes, I think that using ARCH_OMAP2PLUS should do. FWIW, until we have
> sdhci ready to replace omap_hsmmc, we have no choice but to apply such
> a patch.

if you do change to ARCH_OMAP2PLUS, please also add COMPILE_TEST
(ARCH_OMAP2PLUS || COMPILE_TEST) so we can build in other archs.

--=20
balbi

--5xSkJheCpeK0RUEJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR27PuAAoJEIaOsuA1yqRE3ywQAKMxq20KRH2ydcWiGybTiJCv
ngGjEvyrLJ5+yHNrnA2wW8A77IazZQcgiDyQnfuQOqdnL2nxAXgGnvyic5aaMpuG
+SVryYnGTIzFYzinDOIVIx5Wr/2OS4ywGPz2r6gLq/txjiSbt+i+6EIbjLrEo9DO
jyNXTrkau3o5H0bMr/x9gtGaNywrRiE5yZjZV7/ov+VRPDtwNBP8ErsSZCkTquXq
HJRDep636hP4nFdN8BLCCCABxGHKeIPWTuSQYgiwCps51yqYulf6qdOTMWQC42oS
h9rROaGumqMC4JD2K5KUJ/mKOtMrm0t3oOrZbrJRg/qfRc2HiTc97xWFbcsY8WjY
3KdX+AkJp6+2krxwUNv8A119kxZU5OSl7r/5HhI4IxBECPO2WQwN4wa4UChInZr5
IICVVs+yiZHKfWOpY9M0/qg1CJNbB6QVPS2zB16dD2rKnZJY1YDs8nHGU//uy8Yd
dYTGNGJOy+XSjN9Q0R8AwU/b2Ho3Ry12OmrhT5XfhufHEy9ObvsTzDuphkoF42XM
sDz5DKkU4nni3Cn8QuPPeRCXfBsb7ZQsuhjOEI7/onx95n9ZIgPNEXXZ2fgApTFN
6oI98L7sxflqoTDi/YiiIXR5R8kB4/chYdc3ns3NUKuTvBWPlTVyTmWXpIjvusNs
TcQyLgdriIpoPl03R9Cx
=0xQp
-----END PGP SIGNATURE-----

--5xSkJheCpeK0RUEJ--
