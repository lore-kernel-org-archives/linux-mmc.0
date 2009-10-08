From: Pierre Ossman <pierre@ossman.eu>
Subject: Re: [PATCH] sdio: add MMC_CAP_VDD_165_195 host capability
Date: Thu, 8 Oct 2009 20:38:26 +0200
Message-ID: <20091008203826.5e027347@mjolnir.ossman.eu>
References: <1254160269.10634.15.camel@localhost>
	<4AC0FBF0.6090007@csr.com>
	<20090928192548.11da5c3c@fido2.homeip.net>
	<20090929202833.179fb521@mjolnir.ossman.eu>
	<f6ee8ef9d3da123c11433b52ec8d6a60@localhost>
	<20090929233732.62f470e0@mjolnir.ossman.eu>
	<20090929231013.5d67b36a@fido2.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1; protocol="application/pgp-signature"; boundary="=_freyr.ossman.eu-21667-1255027113-0001-2"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 82-117-125-11.tcdsl.calypso.net ([82.117.125.11]:59063 "EHLO
	smtp.ossman.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932977AbZJHSjK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 8 Oct 2009 14:39:10 -0400
In-Reply-To: <20090929231013.5d67b36a@fido2.homeip.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Langdale <philipl@overt.org>
Cc: David Vrabel <david.vrabel@csr.com>, Ohad Ben-Cohen <ohad@bencohen.org>, akpm@linux-foundation.org, ian@mnementh.co.uk, matt@console-pimps.org, roberto.foglietta@gmail.com, linux-mmc@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_freyr.ossman.eu-21667-1255027113-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 29 Sep 2009 23:10:13 -0700
Philip Langdale <philipl@overt.org> wrote:

> On Tue, 29 Sep 2009 23:37:32 +0200
> Pierre Ossman <pierre@ossman.eu> wrote:
>=20
> > I must have missed that part of discussion. If the voltage fully
> > overlaps with the MMC definition, then I don't see the controllers
> > having to be designed explicitly for SD 3.0. If not, then we probably
> > need a new voltage bit for the hosts. In that case separating
> > supporting from non-supporting should sort itself out easily.
>=20
> The reason I think we need is a host cap is that low voltage operations
> apparently implies different signal timings. This is second hand from
> David as there are no public specs for 3.0 available yet. So, the
> failure case is a controller that publishes support for low voltage,
> but only expects MMC cards to use it.
>=20
> In practice, I expect that the timings are close enough that this will
> work anyway, but I think the situation is analogous to HS-MMC vs HS-SD.
> There the timings are slightly different and you felt it was enough to
> justify a separate host cap for each one.
>=20

It's difficult to say without seeing the spec. But if things are not
backwards compatible, then we should probably add either a new timing
mode, or a new bus mode (where we have open drain and push pull today).

> In fact, thinking about it in those terms, it suggests we need to
> retroactively introduce a reduced-voltage MMC host flag too, just in
> case SDHCI 3.0 controllers barf on those cards...
>=20

Maybe. Again, it's difficult to say without seeing the specifics of the
new specification.

Rgds
--=20
     -- Pierre Ossman

  WARNING: This correspondence is being monitored by the
  Swedish government. Make sure your server uses encryption
  for SMTP traffic and consider using PGP for end-to-end
  encryption.

--=_freyr.ossman.eu-21667-1255027113-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iEUEARECAAYFAkrOMacACgkQ7b8eESbyJLi4HgCYqhXcOvaFoo3UAvsy4It+tqEO
mQCgvba6u1n6g3I8pUEAnv6DKGe5Ph0=
=5UPD
-----END PGP SIGNATURE-----

--=_freyr.ossman.eu-21667-1255027113-0001-2--
