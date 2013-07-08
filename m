From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] mmc: omap_hsmmc: use for OMAP5 as well
Date: Mon, 8 Jul 2013 10:46:06 +0300
Message-ID: <20130708074606.GD16635@arwen.pp.htv.fi>
References: <1372422894-23729-1-git-send-email-a-bindra@ti.com>
 <51CDB260.8080108@ti.com>
 <20130707201309.GA5429@localhost>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MAH+hnPXVZWQ5cD/"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41701 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751000Ab3GHHqW (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 8 Jul 2013 03:46:22 -0400
Content-Disposition: inline
In-Reply-To: <20130707201309.GA5429@localhost>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Balaji T K <balajitk@ti.com>, a-bindra@ti.com, linux-mmc@vger.kernel.org, cjb@laptop.org, linux-omap@vger.kernel.org, balbi@ti.com, nm@ti.com

--MAH+hnPXVZWQ5cD/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 07, 2013 at 05:13:10PM -0300, Ezequiel Garcia wrote:
> Hi guys,
>=20
> On Fri, Jun 28, 2013 at 09:27:20PM +0530, Balaji T K wrote:
> > On Friday 28 June 2013 06:04 PM, a-bindra@ti.com wrote:
> > > From: Amarinder Bindra <a-bindra@ti.com>
> > >
> > > OMAP's hs_mmc driver is also used for OMAP5 MMC controller operation.
> > > Considering that the device tree entries are already there for this,
> > > allow the driver to be built when only OMAP5 is enabled.
> > > This allows MMC root filesystems to be available in "OMAP5 only"
> > > configurations.
> > >
> > > Signed-off-by: Amarinder Bindra <a-bindra@ti.com>
> > > Acked-by: Felipe Balbi <balbi@ti.com>
> > > Acked-by: Nishanth Menon <nm@ti.com>
> >=20
> > Looks good to me,
> > Acked-by: Balaji T K <balajitk@ti.com>
> >=20
>=20
> I came across this same issue while trying MMC patches on AM3xx,
> which is nor OMAP3 neither OMAP4.
>=20
> Now, looking at the driver I don't see any OMAP-specific bits
> (welcome to the multiplatform world ;-) so I think we can just
> remove the 'depends' line. Something like this:

frankly speaking, this driver should be deleted and all users should be
moved to sdhci. OMAP's HSMMC controller is compatible with SDHCI except
for a couple quirks which can be easily worked around.

--=20
balbi

--MAH+hnPXVZWQ5cD/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR2m4+AAoJEIaOsuA1yqREloAP/jgQSPMd/lrZ6mSJhzUVn57X
kW2xmC4u33ZmB3NN7dNGO4THgPQPUl1QriNB2dFknsJZgPCdfip6ZCLSxdt7dDQJ
ImZipI7zzoKzaIhYcUA1jH621KRICRBwaig41HuN8Xl3K6+hBUql1PS4Z7oSVl44
qD3fhZ9J/kCwz9cWs0M0gahDZFSv09PW8IRmWo62IOf89Ci63zbVyDSfjvvnJhYr
LOMOYfHKdJnELrwrwEpiu3Rm8hCr7da+xcbQF8oIruuMBjg6OGEGih2pKJBB6FRm
oHwTONvfh4vq2jJXKymukRqFRNHtfST83MWiNqoxH/xA7EfHlg1SogowjzgYrJi4
WK8ZHTWRb7yX76KBdM9lqkjEfwtHVZz9anlkClgWTsyh/p0yD+MyDhfcbZbv5vRw
itLW9FmoMd3xzELOOgAME32qga3eBjbxBcXl1gxGWQ6rvAKEnBKUpSNivikz1/Fh
jF+iABryuut7ot0L7KU0M1F9reAVke0pByEI4ZKLWNRlHCdEJibnzM86zC0vzvBG
+VikLNW7NqyZobviq7UfoF+HUroA3VcAqnVeMpdD27tgVApQXT7Ot0McMaerzKxd
ktN7/Od+4NEo6BegOyb48BwHrNU7uof1INrWwP54UsGgEY2xYBANrJp+26UuBu2m
LqFFodyoRqnBPX24cEr6
=aoIV
-----END PGP SIGNATURE-----

--MAH+hnPXVZWQ5cD/--
