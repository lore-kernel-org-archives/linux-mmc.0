From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: MMC quirks relating to performance/lifetime.
Date: Tue, 8 Feb 2011 22:38:25 +0100
Message-ID: <20110208213825.GB29410@pengutronix.de>
References: <AANLkTikh4vfS7SLKAa-aUXhbTxcHzYHmBuaXj1qHHYN9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p4qYPpj5QlsIQJ0K"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35338 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751846Ab1BHVia (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Feb 2011 16:38:30 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTikh4vfS7SLKAa-aUXhbTxcHzYHmBuaXj1qHHYN9@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org


--p4qYPpj5QlsIQJ0K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 08, 2011 at 03:22:59PM -0600, Andrei Warkentin wrote:
> Hi,
>=20
> I'm not sure if this is the best place to bring this up, but Russel's
> name is on a fair share of drivers/mmc code, and there does seem to be
> quite a bit of MMC-related discussions. Excuse me in advance if this
> isn't the right forum :-).

Searching for MMC in MAINTAINERS will get you:

MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND SDIO SUBSYSTEM
M:      Chris Ball <cjb@laptop.org>
L:      linux-mmc@vger.kernel.org
=2E..

List CCed...

> Certain MMC vendors (maybe even quite a bit of them) use a pretty
> rigid buffering scheme when it comes to handling writes. There is
> usually a buffer A for random accesses, and a buffer B for sequential
> accesses. For certain Toshiba parts, it looks like buffer A is 8KB
> wide, with buffer B being 4MB wide, and all accesses larger than 8KB
> effectively equating to 4MB accesses. Worse, consecutive small (8k)
> writes are treated as one large sequential access, once again ending
> up in buffer B, thus necessitating out-of-order writing to work around
> this.
>=20
> What this means is decreased life span for the parts, and it also
> means a performance impact on small writes, but the first item is much
> more crucial, especially for smaller parts.
>=20
> As I've mentioned, probably more vendors are affected. How about a
> generic MMC_BLOCK quirk that splits the requests (and optionally
> reorders) them? The thresholds would then be adjustable as
> module/kernel parameters based on manfid. I'm asking because I have a
> patch now, but its ugly and hardcoded against a specific manufacturer.
>=20
> Thanks,
> A
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--p4qYPpj5QlsIQJ0K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAk1Rt9EACgkQD27XaX1/VRsEQACgytf7jjpXNSDqEiw1bNWCWYcd
pWEAn0Rbrn0y8+IGq6HEGQShs1GhGVC+
=61BR
-----END PGP SIGNATURE-----

--p4qYPpj5QlsIQJ0K--
