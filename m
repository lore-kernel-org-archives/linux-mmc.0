From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: Is anyone working on SD/MMC driver for i.MX35 ?
Date: Fri, 2 Apr 2010 03:29:32 +0200
Message-ID: <20100402012932.GE13989@pengutronix.de>
References: <20100401125739.GE2045@bluebox.local> <20100401132017.GA30804@buzzloop.caiaq.de> <20100401132234.GG2045@bluebox.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cYtjc4pxslFTELvY"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58449 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932156Ab0DBBaF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Apr 2010 21:30:05 -0400
Content-Disposition: inline
In-Reply-To: <20100401132234.GG2045@bluebox.local>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Hans J. Koch" <hjk@linutronix.de>
Cc: Daniel Mack <daniel@caiaq.de>, linux-arm-kernel@lists.infradead.org, John Ogness <jogness@linutronix.de>, linux-mmc@vger.kernel.org


--cYtjc4pxslFTELvY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 01, 2010 at 03:22:35PM +0200, Hans J. Koch wrote:
> On Thu, Apr 01, 2010 at 03:20:17PM +0200, Daniel Mack wrote:
> > On Thu, Apr 01, 2010 at 02:57:40PM +0200, Hans J. Koch wrote:
> > > I need to get the MMC interface of an i.MX35 to work in the near futu=
re.
> > > To avoid duplicate work, I'd like to know if anybody already started
> > > work on this.
> >=20
> > Is the controller very different from the one which is already supported
> > for MX31?
>=20
> Yep. Completely different beast. Unfortunately.

(CCing linux-mmc)

And it is a mess, really :(

The kernel already has an esdhc-driver (and Anton already worked around a
number of hardware-bugs), but is tied into an of-driver because the core was
also used on PowerPC. There, it utilizes a 32-bit-byte-swaper which is not
needed on ARM. So, one has to rip all that out, generalize the sdhc-platform
support (possibly also abstract the quirk support) and make sure nothing
breaks.

I started and got MMC working, but it is by far not mainline quality (and m=
aybe
bitrotten by now). Check the sdhci-pltfm branch at

http://git.pengutronix.de/?p=3Dwsa/linux-2.6.git;a=3Dsummary

You see, there is still some of_* left in the platform-part.

Maybe you can push this a bit further,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--cYtjc4pxslFTELvY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAku1SHsACgkQD27XaX1/VRuZxgCgiGlUOTttZQd/mN9iIMi90sGQ
RxAAoMjpRA9Rx278EDdV2E9K1Ui8m+1L
=XdL/
-----END PGP SIGNATURE-----

--cYtjc4pxslFTELvY--
