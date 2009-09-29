From: Pierre Ossman <pierre@ossman.eu>
Subject: Re: [PATCH] sdio: add MMC_CAP_VDD_165_195 host capability
Date: Tue, 29 Sep 2009 20:28:33 +0200
Message-ID: <20090929202833.179fb521@mjolnir.ossman.eu>
References: <1254160269.10634.15.camel@localhost>
	<4AC0FBF0.6090007@csr.com>
	<20090928192548.11da5c3c@fido2.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1; protocol="application/pgp-signature"; boundary="=_freyr.ossman.eu-31751-1254248919-0001-2"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 82-117-125-11.tcdsl.calypso.net ([82.117.125.11]:46732 "EHLO
	smtp.ossman.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753047AbZI2S2f (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 29 Sep 2009 14:28:35 -0400
In-Reply-To: <20090928192548.11da5c3c@fido2.homeip.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Langdale <philipl@overt.org>
Cc: David Vrabel <david.vrabel@csr.com>, Ohad Ben-Cohen <ohad@bencohen.org>, akpm@linux-foundation.org, "p hilipl"@overt.org, ian@mnementh.co.uk, matt@console-pimps.org, roberto.foglietta@gmail.com, linux-mmc@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_freyr.ossman.eu-31751-1254248919-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 28 Sep 2009 19:25:48 -0700
Philip Langdale <philipl@overt.org> wrote:

>=20
> Hi David,
>=20
> Ok, that sounds reasonable, but my concern is a controller that
> publishes support for MMC_VDD_165_195 for mmc cards but doesn't
> claim support for SDIO cards - particularly considering the
> signalling implications you mentioned. Now, maybe you don't see
> this happening in the wild, but it seems to me that it has to
> be possible. It seems that to guard against this, you'd need a
> host cap that says "165_195 for SD" and if it's not present,
> mask it out of the OCR when dealing with SD/IO cards.
>=20
> Am I being too paranoid?
>=20

There is no way the vendor of the SD controller can know what this bit
means to the vendor of the SD/SDIO card as it is undefined. I'm afraid
I see no safe way of supporting this bit. The only thing we can do is
interpret it as being the same as the MMC bit, but then only with an
opt-in configuration as we might be killing hardware with this.

Rgds
--=20
     -- Pierre Ossman

  WARNING: This correspondence is being monitored by the
  Swedish government. Make sure your server uses encryption
  for SMTP traffic and consider using PGP for end-to-end
  encryption.

--=_freyr.ossman.eu-31751-1254248919-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iEYEARECAAYFAkrCUdUACgkQ7b8eESbyJLhNcQCg4FPtIc5KeXrUU9+ysoeuoZ3O
PhsAoMEMaztVVOBdakO4aRod7YAT/JXE
=Os2c
-----END PGP SIGNATURE-----

--=_freyr.ossman.eu-31751-1254248919-0001-2--
