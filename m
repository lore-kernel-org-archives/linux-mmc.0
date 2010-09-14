From: Wolfram Sang <w.sang@pengutronix.de>
Subject: cleaning up sdhci? (was Re: [RFC] thoughts about recent Samsung
 related patches)
Date: Tue, 14 Sep 2010 12:28:59 +0200
Message-ID: <20100914102858.GB2629@pengutronix.de>
References: <20100906110059.GC2617@pengutronix.de>
 <AANLkTikoC35Rg52jJ5NMwvtMh9PfxgS7RqtfvfBeD6LV@mail.gmail.com>
 <20100913123108.GA5497@pengutronix.de>
 <AANLkTi=zpAz+0VT0GGGrMP3KOJiWqvypWVfxuDZDpoSx@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+pHx0qQiF2pBVqBT"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37250 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752113Ab0INK3E (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Sep 2010 06:29:04 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTi=zpAz+0VT0GGGrMP3KOJiWqvypWVfxuDZDpoSx@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kyungmin Park <kmpark@infradead.org>
Cc: linux-mmc@vger.kernel.org, pierre-list@ossman.eu, gdavis@mvista.com, cbouatmailru@gmail.com, m.szyprowski@samsung.com, akpm@linux-foundation.org, =?utf-8?B?7KCV7J6s7ZuI?= <jh80.chung@samsung.com>, Alan Cox <alan@linux.intel.com>


--+pHx0qQiF2pBVqBT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 14, 2010 at 09:05:30AM +0900, Kyungmin Park wrote:
> On Mon, Sep 13, 2010 at 9:31 PM, Wolfram Sang <w.sang@pengutronix.de> wro=
te:
> >> > I hope my comments are applicable; because there is no freely availa=
ble
> >> > datasheet, I can't verify all of my assumptions. Looking forward to
> >> > comments.
> >> Good, I think it's possible. I'll try and send a patch.
> >
> > Any news on this ?
>=20
> I tried and no problem to work, but I'm thinking does it really
> required for reducing one quirk?
> With this change sdhci-s3c should use the
> CONFIG_MMC_SDHCI_IO_ACCESSORS and it introduces the io functions for
> every io access.
>=20
> So I'm not sure these change is required for s3c sdhci.
>=20
> Give you opinions.

I know what you mean. Still, I'd prefer to see that sdhci.c implements
stuff as generic as possible and trying to follow the standard closely.
Exceptions to that should be handled elsewhere if possible. That is, if
some implementations of a controller do not adhere to that standard and
change some bits in the register layout, well, then they have to live
with the quirks and their performance issues IMHO.

BTW it is not only the HI_SPD issue, which is a candidate for the io-
accessors. I am also interested to get the 8BITBUS patch reverted. It
breaks some SD cards on some boards using the esdhc controller :(
Support for a 8bit-bus needs a bit more thought, it seems...

Seeing Alan's patchset, it seems to be a good time to do some
sdhci-cleanup. My impression is that we could get generalize a few
quirks by using io-accessors and overriding capabilties-flags. I am open
for other opinions, though. All in all, it would be great if we all
could combine our efforts and get some kind of master-plan :)
Will take a look at Alan's patches now...

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--+pHx0qQiF2pBVqBT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkyPTmoACgkQD27XaX1/VRuFiQCgqGY/t0It90WKf221n1OIjeVQ
rRUAn3Bv/izjSwXsgyKW/V5Bu6b+z3wV
=zAHh
-----END PGP SIGNATURE-----

--+pHx0qQiF2pBVqBT--
