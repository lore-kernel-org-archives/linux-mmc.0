From: Pierre Ossman <pierre@ossman.eu>
Subject: Re: [PATCH] sdio: add MMC_CAP_VDD_165_195 host capability
Date: Wed, 14 Oct 2009 13:05:02 +0200
Message-ID: <20091014130502.1cbed7f8@mjolnir.ossman.eu>
References: <1254160269.10634.15.camel@localhost>
	<20090928192548.11da5c3c@fido2.homeip.net>
	<20090929202833.179fb521@mjolnir.ossman.eu>
	<f6ee8ef9d3da123c11433b52ec8d6a60@localhost>
	<20090929233732.62f470e0@mjolnir.ossman.eu>
	<20090929231013.5d67b36a@fido2.homeip.net>
	<20091008203826.5e027347@mjolnir.ossman.eu>
	<20091010114215.5f9d8c94@fido2.homeip.net>
	<4AD32B01.5000600@csr.com>
	<20091012193952.1482e322@fido2.homeip.net>
	<da15981b0910140056j9a62fccvdb256b851455c686@mail.gmail.com>
	<20091014104849.3c441249@mjolnir.ossman.eu>
	<4AD5A942.3000207@csr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1; protocol="application/pgp-signature"; boundary="=_freyr.ossman.eu-32014-1255518308-0001-2"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 82-117-125-11.tcdsl.calypso.net ([82.117.125.11]:44078 "EHLO
	smtp.ossman.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754837AbZJNLFo (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 14 Oct 2009 07:05:44 -0400
In-Reply-To: <4AD5A942.3000207@csr.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: David Vrabel <david.vrabel@csr.com>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Philip Langdale <philipl@overt.org>, akpm@linux-foundation.org, ian@mnementh.co.uk, matt@console-pimps.org, roberto.foglietta@gmail.com, linux-mmc@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_freyr.ossman.eu-32014-1255518308-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 14 Oct 2009 11:34:42 +0100
David Vrabel <david.vrabel@csr.com> wrote:

>=20
> It can be done per-card, the switch to the lower voltage just needs to
> be deferred.  Initially set the voltage to a standard one that's
> supported by the card and host.  After the card is fully initialized and
> enumerated, have a hook for per-card fixups.  For the particular
> non-standard card in question, this would then reduce the voltage to 1.8V.
>=20

In theory. But it would require a bit of redesign of the code as it
would have to restart the whole init again.

Rgds
--=20
     -- Pierre Ossman

  WARNING: This correspondence is being monitored by the
  Swedish government. Make sure your server uses encryption
  for SMTP traffic and consider using PGP for end-to-end
  encryption.

--=_freyr.ossman.eu-32014-1255518308-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iEYEARECAAYFAkrVsGAACgkQ7b8eESbyJLg5fACfUsfb+L5NGkTOQLkors79l37E
RRgAoMMxTJl17YlgSpQMMV87QbyLGeIJ
=nA+H
-----END PGP SIGNATURE-----

--=_freyr.ossman.eu-32014-1255518308-0001-2--
